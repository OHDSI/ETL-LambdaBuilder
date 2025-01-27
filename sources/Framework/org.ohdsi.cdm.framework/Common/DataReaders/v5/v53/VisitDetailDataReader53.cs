﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.DataReaders.v5.v53
{
    public class VisitDetailDataReader53(List<VisitDetail> batch, KeyMasterOffsetManager o) : IDataReader
    {
        private readonly IEnumerator<VisitDetail> _enumerator = batch?.GetEnumerator();
        private readonly KeyMasterOffsetManager _offset = o;

        public bool Read()
        {
            return _enumerator.MoveNext();
        }

        public int FieldCount
        {
            get { return 19; }
        }

        // is this called only because the datatype specific methods are not implemented?  
        // probably performance to be gained by not passing object back?
        public object GetValue(int i)
        {
            switch (i)
            {
                case 0:
                    {
                        return _offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged
                            ? _offset.GetId(_enumerator.Current.PersonId, _enumerator.Current.Id)
                            : _enumerator.Current.Id;
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
                    return _enumerator.Current.EndDate.Value;
                case 7:
                    return _enumerator.Current.TypeConceptId;
                case 8:
                    return _enumerator.Current.ProviderId == 0 ? null : _enumerator.Current.ProviderId;
                case 9:
                    return _enumerator.Current.CareSiteId == 0 ? null : _enumerator.Current.CareSiteId;

                case 10:
                    return _enumerator.Current.AdmittingSourceConceptId;

                case 11:
                    return _enumerator.Current.DischargeToConceptId;

                case 12:
                    if (_enumerator.Current.PrecedingVisitDetailId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.PrecedingVisitDetailId.Value);

                        return _enumerator.Current.PrecedingVisitDetailId.Value;
                    }

                    return null;

                //return _enumerator.Current.PrecedingVisitDetailId.HasValue
                //    ? _offset.GetId(_enumerator.Current.PersonId,
                //        _enumerator.Current.PrecedingVisitDetailId.Value)
                //    : _enumerator.Current.PrecedingVisitDetailId;

                case 13:
                    return _enumerator.Current.SourceValue;

                case 14:
                    return _enumerator.Current.SourceConceptId;

                case 15:
                    return _enumerator.Current.AdmittingSourceValue;

                case 16:
                    return _enumerator.Current.DischargeToSourceValue;

                case 17:
                    if (_enumerator.Current.VisitDetailParentId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitDetailIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitDetailParentId.Value);

                        return _enumerator.Current.VisitDetailParentId.Value;
                    }
                    return null;

                case 18:
                    if (_enumerator.Current.VisitOccurrenceId.HasValue)
                    {
                        if (_offset.GetKeyOffset(_enumerator.Current.PersonId).VisitOccurrenceIdChanged)
                            return _offset.GetId(_enumerator.Current.PersonId,
                                _enumerator.Current.VisitOccurrenceId.Value);

                        return _enumerator.Current.VisitOccurrenceId.Value;
                    }

                    return null;


                default:
                    throw new NotImplementedException();
            }
        }

        public string GetName(int i)
        {
            return i switch
            {
                0 => "visit_detail_id",
                1 => "person_id",
                2 => "visit_detail_concept_id",
                3 => "visit_detail_start_date",
                4 => "visit_detail_start_datetime",
                5 => "visit_detail_end_date",
                6 => "visit_detail_end_datetime",
                7 => "visit_detail_type_concept_id",
                8 => "provider_id",
                9 => "care_site_id",
                10 => "admitting_source_concept_id",
                11 => "discharge_to_concept_id",
                12 => "preceding_visit_detail_id",
                13 => "visit_detail_source_value",
                14 => "visit_detail_source_concept_id",
                15 => "admitting_source_value",
                16 => "discharge_to_source_value",
                17 => "visit_detail_parent_id",
                18 => "visit_occurrence_id",
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
                7 => typeof(long?),
                8 => typeof(long?),
                9 => typeof(long?),
                10 => typeof(long),
                11 => typeof(long),
                12 => typeof(long?),
                13 => typeof(string),
                14 => typeof(long),
                15 => typeof(string),
                16 => typeof(string),
                17 => typeof(long?),
                18 => typeof(long?),
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
