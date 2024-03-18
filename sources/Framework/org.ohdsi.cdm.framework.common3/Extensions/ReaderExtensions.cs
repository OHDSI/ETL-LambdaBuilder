using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Text;


namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class ReaderExtensions
    {
        public static T? GetValue<T>(this IDataReader reader, string fieldName) where T : struct
        {
            if (string.IsNullOrEmpty(fieldName))
                return null;

            var value = reader[fieldName];

            if (value is DBNull)
                return null;

            if (typeof(T) == typeof(decimal))
            {
                decimal? result = Convert.ToDecimal(value);
                return result as T?;
            }

            if (typeof(T) == typeof(long))
            {
                long? result = Convert.ToInt64(value);
                return result as T?;
            }

            if (typeof(T) == typeof(int))
            {
                int? result = Convert.ToInt32(value);
                return result as T?;
            }

            return reader[fieldName] as T?;
        }

        public static string GetString(this IDataReader reader, string fieldName)
        {
            return string.IsNullOrEmpty(fieldName) ? null : reader[fieldName].ToString().Trim();
        }

        public static int? GetInt(this IDataReader reader, string fieldName)
        {
            return reader.GetValue<int>(fieldName);
        }

        public static decimal? GetDecimal(this IDataReader reader, string fieldName)
        {
            return reader.GetValue<decimal>(fieldName);
        }

        public static DateTime GetDateTime(this IDataReader reader, string fieldName)
        {
            var result = reader.GetValue<DateTime>(fieldName);
            if (!result.HasValue)
            {
                var dateTimeString = reader.GetString(fieldName);
                if (!string.IsNullOrEmpty(dateTimeString) && DateTime.TryParse(dateTimeString, out var dateTime))
                {
                    return dateTime;
                }
            }

            return result ?? DateTime.MinValue;
        }

        public static long? GetLong(this IDataReader reader, string fieldName)
        {
            return reader.GetValue<long>(fieldName);
        }

         public static MemoryStream GetStream(this IDataReader reader, S3StorageType storageType)
        {
            return reader.GetStreamCsv();
        }

         private static CsvWriter CreateCsvWriter(TextWriter innerWriter)
        {
            innerWriter.NewLine = "\n";
            return new CsvWriter(
               innerWriter,
               new CsvConfiguration(CultureInfo.InvariantCulture)
               {
                   Delimiter = ",",
                   Quote = '"',
                   Encoding = Encoding.UTF8,
                   IgnoreBlankLines = true,
                   HasHeaderRecord = false
               });
        }

        public static MemoryStream GetStreamCsv(this IDataReader reader)
        {
            using var memoryStream = new MemoryStream();
            using var writer = new StreamWriter(memoryStream, new UTF8Encoding(false, true), 1024, true);
            using var csv = CreateCsvWriter(writer);
            int rowCnt = 0;
            while (reader.Read())
            {
                for (var i = 0; i < reader.FieldCount; i++)
                {
                    var type = reader.GetFieldType(i);
                    var value = reader.GetValue(i);
                    if ((type == typeof(DateTime) || type == typeof(DateTime?)) && value != null)
                    {
                        if (reader.GetName(i).Contains("datetime", StringComparison.CurrentCultureIgnoreCase))
                        {
                            csv.WriteField(((DateTime)value).ToString("yyyy-MM-dd HH:mm:ss.fff"));
                        }
                        else
                            csv.WriteField(((DateTime)value).ToString("yyyy-MM-dd"));
                    }
                    else if (type == typeof(string) && (value == null || value is DBNull))
                    {
                        csv.WriteField(@"\N");
                    }
                    else
                    {
                        csv.WriteField(value ?? string.Empty);
                    }
                }

                csv.NextRecord();
                rowCnt++;
            }

            writer.Flush();
            return Compress(memoryStream);
        }

        private static MemoryStream Compress(Stream inputStream)
        {
            inputStream.Position = 0;
            var outputStream = new MemoryStream();
            using (var gz = new BufferedStream(new GZipStream(outputStream, CompressionLevel.Optimal, true)))
            {
                inputStream.CopyTo(gz);
            }

            outputStream.Position = 0;

            return outputStream;
        }
    }
}
