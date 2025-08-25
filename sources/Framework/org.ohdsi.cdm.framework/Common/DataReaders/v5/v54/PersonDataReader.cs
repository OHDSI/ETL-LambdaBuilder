using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class PersonDataReader(List<Person> batch) : IDataReader
    {
        private readonly IEnumerator<Person> _personEnumerator = batch?.GetEnumerator();

        public bool Read()
        {
            return _personEnumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 18; }
        }

        public object GetValue(int i)
        {
            return i switch
            {
                0 => _personEnumerator.Current.PersonId,
                1 => _personEnumerator.Current.GenderConceptId,
                2 => _personEnumerator.Current.YearOfBirth,
                3 => _personEnumerator.Current.MonthOfBirth,
                4 => _personEnumerator.Current.DayOfBirth,
                5 => _personEnumerator.Current.TimeOfBirth ?? null,
                6 => _personEnumerator.Current.RaceConceptId,
                7 => _personEnumerator.Current.EthnicityConceptId,
                8 => _personEnumerator.Current.LocationId,
                9 => _personEnumerator.Current.ProviderId == 0 ? null : _personEnumerator.Current.ProviderId,
                10 => _personEnumerator.Current.CareSiteId == 0 ? null : _personEnumerator.Current.CareSiteId,
                11 => _personEnumerator.Current.PersonSourceValue,
                12 => _personEnumerator.Current.GenderSourceValue,
                13 => _personEnumerator.Current.GenderSourceConceptId,
                14 => _personEnumerator.Current.RaceSourceValue,
                15 => _personEnumerator.Current.RaceSourceConceptId,
                16 => _personEnumerator.Current.EthnicitySourceValue,
                17 => _personEnumerator.Current.EthnicitySourceConceptId,
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "person_id",
                1 => "gender_concept_id",
                2 => "year_of_birth",
                3 => "month_of_birth",
                4 => "day_of_birth",
                5 => "birth_datetime",
                6 => "race_concept_id",
                7 => "ethnicity_concept_id",
                8 => "location_id",
                9 => "provider_id",
                10 => "care_site_id",
                11 => "person_source_value",
                12 => "gender_source_value",
                13 => "gender_source_concept_id",
                14 => "race_source_value",
                15 => "race_source_concept_id",
                16 => "ethnicity_source_value",
                17 => "ethnicity_source_concept_id",
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
                1 => typeof(long?),
                2 => typeof(int?),
                3 => typeof(int?),
                4 => typeof(int?),
                5 => typeof(DateTime),
                6 => typeof(long?),
                7 => typeof(long?),
                8 => typeof(long?),
                9 => typeof(long?),
                10 => typeof(long?),
                11 => typeof(string),
                12 => typeof(string),
                13 => typeof(long?),
                14 => typeof(string),
                15 => typeof(long?),
                16 => typeof(string),
                17 => typeof(long?),
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
