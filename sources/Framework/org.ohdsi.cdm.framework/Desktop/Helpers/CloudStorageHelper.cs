using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class CloudStorageHelper
    {
        public static void UploadFile(IAmazonS3 awsClient, BlobContainerClient azureClient, string storageName, string fileName, IDataReader reader)
        {
            CloudStorageHelper.UploadFile(awsClient, azureClient, storageName, fileName, reader, true, false);
        }

        public static void UploadFile(IAmazonS3 awsClient, BlobContainerClient azureClient, string storageName, string fileName, IDataReader reader, bool compress, bool schemaOnly)
        {
            int fileIndex = 0;
            var name = fileName;

            foreach (var stream in common.Helpers.CsvHelper.GetStreamCsv(reader, 10_000_000, compress, schemaOnly))
            {
                if (fileIndex > 0)
                    name = fileName.Replace(".gz", "." + fileIndex + ".gz");

                using (stream)
                {
                    if (awsClient != null)
                    {
                        using (awsClient)
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
                    }

                    if (azureClient != null)
                    {
                        azureClient.UploadBlob(name, stream);
                    }

                    Console.WriteLine("BucketName=" + storageName);
                    Console.WriteLine("Key=" + name);
                }
                fileIndex++;
            }
        }


        public static IEnumerable<Tuple<string, DateTime>> GetObjectInfo(IAmazonS3 awsClient, BlobContainerClient azureClient, string storageName, string prefix)
        {
            if (awsClient != null)
            {
                using (awsClient)
                {
                    var request = new ListObjectsV2Request { BucketName = storageName, Prefix = prefix };
                    Task<ListObjectsV2Response> task;

                    do
                    {
                        task = awsClient.ListObjectsV2Async(request);
                        task.Wait();

                        foreach (var o in task.Result.S3Objects)
                        {
                            yield return new Tuple<string, DateTime>(o.Key, o.LastModified);
                        }

                        request.ContinuationToken = task.Result.NextContinuationToken;

                    } while (task.Result.IsTruncated);
                }
            }
            else if (azureClient != null)
            {
                foreach (var blob in azureClient.GetBlobs(BlobTraits.None, BlobStates.None, prefix))
                {
                    yield return new Tuple<string, DateTime>(blob.Name, blob.Properties.LastModified.Value.DateTime);
                }
            }
        }

        public static BlobContainerClient GetBlobContainerClient()
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

        public static BlobContainerClient GetTriggerBlobContainerClient()
        {
            if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageHolder))
            {
                var credential = new ClientSecretCredential(
                  Settings.Settings.Current.CloudTriggerStorageHolder,
                  Settings.Settings.Current.CloudTriggerStorageKey,
                  Settings.Settings.Current.CloudTriggerStorageSecret);
                var client = new BlobServiceClient(new Uri(Settings.Settings.Current.CloudTriggerStorageUri), credential, null);
                return client.GetBlobContainerClient(Settings.Settings.Current.CloudTriggerStorageName);
            }
            else if (!string.IsNullOrEmpty(Settings.Settings.Current.CloudTriggerStorageConnectionString))
            {
                var client = new BlobServiceClient(Settings.Settings.Current.CloudTriggerStorageConnectionString);
                return client.GetBlobContainerClient(Settings.Settings.Current.CloudTriggerStorageName);
            }

            return null;
        }
    }
}