using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Core.Transformation.HealthVerity
{
    public enum DataVendor
    {
        PrivateSource17,
        PrivateSource20
    }

    public enum Table
    {
        Medical,
        Pharmacy
    }
    public enum AggregationType
    {
        Min,
        Max
    }

    public class HealthVerityPersonBuilder : PersonBuilder
    {
        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = [];
        private readonly Dictionary<long, List<VisitDetail>> _visitDetails = [];
        private readonly Dictionary<string, List<VisitDetail>> _visitDetailsByHvEncId = [];
        private readonly Dictionary<string, HashSet<DateTime>> _minsMaxs = [];
        private readonly DateTime _minDate = new(2009, 1, 1);

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            if (records.All(p => p.GenderConceptId == 8551))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (records.All(p => p.YearOfBirth < 1900))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);
            }

            if (records.All(p => p.YearOfBirth > DateTime.Now.Year))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBFuture);
            }

            var filtered = records.Where(p =>
                p.GenderConceptId != 8551 &&
                p.YearOfBirth >= 1900 &&
                p.YearOfBirth <= DateTime.Now.Year).ToArray();

            if (filtered.Length == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = filtered.OrderByDescending(p => p.StartDate).ToArray();
            var person = ordered.Take(1).First();
            person.StartDate = ordered.Take(1).Last().StartDate;

            if (person.GenderConceptId == 8551)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (records.Any(r => r.GenderConceptId != 8551 && r.GenderConceptId != person.GenderConceptId))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges); // Gender changed over different enrollment period 
            }

            if (person.YearOfBirth < 1900)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            if (person.YearOfBirth > DateTime.Now.Year)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBFuture);

            if (records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Max(r => r.YearOfBirth) -
                records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Min(r => r.YearOfBirth) > 2)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.MultipleYearsOfBirth);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        private void AddRawVisitOccurrence(VisitOccurrence rawVisit, VisitOccurrence finalVisit)
        {
            if (!_rawVisits.TryAdd(rawVisit.SourceRecordGuid, finalVisit))
                _rawVisits[rawVisit.SourceRecordGuid] = finalVisit;
        }

        public override IEnumerable<VisitOccurrence> BuildVisitOccurrences(VisitOccurrence[] rawVisitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var ipVisitsRaw = new List<VisitOccurrence>();
            var erVisitsRaw = new List<VisitOccurrence>();
            var erVisits = new List<VisitOccurrence>();
            var nonHospitalVisitsRaw = new List<VisitOccurrence>();
            var othersRaw = new List<VisitOccurrence>();
            var remainingRaw = new List<VisitOccurrence>();
            var remaining = new List<VisitOccurrence>();

            foreach (var visitOccurrence in rawVisitOccurrences)
            {
                if (!visitOccurrence.EndDate.HasValue)
                    visitOccurrence.EndDate = visitOccurrence.StartDate;


                if (visitOccurrence.StartDate > visitOccurrence.EndDate.Value)
                    visitOccurrence.EndDate = visitOccurrence.StartDate;

                var result = Vocabulary.Lookup(visitOccurrence.ConceptId.ToString(), "CMSPlaceOfService",
                    DateTime.MinValue);

                var conceptId = result.Count != 0 ? result[0].ConceptId ?? 0 : 0;
                visitOccurrence.ConceptId = conceptId;

                if (conceptId == 9201)
                {
                    ipVisitsRaw.Add(visitOccurrence);
                }
                else if (conceptId == 9203)
                {
                    erVisitsRaw.Add(visitOccurrence);
                }
                else
                {
                    othersRaw.Add(visitOccurrence);
                }
            }


            var ipVisits = CollapseVisits(ipVisitsRaw);

            // Collapse records that have the same VISIT_DETAIL_START_DATETIME into one Visit.
            foreach (var erGroup in erVisitsRaw.GroupBy(v => v.StartDate))
            {
                var erVisit = erGroup.First();
                erVisit.EndDate = erGroup.Max(v => v.EndDate);

                var ip = ipVisits.FirstOrDefault(v => erVisit.StartDate.Between(v.StartDate, v.EndDate.Value));
                VisitOccurrence visit = null;
                if (ip != null)
                {
                    //    If an emergency room visit starts on the first day of an Inpatient visit(defined in the step above), then
                    //    Assign the emergency room visit the autogenerated VISIT_OCCURRENCE_ID of the Inpatient visit.
                    //    Set VISIT_CONCEPT_ID = 262(it would previously have been 9201).
                    if (ip.StartDate == erVisit.StartDate)
                    {
                        ip.ConceptId = 262;
                    }

                    if (ip.EndDate < erVisit.EndDate)
                        ip.EndDate = erVisit.EndDate;

                    visit = ip;
                }
                else
                {
                    visit = erVisit;
                    erVisits.Add(visit);
                }

                foreach (var visitOccurrence in erGroup)
                {
                    AddRawVisitOccurrence(visitOccurrence, visit);
                }
            }

            // Rolling additional visit detail into Inpatient
            foreach (var otherVisit in othersRaw)
            {
                var ip = ipVisits.FirstOrDefault(v => otherVisit.StartDate.Between(v.StartDate, v.EndDate.Value));

                //For all other VISIT_DETAIL records, first look to see if they occur at any point within a previously defined inpatient visit.
                if (ip != null)
                {
                    AddRawVisitOccurrence(otherVisit, ip);
                }
                else
                {
                    if (otherVisit.ConceptId == 42898160)
                    {
                        nonHospitalVisitsRaw.Add(otherVisit);
                    }
                    else
                    {
                        remainingRaw.Add(otherVisit);
                    }
                }
            }

            var nonHospitalVisits = CollapseVisits(nonHospitalVisitsRaw);
            // Rolling additional visit detail into Non-hospital institution visit
            foreach (var remainingVisit in remainingRaw)
            {
                var nonHospital =
                    nonHospitalVisits.FirstOrDefault(
                        v => remainingVisit.StartDate.Between(v.StartDate, v.EndDate.Value));
                if (nonHospital != null)
                {
                    AddRawVisitOccurrence(remainingVisit, nonHospital);
                }
                else
                {
                    remaining.Add(remainingVisit);
                }
            }

            // All other VISIT_DETAIL records
            foreach (var byStart in remaining.GroupBy(v => v.StartDate))
            {
                foreach (var byEnd in byStart.GroupBy(v => v.EndDate))
                {
                    foreach (var byCareSiteId in byEnd.GroupBy(v => v.CareSiteId))
                    {
                        var visit = byCareSiteId.OrderBy(v => v.ConceptId).First();
                        foreach (var vo in byCareSiteId)
                        {
                            AddRawVisitOccurrence(vo, visit);
                        }

                        yield return visit;
                    }
                }
            }

            foreach (var visitOccurrence in ipVisits)
            {
                yield return visitOccurrence;
            }

            foreach (var visitOccurrence in erVisits)
            {
                yield return visitOccurrence;
            }

            foreach (var visitOccurrence in nonHospitalVisits)
            {
                yield return visitOccurrence;
            }
        }

        private List<VisitOccurrence> CollapseVisits(IEnumerable<VisitOccurrence> visits)
        {
            var collaped = new List<VisitOccurrence>();
            foreach (var claim in visits.OrderBy(vo => vo.StartDate)
                .ThenBy(vo => vo.EndDate))
            {
                if (collaped.Count > 0)
                {
                    var previousClaim = collaped.Last();
                    if (claim.StartDate <= previousClaim.EndDate.Value.AddDays(1))
                    {
                        if (claim.EndDate >= previousClaim.EndDate)
                        {
                            previousClaim.EndDate = claim.EndDate;
                        }

                        AddRawVisitOccurrence(claim, previousClaim);
                        continue;
                    }
                }

                AddRawVisitOccurrence(claim, claim);
                collaped.Add(claim);
            }

            return collaped;
        }

        private VisitOccurrence GetVisitOccurrence(IEntity ent)
        {
            if (_rawVisits.ContainsKey(ent.SourceRecordGuid))
            {
                var vo = _rawVisits[ent.SourceRecordGuid];
                if (vo.Id == 0 && _rawVisits.TryGetValue(vo.SourceRecordGuid, out VisitOccurrence value) &&
value.SourceRecordGuid != ent.SourceRecordGuid)
                {
                    vo = value;
                }

                return vo;
            }

            return null;
        }

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails,
         VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var visitOccurrence in visitOccurrences)
            {
                var visitDetail =
                    new VisitDetail(visitOccurrence)
                    {
                        Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitDetailId
                    };

                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;


                yield return visitDetail;
            }
        }

        public override IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
        {
            if (observationPeriods.Length > 1)
            {
                List<EraEntity> medical = []; //observationPeriods.Where(op => op.TypeConceptId == 1).ToArray();
                List<EraEntity> pharmacy = []; //observationPeriods.Where(op => op.TypeConceptId == 2).ToArray();

                foreach (var dv in observationPeriods.Where(op => op.TypeConceptId == 1).
                    GroupBy(op => op.AdditionalFields["data_vendor"]))
                {
                    foreach (var sd in dv.GroupBy(op => op.StartDate))
                    {
                        medical.Add(new EraEntity
                        {
                            PersonId = sd.First().PersonId,
                            StartDate = sd.First().StartDate,
                            EndDate = sd.Max(d => d.EndDate),
                            AdditionalFields = sd.First().AdditionalFields
                        });
                    }
                }

                foreach (var dv in observationPeriods.Where(op => op.TypeConceptId == 2).
                    GroupBy(op => op.AdditionalFields["data_vendor"]))
                {
                    foreach (var sd in dv.GroupBy(op => op.StartDate))
                    {
                        pharmacy.Add(new EraEntity
                        {
                            PersonId = sd.First().PersonId,
                            StartDate = sd.First().StartDate,
                            EndDate = sd.Max(d => d.EndDate),
                            AdditionalFields = sd.First().AdditionalFields
                        });
                    }
                }

                if (medical.Count > 0 && pharmacy.Count > 0)
                {
                    FixObservationPeriodDates(medical, Table.Medical);
                    FixObservationPeriodDates(pharmacy, Table.Pharmacy);

                    var medicalPeriods = EraHelper.GetEras(medical.Where(i => i.StartDate <= i.EndDate
                    && i.StartDate.Year >= _minDate.Year && i.EndDate.Value.Year <= DateTime.Now.Year), 30, 0);

                    var pharmacyPeriods = EraHelper.GetEras(pharmacy.Where(i => i.StartDate <= i.EndDate
                     && i.StartDate.Year >= _minDate.Year && i.EndDate.Value.Year <= DateTime.Now.Year), 30, 0);

                    foreach (var mp in medicalPeriods)
                    {
                        List<EraEntity> overlaps = [];

                        var ph = pharmacyPeriods.Where(pp => mp.StartDate < pp.EndDate && pp.StartDate < mp.EndDate);

                        foreach (var p in ph)
                        {
                            var o = new EraEntity
                            {
                                StartDate = p.StartDate,
                                EndDate = p.EndDate
                            };

                            if (mp.StartDate > p.StartDate)
                                o.StartDate = mp.StartDate;

                            if (mp.EndDate < p.EndDate)
                                o.EndDate = mp.EndDate;

                            overlaps.Add(o);
                        }

                        if (overlaps.Count == 0)
                            continue;

                        foreach (var overlap in EraHelper.GetEras(overlaps, 1, 0))
                        {
                            yield return new ObservationPeriod
                            {
                                StartDate = overlap.StartDate,
                                EndDate = overlap.EndDate,
                                TypeConceptId = 32875,
                                PersonId = observationPeriods[0].PersonId
                            };
                        }
                    }
                }
            }
        }

        private void FixObservationPeriodDates(IEnumerable<EraEntity> observationPeriods, Table table)
        {
            foreach (var g in observationPeriods.GroupBy(m => m.AdditionalFields["data_vendor"]))
            {
                DataVendor? vendor = null;

                if (g.First().AdditionalFields["data_vendor"].StartsWith("private source 17", StringComparison.CurrentCultureIgnoreCase))
                    vendor = DataVendor.PrivateSource17;
                else if (g.First().AdditionalFields["data_vendor"].StartsWith("private source 20", StringComparison.CurrentCultureIgnoreCase))
                    vendor = DataVendor.PrivateSource20;
                else
                    continue;

                foreach (var item in g.ToArray())
                {
                    if (item.StartDate.Year < _minDate.Year)
                    {
                        //item.StartDate = min.Value;
                        var key = GetDateKey(table, vendor.Value, AggregationType.Min);
                        if (_minsMaxs.ContainsKey(key))
                            item.StartDate = _minsMaxs[key].Min();
                    }

                    if (item.EndDate.Value.Year > DateTime.Now.Year)
                    {
                        var key = GetDateKey(table, vendor.Value, AggregationType.Max);
                        if (_minsMaxs.ContainsKey(key))
                            item.EndDate = _minsMaxs[key].Max();
                    }
                }
            }
        }

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;

            if (person == null)
            {
                Complete = true;
                return result.Value;
            }

            GetMinMaxDates(DrugExposuresRaw, _minsMaxs);
            GetMinMaxDates(ConditionOccurrencesRaw, _minsMaxs);
            GetMinMaxDates(ProcedureOccurrencesRaw, _minsMaxs);
            GetMinMaxDates(ObservationsRaw, _minsMaxs);
            GetMinMaxDates(DeviceExposureRaw, _minsMaxs);
            GetMinMaxDates(MeasurementsRaw, _minsMaxs);
            GetMinMaxDates(VisitOccurrencesRaw, _minsMaxs);
            GetMinMaxDates(VisitDetailsRaw, _minsMaxs);

            if (VisitOccurrencesRaw.Count > 1000 * 1000)
            {
                Console.WriteLine("UnacceptablePatientQuality " + person.PersonSourceValue + " " + VisitOccurrencesRaw.Count);
                return Attrition.UnacceptablePatientQuality;
            }

            var observationPeriods =
                   BuildObservationPeriods(person.ObservationPeriodGap, [.. ObservationPeriodsRaw])
                       .ToArray();

            foreach (var op in observationPeriods)
            {
                op.Id = Offset.GetKeyOffset(op.PersonId).ObservationPeriodId;

                if (op.EndDate > new DateTime(2023, 2, 1))
                    op.EndDate = new DateTime(2023, 2, 1);
            }

            if (observationPeriods.Length == 0)
            {
                return Attrition.InvalidObservationTime;
            }

            if (Excluded(person, observationPeriods))
            {
                Complete = true;
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            foreach (var v in VisitOccurrencesRaw)
            {
                if (v.ConceptId == 0 && v.AdditionalFields != null && v.AdditionalFields.ContainsKey("defaultconceptid"))
                {
                    v.ConceptId = int.Parse(v.AdditionalFields["defaultconceptid"]);
                }

                if (!v.EndDate.HasValue)
                    v.EndDate = v.StartDate;

                // inst_type_of_bill_std_id
                if (v.TypeConceptId == 32810 &&
                    !string.IsNullOrEmpty(v.SourceValue) &&
                    v.SourceValue.Length > 1 &&
                    v.SourceValue.ToLower()[0] == 'x')
                {
                    if (v.SourceValue[1] == '1' || v.SourceValue[1] == '2')
                    {
                        v.ConceptId = 9201;
                    }
                    else if (v.SourceValue[1] == '3' || v.SourceValue[1] == '4')
                    {
                        v.ConceptId = 9202;
                    }
                }
            }

            var visitDetails = BuildVisitDetails(null, [.. VisitOccurrencesRaw], observationPeriods).ToArray();

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], observationPeriods))
            {
                visitOccurrence.Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;

                if (visitOccurrences.TryAdd(visitOccurrence.Id, visitOccurrence))
                {
                    visitIds.Add(visitOccurrence.Id);
                }
            }

            foreach (var visitDetail in visitDetails)
            {
                var vo = GetVisitOccurrence(visitDetail);
                visitDetail.VisitOccurrenceId = vo?.Id ?? 0;

                if (visitDetail.AdditionalFields != null && visitDetail.AdditionalFields.ContainsKey("hv_enc_id"))
                {
                    var hvEncId = visitDetail.AdditionalFields["hv_enc_id"];

                    if (!string.IsNullOrEmpty(hvEncId))
                    {
                        if (!_visitDetailsByHvEncId.ContainsKey(hvEncId))
                        {
                            _visitDetailsByHvEncId.Add(hvEncId, []);
                        }

                        _visitDetailsByHvEncId[hvEncId].Add(visitDetail);
                    }
                }

                if (visitDetail.VisitOccurrenceId.HasValue && !_visitDetails.ContainsKey(visitDetail.VisitOccurrenceId.Value))
                {
                    _visitDetails.Add(visitDetail.VisitOccurrenceId.Value, []);
                }

                _visitDetails[visitDetail.VisitOccurrenceId.Value].Add(visitDetail);
            }

            long? prevVisitId = null;
            foreach (var visitId in visitIds.OrderBy(v => v))
            {
                if (prevVisitId.HasValue)
                {
                    visitOccurrences[visitId].PrecedingVisitOccurrenceId = prevVisitId;
                }

                prevVisitId = visitId;
            }


            var conditionOccurrences =
                BuildConditionOccurrences([.. ConditionOccurrencesRaw], visitOccurrences, observationPeriods)
                    .ToArray();
            foreach (var co in conditionOccurrences)
            {
                co.Id = Offset.GetKeyOffset(co.PersonId).ConditionOccurrenceId;
            }

            var procedureOccurrences =
                BuildProcedureOccurrences([.. ProcedureOccurrencesRaw], visitOccurrences, observationPeriods)
                    .ToArray();
            foreach (var procedureOccurrence in procedureOccurrences)
            {
                procedureOccurrence.Id =
                    Offset.GetKeyOffset(procedureOccurrence.PersonId).ProcedureOccurrenceId;
            }

            var observations = BuildObservations([.. ObservationsRaw], visitOccurrences, observationPeriods)
                .ToArray();
            foreach (var ob in observations)
            {
                ob.Id = Offset.GetKeyOffset(ob.PersonId).ObservationId;
            }

            var drugExposures =
                BuildDrugExposures([.. DrugExposuresRaw], visitOccurrences, observationPeriods)
                    .ToArray();

            var maxEndDate = observationPeriods.Max(op => op.EndDate.Value);
            foreach (var de in drugExposures)
            {
                if (de.EndDate > DateTime.Now)
                {
                    de.EndDate = maxEndDate;
                }
            }

            var measurements = BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods)
                .ToArray();
            var deviceExposure = BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods)
                .ToArray();

            //// set corresponding ProviderIds
            //SetProviderIds(drugExposures);
            //SetProviderIds(conditionOccurrences);
            //SetProviderIds(visitOccurrences.Values.ToArray());
            //SetProviderIds(procedureOccurrences);
            //SetProviderIds(observations);
            //SetProviderIds(visitDetails);

            if (visitOccurrences.Values.Count < 1000 * 1000)
            {
                var visitByStart = new Dictionary<int, Dictionary<int, List<VisitOccurrence>>>();
                foreach (var vo in visitOccurrences.Values)
                {
                    if (!visitByStart.ContainsKey(vo.StartDate.Year))
                        visitByStart.Add(vo.StartDate.Year, []);

                    if (!visitByStart[vo.StartDate.Year].ContainsKey(vo.StartDate.Month))
                        visitByStart[vo.StartDate.Year].Add(vo.StartDate.Month, []);

                    visitByStart[vo.StartDate.Year][vo.StartDate.Month].Add(vo);
                }

                SetVisitDetailId(drugExposures, visitByStart);
                SetVisitDetailId(conditionOccurrences, visitByStart);
                SetVisitDetailId(procedureOccurrences, visitByStart);
                SetVisitDetailId(measurements, visitByStart);
                SetVisitDetailId(observations, visitByStart);
                SetVisitDetailId(deviceExposure, visitByStart);
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, null,
                observationPeriods,
                [],
                drugExposures,
                conditionOccurrences,
                procedureOccurrences,
                observations,
                measurements,
                [.. visitOccurrences.Values], visitDetails, [], deviceExposure, [], []);

            Complete = true;

            var pg = new PregnancyAlgorithm.PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, observationPeriods,
                ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
            {
                r.Id = Offset.GetKeyOffset(r.PersonId).ConditionEraId;
                ChunkData.ConditionEra.Add(r);
            }

            return Attrition.None;
        }

        public override IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures, Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var de in base.BuildDrugExposures(drugExposures, visitOccurrences, observationPeriods))
            {
                int? daysSupply = 1;
                if (de.AdditionalFields != null && de.AdditionalFields.ContainsKey("medctn_days_supply_cnt"))
                {
                    var daysSupplyValue = de.AdditionalFields["medctn_days_supply_cnt"];

                    if (!string.IsNullOrEmpty(daysSupplyValue))
                    {
                        if (int.TryParse(daysSupplyValue.Split('.')[0], out var ds))
                        {
                            daysSupply = ds;

                            if (daysSupply < 0)
                                daysSupply = 1;
                            else if (daysSupply > 365)
                                daysSupply = 365;
                        }
                    }
                }

                de.EndDate = de.StartDate.AddDays(daysSupply.Value - 1);
                de.DaysSupply = daysSupply;

                yield return de;
            }
        }

        private void SetVisitDetailId(IEnumerable<IEntity> entities, Dictionary<int, Dictionary<int, List<VisitOccurrence>>> visits)
        {
            foreach (var e in entities)
            {
                if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("hv_enc_id"))
                {
                    var hvEncId = e.AdditionalFields["hv_enc_id"];

                    if (!string.IsNullOrEmpty(hvEncId) && _visitDetailsByHvEncId.ContainsKey(hvEncId))
                    {
                        var vdEncId = _visitDetailsByHvEncId[hvEncId].FirstOrDefault();

                        e.VisitDetailId = vdEncId.Id;
                        e.VisitOccurrenceId = vdEncId.VisitOccurrenceId;
                        continue;
                    }
                }

                if (!visits.ContainsKey(e.StartDate.Year))
                    return;

                if (!visits[e.StartDate.Year].ContainsKey(e.StartDate.Month))
                    return;

                var vs = visits[e.StartDate.Year][e.StartDate.Month].Where(vd => e.StartDate.Between(vd.StartDate, vd.EndDate.Value)).ToArray();
                if (vs.Length == 0)
                    return;

                VisitDetail vd = null;
                foreach (var vo in vs)
                {
                    vd = _visitDetails[vo.Id].FirstOrDefault(vd => vd.SourceRecordGuid == e.SourceRecordGuid);

                    if (vd != null)
                    {
                        break;
                    }
                }

                vd ??= _visitDetails[vs[0].Id].First();

                if (vd != null)
                {
                    e.VisitDetailId = vd.Id;
                    e.VisitOccurrenceId = vd.VisitOccurrenceId;
                }
            }
        }
        protected static void GetMinMaxDates<T>(IEnumerable<T> inputRecords, Dictionary<string, HashSet<DateTime>> result) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;

            GetMinMaxDates(result, inputRecords.Where(e => e.StartDate != DateTime.MinValue), AggregationType.Min);
            GetMinMaxDates(result, inputRecords.Where(e => e.EndDate.HasValue && e.EndDate.Value != DateTime.MinValue && e.EndDate.Value != DateTime.MaxValue), AggregationType.Max);
        }

        private static void GetMinMaxDates<T>(Dictionary<string, HashSet<DateTime>> result, IEnumerable<T> dates, AggregationType at) where T : class, IEntity
        {
            if (dates != null && dates.Any())
            {
                var medical = dates.Where(d => d.TypeConceptId == 32871 || d.TypeConceptId == 32810 || d.TypeConceptId == 32811);
                GetMinMaxDates(result, medical, Table.Medical, at);

                var pharmacy = dates.Where(d => d.TypeConceptId == 32869);
                GetMinMaxDates(result, pharmacy, Table.Pharmacy, at);
            }
        }
        private static string GetDateKey(Table t, DataVendor dv, AggregationType at)
        {
            return $"{t}-{dv}-{at}";
        }
        private static void GetMinMaxDates<T>(Dictionary<string, HashSet<DateTime>> result, IEnumerable<T> input, Table table, AggregationType at) where T : class, IEntity
        {
            if (input != null && input.Any())
            {
                var ps17 = input.Where(m => m.AdditionalFields != null && m.AdditionalFields.ContainsKey("data_vendor") && m.AdditionalFields["data_vendor"].Equals("private source 17", StringComparison.CurrentCultureIgnoreCase));
                var ps20 = input.Where(m => m.AdditionalFields != null && m.AdditionalFields.ContainsKey("data_vendor") && m.AdditionalFields["data_vendor"].Equals("private source 20", StringComparison.CurrentCultureIgnoreCase));
                GetMinMaxDates(result, table, DataVendor.PrivateSource17, at, ps17);
                GetMinMaxDates(result, table, DataVendor.PrivateSource20, at, ps20);
            }
        }

        private void SetUnitConceptId(IEntity e)
        {
            if (e.GeEntityType() != Enums.EntityType.Measurement ||
                e.GeEntityType() != Enums.EntityType.Observation)
                return;

            if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("unit_source_value"))
            {
                var unitSourceValue = e.AdditionalFields["unit_source_value"];

                if (!string.IsNullOrEmpty(unitSourceValue))
                {
                    var result = Vocabulary.Lookup(unitSourceValue.Trim(), "units", DateTime.MinValue);
                    long conceptId = 0;

                    if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                        conceptId = result[0].ConceptId.Value;

                    if (e.GeEntityType() == Enums.EntityType.Measurement)
                        ((Measurement)e).UnitConceptId = conceptId;
                    else
                        ((Observation)e).UnitsConceptId = conceptId;
                }
            }
        }

        private static void GetMinMaxDates<T>(Dictionary<string, HashSet<DateTime>> result, Table table, DataVendor dv, AggregationType at, IEnumerable<T> input) where T : class, IEntity
        {
            if (input != null && input.Any())
            {
                var key = GetDateKey(table, dv, at);
                if (!result.ContainsKey(key))
                    result.Add(key, []);

                if (at == AggregationType.Min)
                    result[key].Add(input.Min(e => e.StartDate));
                else
                    result[key].Add(input.Max(e => e.StartDate));
            }
        }

        public override void AddToChunk(string domain, IEnumerable<IEntity> entities)
        {
            foreach (var entity in entities)
            {
                var entityDomain = GetDomain(domain, entity.Domain);

                switch (entityDomain)
                {
                    case "Condition":
                        var obs = entity as Observation;
                        if (obs == null || obs.ValueAsNumber == 1)
                        {
                            var cond = entity as ConditionOccurrence ??
                                       new ConditionOccurrence(entity)
                                       {
                                           Id = Offset.GetKeyOffset(entity.PersonId)
                                               .ConditionOccurrenceId
                                       };
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        var mes = entity as Measurement ?? new Measurement(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                        };

                        SetUnitConceptId(mes);
                        ChunkData.AddData(mes);
                        break;

                    case "Observation":
                        var o = entity as Observation ?? new Observation(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                        };

                        SetUnitConceptId(o);
                        ChunkData.AddData(o);
                        break;

                    case "Procedure":
                        ChunkData.AddData(entity as ProcedureOccurrence ??
                                          new ProcedureOccurrence(entity)
                                          {
                                              Id =
                                                  Offset.GetKeyOffset(entity.PersonId)
                                                      .ProcedureOccurrenceId
                                          });
                        break;

                    case "Device":
                        ChunkData.AddData(entity as DeviceExposure ??
                                          new DeviceExposure(entity)
                                          {
                                              Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId
                                          });
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DrugExposureId
                                  };

                        if (!drg.EndDate.HasValue)
                            drg.EndDate = drg.StartDate;

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }
            }
        }
    }
}