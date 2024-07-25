using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class EpisodeDataReader54(List<Episode> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<Episode> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 13; }
        }

        // is this called only because the datatype specific methods are not implemented?  
        // probably performance to be gained by not passing object back?
        public object GetValue(int i)
        {
            return i switch
            {
                0 => _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id),
                1 => _enumerator.Current.PersonId,
                2 => _enumerator.Current.ConceptId,
                3 => _enumerator.Current.StartDate,
                4 => _enumerator.Current.StartDate,
                5 => _enumerator.Current.EndDate,
                6 => _enumerator.Current.EndDate,
                7 => _enumerator.Current.EpisodeParentId,
                8 => _enumerator.Current.EpisodeNumber,
                9 => _enumerator.Current.EpisodeObjectConceptId,
                10 => _enumerator.Current.TypeConceptId,
                11 => _enumerator.Current.SourceValue,
                12 => _enumerator.Current.SourceConceptId,
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "episode_id",
                1 => "person_id",
                2 => "episode_concept_id",
                3 => "episode_start_date",
                4 => "episode_start_datetime",
                5 => "episode_end_date",
                6 => "episode_end_datetime",
                7 => "episode_parent_id",
                8 => "episode_number",
                9 => "episode_object_concept_id",
                10 => "episode_type_concept_id",
                11 => "episode_source_value",
                12 => "episode_source_concept_id",
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
                1 => typeof(long),
                2 => typeof(long),
                3 => typeof(DateTime),
                4 => typeof(DateTime),
                5 => typeof(DateTime),
                6 => typeof(DateTime),
                7 => typeof(long),
                8 => typeof(int),
                9 => typeof(long),
                10 => typeof(long),
                11 => typeof(string),
                12 => typeof(long),
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
