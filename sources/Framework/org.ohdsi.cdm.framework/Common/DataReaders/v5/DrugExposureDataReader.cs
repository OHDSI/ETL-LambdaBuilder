﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5
{
    public class DrugExposureDataReader(List<DrugExposure> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<DrugExposure> _enumerator = batch?.GetEnumerator();
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

            switch (i)
            {
                case 0:
                    return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id);
                case 1:
                    return _enumerator.Current.PersonId;
                case 2:
                    return _enumerator.Current.ConceptId;
                case 3:
                    return _enumerator.Current.StartDate;
                case 4:
                    return _enumerator.Current.EndDate;
                case 5:
                    return _enumerator.Current.TypeConceptId;
                case 6:
                    return _enumerator.Current.StopReason;
                case 7:
                    return _enumerator.Current.Refills;
                case 8:
                    return _enumerator.Current.Quantity;
                case 9:
                    return _enumerator.Current.DaysSupply;
                case 10:
                    return _enumerator.Current.Sig;
                case 11:
                    return _enumerator.Current.RouteConceptId;
                case 12:
                    return _enumerator.Current.EffectiveDrugDose;
                case 13:
                    return _enumerator.Current.DoseUnitConceptId;
                case 14:
                    return _enumerator.Current.LotNumber;
                case 15:
                    return _enumerator.Current.ProviderId == 0 ? null : _enumerator.Current.ProviderId;
                case 16:
                    if (_enumerator.Current.VisitOccurrenceId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitOccurrenceId.Value);

                        return _enumerator.Current.VisitOccurrenceId.Value;
                    }

                    return null;
                case 17:
                    return _enumerator.Current.SourceValue;
                case 18:
                    return _enumerator.Current.SourceConceptId;
                case 19:
                    return _enumerator.Current.RouteSourceValue;
                case 20:
                    return _enumerator.Current.DoseUnitSourceValue;
                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "Id",
                1 => "PersonId",
                2 => "ConceptId",
                3 => "StartDate",
                4 => "EndDate",
                5 => "TypeConceptId",
                6 => "StopReason",
                7 => "Refills",
                8 => "Quantity",
                9 => "DaysSupply",
                10 => "Sig",
                11 => "RouteConceptId",
                12 => "EffectiveDrugDose",
                13 => "DoseUnitConceptId",
                14 => "LotNumber",
                15 => "ProviderId",
                16 => "VisitOccurrenceId",
                17 => "SourceValue",
                18 => "SourceConceptId",
                19 => "RouteSourceValue",
                20 => "DoseUnitSourceValue",
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
                5 => typeof(long?),
                6 => typeof(string),
                7 => typeof(int?),
                8 => typeof(int?),
                9 => typeof(int?),
                10 => typeof(string),
                11 => typeof(long?),
                12 => typeof(decimal?),
                13 => typeof(long?),
                14 => typeof(string),
                15 => typeof(int?),
                16 => typeof(int?),
                17 => typeof(string),
                18 => typeof(long?),
                19 => typeof(string),
                20 => typeof(string),
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
