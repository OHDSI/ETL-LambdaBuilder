using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Text;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common2.Helpers;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class S3DataReader2 : IDataReader
    {
        private string[] _currentLine;


        private readonly int _chunkId;
        private readonly string _bucket;
        private readonly string _folder;
        private readonly string _fileName;
        private readonly Dictionary<string, int> _fieldHeaders;
        private readonly StringSplitter _spliter;
        private readonly string _prefix;

        private Stream _responseStream;
        private BufferedStream _bufferedStream;
        private GZipStream _gzipStream;
        private StreamReader _reader;

        private TransferUtility _transferUtility;
        private long _rowIndex;

        public long RowIndex
        {
            get { return _rowIndex; }
        }

        public S3DataReader2(string bucket, string folder, string awsAccessKeyId,
           string awsSecretAccessKey, int chunkId, string fileName, Dictionary<string, int> fieldHeaders, string prefix, long initRow)
        {
            _chunkId = chunkId;
            _bucket = bucket;
            _folder = folder;
            _fileName = fileName;
            _fieldHeaders = fieldHeaders;
            _prefix = prefix;
            _spliter = new StringSplitter(this._fieldHeaders.Count);


            _transferUtility = new TransferUtility(awsAccessKeyId, awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            _responseStream = _transferUtility.OpenStream(bucket, $"{folder}/{chunkId}/{fileName}/{fileName}{prefix}_part_00.gz");

            _bufferedStream = new BufferedStream(_responseStream);
            _gzipStream = new GZipStream(_bufferedStream, CompressionMode.Decompress);
            _reader = new StreamReader(_gzipStream, Encoding.Default);

            _rowIndex = initRow;
            for (var i = 0; i < initRow; i++)
            {
                _reader.ReadLine();
            }

            if (initRow > 0)
                Console.WriteLine($"{fileName}{prefix}_part_00.gz; Rows skipped={initRow}");
        }


        public void Close()
        {
            _responseStream.Close();
            _bufferedStream.Close();
            _gzipStream.Close();
            _reader.Close();
        }

        public void Dispose()
        {
            _responseStream.Dispose();
            _bufferedStream.Dispose();
            _gzipStream.Dispose();
            _reader.Dispose();
            _transferUtility.Dispose();
        }

        public bool Read()
        {
            try
            {
                string line;
                while (!Settings.Current.WatchdogTimeout && (line = _reader.ReadLine()) != null)
                {
                    Settings.Current.ReadIdle = false;
                    if (!string.IsNullOrEmpty(line))
                    {
                        try
                        {
                            _spliter.Split(line, '\t');
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(_fileName);
                            Console.WriteLine(line);
                            Console.WriteLine("WARN_EXC - Read - Split - throw");
                            Console.WriteLine(ex.Message);
                            Console.WriteLine(ex.StackTrace);
                            throw;
                        }

                        _currentLine = _spliter.Results;
                        _rowIndex++;

                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("WARN_EXC - Read - throw");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }

            return false;
        }

        object IDataRecord.this[int i]
        {
            get
            {
                return _currentLine[i];
            }
        }

        object IDataRecord.this[string name]
        {
            get
            {
                return _currentLine[_fieldHeaders[name]];
            }
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
            throw new NotImplementedException();
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
