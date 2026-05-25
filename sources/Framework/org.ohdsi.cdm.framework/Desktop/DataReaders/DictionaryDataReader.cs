using System.Collections;
using System.Data;

namespace org.ohdsi.cdm.framework.Desktop.DataReaders
{
    public class DictionaryDataReader : IDataReader
    {
        private Dictionary<string, string> _dictionary;
        private IEnumerator<KeyValuePair<string, string>> _enumerator;
        private KeyValuePair<string, string> _current;
        private bool _hasRows;

        public DictionaryDataReader(Dictionary<string, string> dictionary)
        {
            _dictionary = dictionary;
            _enumerator = _dictionary.GetEnumerator();
            _hasRows = dictionary.Count > 0;
        }

        public bool Read()
        {
            if (_enumerator.MoveNext())
            {
                _current = _enumerator.Current;
                return true;
            }
            return false;
        }

        public int FieldCount => 2; // Key and Value

        public string GetName(int i)
        {
            if (i == 0) return "Key";
            if (i == 1) return "Value";
            throw new IndexOutOfRangeException();
        }

        public Type GetFieldType(int i)
        {
            if (i == 0 || i == 1) return typeof(string);
            throw new IndexOutOfRangeException();
        }

        public object GetValue(int i)
        {
            if (i == 0) return _current.Key;
            if (i == 1) return _current.Value;
            throw new IndexOutOfRangeException();
        }

        public bool IsDBNull(int i) => false;
        public void Close() { }
        public DataTable GetSchemaTable() => throw new NotSupportedException();
        public bool HasRows => _hasRows;
        public int RecordsAffected => -1;
        public bool NextResult() => false;
        public int Depth => 0;

        public bool IsClosed => throw new NotImplementedException();

        public object this[string name] => throw new NotImplementedException();

        public object this[int ordinal] => throw new NotImplementedException();

        // Implement specific type getters
        public string GetString(int i) => (string)GetValue(i);

        public bool GetBoolean(int ordinal)
        {
            throw new NotImplementedException();
        }

        public byte GetByte(int ordinal)
        {
            throw new NotImplementedException();
        }

        public long GetBytes(int ordinal, long dataOffset, byte[]? buffer, int bufferOffset, int length)
        {
            throw new NotImplementedException();
        }

        public char GetChar(int ordinal)
        {
            throw new NotImplementedException();
        }

        public long GetChars(int ordinal, long dataOffset, char[]? buffer, int bufferOffset, int length)
        {
            throw new NotImplementedException();
        }

        public string GetDataTypeName(int ordinal)
        {
            throw new NotImplementedException();
        }

        public DateTime GetDateTime(int ordinal)
        {
            throw new NotImplementedException();
        }

        public decimal GetDecimal(int ordinal)
        {
            throw new NotImplementedException();
        }

        public double GetDouble(int ordinal)
        {
            throw new NotImplementedException();
        }

        public IEnumerator GetEnumerator()
        {
            throw new NotImplementedException();
        }

        public float GetFloat(int ordinal)
        {
            throw new NotImplementedException();
        }

        public Guid GetGuid(int ordinal)
        {
            throw new NotImplementedException();
        }

        public short GetInt16(int ordinal)
        {
            throw new NotImplementedException();
        }

        public int GetInt32(int ordinal)
        {
            throw new NotImplementedException();
        }

        public long GetInt64(int ordinal)
        {
            throw new NotImplementedException();
        }

        public int GetOrdinal(string name)
        {
            throw new NotImplementedException();
        }

        public int GetValues(object[] values)
        {
            throw new NotImplementedException();
        }

        public IDataReader GetData(int i)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}