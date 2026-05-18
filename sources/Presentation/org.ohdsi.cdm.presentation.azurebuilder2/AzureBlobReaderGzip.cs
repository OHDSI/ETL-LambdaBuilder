using Azure.Storage.Blobs.Models;
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

        private string _fileName;
        private int _fileIndex = 0;

        private readonly string _prefix;

        private readonly long? _lastSavedPersonId;
        private SortedList<int, string> _files;

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

        public AzureBlobReaderGzip(string prefix, Dictionary<string, int> fieldHeaders, long initRow, long? lastSavedPersonId)
        {
            _prefix = prefix;
            _fieldHeaders = fieldHeaders;

            _spliter = new StringSplitter(this._fieldHeaders.Count);
            _lastSavedPersonId = lastSavedPersonId;

            if (initRow > 0)
                throw new Exception("initRow > 0");
            //Init(initRow);
            GetFiles();
            Init();
        }

        private void GetFiles()
        {
            try
            {
                _files = [];
                var bcc = AzureHelper.GetBlobContainer();
                //"temp/tmp_aivanov3/CDM/28/raw/17/Condition_occurrence/PartitionId=10"
                foreach (var b in bcc.GetBlobs(BlobTraits.None, BlobStates.None, _prefix))
                {
                    if (!b.Name.EndsWith("csv.gz"))
                        continue;

                    // part-00004-tid-3957083962449067901-cd3d81c9-b752-4836-b5b2-2f35fc986ab7-38842-3.c000.csv.gz
                    _files.Add(int.Parse(b.Name.Split('-')[1]), b.Name);
                }
            }
            catch (Exception e)
            {
                Settings.Current.Logger.LogInformation($"*********>>>{_fileName}; {_prefix}");

                Settings.Current.Logger.LogInformation($"----------------------------------------------");
                foreach (var item in _files)
                {
                    Settings.Current.Logger.LogInformation($">{item.Key};{item.Value}");
                }
                Settings.Current.Logger.LogInformation($"----------------------------------------------");

                var bcc2 = AzureHelper.GetBlobContainer();
                foreach (var b in bcc2.GetBlobs(BlobTraits.None, BlobStates.None, _prefix))
                {
                    if (!b.Name.EndsWith("csv.gz"))
                        continue;

                    // part-00004-tid-3957083962449067901-cd3d81c9-b752-4836-b5b2-2f35fc986ab7-38842-3.c000.csv.gz
                    //_files.Add(int.Parse(b.Name.Split('-')[1]), b.Name);
                    Settings.Current.Logger.LogInformation($"==>>>{b.Name}; {int.Parse(b.Name.Split('-')[1])}");
                }
                throw;
            }
        }

        private void Init()
        {
            if (_files.Count == 0)
                return;

            Close();
            Dispose();

            var initRow = 0;

            _fileName = _files.GetValueAtIndex(_fileIndex);

            Settings.Current.Logger.LogInformation(_fileName + ";initRow=" + initRow + ";lastSavedPersonId=" + _lastSavedPersonId);

            _stream = AzureHelper.OpenStream(_fileName);

            _bufferedStream = new BufferedStream(_stream);
            _gzipStream = new GZipStream(_bufferedStream, CompressionMode.Decompress);
            _reader = new StreamReader(_gzipStream, Encoding.Default);
            _fileIndex++;

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
            if (_files.Count == 0)
                return false;

            if (Paused)
                return true;

            try
            {
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

                if (_files.Count == _fileIndex)
                {
                    _lastReadTime = DateTime.MinValue;
                    return false;
                }
                else
                {
                    Init();

                    return Read();
                }
            }
            catch (Exception e)
            {
                throw;
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
