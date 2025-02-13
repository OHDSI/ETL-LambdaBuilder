using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v52
{
    public class CostDataReader52(List<Cost> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<Cost> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 22; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            switch (i)
            {
                case 0:
                    {
                        if (_enumerator.Current.Id.HasValue)
                            return _enumerator.Current.Id.Value;

                        return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.CostId);
                    }

                case 1:
                    {
                        if (_enumerator.Current.Domain == "Procedure" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).ProcedureOccurrenceIdChanged)
                            return _enumerator.Current.EventId;

                        if (_enumerator.Current.Domain == "Observation" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).ObservationIdChanged)
                            return _enumerator.Current.EventId;

                        if (_enumerator.Current.Domain == "Drug" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).DrugExposureIdChanged)
                            return _enumerator.Current.EventId;

                        if (_enumerator.Current.Domain == "Device" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).DeviceExposureIdChanged)
                            return _enumerator.Current.EventId;

                        if (_enumerator.Current.Domain == "Measurement" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).MeasurementIdChanged)
                            return _enumerator.Current.EventId;

                        if (_enumerator.Current.Domain == "Visit" && !_offset
                                .GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _enumerator.Current.EventId;

                        return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.EventId);
                    }
                case 2:
                    return _enumerator.Current.Domain;

                case 3:
                    return _enumerator.Current.TypeId;

                case 4:
                    return _enumerator.Current.CurrencyConceptId;

                case 5:
                    return _enumerator.Current.TotalCharge.Round();

                case 6:
                    return _enumerator.Current.TotalCost.Round();

                case 7:
                    return _enumerator.Current.TotalPaid.Round();

                case 8:
                    return _enumerator.Current.PaidByPayer.Round();

                case 9:
                    return _enumerator.Current.PaidByPatient.Round();

                case 10:
                    return _enumerator.Current.PaidPatientCopay.Round();

                case 11:
                    return _enumerator.Current.PaidPatientCoinsurance.Round();

                case 12:
                    return _enumerator.Current.PaidPatientDeductible.Round();

                case 13:
                    return _enumerator.Current.PaidByPrimary.Round();

                case 14:
                    return _enumerator.Current.PaidIngredientCost.Round();

                case 15:
                    return _enumerator.Current.PaidDispensingFee.Round();

                case 16:
                    if (_enumerator.Current.PayerPlanPeriodId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).PayerPlanPeriodIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.PayerPlanPeriodId.Value);
                        else
                            return _enumerator.Current.PayerPlanPeriodId;
                    }

                    return null;

                case 17:
                    return _enumerator.Current.AmountAllowed.Round();

                case 18:
                    return _enumerator.Current.RevenueCodeConceptId;

                case 19:
                    return _enumerator.Current.RevenueCodeSourceValue;

                case 20:
                    return _enumerator.Current.DrgConceptId;

                case 21:
                    return _enumerator.Current.DrgSourceValue;


                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "cost_id",
                1 => "cost_event_id",
                2 => "cost_domain_id",
                3 => "cost_type_concept_id",
                4 => "currency_concept_id",
                5 => "total_charge",
                6 => "total_cost",
                7 => "total_paid",
                8 => "paid_by_payer",
                9 => "paid_by_patient",
                10 => "paid_patient_copay",
                11 => "paid_patient_coinsurance",
                12 => "paid_patient_deductible",
                13 => "paid_by_primary",
                14 => "paid_ingredient_cost",
                15 => "paid_dispensing_fee",
                16 => "payer_plan_period_id",
                17 => "amount_allowed",
                18 => "revenue_code_concept_id",
                19 => "revenue_code_source_value",
                20 => "drg_concept_id",
                21 => "drg_source_value",
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
                2 => typeof(string),
                3 => typeof(long),
                4 => typeof(long),
                5 => typeof(decimal?),
                6 => typeof(decimal?),
                7 => typeof(decimal?),
                8 => typeof(decimal?),
                9 => typeof(decimal?),
                10 => typeof(decimal?),
                11 => typeof(decimal?),
                12 => typeof(decimal?),
                13 => typeof(decimal?),
                14 => typeof(decimal?),
                15 => typeof(decimal?),
                16 => typeof(long?),
                17 => typeof(decimal?),
                18 => typeof(long?),
                19 => typeof(string),
                20 => typeof(long?),
                21 => typeof(string),
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
