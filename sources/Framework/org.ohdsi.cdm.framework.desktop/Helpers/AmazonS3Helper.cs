using System;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Text;
using Amazon.S3;
using Amazon.S3.Transfer;
using CsvHelper;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class AmazonS3Helper
    {
        public static void CopyFile(IAmazonS3 client, string bucketName, string fileName, IDataReader reader)
        {
            int fileIndex = 0;
            var fileEnded = false;

            while (!fileEnded)
            {
                var name = fileName + "." + fileIndex;
                fileEnded = SaveFilePart(client, bucketName, name, reader);
                fileIndex++;
            }
        }

        private static bool SaveFilePart(IAmazonS3 client, string bucketName, string fileName, IDataReader reader)
        {
            var rowNumbers = 0;
            const int rowLimit = 10 * 1000 * 1000;
            var ended = false;

            using (var source = new MemoryStream())
            using (TextWriter writer = new StreamWriter(source, new UTF8Encoding(false, true)))
            using (
               var csv = new CsvWriter(writer,
                  new CsvHelper.Configuration.Configuration
                  {
                      HasHeaderRecord = false,
                      Delimiter = "\t",
                      Quote = '`',
                      Encoding = Encoding.UTF8
                  }))
            {
                while (rowNumbers < rowLimit)
                {
                    ended = !reader.Read();

                    if (ended)
                        break;

                    for (var i = 0; i < reader.FieldCount; i++)
                    {
                        var type = reader.GetFieldType(i);
                        var value = reader.GetValue(i);
                        if (type == typeof(DateTime) && value != null && !(value is DBNull))
                        {
                            csv.WriteField(((DateTime)value).ToString("yyyy-MM-dd"));
                        }
                        else if (type == typeof(string) && (value == null || value is DBNull))
                        {
                            csv.WriteField('\0');
                        }
                        else
                        {
                            csv.WriteField(value ?? string.Empty);
                        }
                    }
                    csv.NextRecord();
                    rowNumbers++;
                }
                writer.Flush();

                using (var gz = Compress(source))
                using (var directoryTransferUtility = new TransferUtility(client))
                {
                    directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                    {
                        BucketName = bucketName,
                        Key = fileName,
                        ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                        StorageClass = S3StorageClass.Standard,
                        InputStream = gz
                    });
                }
            }

            return ended;
        }

        public static MemoryStream Compress(Stream inputStream)
        {
            var timer = new Stopwatch();
            timer.Start();
            inputStream.Position = 0;
            var outputStream = new MemoryStream();
            using (var gz = new GZipStream(outputStream, CompressionLevel.Fastest, true))
            {
                inputStream.CopyTo(gz);
            }
            outputStream.Position = 0;
            timer.Stop();
            return outputStream;
        }
    }
}
