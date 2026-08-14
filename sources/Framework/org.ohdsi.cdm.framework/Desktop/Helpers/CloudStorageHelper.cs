using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Queues;
using Azure.Storage.Queues.Models;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class CloudStorageHelper
    {
        public static void UploadFile(string fileName, IDataReader reader)
        {
            CloudStorageHelper.UploadFile(fileName, reader, true, false);
        }

        public static void UploadFile(string fileName, IDataReader reader, bool compress, bool schemaOnly)
        {
            var storageName = Settings.Settings.Current.CloudStorageName;
            IAmazonS3 awsClient = GetAwsStorageClient();
            BlobContainerClient azureClient = GetBlobContainerClient();

            int fileIndex = 0;
            var name = fileName;

            using (awsClient)
            {
                foreach (var stream in common.Helpers.CsvHelper.GetStreamCsv(reader, 10_000_000, compress, schemaOnly))
                {
                    if (fileIndex > 0)
                        name = fileName.Replace(".gz", "." + fileIndex + ".gz");

                    using (stream)
                    {
                        if (awsClient != null)
                        {
                            using var directoryTransferUtility = new TransferUtility(awsClient);
                            directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                            {
                                BucketName = storageName,
                                Key = name,
                                ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                                StorageClass = S3StorageClass.Standard,
                                InputStream = stream
                            });
                        }
                        else if (azureClient != null)
                        {
                            azureClient.UploadBlob(name, stream);
                        }

                        Console.WriteLine("BucketName=" + storageName);
                        Console.WriteLine("Key=" + name);
                    }
                    fileIndex++;
                }
            }
        }


        public static Tuple<int, DateTime> GetRunningFunctionInfo(string storageName, string prefix)
        {
            AmazonS3Client awsClient = GetAwsTriggerClient();
            var azureClient = GetAzureTriggerClient();

            if (awsClient != null)
            {
                using (awsClient)
                {
                    var request = new ListObjectsV2Request { BucketName = storageName, Prefix = prefix };
                    Task<ListObjectsV2Response> task;
                    int count = 0;
                    var lastModified = DateTime.MinValue;

                    do
                    {
                        task = awsClient.ListObjectsV2Async(request);
                        task.Wait();

                        if (task.Result.S3Objects != null)
                        {
                            foreach (var o in task.Result.S3Objects)
                            {
                                if (o.LastModified.HasValue)
                                {
                                    if(o.LastModified.Value > lastModified)
                                        lastModified = o.LastModified.Value;

                                    count++;
                                }
                            }
                        }

                        request.ContinuationToken = task.Result.NextContinuationToken;
                        
                    } while (task.Result.IsTruncated ?? false);

                    return new Tuple<int, DateTime>(count, lastModified);
                }
            }
            else if (azureClient != null)
            {
                QueueProperties properties = azureClient.GetProperties();

                return new Tuple<int, DateTime>(properties.ApproximateMessagesCount, DateTime.Now);
            }

            throw new Exception("TriggerClient == NULL");
        }

        private static BlobContainerClient GetBlobContainerClient()
        {
            if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudStorageHolder))
            {
                var credential = new ClientSecretCredential(
                  Settings.Settings.Current.CloudStorageHolder,
                  Settings.Settings.Current.CloudStorageKey,
                  Settings.Settings.Current.CloudStorageSecret);
                var client = new BlobServiceClient(new Uri(Settings.Settings.Current.CloudStorageUri), credential, null);
                return client.GetBlobContainerClient(Settings.Settings.Current.CloudStorageName);
            }
            else if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudStorageConnectionString))
            {
                var client = new BlobServiceClient(Settings.Settings.Current.CloudStorageConnectionString);
                return client.GetBlobContainerClient(Settings.Settings.Current.CloudStorageName);
            }

            return null;
        }

        public static QueueClient GetAzureTriggerClient()
        {
            // if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageHolder))
            // {
            //     var credential = new ClientSecretCredential(
            //       Settings.Settings.Current.CloudTriggerStorageHolder,
            //       Settings.Settings.Current.CloudTriggerStorageKey,
            //       Settings.Settings.Current.CloudTriggerStorageSecret);
            //     var client = new BlobServiceClient(new Uri(Settings.Settings.Current.CloudTriggerStorageUri), credential, null);
            //     return client.GetBlobContainerClient(Settings.Settings.Current.CloudTriggerStorageName);
            // }
            // else 
            if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageConnectionString))
            {
                QueueClient client = new(Settings.Settings.Current.CloudTriggerStorageConnectionString, Settings.Settings.Current.CloudTriggerStorageName, 
                new QueueClientOptions 
                {
                    MessageEncoding = QueueMessageEncoding.Base64
                });
                
                return client;
            }

            return null;
        }

        private static AmazonS3Client GetAwsStorageClient()
        {
            if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudStorageHolder) || !string.IsNullOrEmpty(Settings.Settings.Current.CloudStorageConnectionString))
                return null;

            return new AmazonS3Client(
                    Settings.Settings.Current.CloudStorageKey,
                    Settings.Settings.Current.CloudStorageSecret,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
        }

        public static AmazonS3Client GetAwsTriggerClient()
        {
            if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageHolder) || !string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageConnectionString))
                return null;

            return new AmazonS3Client(
                    Settings.Settings.Current.CloudTriggerStorageKey,
                    Settings.Settings.Current.CloudTriggerStorageSecret,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
        }

        public static void TriggerFunctions(string[] messages)
        {
            var tasks = new List<Task>();

            AmazonS3Client awsClient = GetAwsTriggerClient();
            var azureClient = GetAzureTriggerClient();

            if (awsClient != null)
            {
                using (awsClient)
                using (var tu = new TransferUtility(awsClient))
                {
                    foreach(var msg in messages)
                    {
                        var t = tu.UploadAsync(new TransferUtilityUploadRequest
                        {
                            InputStream = new MemoryStream(),
                            BucketName = Settings.Settings.Current.CloudTriggerStorageName,
                            Key = msg,
                            ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                            StorageClass = S3StorageClass.Standard,
                        });
                        tasks.Add(t);
                    }
                }
            }
            else if (azureClient != null)
            {
                foreach(var msg in messages)
                {
                    var t = azureClient.SendMessageAsync(msg);
                    tasks.Add(t);
                }
            }

            Task.WaitAll([.. tasks]);
        }

        public static IEnumerable<int> GetSlices(int chunkId)
        {
            using var client = GetAwsStorageClient();

            var prefix = $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw/{chunkId}/";
            var request = new ListObjectsV2Request
            {
                BucketName = Settings.Settings.Current.CloudStorageName,
                Prefix = prefix
            };

            Task<ListObjectsV2Response> task;
            var slices = new HashSet<int>();

            do
            {
                task = client.ListObjectsV2Async(request);
                task.Wait();

                foreach (var o in task.Result.S3Objects)
                {

                    if (o.Key.Contains("/metadata/"))
                        continue;

                    if (o.Key.Split('/').Length < 6)
                        continue;

                    var tableName = o.Key.Split('/')[4];
                    var fileName = o.Key.Split('/')[5];

                    //if (Settings.Settings.Current.Building.SourceEngine.Database == Enums.Database.Databricks)
                    //{
                    //    slices.Add(int.Parse(fileName));
                    //}
                    //else
                    //{
                    var tail = fileName[fileName.IndexOf("_part")..];
                    var slice = fileName.Replace(tableName, "").Replace(tail, "");

                    slices.Add(int.Parse(slice));
                    //}
                }

                request.ContinuationToken = task.Result.NextContinuationToken;
                
            } while (task.Result.IsTruncated ?? false);

            return slices;
        }
    }
}