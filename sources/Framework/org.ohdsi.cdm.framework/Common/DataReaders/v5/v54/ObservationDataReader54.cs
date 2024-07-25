using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v54
{
    public class ObservationDataReader54(List<Observation> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<Observation> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 21; }
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
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).ObservationIdChanged)
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
                    return _enumerator.Current.TypeConceptId;
                case 6:
                    return _enumerator.Current.ValueAsNumber;
                case 7:
                    return _enumerator.Current.ValueAsString;
                case 8:
                    return _enumerator.Current.ValueAsConceptId;
                case 9:
                    return _enumerator.Current.QualifierConceptId;
                case 10:
                    if (!_enumerator.Current.ValueAsNumber.HasValue)
                        return null;

                    if (string.IsNullOrEmpty(_enumerator.Current.UnitsSourceValue))
                        return null;

                    return _enumerator.Current.UnitsConceptId;
                case 11:
                    return _enumerator.Current.ProviderId == 0 ? null : _enumerator.Current.ProviderId;
                case 12:
                    if (_enumerator.Current.VisitOccurrenceId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitOccurrenceId.Value);

                        return _enumerator.Current.VisitOccurrenceId.Value;
                    }

                    return null;

                case 13:
                    if (_enumerator.Current.VisitDetailId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitDetailId.Value);

                        return _enumerator.Current.VisitDetailId;
                    }

                    return null;
                case 14:
                    return _enumerator.Current.SourceValue;
                case 15:
                    return _enumerator.Current.SourceConceptId;
                case 16:
                    return _enumerator.Current.UnitsSourceValue;
                case 17:
                    return _enumerator.Current.QualifierSourceValue;
                case 18:
                    return _enumerator.Current.ValueSourceValue;
                case 19:
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
                                if (_offset.GetKeyOffset(_enumerator.Current.PersonId).ObservationPeriodIdChanged)
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
                case 20:
                    return _enumerator.Current.EventFieldConceptId;

                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "observation_id",
                1 => "person_id",
                2 => "observation_concept_id",
                3 => "observation_date",
                4 => "observation_datetime",
                5 => "observation_type_concept_id",
                6 => "value_as_number",
                7 => "value_as_string",
                8 => "value_as_concept_id",
                9 => "qualifier_concept_id",
                10 => "unit_concept_id",
                11 => "provider_id",
                12 => "visit_occurrence_id",
                13 => "visit_detail_id",
                14 => "observation_source_value",
                15 => "observation_source_concept_id",
                16 => "unit_source_value",
                17 => "qualifier_source_value",
                18 => "value_source_value",
                19 => "observation_event_id",
                20 => "obs_event_field_concept_id",
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
                6 => typeof(decimal?),
                7 => typeof(string),
                8 => typeof(long),
                9 => typeof(long),
                10 => typeof(long),
                11 => typeof(long?),
                12 => typeof(long?),
                13 => typeof(long?),
                14 => typeof(string),
                15 => typeof(long),
                16 => typeof(string),
                17 => typeof(string),
                18 => typeof(string),
                19 => typeof(long),
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
