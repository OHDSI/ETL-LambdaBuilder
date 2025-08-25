using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class CdmSourceDataReader : IDataReader
    {
        private readonly IEnumerator<CdmSource> _enumerator;

        // A custom DataReader is implemented to prevent the need for the HashSet to be transformed to a DataTable for loading by SqlBulkCopy
        public CdmSourceDataReader()
        {
            _enumerator = new List<CdmSource> { new() }.GetEnumerator();
        }

        public CdmSourceDataReader(DateTime sourceReleaseDate, string vocabularyVersion)
        {
            _enumerator = new List<CdmSource>
            {
                new() 
                {
                    SourceReleaseDate = sourceReleaseDate, 
                    VocabularyVersion = vocabularyVersion,
                    CdmSourceName = "",
                    CdmVersionConceptId = 756265  //OMOP CDM Version 5.4.0
                }
                
            }.GetEnumerator();
        }

        public CdmSourceDataReader(CdmSource cdmSource)
        {
            _enumerator = new List<CdmSource>
            {
                cdmSource
            }.GetEnumerator();
        }

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 11; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            return i switch
            {
                0 => _enumerator.Current.CdmSourceName,
                1 => _enumerator.Current.CdmSourceAbbreviation,
                2 => _enumerator.Current.CdmHolder,
                3 => _enumerator.Current.SourceDescription,
                4 => _enumerator.Current.SourceDocumentationReference,
                5 => _enumerator.Current.CdmEtlReference,
                6 => _enumerator.Current.SourceReleaseDate,
                7 => _enumerator.Current.CdmReleaseDate,
                8 => _enumerator.Current.CdmVersion,
                9 => _enumerator.Current.CdmVersionConceptId,
                10 => _enumerator.Current.VocabularyVersion,
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "cdm_source_name",
                1 => "cdm_source_abbreviation",
                2 => "cdm_holder",
                3 => "source_description",
                4 => "source_documentation_reference",
                5 => "cdm_etl_reference",
                6 => "source_release_date",
                7 => "cdm_release_date",
                8 => "cdm_version",
                9 => "cdm_version_concept_id",
                10 => "vocabulary_version",
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
                0 => typeof(string),
                1 => typeof(string),
                2 => typeof(string),
                3 => typeof(string),
                4 => typeof(string),
                5 => typeof(string),
                6 => typeof(DateTime),
                7 => typeof(DateTime),
                8 => typeof(string),
                9 => typeof(long),
                10 => typeof(string),
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
