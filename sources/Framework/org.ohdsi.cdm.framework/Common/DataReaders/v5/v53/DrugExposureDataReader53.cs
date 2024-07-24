using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v53
{
    public class DrugExposureDataReader53(List<DrugExposure> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<DrugExposure> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 23; }
        }

        public object GetValue(int i)
        {
            if (_enumerator.Current == null) return null;

            switch (i)
            {
                case 0:
                    //return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id);
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).DrugExposureIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id);
                        else
                            return _enumerator.Current.Id;
                    }
                case 1:
                    return _enumerator.Current.PersonId;
                case 2:
                    return _enumerator.Current.ConceptId;
                case 3:
                    return _enumerator.Current.StartDate;
                case 4:
                    return _enumerator.Current.StartDate;
                case 5:
                    return _enumerator.Current.EndDate;
                case 6:
                    return _enumerator.Current.EndDate;
                case 7:
                    return _enumerator.Current.VerbatimEndDate;
                case 8:
                    return _enumerator.Current.TypeConceptId;
                case 9:
                    return _enumerator.Current.StopReason;
                case 10:
                    return _enumerator.Current.Refills;
                case 11:
                    return _enumerator.Current.Quantity;
                case 12:
                    return _enumerator.Current.DaysSupply;
                case 13:
                    return _enumerator.Current.Sig;
                case 14:
                    return _enumerator.Current.RouteConceptId;
                case 15:
                    return _enumerator.Current.LotNumber;
                case 16:
                    return _enumerator.Current.ProviderId == 0 ? null : _enumerator.Current.ProviderId;
                case 17:
                    if (_enumerator.Current.VisitOccurrenceId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitOccurrenceId.Value);

                        return _enumerator.Current.VisitOccurrenceId.Value;
                    }

                    return null;
                case 18:
                    if (_enumerator.Current.VisitDetailId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitDetailId.Value);

                        return _enumerator.Current.VisitDetailId;
                    }

                    return null;
                case 19:
                    return _enumerator.Current.SourceValue;
                case 20:
                    return _enumerator.Current.SourceConceptId;
                case 21:
                    return _enumerator.Current.RouteSourceValue;
                case 22:
                    return _enumerator.Current.DoseUnitSourceValue;
                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "drug_exposure_id",
                1 => "person_id",
                2 => "drug_concept_id",
                3 => "drug_exposure_start_date",
                4 => "drug_exposure_start_datetime",
                5 => "drug_exposure_end_date",
                6 => "drug_exposure_end_datetime",
                7 => "verbatim_end_date",
                8 => "drug_type_concept_id",
                9 => "stop_reason",
                10 => "refills",
                11 => "quantity",
                12 => "days_supply",
                13 => "sig",
                14 => "route_concept_id",
                15 => "lot_number",
                16 => "provider_id",
                17 => "visit_occurrence_id",
                18 => "visit_detail_id",
                19 => "drug_source_value",
                20 => "drug_source_concept_id",
                21 => "route_source_value",
                22 => "dose_unit_source_value",
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
                5 => typeof(DateTime?),
                6 => typeof(DateTime),
                7 => typeof(DateTime?),
                8 => typeof(long?),
                9 => typeof(string),
                10 => typeof(int?),
                11 => typeof(decimal?),
                12 => typeof(int?),
                13 => typeof(string),
                14 => typeof(long),
                15 => typeof(string),
                16 => typeof(long?),
                17 => typeof(long?),
                18 => typeof(long?),
                19 => typeof(string),
                20 => typeof(long),
                21 => typeof(string),
                22 => typeof(string),
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
