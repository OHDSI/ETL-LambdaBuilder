using Microsoft.Extensions.Logging;
using org.ohdsi.cdm.framework.common.Helpers;
using System.Data;
using System.IO.Compression;
using System.Text;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class AzureBlobReaderGzip : IDataReader
    {
        private string[] _currentLine;

        private readonly string _fileName;
        
        private readonly Dictionary<string, int> _fieldHeaders;
        private readonly StringSplitter _spliter;

        private Stream _stream;
        private BufferedStream _bufferedStream;
        private GZipStream _gzipStream;
        private StreamReader _reader;
        private long _rowIndex;

        private DateTime _lastReadTime;

        public long RowIndex
        {
            get { return _rowIndex; }
        }

        public TimeSpan IdleTime
        {
            get
            {
                if (_lastReadTime == DateTime.MinValue)
                    return TimeSpan.Zero;

                return DateTime.Now.Subtract(_lastReadTime);
            }
        }

        public bool Paused { get; private set; } = false;


        public void Pause()
        {
            Paused = true;
        }

        public void Resume()
        {
            Paused = false;
        }

        public AzureBlobReaderGzip(string fileName, Dictionary<string, int> fieldHeaders, long initRow)
        {

            _fileName = fileName;
            _fieldHeaders = fieldHeaders;

            _spliter = new StringSplitter(this._fieldHeaders.Count);

            Init(initRow);
        }

        private void Init(long initRow)
        {
            Close();
            Dispose();

            Settings.Current.Logger.LogInformation(_fileName + " " + initRow);

            _stream = AzureHelper.OpenStream(_fileName);

            _bufferedStream = new BufferedStream(_stream);
            _gzipStream = new GZipStream(_bufferedStream, CompressionMode.Decompress);
            _reader = new StreamReader(_gzipStream, Encoding.Default);

            _rowIndex = initRow;
            for (var i = 0; i < initRow; i++)
            {
                _reader.ReadLine();
            }

            if (initRow > 0)
                Settings.Current.Logger.LogInformation($"{_fileName}; Rows skipped={initRow}");

            _lastReadTime = DateTime.MinValue;
        }

        public void Close()
        {
            _stream?.Close();
            _bufferedStream?.Close();
            _gzipStream?.Close();
            _reader?.Close();
        }

        public void Dispose()
        {
            _stream?.Dispose();
            _bufferedStream?.Dispose();
            _gzipStream?.Dispose();

            _reader?.Dispose();

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public void Restart()
        {
            Settings.Current.Logger.LogInformation($"{_fileName} - restarting... (IdleTime={IdleTime.TotalSeconds})");
            Close();
            Dispose();
        }

        public bool Read()
        {
            if (Paused)
                return true;

            var attempt = 0;
            while (true)
            {
                try
                {
                    attempt++;
                    string line;

                    while ((line = _reader.ReadLine()) != null)
                    {
                        _lastReadTime = DateTime.Now;

                        if (!string.IsNullOrEmpty(line))
                        {

                            _spliter.Split(line, '\t');

                            _currentLine = _spliter.Results;
                            _rowIndex++;

                            return true;
                        }
                    }

                    _lastReadTime = DateTime.MinValue;
                    return false;
                }
                catch (Exception e)
                {
                    _lastReadTime = DateTime.Now;

                    Settings.Current.Logger.LogInformation($"{_fileName} AzureBlobReaderGzip attempt={attempt} | Exception={e.Message}");
                    Init(_rowIndex);
                    if (attempt > 5)
                    {
                        Settings.Current.Logger.LogInformation("WARN_EXC - Read - throw");
                        Settings.Current.Logger.LogInformation(e.Message);
                        Settings.Current.Logger.LogInformation(e.StackTrace);
                        throw;
                    }
                }
            }
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
