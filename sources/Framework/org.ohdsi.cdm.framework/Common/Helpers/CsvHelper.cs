using CsvHelper;
using CsvHelper.Configuration;
using System.Data;
using System.Globalization;
using System.IO.Compression;
using System.Text;

namespace org.ohdsi.cdm.framework.common.Helpers
{
    public static class CsvHelper
    {
        private const string NewLine = "\n";
        private const string Delimiter = ",";
        private const char Quote = '"';
        private const string NullAs = @"\N";

        private static CsvConfiguration CsvConfiguration
        {
            get
            {
                return new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    Delimiter = Delimiter,
                    Quote = Quote,
                    Encoding = Encoding.UTF8,
                    IgnoreBlankLines = true,
                    HasHeaderRecord = false
                };
            }
        }

        public static CsvWriter CreateCsvWriter(TextWriter innerWriter)
        {
            innerWriter.NewLine = NewLine;
            return new CsvWriter(innerWriter, CsvConfiguration);
        }
        
        public static CsvReader CreateCsvReader(TextReader reader)
        {
            return new CsvReader(reader, CsvConfiguration);
        }

        public static IEnumerable<MemoryStream> GetStreamCsv(IDataReader reader)
        {
            return GetStreamCsv(reader, null, true, false);
        }

        public static IEnumerable<MemoryStream> GetStreamCsv(IDataReader reader, int? breakUpSize, bool compress, bool schemaOnly)
        {
            var rowCount = 0;
            
            var source = new MemoryStream();
            StreamWriter writer = new(source, new UTF8Encoding(false, true));
            var csv = CreateCsvWriter(writer);
            while (reader.Read())
            {
                for (var i = 0; i < reader.FieldCount; i++)
                {
                    if (schemaOnly)
                    {
                        var fieldName = reader.GetName(i);
                        csv.WriteField(fieldName);
                    }
                    else
                    {
                        var type = reader.GetFieldType(i);
                        var value = reader.GetValue(i);
                        if ((type == typeof(DateTime) || type == typeof(DateTime?)) && value != null && value is not DBNull)
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
                            csv.WriteField(NullAs);
                        }
                        else
                        {
                            csv.WriteField(value ?? string.Empty);
                        }
                    }
                }
                csv.NextRecord();
                rowCount++;

                if(breakUpSize.HasValue && rowCount > breakUpSize.Value)
                {
                    writer.Flush();
                    yield return Compress(source, compress);

                    csv.Dispose();
                    writer.Dispose();
                    source.Dispose();

                    source = new MemoryStream();
                    writer = new(source, new UTF8Encoding(false, true));
                    csv = CreateCsvWriter(writer);
                    rowCount = 0;
                }
            }

            writer.Flush();
            
            yield return Compress(source, compress);

            csv.Dispose();
            writer.Dispose();
            source.Dispose();
        }

        private static MemoryStream Compress(MemoryStream inputStream, bool useCompression)
        {
            if (!useCompression)
                return inputStream;

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
