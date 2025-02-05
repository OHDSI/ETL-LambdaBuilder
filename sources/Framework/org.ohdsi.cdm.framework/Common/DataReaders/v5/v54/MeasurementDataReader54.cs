using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class MeasurementDataReader54(List<Measurement> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<Measurement> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 23; }
        }

        // is this called only because the datatype specific methods are not implemented?  
        // probably performance to be gained by not passing object back?
        public object GetValue(int i)
        {

            switch (i)
            {
                case 0:
                    //return _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id);
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).MeasurementIdChanged)
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
                    return _enumerator.Current.Time;
                case 6:
                    return _enumerator.Current.TypeConceptId;
                case 7:
                    return _enumerator.Current.OperatorConceptId;
                case 8:
                    return _enumerator.Current.ValueAsNumber;
                case 9:
                    return _enumerator.Current.ValueAsConceptId;
                case 10:
                    if (!_enumerator.Current.ValueAsNumber.HasValue)
                        return null;

                    if (string.IsNullOrEmpty(_enumerator.Current.UnitSourceValue))
                        return null;

                    return _enumerator.Current.UnitConceptId;
                case 11:
                    return _enumerator.Current.RangeLow;
                case 12:
                    return _enumerator.Current.RangeHigh;
                case 13:
                    return _enumerator.Current.ProviderId == 0 ? null : _enumerator.Current.ProviderId;
                case 14:
                    if (_enumerator.Current.VisitOccurrenceId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitOccurrenceId.Value);

                        return _enumerator.Current.VisitOccurrenceId.Value;
                    }

                    return null;

                case 15:
                    if (_enumerator.Current.VisitDetailId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitDetailId.Value);

                        return _enumerator.Current.VisitDetailId;
                    }

                    return null;
                case 16:
                    return _enumerator.Current.SourceValue;
                case 17:
                    return _enumerator.Current.SourceConceptId;
                case 18:
                    return _enumerator.Current.UnitSourceValue;
                case 19:
                    if (!_enumerator.Current.ValueAsNumber.HasValue)
                        return null;

                    if (string.IsNullOrEmpty(_enumerator.Current.UnitSourceValue))
                        return null;

                    return _enumerator.Current.UnitSourceConceptId;
                case 20:
                    return _enumerator.Current.ValueSourceValue;
                case 21:
                    if (_enumerator.Current.EventId.HasValue)
                    {
                        switch (_enumerator.Current.EventType)
                        {
                            case Enums.EntityType.ConditionOccurrence:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).ConditionOccurrenceIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            case Enums.EntityType.DeviceExposure:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).DeviceExposureIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            case Enums.EntityType.DrugExposure:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).DrugExposureIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            case Enums.EntityType.Measurement:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).MeasurementIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            case Enums.EntityType.Observation:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).ObservationIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            case Enums.EntityType.ProcedureOccurrence:
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).ProcedureOccurrenceIdChanged)
                                    return _offset.GetId(_enumerator.Current.PersonId,
                                        _enumerator.Current.EventId.Value);
                                break;
                            default:
                                throw new InvalidOperationException("EventId invalid EventType " + _enumerator.Current.EventType);
                        }
                        return _enumerator.Current.EventId;
                    }
                    return null;
                case 22:
                    return _enumerator.Current.EventFieldConceptId;

                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "measurement_id",
                1 => "person_id",
                2 => "measurement_concept_id",
                3 => "measurement_date",
                4 => "measurement_datetime",
                5 => "measurement_time",
                6 => "measurement_type_concept_id",
                7 => "operator_concept_id",
                8 => "value_as_number",
                9 => "value_as_concept_id",
                10 => "unit_concept_id",
                11 => "range_low",
                12 => "range_high",
                13 => "provider_id",
                14 => "visit_occurrence_id",
                15 => "visit_detail_id",
                16 => "measurement_source_value",
                17 => "measurement_source_concept_id",
                18 => "unit_source_value",
                19 => "unit_source_concept_id",
                20 => "value_source_value",
                21 => "measurement_event_id",
                22 => "meas_event_field_concept_id",
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
                5 => typeof(string),
                6 => typeof(long?),
                7 => typeof(long),
                8 => typeof(decimal?),
                9 => typeof(long),
                10 => typeof(long),
                11 => typeof(decimal?),
                12 => typeof(decimal?),
                13 => typeof(long?),
                14 => typeof(long?),
                15 => typeof(long?),
                16 => typeof(string),
                17 => typeof(long),
                18 => typeof(string),
                19 => typeof(long),
                20 => typeof(string),
                21 => typeof(long),
                22 => typeof(long),
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
