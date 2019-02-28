using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common2.Enums;
using Parquet;
using Parquet.Data;
using DataColumn = Parquet.Data.DataColumn;


namespace org.ohdsi.cdm.framework.common2.Extensions
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
            //return string.IsNullOrEmpty(fieldName) ? null : String.Intern(reader[fieldName].ToString().Trim());
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

        private static MemoryStream GetStreamSnappy(this IDataReader reader)
        {
            return reader.GetStreamSnappy(0).First();
        }

        public static IEnumerable<MemoryStream> GetStreamSnappy(this IDataReader reader, int batchSize)
        {
            var schema = CreateSchema(reader);

            var fields = schema.GetDataFields();
            var cnt = 0;
            var data = new Dictionary<int, List<object>>();
            while (reader.Read())
            {
                for (var i = 0; i < reader.FieldCount; i++)
                {
                    if (!data.ContainsKey(i))
                        data.Add(i, new List<object>());

                    var value = reader.GetValue(i);

                    if (value == null || value is DBNull)
                        data[i].Add(null);
                    else if (fields[i] is DateTimeDataField)
                    {
                        data[i].Add(value is DateTimeOffset ? value : new DateTimeOffset((DateTime)value));
                    }
                    else
                        data[i].Add(value);
                }

                cnt++;

                if (batchSize > 0 && cnt == batchSize)
                {
                    yield return CreateStream(schema, data);

                    data.Clear();
                    cnt = 0;
                }
            }

            if (cnt > 0)
                yield return CreateStream(schema, data);
        }

        private static Schema CreateSchema(IDataReader reader)
        {
            var fields = new List<DataField>(reader.FieldCount);
            for (var i = 0; i < reader.FieldCount; i++)
            {
                var t = reader.GetFieldType(i);
                var name = reader.GetName(i);

                if (t == typeof(int) || t == typeof(int?))
                {
                    fields.Add(new DataField(name, DataType.Int32, true, false));
                }
                else if (t == typeof(long) || t == typeof(long?))
                {
                    fields.Add(new DataField(name, DataType.Int64, true, false));
                }
                else if (t == typeof(decimal) || t == typeof(decimal?))
                {
                    fields.Add(new DataField(name, DataType.Decimal, true, false));
                }
                else if (t == typeof(double) || t == typeof(double?))
                {
                    fields.Add(new DataField(name, DataType.Double, true, false));
                }
                else if (t == typeof(float) || t == typeof(float?))
                {
                    fields.Add(new DataField(name, DataType.Float, true, false));
                }
                else if (t == typeof(string))
                {
                    fields.Add(new DataField(name, DataType.String, true, false));
                }
                else if (t == typeof(DateTime) || t == typeof(DateTime?) ||
                         t == typeof(DateTimeOffset) || t == typeof(DateTimeOffset?))
                {
                    fields.Add(new DateTimeDataField(reader.GetName(i), DateTimeFormat.Date, true, false));
                }
                else if (t == typeof(TimeSpan) || t == typeof(TimeSpan?))
                {
                    fields.Add(new DataField(name, DataType.String, true, false));
                }
            }

            return new Schema(fields);
        }

        private static MemoryStream CreateStream(Schema schema, Dictionary<int, List<object>> data)
        {
            var memoryStream = new MemoryStream();
            var fields = schema.GetDataFields();
            using (var parquet = new ParquetWriter(schema, memoryStream) { CompressionMethod = CompressionMethod.Snappy })
            using (var rgw = parquet.CreateRowGroup())
            {
                for (var i = 0; i < fields.Length; i++)
                {
                    var columData = data[i];
                    var dataField = fields[i];

                    switch (fields[i].DataType)
                    {
                        case DataType.Int32:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<int?>().ToArray()));
                            break;

                        case DataType.Int64:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<long?>().ToArray()));
                            break;

                        case DataType.Float:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<float?>().ToArray()));
                            break;

                        case DataType.Decimal:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<decimal?>().ToArray()));
                            break;

                        case DataType.Double:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<double?>().ToArray()));
                            break;

                        case DataType.String:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<string>().ToArray()));
                            break;

                        case DataType.DateTimeOffset:
                            rgw.WriteColumn(new DataColumn(dataField, columData.Cast<DateTimeOffset?>().ToArray()));
                            break;
                    }
                }
            }

            return memoryStream;
        }

        public static MemoryStream GetStream(this IDataReader reader, S3StorageType storageType)
        {
            return storageType == S3StorageType.CSV ? reader.GetStreamCSV() : reader.GetStreamSnappy();
        }


        private static MemoryStream GetStreamCSV(this IDataReader reader)
        {
            using (var memoryStream = new MemoryStream())
            using (var writer = new StreamWriter(memoryStream, new UTF8Encoding(false, true)))
            using (var csv = new CsvWriter(writer,
                new Configuration
                {
                    HasHeaderRecord = false,
                    Delimiter = "\t",
                    Quote = '`',
                    Encoding = Encoding.UTF8
                }))
            {
                while (reader.Read())
                {
                    for (var i = 0; i < reader.FieldCount; i++)
                    {
                        var type = reader.GetFieldType(i);
                        var value = reader.GetValue(i);
                        if (type == typeof(DateTime) && value != null)
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
                }

                writer.Flush();

                return Compress(memoryStream);
            }
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
