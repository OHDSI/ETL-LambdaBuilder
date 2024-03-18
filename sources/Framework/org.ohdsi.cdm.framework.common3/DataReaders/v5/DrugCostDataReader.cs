using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5
{
    public class DrugCostDataReader(List<DrugCost> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<DrugCost> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 14; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            return i switch
            {
                0 => _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.DrugCostId),
                1 => _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id),
                2 => _enumerator.Current.CurrencyConceptId,
                3 => _enumerator.Current.PaidCopay.Round(),
                4 => _enumerator.Current.PaidCoinsurance.Round(),
                5 => _enumerator.Current.PaidTowardDeductible.Round(),
                6 => _enumerator.Current.PaidByPayer.Round(),
                7 => _enumerator.Current.PaidByCoordinationBenefits.Round(),
                8 => _enumerator.Current.TotalOutOfPocket.Round(),
                9 => _enumerator.Current.TotalPaid.Round(),
                10 => _enumerator.Current.IngredientCost.Round(),
                11 => _enumerator.Current.DispensingFee.Round(),
                12 => _enumerator.Current.AverageWholesalePrice.Round(),
                13 => (object)(_enumerator.Current.PayerPlanPeriodId.HasValue
                                        ? _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.PayerPlanPeriodId.Value)
                                        : _enumerator.Current.PayerPlanPeriodId),
                _ => throw new NotImplementedException(),
            };
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "Id",
                1 => "DrugExposureId",
                2 => "CurrencyConceptId",
                3 => "PaidCopay",
                4 => "PaidCoinsurance",
                5 => "PaidTowardDeductible",
                6 => "PaidByPayer",
                7 => "PaidByCoordinationBenefits",
                8 => "TotalOutOfPocket",
                9 => "TotalPaid",
                10 => "IngredientCost",
                11 => "DispensingFee",
                12 => "AverageWholesalePrice",
                13 => "PayerPlanPeriodId",
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
                3 => typeof(decimal?),
                4 => typeof(decimal?),
                5 => typeof(decimal?),
                6 => typeof(decimal?),
                7 => typeof(decimal?),
                8 => typeof(decimal?),
                9 => typeof(decimal?),
                10 => typeof(decimal?),
                11 => typeof(decimal?),
                12 => typeof(decimal?),
                13 => typeof(long?),
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
