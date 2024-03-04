using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Helpers;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.framework.desktop.DataReaders
{

    public class S3DataReader : IDataReader
    {
        private readonly IEnumerator<string[]> _enumerator;

        private readonly AmazonS3Client _client;
        private readonly int _chunkId;
        private readonly string _bucket;
        private readonly string _folder;
        private readonly string _fileName;
        private readonly Dictionary<string, int> _fieldHeaders;
        private readonly string _prefix;

        public S3DataReader(string bucket, string folder, string awsAccessKeyId,
           string awsSecretAccessKey, int chunkId, string fileName, Dictionary<string, int> fieldHeaders, string prefix)
        {
            _chunkId = chunkId;
            _bucket = bucket;
            _folder = folder;
            _fileName = fileName;
            _fieldHeaders = fieldHeaders;
            _prefix = prefix;

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            _client = new AmazonS3Client(awsAccessKeyId, awsSecretAccessKey, config);

            var data = GetData();
            data.Wait();

            _enumerator = data.Result.GetEnumerator();
        }

        private async Task<List<string[]>> GetData()
        {
            var data = new List<string[]>();
            var files = await GetFiles();
            foreach (var file in files)
            {
                var getObjectRequest = new GetObjectRequest
                {
                    BucketName = _bucket,
                    Key = file
                };

                var lines = new BlockingCollection<string>();


                using var getObjectResponse = await _client.GetObjectAsync(getObjectRequest);
                var r = getObjectResponse;
                var stage1 = Task.Run(() =>
                {
                    try
                    {
                        using var responseStream = r.ResponseStream;
                        using var bufferedStream = new BufferedStream(responseStream);
                        using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                        using var reader = new StreamReader(gzipStream, Encoding.Default);
                        string line;

                        while ((line = reader.ReadLine()) != null)
                        {
                            lines.Add(line);
                        }

                    }
                    finally
                    {
                        lines.CompleteAdding();
                    }
                });

                var spliter = new StringSplitter(_fieldHeaders.Count);
                foreach (var line in lines.GetConsumingEnumerable())
                {
                    if (!string.IsNullOrEmpty(line))
                    {
                        try
                        {
                            spliter.Split(line, '\t');
                        }
                        catch (Exception)
                        {
                            throw;
                        }

                        data.Add(spliter.Results);
                    }
                }

                stage1.Wait();
            }

            return data;
        }


        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        private async Task<IList<string>> GetFiles()
        {
            var result = new List<string>();
            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = $"{_folder}/{_chunkId}/{_fileName}/{_fileName + _prefix}"
            };

            ListObjectsV2Response response;
            do
            {
                response = await _client.ListObjectsV2Async(request);

                foreach (var entry in response.S3Objects)
                {
                    //1. entry.Size 20byte add filtraion
                    //2. split by subfolders
                    //3. restore point, store max subSaved person id
                    if (entry.Size > 20)
                        result.Add(entry.Key);
                }

                request.ContinuationToken = response.NextContinuationToken;
            } while (response.IsTruncated);

            return result;
        }



        object IDataRecord.this[int i] => _enumerator.Current?[i];

        object IDataRecord.this[string name] => _enumerator.Current?[_fieldHeaders[name]];

        public void Close()
        {
        }

        public void Dispose()
        {
            _client.Dispose();
            GC.SuppressFinalize(this);
        }

        public int FieldCount { get; private set; }

        #region NotImplemented
        public string GetName(int i)
        {
            throw new NotImplementedException();
        }

        public string GetDataTypeName(int i)
        {
            throw new NotImplementedException();
        }

        public Type GetFieldType(int i)
        {
            throw new NotImplementedException();
        }

        public object GetValue(int i)
        {
            throw new NotImplementedException();
        }

        public int GetValues(object[] values)
        {
            var cnt = 0;
            for (var i = 0; i < FieldCount; i++)
            {
                values[i] = GetValue(i);
                cnt++;
            }

            return cnt;
        }

        public int GetOrdinal(string name)
        {
            throw new NotImplementedException();
        }

        public bool GetBoolean(int i)
        {
            throw new NotImplementedException();
        }

        public byte GetByte(int i)
        {
            throw new NotImplementedException();
        }

        public long GetBytes(int i, long fieldOffset, byte[] buffer, int bufferoffset, int length)
        {
            throw new NotImplementedException();
        }

        public char GetChar(int i)
        {
            throw new NotImplementedException();
        }

        public long GetChars(int i, long fieldoffset, char[] buffer, int bufferoffset, int length)
        {
            throw new NotImplementedException();
        }

        public Guid GetGuid(int i)
        {
            throw new NotImplementedException();
        }

        public short GetInt16(int i)
        {
            throw new NotImplementedException();
        }

        public int GetInt32(int i)
        {
            throw new NotImplementedException();
        }

        public long GetInt64(int i)
        {
            throw new NotImplementedException();
        }

        public float GetFloat(int i)
        {
            throw new NotImplementedException();
        }

        public double GetDouble(int i)
        {
            throw new NotImplementedException();
        }

        public string GetString(int i)
        {
            throw new NotImplementedException();
        }

        public decimal GetDecimal(int i)
        {
            throw new NotImplementedException();
        }

        public DateTime GetDateTime(int i)
        {
            throw new NotImplementedException();
        }

        public IDataReader GetData(int i)
        {
            throw new NotImplementedException();
        }

        public bool IsDBNull(int i)
        {
            throw new NotImplementedException();
        }

        public DataTable GetSchemaTable()
        {
            throw new NotImplementedException();
        }

        public bool NextResult()
        {
            throw new NotImplementedException();
        }

        public int Depth { get; private set; }
        public bool IsClosed { get; private set; }
        public int RecordsAffected { get; private set; }
        #endregion
    }
}
