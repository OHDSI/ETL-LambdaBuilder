using Amazon.S3;
using Amazon.S3.Transfer;
using CsvHelper;
using CsvHelper.Configuration;
using System;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Text;

namespace org.ohdsi.cdm.framework.desktop.Helpers
{
    public class AmazonS3Helper
    {
        public static void CopyFile(IAmazonS3 client, string bucketName, string fileName, IDataReader reader, string delimiter, char quote, string nullAs)
        {
            int fileIndex = 0;
            var fileEnded = false;

            while (!fileEnded)
            {
                var name = fileName;

                if (fileIndex > 0)
                    name = fileName + "." + fileIndex;

                fileEnded = SaveFilePart(client, bucketName, name, reader, delimiter, quote, nullAs);
                fileIndex++;
            }
        }

        private static CsvWriter CreateCsvWriter(TextWriter innerWriter, string delimiter, char quote)
        {
            innerWriter.NewLine = "\n";
            return new CsvWriter(
               innerWriter,
               new CsvConfiguration(CultureInfo.InvariantCulture)
               {
                   Delimiter = delimiter,
                   Quote = quote,
                   Encoding = Encoding.UTF8,
                   IgnoreBlankLines = true,
                   HasHeaderRecord = false
               });
        }

        private static bool SaveFilePart(IAmazonS3 client, string bucketName, string fileName, IDataReader reader, string delimiter, char quote, string nullAs)
        {
            var rowNumbers = 0;
            const int rowLimit = 10_000_000;
            var ended = false;

            using (var source = new MemoryStream())
            using (StreamWriter writer = new(source, new UTF8Encoding(false, true)))
            using (var csv = CreateCsvWriter(writer, delimiter, quote))
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
                            csv.WriteField(nullAs);
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

                Console.WriteLine("BucketName=" + bucketName);
                Console.WriteLine("Key=" + fileName);

                using var gz = Compress(source);
                using var directoryTransferUtility = new TransferUtility(client);
                directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                {
                    BucketName = bucketName,
                    Key = fileName,
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                    StorageClass = S3StorageClass.Standard,
                    InputStream = gz
                });
            }

            return ended;
        }

        public static MemoryStream Compress(Stream inputStream)
        {
            var timer = new Stopwatch();
            timer.Start();
            inputStream.Position = 0;
            var outputStream = new MemoryStream();
            using (var gz = new GZipStream(outputStream, CompressionLevel.Optimal, true))
            {
                inputStream.CopyTo(gz);
            }
            outputStream.Position = 0;
            timer.Stop();
            return outputStream;
        }
    }
}