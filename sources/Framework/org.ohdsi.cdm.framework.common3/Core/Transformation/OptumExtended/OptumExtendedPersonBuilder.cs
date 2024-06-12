using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Core.Transformation.OptumExtended
{
    /// <summary>
    ///  Implementation of PersonBuilder for Optum, based on CDM Build spec
    /// </summary>
    public class OptumExtendedPersonBuilder : PersonBuilder
    {
        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = [];

        private readonly Dictionary<string, Dictionary<string, Dictionary<string, List<VisitDetail>>>> _rawVisitDetails =
            [];

        private readonly Dictionary<long, HashSet<DateTime>> _potentialChilds = [];
        private readonly string[] _neg = ["ldtnot", "neg", "not-detected", "notdet", "negative for covid"];
        private readonly string[] _pos = ["ldtdet", "pos", "positive for 2019-", "positive for covid"];

        public override Death BuildDeath(Death[] deathRaw, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var death = FilterDeathRecords(deathRaw).ToList();

            if (death.Count != 0)
            {
                var dodDeath = death.FirstOrDefault(d => d.TypeConceptId == 32885);
                if (dodDeath != null)
                {
                    var endOfMonth = new DateTime(dodDeath.StartDate.Year,
                        dodDeath.StartDate.Month,
                        DateTime.DaysInMonth(dodDeath.StartDate.Year,
                            dodDeath.StartDate.Month));

                    dodDeath.StartDate = endOfMonth;

                    return dodDeath;
                }

                var maxStartDate = death.Max(d => d.StartDate);
                var result = death.Where(d => d.StartDate == maxStartDate).OrderByDescending(d => d.Primary).First();

                result.CauseConceptId = 0;

                return result;
            }

            return null;
        }

        private IEnumerable<Death> FilterDeathRecords(IEnumerable<Death> death)
        {
            foreach (var d in death)
            {
                if (d.TypeConceptId == 32885)
                {
                    yield return d;
                    continue;
                }

                var visitOccurrence = GetVisitOccurrence(d);
                if (visitOccurrence == null)
                {
                    continue;
                }

                d.StartDate = visitOccurrence.EndDate.Value;

                yield return d;
            }
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

        private void AddRawVisitOccurrence(VisitOccurrence rawVisit, VisitOccurrence finalVisit)
        {
            if (!_rawVisits.TryAdd(rawVisit.SourceRecordGuid, finalVisit))
                _rawVisits[rawVisit.SourceRecordGuid] = finalVisit;
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

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements, Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            var final = new List<Measurement>();
            var labs = new List<Measurement>();
            var others = new List<Measurement>();

            foreach (var m in measurements)
            {
                if (m.TypeConceptId == 100 || m.TypeConceptId == 101)
                    labs.Add(m);
                else
                    others.Add(m);
            }

            foreach (var row in labs.GroupBy(e => e.SourceRecordGuid))
            {
                var loincCd = row.FirstOrDefault(r => r.TypeConceptId == 100 && r.ConceptId > 0);
                var procCd = row.FirstOrDefault(r => r.TypeConceptId == 101 && r.ConceptId > 0);

                Measurement measurement;
                if (loincCd != null)
                {
                    measurement = loincCd;
                }
                else if (procCd != null)
                {
                    measurement = procCd;
                }
                else
                {
                    measurement = row.FirstOrDefault(r => !string.IsNullOrWhiteSpace(r.SourceValue));

                    measurement ??= row.FirstOrDefault();
                }

                measurement.TypeConceptId = 32856;
                final.Add(measurement);
            }

            final.AddRange(others);
            return base.BuildMeasurement([.. final], visitOccurrences, observationPeriods);
        }


        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails,
            VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            var mcVisits = new Dictionary<long, VisitDetail>();
            var inConfVisits = new Dictionary<string, long>();
            foreach (var visitOccurrence in visitOccurrences)
            {
                var visitDetail =
                    new VisitDetail(visitOccurrence)
                    {
                        Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitDetailId,
                        DischargeToConceptId = visitOccurrence.DischargeToConceptId,
                        DischargeToSourceValue = visitOccurrence.DischargeToSourceValue
                    };

                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;

                if (visitDetail.EndDate.Value.Year == 9999)
                    visitDetail.EndDate = visitDetail.StartDate;

                //if(visitDetail.StartDate > visitDetail.EndDate.Value)
                //    visitDetail.EndDate = visitDetail.StartDate;

                var stdplacs = new[] { "02", "08", "17", "53", "57", "71", "72", "11", "01", "95", "12", "20", "49", "60", "15", "81", "42", "41", "14", "04", "18", "09", "03", "65", "16" };
                var stdplacs2 = new[] { "23", "24", "19", "25", "50", "62" };

                // If STDPLAC (POS) in 22 and TSVCDAT - SVCDATE > 1 (LST_DT - FST_DT > 1) then set VISIT_DETAIL_CONCEPT_ID to 9201.
                if (visitDetail.SourceValue == "22" && visitDetail.EndDate.Value.Subtract(visitDetail.StartDate).Days > 1)
                {
                    visitDetail.ConceptId = 9201;
                }
                // If STDPLAC (POS) is blank, NULL, does not have a mapping or 
                // is equal to 02, 08, 17, 53, 57, 71, 72, 11, 01, 95, 12, 20, 49, 60, 15, 81, 42, 41, 14, 04, 18, , 09, 03, 65 or 16 
                // then set visit_detail_end_date equal to visit_detail_start_date.
                else if (string.IsNullOrEmpty(visitDetail.SourceValue) || stdplacs.Contains(visitDetail.SourceValue))
                {
                    visitDetail.EndDate = visitDetail.StartDate;
                }
                // If STDPLAC(POS) is equal to 23, 24, 19, 25, 50, 62 and 
                // TSVCDAT - SVCDATE > 1(LST_DT - FST_DT > 1) then set visit_detail_end_date equal to visit_detail_start_date.
                else if (stdplacs2.Contains(visitDetail.SourceValue) && visitDetail.EndDate.Value.Subtract(visitDetail.StartDate).Days > 1)
                {
                    visitDetail.EndDate = visitDetail.StartDate;
                }

                visitOccurrence.ConceptId = visitDetail.ConceptId;
                visitOccurrence.StartDate = visitDetail.StartDate;
                visitOccurrence.EndDate = visitDetail.EndDate;

                //medical_claims
                if (visitDetail.AdditionalFields.ContainsKey("paid_status"))
                    mcVisits.Add(visitDetail.Id, visitDetail);
                else if (visitDetail.TypeConceptId == 32855)
                {
                    visitDetail.VisitDetailParentId = visitDetail.Id;

                    if (!inConfVisits.ContainsKey(visitDetail.SourceValue))
                        inConfVisits.Add(visitDetail.SourceValue, visitDetail.Id);

                    yield return visitDetail;
                }
                else
                    yield return visitDetail;
            }

            foreach (var patplanidGroup in mcVisits.Values.GroupBy(v => v.AdditionalFields["pat_planid"]))
            {
                foreach (var clmidGroup in patplanidGroup.GroupBy(v => v.AdditionalFields["clmid"]))
                {
                    foreach (var clmseqGroup in clmidGroup.GroupBy(v => v.AdditionalFields["clmseq"]))
                    {
                        long? prevVisitId = null;
                        foreach (var vd in clmseqGroup.OrderBy(v => v.AdditionalFields["paid_status"]))
                        {
                            if (prevVisitId.HasValue)
                            {
                                mcVisits[vd.Id].PrecedingVisitDetailId = prevVisitId;
                            }

                            prevVisitId = vd.Id;
                        }
                    }
                }
            }

            foreach (var visitDetail in mcVisits.Values)
            {
                var confId = visitDetail.AdditionalFields["conf_id"];
                if (inConfVisits.ContainsKey(confId))
                    visitDetail.VisitDetailParentId = inConfVisits[confId];

                yield return visitDetail;
            }
        }

        private VisitOccurrence GetVisitOccurrence(IEntity ent)
        {
            if (_rawVisits.ContainsKey(ent.SourceRecordGuid))
            {
                var vo = _rawVisits[ent.SourceRecordGuid];
                if (vo.Id == 0 && _rawVisits.ContainsKey(vo.SourceRecordGuid) &&
                    _rawVisits[vo.SourceRecordGuid].SourceRecordGuid != ent.SourceRecordGuid)
                {
                    vo = _rawVisits[vo.SourceRecordGuid];
                }

                return vo;
            }

            return null;
        }

        private void SetVisitDetailId(IEnumerable<IEntity> entities, bool updateDates)
        {
            foreach (var e in entities)
            {
                if (e.AdditionalFields == null || !e.AdditionalFields.ContainsKey("pat_planid"))
                    continue;

                var patPlanid = e.AdditionalFields["pat_planid"];
                var clmid = string.Empty;
                var locCd = string.Empty;

                if (e.AdditionalFields.ContainsKey("clmid"))
                    clmid = e.AdditionalFields["clmid"];

                if (e.AdditionalFields.ContainsKey("loc_cd"))
                    locCd = e.AdditionalFields["loc_cd"];

                if (_rawVisitDetails.ContainsKey(patPlanid) && _rawVisitDetails[patPlanid].ContainsKey(clmid))
                {
                    VisitDetail vd = null;
                    if (locCd != string.Empty && _rawVisitDetails[patPlanid][clmid].ContainsKey(locCd))
                    {
                        vd = _rawVisitDetails[patPlanid][clmid][locCd]
                            .FirstOrDefault(v => v.SourceRecordGuid == e.SourceRecordGuid);

                        vd ??= _rawVisitDetails[patPlanid][clmid][locCd]
                                .FirstOrDefault(v => v.StartDate == e.StartDate);

                        vd ??= _rawVisitDetails[patPlanid][clmid][locCd]
                                .FirstOrDefault(v => e.StartDate.Between(v.StartDate, v.EndDate.Value));
                    }
                    else if (locCd == string.Empty)
                    {
                        VisitDetail vdByDate = null;
                        VisitDetail vdByDate2 = null;
                        foreach (var items in _rawVisitDetails[patPlanid][clmid].Values)
                        {
                            vd = items.FirstOrDefault(v => v.SourceRecordGuid == e.SourceRecordGuid);

                            if (vd == null && vdByDate == null)
                                vdByDate = items.FirstOrDefault(v => v.StartDate == e.StartDate);

                            if (vd == null && vdByDate == null && vdByDate2 == null)
                                vdByDate2 = items.FirstOrDefault(v => e.StartDate.Between(v.StartDate, v.EndDate.Value));

                            if (vd != null)
                                break;
                        }

                        if (vd == null && vdByDate != null)
                            vd = vdByDate;

                        if (vd == null && vdByDate2 != null)
                            vd = vdByDate2;
                    }

                    if (vd != null && vd.ConceptId >= 0)
                    {
                        e.VisitDetailId = vd.Id;
                        e.ProviderId = vd.ProviderId;

                        if (updateDates)
                        {
                            e.StartDate = vd.StartDate;
                            e.EndDate = vd.EndDate;
                        }

                        e.VisitOccurrenceId = vd.VisitOccurrenceId;
                    }
                }
            }
        }

        private static IEnumerable<DrugExposure> FilteroutDrugClaims(IEnumerable<DrugExposure> rawDrugs)
        {
            var drugClaims = new Dictionary<Guid, List<DrugExposure>>();
            foreach (var de in rawDrugs)
            {
                if (!drugClaims.ContainsKey(de.SourceRecordGuid))
                    drugClaims.Add(de.SourceRecordGuid, []);

                drugClaims[de.SourceRecordGuid].Add(de);
            }

            foreach (var similarDrugs in drugClaims.SelectMany(drugs => drugs.Value.GroupBy(d => d.SourceValue)))
            {
                var drugs = similarDrugs.Where(d => d.ConceptId > 0).ToArray();
                if (drugs.Length > 0)
                {
                    yield return drugs.OrderBy(d => d.ConceptIdKey.Length).Last();
                    continue;
                }

                var drugs1 = similarDrugs.Where(d => d.SourceConceptId > 0)
                    .ToArray();
                if (drugs1.Length > 0)
                {
                    yield return drugs1.OrderBy(d => d.ConceptIdKey.Length)
                        .Last();
                    continue;
                }

                yield return similarDrugs.OrderBy(d => d.ConceptIdKey.Length).Last();
            }
        }

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;
            if (person == null)
                return result.Value;

            if (person.YearOfBirth > DateTime.Now.Year)
            {
                return Attrition.ImplausibleYOBFuture;
            }

            var op = ObservationPeriodsRaw.Where(op =>
                    op.StartDate.Year >= person.YearOfBirth &&
                    op.EndDate.Value.Year >= person.YearOfBirth &&
                    op.StartDate.Year <= DateTime.Now.Year).ToArray();

            if (op.Length == 0)
                return Attrition.InvalidObservationTime;

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap, op).ToArray();

            if (Excluded(person, observationPeriods))
            {
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var fisrtOP = observationPeriods.Min(op => op.StartDate);
            if (fisrtOP.Year == person.YearOfBirth)
            {
                person.MonthOfBirth = fisrtOP.Month;
                person.DayOfBirth = fisrtOP.Day;
            }
            else
            {
                person.MonthOfBirth = null;
                person.DayOfBirth = null;
            }

            var payerPlanPeriods = BuildPayerPlanPeriods(PayerPlanPeriodsRaw.Where(pp =>
                    pp.StartDate.Year >= person.YearOfBirth &&
                    pp.EndDate.Value.Year >= person.YearOfBirth &&
                    pp.StartDate.Year <= DateTime.Now.Year).ToArray(), null).ToArray();

            List<VisitDetail> visitDetails = [];
            foreach (var vd in BuildVisitDetails(null, [.. VisitOccurrencesRaw], observationPeriods).Where(vd =>
                    vd.StartDate.Year >= person.YearOfBirth &&
                    vd.EndDate.Value.Year >= person.YearOfBirth &&
                    vd.StartDate.Year <= DateTime.Now.Year))
            {
                if (vd.StartDate.Year < person.YearOfBirth || vd.StartDate.Year > DateTime.Now.Year)
                    continue;

                if (vd.EndDate.HasValue && (
                    vd.EndDate.Value.Year < person.YearOfBirth ||
                    vd.EndDate.Value.Year > DateTime.Now.Year))
                    continue;

                visitDetails.Add(vd);
            }

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], observationPeriods))
            {
                if (visitOccurrence.StartDate.Year < person.YearOfBirth || visitOccurrence.StartDate.Year > DateTime.Now.Year)
                    continue;

                if (visitOccurrence.EndDate.HasValue && (
                    visitOccurrence.EndDate.Value.Year < person.YearOfBirth ||
                    visitOccurrence.EndDate.Value.Year > DateTime.Now.Year))
                    continue;


                visitOccurrence.Id =
                    Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;
                visitOccurrence.IdUndefined = false;

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
                visitIds.Add(visitOccurrence.Id);
            }

            foreach (var visitDetail in visitDetails)
            {
                var patPlanid = visitDetail.AdditionalFields["pat_planid"];
                var clmid = string.Empty;
                var locCd = string.Empty;

                if (visitDetail.AdditionalFields.ContainsKey("clmid"))
                    clmid = visitDetail.AdditionalFields["clmid"];

                if (visitDetail.AdditionalFields.ContainsKey("loc_cd"))
                    locCd = visitDetail.AdditionalFields["loc_cd"];

                if (!_rawVisitDetails.ContainsKey(patPlanid))
                    _rawVisitDetails.Add(patPlanid, []);

                if (!_rawVisitDetails[patPlanid].ContainsKey(clmid))
                    _rawVisitDetails[patPlanid].Add(clmid, []);

                if (!_rawVisitDetails[patPlanid][clmid].ContainsKey(locCd))
                    _rawVisitDetails[patPlanid][clmid].Add(locCd, []);

                _rawVisitDetails[patPlanid][clmid][locCd].Add(visitDetail);
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
                procedureOccurrence.Id = Offset.GetKeyOffset(procedureOccurrence.PersonId)
                    .ProcedureOccurrenceId;
            }

            var observations = BuildObservations([.. ObservationsRaw], visitOccurrences, observationPeriods)
                .ToArray();
            var drugExposures = BuildDrugExposures(FilteroutDrugClaims(DrugExposuresRaw).ToArray(), visitOccurrences, observationPeriods).ToList();
            var measurements = BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods)
                .ToArray();
            var deviceExposure = BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods)
                .ToArray();

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);

            if (death != null && person.YearOfBirth.HasValue && person.YearOfBirth.Value > 0 &&
                person.YearOfBirth > death.StartDate.Year)
                death = null;

            if (death != null)
            {
                // DOD
                if (death.TypeConceptId == 32885)
                {
                    foreach (var visitOccurrence in visitOccurrences.Values.Where(v => (v.ConceptId == 9202 || v.ConceptId == 581458) && v.StartDate > death.StartDate.AddDays(30)))
                    {
                        visitOccurrence.ConceptId = -1;
                    }

                    if (visitOccurrences.Values.Any(v => (v.ConceptId == 9201 || v.ConceptId == 9203) && v.StartDate > death.StartDate.AddDays(30)))
                    {
                        death = null;
                    }
                }

                if (death != null)
                {
                    if (death.StartDate.Year < person.YearOfBirth || death.StartDate.Year > DateTime.Now.Year)
                        death = null;

                    foreach (var payerPlanPeriod in payerPlanPeriods)
                    {
                        if (payerPlanPeriod.EndDate.Value == death.StartDate)
                            payerPlanPeriod.StopReasonConceptId = 352;
                    }
                }
            }

            foreach (var visitDetail in visitDetails)
            {
                var vo = GetVisitOccurrence(visitDetail);

                if (vo != null && visitOccurrences.ContainsKey(vo.Id))
                {
                    if (visitOccurrences[vo.Id].ConceptId == -1)
                    {
                        visitDetail.ConceptId = -1;
                    }
                    else
                        visitDetail.VisitOccurrenceId = vo.Id;
                }
                else
                {
                    visitDetail.ConceptId = -1;
                }
            }

            SetVisitDetailId(drugExposures, false);
            SetVisitDetailId(conditionOccurrences, true);
            SetVisitDetailId(procedureOccurrences, true);
            SetVisitDetailId(measurements, true);
            SetVisitDetailId(observations, true);
            SetVisitDetailId(deviceExposure, true);

            var vos = visitOccurrences.Values.Where(v => v.ConceptId >= 0).ToArray();
            var vds = visitDetails.Where(v => v.ConceptId >= 0).ToDictionary(v => v.Id, v => v);

            long? prevVisitId = null;
            foreach (var v in vos.OrderBy(v => v.Id))
            {
                if (prevVisitId.HasValue)
                {
                    visitOccurrences[v.Id].PrecedingVisitOccurrenceId = prevVisitId;
                }

                prevVisitId = v.Id;
            }

            foreach (var vd in vds.Values)
            {
                if (vd.PrecedingVisitDetailId.HasValue && !vds.ContainsKey(vd.PrecedingVisitDetailId.Value))
                {
                    vd.PrecedingVisitDetailId = null;
                }
            }

            var latestEndDate = observationPeriods.Max(op => op.EndDate.Value);
            foreach (var ob in observations)
            {
                if (ob.TypeConceptId != 32813)
                    continue;

                // From the SES table
                // Use the latest observation_period_end_date per patient since we do not have dates associated with this data
                ob.StartDate = latestEndDate;
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person,
                death,
                observationPeriods,
                payerPlanPeriods,
                UpdateRSourceConcept(Clean(drugExposures, person)).ToArray(),
                UpdateRSourceConcept(Clean(conditionOccurrences, person)).ToArray(),
                UpdateRSourceConcept(Clean(procedureOccurrences, person)).ToArray(),
                UpdateRSourceConcept(Clean(observations, person)).ToArray(),
                UpdateRSourceConcept(Clean(measurements, person)).ToArray(),
                vos,
                [.. vds.Values],
                [],
                UpdateRSourceConcept(Clean(deviceExposure, person)).ToArray(),
                [],
                []);

            var pregnancyEpisodes = new List<ConditionEra>();
            var pg = new PregnancyAlgorithm.PregnancyAlgorithm();


            foreach (var episode in pg.GetPregnancyEpisodes(Vocabulary, person, observationPeriods,
                ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
            {
                episode.Id = Offset.GetKeyOffset(episode.PersonId).ConditionEraId;
                //episode.OccurrenceCount = episode.OccurrenceCount * -1; //TMP
                episode.OccurrenceCount = 0;
                ChunkData.ConditionEra.Add(episode);
                pregnancyEpisodes.Add(episode);

                if (episode.ConceptId == 433260 && _potentialChilds.Count > 0)
                {
                    // check for mother
                    // and ce.condition_era_end_date >= ppp.payer_plan_period_start_date
                    // and ce.condition_era_end_date <= ppp.payer_plan_period_end_date

                    if (!payerPlanPeriods.Any(pp => episode.EndDate.Value.Between(pp.StartDate, pp.EndDate.Value)))
                        continue;

                    foreach (var child in _potentialChilds)
                    {
                        var childId = child.Key;

                        foreach (var birthdate in child.Value)
                        {
                            // check child dob
                            // and ci.date_of_birth >= op.observation_period_start_date
                            // and ci.date_of_birth <= op.observation_period_end_date

                            if (!observationPeriods.Any(op => birthdate.Between(op.StartDate, op.EndDate.Value)))
                                continue;

                            if (episode.EndDate.Value.Between(birthdate.AddDays(-60), birthdate.AddDays(60)))
                            {
                                //40485452    Child of subject
                                //40478925    Mother of subject

                                ChunkData.FactRelationships.Add(new FactRelationship
                                {
                                    DomainConceptId1 = 56,
                                    DomainConceptId2 = 56,
                                    FactId1 = episode.PersonId,
                                    FactId2 = childId,
                                    RelationshipConceptId = 40478925
                                });

                                break;
                            }
                        }
                    }
                }
            }

            return Attrition.None;
        }
        public static IEnumerable<T> Clean<T>(IEnumerable<T> entities, Person person) where T : class, IEntity
        {
            foreach (var e in entities)
            {
                if (e.StartDate.Year < person.YearOfBirth || e.StartDate.Year > DateTime.Now.Year)
                    continue;

                if (e.EndDate.HasValue && (
                    e.EndDate.Value.Year < person.YearOfBirth ||
                    e.EndDate.Value.Year > DateTime.Now.Year))
                    continue;

                yield return e;
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

                        var cond = entity as ConditionOccurrence ??
                                   new ConditionOccurrence(entity)
                                   {
                                       Id = Offset.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                   };

                        if (!cond.EndDate.HasValue)
                            cond.EndDate = cond.StartDate;

                        if (cond.TypeConceptId < 20)
                        {
                            if (
                                 cond.TypeConceptId == 1 ||
                                cond.TypeConceptId == 11)
                            {
                                cond.StatusConceptId = 32902;
                            }
                            else
                                cond.StatusConceptId = 32908;

                            string fieldName;
                            if (cond.TypeConceptId < 10)
                            {
                                fieldName = "diag";
                            }
                            else
                                fieldName = "proc";

                            if (cond.TypeConceptId > 10)
                                cond.TypeConceptId -= 10;

                            fieldName += cond.TypeConceptId;

                            cond.StatusSourceValue = fieldName;
                        }

                        SetTypeId(cond);
                        ConditionForEra.Add(cond);
                        ChunkData.AddData(cond);
                        break;

                    case "Measurement":
                        var mes = entity as Measurement ??
                                  new Measurement(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                                  };

                        if (mes.TypeConceptId == 32850)
                        {
                            mes.ValueAsConceptId = GetValueAsConceptId(mes.ValueSourceValue);
                        }
                        else if ((!mes.ValueAsConceptId.HasValue || mes.ValueAsConceptId == 0) && !string.IsNullOrEmpty(mes.ValueSourceValue) && mes.ValueSourceValue.Split(';').Length > 1)
                        {
                            var value = mes.ValueSourceValue.Split(';')[1].ToLower();
                            if (_neg.Contains(value))
                            {
                                mes.ValueAsConceptId = 9190;
                            }
                            else if (value.StartsWith("not detected^no"))
                            {
                                mes.ValueAsConceptId = 9190;
                            }
                            else if (_pos.Contains(value))
                            {
                                mes.ValueAsConceptId = 4126681;
                            }
                        }

                        SetTypeId(mes);
                        ChunkData.AddData(mes);
                        break;

                    case "Meas Value":
                        var mv = entity as Measurement ??
                                 new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId };

                        SetTypeId(mv);
                        ChunkData.AddData(mv);
                        break;

                    case "Observation":
                        var o = entity as Observation ??
                                new Observation(entity) { Id = Offset.GetKeyOffset(entity.PersonId).ObservationId };

                        if (o.TypeConceptId == 32850)
                        {
                            o.ValueAsConceptId = GetValueAsConceptId(o.ValueAsString);
                        }
                        else if ((!o.ValueAsConceptId.HasValue || o.ValueAsConceptId == 0) && !string.IsNullOrEmpty(o.ValueAsString) && o.ValueAsString.Split(';').Length > 1)
                        {
                            var value = o.ValueAsString.Split(';')[1].ToLower();
                            if (_neg.Contains(value))
                            {
                                o.ValueAsConceptId = 9190;
                            }
                            else if (value.StartsWith("not detected^no"))
                            {
                                o.ValueAsConceptId = 9190;
                            }
                            else if (_pos.Contains(value))
                            {
                                o.ValueAsConceptId = 4126681;
                            }
                        }

                        SetTypeId(o);
                        ChunkData.AddData(o);
                        break;

                    case "Procedure":
                        var p = entity as ProcedureOccurrence ??
                                new ProcedureOccurrence(entity)
                                {
                                    Id =
                                        Offset.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
                                };

                        SetTypeId(p);
                        if (p.ConceptId > 0 || !string.IsNullOrEmpty(p.SourceValue) || !string.IsNullOrWhiteSpace(p.SourceValue.Trim('0')))
                            ChunkData.AddData(p);
                        break;

                    case "Device":
                        var dev = entity as DeviceExposure ??
                                  new DeviceExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId
                                  };

                        if (!dev.EndDate.HasValue)
                            dev.EndDate = dev.StartDate;

                        SetTypeId(dev);
                        ChunkData.AddData(dev);
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity) { Id = Offset.GetKeyOffset(entity.PersonId).DrugExposureId };

                        if (!drg.EndDate.HasValue)
                            drg.EndDate = drg.StartDate;

                        SetTypeId(drg);
                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }
            }
        }

        private long? GetValueAsConceptId(string value)
        {
            var result = Vocabulary.Lookup(value, "Lab", DateTime.MinValue);
            return result[0].ConceptId;
        }

        private static void SetTypeId(IEntity entity)
        {
            // INPATIENT_CONFINEMENT
            if (entity.TypeConceptId < 20)
            {
                entity.TypeConceptId = 32855;
            }
        }

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ThenBy(p => p.EndDate).ToArray();

            foreach (var p in ordered)
            {
                if (p.PotentialChildId.HasValue && p.PotentialChildBirthDate != DateTime.MinValue)
                {
                    if (!_potentialChilds.ContainsKey(p.PotentialChildId.Value))
                    {
                        _potentialChilds.Add(p.PotentialChildId.Value, []);
                    }

                    _potentialChilds[p.PotentialChildId.Value].Add(p.PotentialChildBirthDate);
                }
            }

            var person = ordered.Take(1).Last();

            if (records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Max(r => r.YearOfBirth) -
                records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Min(r => r.YearOfBirth) > 2)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.MultipleYearsOfBirth);
            }

            person.LocationId = Entity.GetId(person.LocationSourceValue);

            if (person.GenderConceptId == 8551) //UNKNOWN
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (person.YearOfBirth < 1900) //UNKNOWN
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            if (records.Any(r => r.GenderConceptId != 8551 && r.GenderConceptId != person.GenderConceptId))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges); // Gender changed over different enrollment period 
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

    }
}