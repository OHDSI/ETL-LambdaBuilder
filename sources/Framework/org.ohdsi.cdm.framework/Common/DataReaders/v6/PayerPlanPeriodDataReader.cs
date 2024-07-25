using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v6
{
    public class PayerPlanPeriodDataReader(List<PayerPlanPeriod> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<PayerPlanPeriod> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 21; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            return i switch
            {
                0 => _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id),
                1 => _enumerator.Current.PersonId,
                2 => _enumerator.Current.ContractPersonId,
                3 => _enumerator.Current.StartDate,
                4 => _enumerator.Current.EndDate,
                5 => _enumerator.Current.PayerConceptId,
                6 => _enumerator.Current.PlanConceptId,
                7 => _enumerator.Current.ContractConceptId,
                8 => _enumerator.Current.SponsorConceptId,
                9 => _enumerator.Current.StopReasonConceptId,
                10 => _enumerator.Current.PayerSourceValue,
                11 => _enumerator.Current.PayerSourceConceptId,
                12 => _enumerator.Current.PlanSourceValue,
                13 => _enumerator.Current.PlanSourceConceptId,
                14 => _enumerator.Current.ContractSourceValue,
                15 => _enumerator.Current.ContractSourceConceptId,
                16 => _enumerator.Current.SponsorSourceValue,
                17 => _enumerator.Current.SponsorSourceConceptId,
                18 => _enumerator.Current.FamilySourceValue,
                19 => _enumerator.Current.StopReasonSourceValue,
                20 => _enumerator.Current.StopReasonSourceConceptId,
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "payer_plan_period_id",
                1 => "person_id",
                2 => "contract_person_id",
                3 => "payer_plan_period_start_date",
                4 => "payer_plan_period_end_date",
                5 => "payer_concept_id",
                6 => "plan_concept_id",
                7 => "contract_concept_id",
                8 => "sponsor_concept_id",
                9 => "stop_reason_concept_id",
                10 => "payer_source_value",
                11 => "payer_source_concept_id",
                12 => "plan_source_value",
                13 => "plan_source_concept_id",
                14 => "contract_source_value",
                15 => "contract_source_concept_id",
                16 => "sponsor_source_value",
                17 => "sponsor_source_concept_id",
                18 => "family_source_value",
                19 => "stop_reason_source_value",
                20 => "stop_reason_source_concept_id",
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
                2 => typeof(long?),
                3 => typeof(DateTime),
                4 => typeof(DateTime),
                5 => typeof(long),
                6 => typeof(long),
                7 => typeof(long),
                8 => typeof(long),
                9 => typeof(long),
                10 => typeof(string),
                11 => typeof(long),
                12 => typeof(string),
                13 => typeof(long),
                14 => typeof(string),
                15 => typeof(long),
                16 => typeof(string),
                17 => typeof(long),
                18 => typeof(string),
                19 => typeof(string),
                20 => typeof(long),
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
