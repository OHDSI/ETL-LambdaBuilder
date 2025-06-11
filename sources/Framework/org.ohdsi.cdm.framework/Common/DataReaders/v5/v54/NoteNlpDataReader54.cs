using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class NoteNlpDataReader54(List<NoteNlp> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<NoteNlp> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 14; }
        }

        // is this called only because the datatype specific methods are not implemented?  
        // probably performance to be gained by not passing object back?
        public object GetValue(int i)
        {
            switch (i)
            {
                case 0:
                    return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.NoteNlpId);
                case 1:
                    return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.NoteId);
                case 2:
                    return _enumerator.Current.SectionConceptId;
                case 3:
                    return _enumerator.Current.Snippet;
                case 4:
                    return _enumerator.Current.Offset;
                case 5:
                    return _enumerator.Current.LexicalVariant;
                case 6:
                    return _enumerator.Current.NoteNlpConceptId;
                case 7:
                    return _enumerator.Current.NoteNlpSourceConceptId;
                case 8:
                    return _enumerator.Current.NlpSystem;
                case 9:
                    return _enumerator.Current.NlpDate;
                case 10:
                    return _enumerator.Current.NlpDate;
                case 11:
                    return _enumerator.Current.TermExists;
                case 12:
                    return _enumerator.Current.TermTemporal;
                case 13:
                    return _enumerator.Current.TermModifiers;
                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "note_nlp_id",
                1 => "note_id",
                2 => "section_concept_id",
                3 => "snippet",
                4 => "offset",
                5 => "lexical_variant",
                6 => "note_nlp_concept_id",
                7 => "note_nlp_source_concept_id",
                8 => "nlp_system",
                9 => "nlp_date",
                10 => "nlp_date_time",
                11 => "term_exists",
                12 => "term_temporal",
                13 => "term_modifiers",
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
                2 => typeof(DateTime),
                3 => typeof(DateTime),
                4 => typeof(long?),
                5 => typeof(string),
                6 => typeof(long?),
                7 => typeof(long?),
                8 => typeof(long?),
                9 => typeof(string),
                10 => typeof(long),
                11 => typeof(string),
                12 => typeof(long),
                13 => typeof(long),
                14 => typeof(long),
                15 => typeof(long),
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
