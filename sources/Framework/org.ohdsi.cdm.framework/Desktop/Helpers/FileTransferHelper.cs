using Amazon.S3;
using Amazon.S3.Transfer;
using Azure.Storage.Blobs;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class FileTransferHelper
    {
        public static void UploadFile(IAmazonS3 awsClient, BlobContainerClient azureClient, string bucketName, string fileName, IDataReader reader)
        {
            int fileIndex = 0;
            var name = fileName;

            foreach (var stream in common.Helpers.CsvHelper.GetStreamCsv(reader, 10_000_000))
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
                                BucketName = bucketName,
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

                    Console.WriteLine("BucketName=" + bucketName);
                    Console.WriteLine("Key=" + name);
                }
                fileIndex++;
            }
        }
    }
}