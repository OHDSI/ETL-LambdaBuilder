using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v53
{
    public class PayerPlanPeriodDataReader53(List<PayerPlanPeriod> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<PayerPlanPeriod> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 17; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            switch (i)
            {
                case 0:
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).PayerPlanPeriodIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id);
                        else
                            return _enumerator.Current.Id;
                    }
                case 1:
                    return _enumerator.Current.PersonId;
                case 2:
                    return _enumerator.Current.StartDate;
                case 3:
                    return _enumerator.Current.EndDate;
                case 4:
                    return _enumerator.Current.PayerConceptId;
                case 5:
                    return _enumerator.Current.PayerSourceValue;
                case 6:
                    return _enumerator.Current.PayerSourceConceptId;
                case 7:
                    return _enumerator.Current.PlanConceptId;
                case 8:
                    return _enumerator.Current.PlanSourceValue;
                case 9:
                    return _enumerator.Current.PlanSourceConceptId;
                case 10:
                    return _enumerator.Current.SponsorConceptId;
                case 11:
                    return _enumerator.Current.SponsorSourceValue;
                case 12:
                    return _enumerator.Current.SponsorSourceConceptId;
                case 13:
                    return _enumerator.Current.FamilySourceValue;
                case 14:
                    return _enumerator.Current.StopReasonConceptId;
                case 15:
                    return _enumerator.Current.StopReasonSourceValue;
                case 16:
                    return _enumerator.Current.StopReasonSourceConceptId;
                default:
                    throw new NotImplementedException();
            }

           
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "payer_plan_period_id",
                1 => "person_id",
                2 => "payer_plan_period_start_date",
                3 => "payer_plan_period_end_date",
                4 => "payer_concept_id",
                5 => "payer_source_value",
                6 => "payer_source_concept_id",
                7 => "plan_concept_id",
                8 => "plan_source_value",
                9 => "plan_source_concept_id",
                10 => "sponsor_concept_id",
                11 => "sponsor_source_value",
                12 => "sponsor_source_concept_id",
                13 => "family_source_value",
                14 => "stop_reason_concept_id",
                15 => "stop_reason_source_value",
                16 => "stop_reason_source_concept_id",
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
                3 => typeof(DateTime?),
                4 => typeof(long),
                5 => typeof(string),
                6 => typeof(long),
                7 => typeof(long),
                8 => typeof(string),
                9 => typeof(long),
                10 => typeof(long),
                11 => typeof(string),
                12 => typeof(long),
                13 => typeof(string),
                14 => typeof(long),
                15 => typeof(string),
                16 => typeof(long),
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
