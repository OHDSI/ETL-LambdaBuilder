using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class CloadStorageHelper
    {
        public static void UploadFile(IAmazonS3 awsClient, BlobContainerClient azureClient, string storageName, string fileName, IDataReader reader)
        {
            CloadStorageHelper.UploadFile(awsClient, azureClient, storageName, fileName, reader, true, false);
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
    }
}