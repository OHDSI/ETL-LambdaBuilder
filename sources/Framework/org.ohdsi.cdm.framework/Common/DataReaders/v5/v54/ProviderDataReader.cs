using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class ProviderDataReader(List<Provider> batch) : IDataReader
    {
        private readonly IEnumerator<Provider> _enumerator = batch?.GetEnumerator();

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 13; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            return i switch
            {
                0 => _enumerator.Current.Id,
                1 => _enumerator.Current.Name,
                2 => _enumerator.Current.Npi,
                3 => _enumerator.Current.Dea,
                4 => _enumerator.Current.ConceptId,//SPECIALTY_CONCEPT_ID
                5 => _enumerator.Current.CareSiteId == 0 ? null : _enumerator.Current.CareSiteId,
                6 => _enumerator.Current.YearOfBirth,
                7 => _enumerator.Current.GenderConceptId,
                8 => _enumerator.Current.ProviderSourceValue,
                9 => _enumerator.Current.SourceValue,//SPECIALTY_SOURCE_VALUE
                10 => _enumerator.Current.SpecialtySourceConceptId,
                11 => _enumerator.Current.GenderSourceValue,
                12 => _enumerator.Current.GenderSourceConceptId,
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "provider_id",
                1 => "provider_name",
                2 => "npi",
                3 => "dea",
                4 => "specialty_concept_id",
                5 => "care_site_id",
                6 => "year_of_birth",
                7 => "gender_concept_id",
                8 => "provider_source_value",
                9 => "specialty_source_value",
                10 => "specialty_source_concept_id",
                11 => "gender_source_value",
                12 => "gender_source_concept_id",
                _ => throw new NotImplementedException(),
            };
        }

        #region implementationn not required for SqlBulkCopy

        public bool NextResult()
        {
            throw new NotImplementedException();
        }

        public void Close()
        {
            throw new NotImplementedException();
        }

        public bool IsClosed
        {
            get { throw new NotImplementedException(); }
        }

        public int Depth
        {
            get { throw new NotImplementedException(); }
        }

        public DataTable GetSchemaTable()
        {
            throw new NotImplementedException();
        }

        public int RecordsAffected
        {
            get { throw new NotImplementedException(); }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public bool GetBoolean(int i)
        {
            return (bool)GetValue(i);
        }

        public byte GetByte(int i)
        {
            return (byte)GetValue(i);
        }

        public long GetBytes(int i, long fieldOffset, byte[] buffer, int bufferoffset, int length)
        {
            throw new NotImplementedException();
        }

        public char GetChar(int i)
        {
            return (char)GetValue(i);
        }

        public long GetChars(int i, long fieldoffset, char[] buffer, int bufferoffset, int length)
        {
            throw new NotImplementedException();
        }

        public IDataReader GetData(int i)
        {
            throw new NotImplementedException();
        }

        public string GetDataTypeName(int i)
        {
            throw new NotImplementedException();
        }

        public DateTime GetDateTime(int i)
        {
            return (DateTime)GetValue(i);
        }

        public decimal GetDecimal(int i)
        {
            return (decimal)GetValue(i);
        }

        public double GetDouble(int i)
        {
            return Convert.ToDouble(GetValue(i));
        }

        public Type GetFieldType(int i)
        {
            return i switch
            {
                0 => typeof(long),
                1 => typeof(string),
                2 => typeof(string),
                3 => typeof(string),
                4 => typeof(long),
                5 => typeof(long?),
                6 => typeof(int?),
                7 => typeof(long?),
                8 => typeof(string),
                9 => typeof(string),
                10 => typeof(long?),
                11 => typeof(string),
                12 => typeof(long?),
                _ => throw new NotImplementedException(),
            };
        }

        public float GetFloat(int i)
        {
            return (float)GetValue(i);
        }

        public Guid GetGuid(int i)
        {
            return (Guid)GetValue(i);
        }

        public short GetInt16(int i)
        {
            return (short)GetValue(i);
        }

        public int GetInt32(int i)
        {
            return (int)GetValue(i);
        }

        public long GetInt64(int i)
        {
            return Convert.ToInt64(GetValue(i));
        }

        public int GetOrdinal(string name)
        {
            throw new NotImplementedException();
        }

        public string GetString(int i)
        {
            return (string)GetValue(i);
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

        public bool IsDBNull(int i)
        {
            return GetValue(i) == null;
        }

        public object this[string name]
        {
            get { throw new NotImplementedException(); }
        }

        public object this[int i]
        {
            get { throw new NotImplementedException(); }
        }

        #endregion
    }
}
