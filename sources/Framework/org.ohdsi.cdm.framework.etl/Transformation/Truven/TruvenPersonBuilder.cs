using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;
using org.ohdsi.cdm.framework.common.Validators;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace org.ohdsi.cdm.framework.etl.Transformation.Truven
{
    /// <summary>
    ///  Implementation of PersonBuilder for Truven CCAE/MDCR/MDCD, based on CDM Build spec
    /// </summary>
    public class TruvenPersonBuilder : PersonBuilder
    {
        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = [];
        private readonly Dictionary<string, Dictionary<Guid, List<VisitDetail>>> _rawVisitDetails = [];
        private readonly Dictionary<string, Dictionary<DateTime, List<VisitDetail>>> _rawVisitDetailsByDate = [];
        private readonly Dictionary<long, VisitDetail> _visitDetails = [];
        private readonly Dictionary<long, HashSet<DateTime>> _potentialChilds = [];

        /// <summary>
        /// Projects Enumeration of payerPlanPeriod from the raw set of payerPlanPeriod entities.
        /// </summary>
        /// <param name="payerPlanPeriods">raw set of payerPlanPeriod entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <returns>Enumeration of payerPlanPeriod entities</returns>
        public override IEnumerable<PayerPlanPeriod> BuildPayerPlanPeriods(PayerPlanPeriod[] payerPlanPeriods,
            Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            return base.BuildPayerPlanPeriods(CleanPayerPlanPeriods(payerPlanPeriods).ToArray(), visitOccurrences);
        }

        /// <summary>
        /// Projects person etity from the raw set of persons entities. 
        /// </summary>
        /// <param name="records">raw set of Person entities</param>
        /// <returns>Person entity</returns>
        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            if (records.All(p => p.GenderConceptId == 8551))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (records.All(p => p.AdditionalFields["missinginsurance"] == "1"))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.MissingInsuranceCoverage);
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
                p.AdditionalFields["missinginsurance"] == "0" &&
                p.YearOfBirth >= 1900 &&
                p.YearOfBirth <= DateTime.Now.Year).ToArray();

            if (filtered.Length == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            foreach (var p in filtered)
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

            if (DateTime.Now.Year - person.YearOfBirth < 90 && records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Max(r => r.YearOfBirth) -
                records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Min(r => r.YearOfBirth) > 2)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.MultipleYearsOfBirth);
            }

            if (person.LocationId == 0)
                person.LocationId = null;

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        /// <summary>
        /// Projects death entity from the raw set of death entities.
        /// During build:
        /// override the death's start date using the end date of the corresponding visit.
        /// </summary>
        /// <param name="deathRaw">raw set of death entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>death entity</returns>
        public override Death BuildDeath(Death[] deathRaw, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            // Filter out death records without visit occurrence and override the death date using the end date of the corresponding visit.
            var death = FilterDeathRecords(deathRaw, visitOccurrences).ToList();

            // Data sources might contain multiple records of death at different dates. 
            // It is the task of the ETL to pick the most plausible or most accurate record to be stored to this table.
            if (death.Count != 0)
            {
                var result = death.Where(d => d.Primary).OrderByDescending(d => d.StartDate).FirstOrDefault() ??
                             death.OrderByDescending(d => d.StartDate).First();

                var maxVisitStartDate = visitOccurrences.Values.Max(vo => vo.StartDate);

                // If there are health care visits after 32 days of death date, delete this record
                if (maxVisitStartDate < result.StartDate.AddDays(32))
                {
                    return result;
                }
            }

            return null;
        }

        // Filter out death records without visit occurrence and override the death date using the end date of the corresponding visit.
        private IEnumerable<Death> FilterDeathRecords(IEnumerable<Death> death,
            Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            SetVisitDetailIds(death, false);
            foreach (var d in death)
            {
                if (!d.VisitOccurrenceId.HasValue || !visitOccurrences.ContainsKey(d.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[d.VisitOccurrenceId.Value];

                d.StartDate = visitOccurrence.EndDate.Value;

                yield return d;
            }
        }


        public override bool CanPayerPlanPeriodBeCombined(PayerPlanPeriod current, PayerPlanPeriod other)
        {
            return current.PlanSourceValue == other.PlanSourceValue &&
                   current.PayerSourceValue == other.PayerSourceValue;
        }

        private static IEnumerable<PayerPlanPeriod> CleanPayerPlanPeriods(IList<PayerPlanPeriod> payerPlanPeriods)
        {
            payerPlanPeriods = [.. payerPlanPeriods.OrderBy(p => p.StartDate).ThenBy(p => p.EndDate)];

            for (var i = 0; i < payerPlanPeriods.Count - 1; i++)
            {
                if (payerPlanPeriods[i].EndDate >= payerPlanPeriods[i + 1].StartDate)
                {
                    payerPlanPeriods[i].EndDate = payerPlanPeriods[i + 1].StartDate.AddDays(-1);

                    if (payerPlanPeriods[i].EndDate < payerPlanPeriods[i].StartDate)
                        continue;
                }

                yield return payerPlanPeriods[i];
            }

            yield return payerPlanPeriods.Last();
        }

        public static IcdVer GetIcdVersion(IEntity entity)
        {
            if (!entity.AdditionalFields.ContainsKey("dxver"))
                return IcdVer.Icd9;

            return entity.AdditionalFields["dxver"] switch
            {
                "0" => IcdVer.Icd10,
                "9" => IcdVer.Icd9,
                _ => IcdVer.Icd9,
            };
        }

        /// <summary>
        /// Projects Enumeration of ConditionOccurrence from the raw set of ConditionOccurrence entities. 
        /// 	During build:
        /// 	override the condition's start date using the start date of the corresponding visit.
        ///   overide TypeConceptId per CDM Mapping spec. 
        /// </summary>
        /// <param name="conditionOccurrences">raw set of condition occurrence entities</param>
        /// <param name="vo">the visit occurrence entities for current person</param>
        /// <param name="op">the observation period entities for current person</param>
        /// <returns>Enumeration of condition occurrence entities</returns>
        public override IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
            ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> vo, ObservationPeriod[] op)
        {
            var filteredConditionOccurrences = new List<ConditionOccurrence>();

            filteredConditionOccurrences.AddRange(conditionOccurrences.Where(
                co => co.AdditionalFields["priority"] == "1" &&
                      CodeValidator.IsValidIcd(co.SourceValue, GetIcdVersion(co))));

            foreach (var sameRow in conditionOccurrences.Where(
                    co => co.AdditionalFields["priority"] == "2" || co.AdditionalFields["priority"] == "3") // I_A + F_H
                .GroupBy(c => c.SourceRecordGuid))
            {
                foreach (var sameSource in sameRow.GroupBy(c => c.SourceValue))
                {
                    var cond = sameSource.Where(c => c.TypeConceptId < 1000)
                        .Where(co => CodeValidator.IsValidIcd(co.SourceValue, GetIcdVersion(co))).ToList();

                    var proc = sameSource.Where(c => c.TypeConceptId >= 1000).ToList();

                    if (cond.Count > 0)
                    {
                        foreach (var co in cond)
                        {
                            var c = co;
                            if (c.ConceptId == 0 && proc.Count > 0)
                            {
                                var po = proc.FirstOrDefault(p =>
                                    p.ConceptId > 0 && p.TypeConceptId - 1000 == c.TypeConceptId);
                                filteredConditionOccurrences.Add(po ?? c);
                            }
                            else
                            {
                                filteredConditionOccurrences.Add(c);
                            }
                        }
                    }
                    else if (proc.Count > 0)
                    {
                        filteredConditionOccurrences.AddRange(proc);
                    }
                }
            }

            SetVisitDetailIds(filteredConditionOccurrences, false);
            var result = new HashSet<ConditionOccurrence>();
            foreach (var sameVisit in filteredConditionOccurrences
                .GroupBy(c => c.VisitDetailId))
            {
                foreach (var sameSource in sameVisit.GroupBy(c => c.SourceValue))
                {
                    foreach (var sameConcept in sameSource.GroupBy(c => c.ConceptId))
                    {
                        var co = sameConcept.OrderBy(c => c.AdditionalFields["priority"])
                            .ThenBy(c => c.TypeConceptId)
                            .First();


                        var visitOccurrence = vo[co.VisitOccurrenceId.Value];

                        co.EndDate = null;

                        if (co.AdditionalFields["priority"] != "1") // HIX-1274
                        {
                            co.StartDate = visitOccurrence.StartDate;
                        }

                        result.Add(co);
                    }
                }
            }

            return base.BuildConditionOccurrences([.. result], vo, op);
        }

        /// <summary>
        /// Projects Enumeration of ProcedureOccurrence from the raw set of ProcedureOccurence entities.
        /// During build:
        /// override the procedure's start date using the end date of the corresponding visit.
        /// overide TypeConceptId per CDM Mapping spec.
        /// truncate procedure's dates to the corresponding observation period dates
        /// </summary>
        /// <param name="procedureOccurrences">raw set of procedure occurrence entities</param>
        /// <param name="vo">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of procedure occurrence entities</returns>
        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> vo,
            ObservationPeriod[] observationPeriods)
        {
            var result = new HashSet<ProcedureOccurrence>();
            var procedures = new List<ProcedureOccurrence>();

            //var proc = JoinVisitOccurrences(procedureOccurrences).ToList();
            SetVisitDetailIds(procedureOccurrences, false);

            foreach (var po in procedureOccurrences)
            {
                var visitOccurrence = vo[po.VisitOccurrenceId.Value];

                po.StartDate = visitOccurrence.StartDate;
                TruncateDatesToObservationPeriod(observationPeriods, po);

                po.VisitOccurrenceId = visitOccurrence.Id;

                procedures.Add(po);
            }

            foreach (var sameVisit in procedures.GroupBy(c => c.VisitDetailId))
            {
                foreach (var sameStartDate in sameVisit.GroupBy(c => c.StartDate))
                {
                    foreach (var sameSource in sameStartDate.GroupBy(c => c.SourceValue))
                    {
                        foreach (var sameConcept in sameSource.GroupBy(c => c.ConceptId))
                        {
                            var grouped = sameConcept.OrderBy(c => c.AdditionalFields["priority"])
                                .ThenBy(c => c.TypeConceptId).ToArray();
                            var po = grouped.First();

                            var visitOccurrence = vo[po.VisitOccurrenceId.Value];


                            // provid in CCAE/MDCR is int & in MDCD is string
                            var isCcae = po.AdditionalFields["vendor"] != "mdcd";


                            if (po.AdditionalFields["priority"] == "1")
                            {
                                //DX1, PROVID and STDPROV
                                ProcedureOccurrence first;

                                if (isCcae)
                                {
                                    first = grouped.Where(e => e.AdditionalFields["priority"] == "1")
                                        .OrderBy(e => e.AdditionalFields["dx1"])
                                        .ThenBy(
                                            e =>
                                                string.IsNullOrEmpty(e.AdditionalFields["provid"])
                                                    ? 0
                                                    : int.Parse(e.AdditionalFields["provid"]))
                                        .ThenBy(
                                            e =>
                                                string.IsNullOrEmpty(e.AdditionalFields["stdprov"])
                                                    ? 0
                                                    : int.Parse(e.AdditionalFields["stdprov"])).First();
                                }
                                else
                                {
                                    first = grouped.Where(e => e.AdditionalFields["priority"] == "1")
                                        .OrderBy(e => e.AdditionalFields["dx1"])
                                        .ThenBy(e => e.AdditionalFields["provid"].ToLower())
                                        .ThenBy(
                                            e =>
                                                string.IsNullOrEmpty(e.AdditionalFields["stdprov"])
                                                    ? 0
                                                    : int.Parse(e.AdditionalFields["stdprov"])).First();
                                }

                                po.ProviderKey = first.ProviderKey;

                                var costs = new List<ProcedureCost>();
                                foreach (
                                    var procedureOccurrence in
                                    grouped.Where(procedureOccurrence => procedureOccurrence.ProcedureCosts != null))
                                {
                                    costs.AddRange(procedureOccurrence.ProcedureCosts);
                                }

                                po.ProcedureCosts = costs;
                            }
    

                            po.EndDate = null;
                            result.Add(po);
                        }
                    }
                }
            }

            return BuildEntities(procedureOccurrences, vo, observationPeriods, false);
        }

        /// <summary>
        /// Projects Enumeration of procedure cost from the set of procedure occurrence entities.
        /// During build:
        /// override the procedure cost Id to the corresponding procedure occurrence Id
        /// calculate TotalOutOfPocket & TotalPaid per CDM Mapping spec. 
        /// </summary>
        /// <param name="procedureOccurrences">set of procedure occurrence entities</param>
        /// <returns>set of procedure cost entities</returns>
        public override IEnumerable<ProcedureCost> BuildProcedureCosts(ProcedureOccurrence[] procedureOccurrences)
        {
            foreach (var procedureOccurrence in procedureOccurrences)
            {
                if (procedureOccurrence.ProcedureCosts == null) continue;

                foreach (var procedureCost in procedureOccurrence.ProcedureCosts)
                {
                    procedureCost.Id = procedureOccurrence.Id;
                    yield return procedureCost;
                }
            }
        }


        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var o in observations)
            {
                yield return o;
            }
        }

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails, VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {
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

                if (visitDetail.ConceptId == 0)
                {
                    switch (visitDetail.TypeConceptId)
                    {
                        case 32860: // OUTPATIENT_SERVICES
                        case 32846: // FACILITY HEADER
                            visitDetail.ConceptId = 9202;
                            break;

                        // INPATIENT_SERVICES
                        case 32854:
                            visitDetail.ConceptId = 9201;
                            break;

                        // LONG TERM CARE
                        case 38004277:
                            visitDetail.ConceptId = 42898160;
                            break;

                        default:
                            break;
                    }
                }

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

                foreach (var op in observationPeriods)
                {
                    if (visitDetail.EndDate.Value.Between(op.StartDate, op.EndDate.Value))
                    {
                        if (visitDetail.StartDate < op.StartDate)
                            visitDetail.StartDate = op.StartDate;
                        break;
                    }
                }

                visitOccurrence.ConceptId = visitDetail.ConceptId;
                visitOccurrence.StartDate = visitDetail.StartDate;
                visitOccurrence.EndDate = visitDetail.EndDate;

                if (visitOccurrence.VisitCosts != null)
                {
                    foreach (var c in visitOccurrence.VisitCosts)
                    {
                        var cost = new Cost(c.PersonId)
                        {
                            CostId = Offset.GetKeyOffset(c.PersonId).VisitCostId,
                            EventId = visitDetail.Id,
                            CurrencyConceptId = c.CurrencyConceptId,
                            PayerPlanPeriodId = c.PayerPlanPeriodId,
                            TotalPaid = c.TotalPaid,
                            TypeId = visitDetail.TypeConceptId,
                            Domain = "Visit Detail"
                        };

                        ChunkData.Cost.Add(cost);
                    }
                }

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

        /// <summary>
        /// Build person entity and all person related entities like: DrugExposures, ConditionOccurrences, ProcedureOccurrences... from raw data sets 
        /// </summary>
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

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap,
                        ObservationPeriodsRaw.Where(p => p.AdditionalFields["missinginsurance"] == "0").ToArray())
                    .ToArray();

            if (Excluded(person, observationPeriods))
            {
                Complete = true;
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var payerPlanPeriods = BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], null).ToArray();

            List<VisitDetail> visitDetails = [.. BuildVisitDetails(null, [.. VisitOccurrencesRaw], observationPeriods)];

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], observationPeriods))
            {

                visitOccurrence.Id =
                    Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;
                visitOccurrence.IdUndefined = false;

                if (visitOccurrence.ConceptId == 0)
                    visitOccurrence.ConceptId = 9202;

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
                visitIds.Add(visitOccurrence.Id);
            }

            foreach (var visitDetail in visitDetails)
            {
                var hlthplan = "1";

                if (visitDetail.AdditionalFields.ContainsKey("hlthplan"))
                    hlthplan = visitDetail.AdditionalFields["hlthplan"];

                if (!_rawVisitDetails.ContainsKey(hlthplan))
                    _rawVisitDetails.Add(hlthplan, []);

                if (!_rawVisitDetailsByDate.ContainsKey(hlthplan))
                    _rawVisitDetailsByDate.Add(hlthplan, []);

                if (!_rawVisitDetails[hlthplan].ContainsKey(visitDetail.SourceRecordGuid))
                    _rawVisitDetails[hlthplan].Add(visitDetail.SourceRecordGuid, []);

                if (!_rawVisitDetailsByDate[hlthplan].ContainsKey(visitDetail.StartDate))
                    _rawVisitDetailsByDate[hlthplan].Add(visitDetail.StartDate, []);

                _rawVisitDetails[hlthplan][visitDetail.SourceRecordGuid].Add(visitDetail);
                _rawVisitDetailsByDate[hlthplan][visitDetail.StartDate].Add(visitDetail);
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

                _visitDetails.Add(visitDetail.Id, visitDetail);
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
                BuildDrugExposure(DrugExposuresRaw, procedureOccurrences, visitOccurrences, observationPeriods)
                    .ToList();
            var measurements = BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods)
                .ToArray();
            var deviceExposure = BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods)
                .ToArray();

            foreach (var de in deviceExposure)
            {
                de.Quantity = 1;
            }

            // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
            SetPayerPlanPeriodId(payerPlanPeriods, [.. drugExposures], procedureOccurrences,
                [.. visitOccurrences.Values], deviceExposure);

            // set corresponding ProviderIds
            SetProviderIds(drugExposures);
            SetProviderIds(conditionOccurrences);
            SetProviderIds(visitOccurrences.Values.ToArray());
            SetProviderIds(procedureOccurrences);
            SetProviderIds(observations);
            SetProviderIds(visitDetails);

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);
            var drugCosts = BuildDrugCosts([.. drugExposures]).ToArray();
            var procedureCosts = BuildProcedureCosts(procedureOccurrences).ToArray();
            var devicCosts = BuildDeviceCosts(deviceExposure).ToArray();
            var visitCosts = BuildVisitCosts(visitOccurrences.Values.Where(v => v.ConceptId != 1).ToArray()).ToArray();


            if (death != null)
            {
                death = CleanUpDeath(visitOccurrences.Values, death);
                death = CleanUpDeath(drugExposures, death);
                death = CleanUpDeath(conditionOccurrences, death);
                death = CleanUpDeath(procedureOccurrences, death);
                death = CleanUpDeath(measurements, death);
                death = CleanUpDeath(observations.Where(ob => ob.ConceptId != 900000010), death);
                death = CleanUpDeath(deviceExposure, death);
            }

            if (death != null && string.IsNullOrEmpty(death.CauseSource))
            {
                death.CauseConceptId = null;
                death.SourceCauseConceptId = null;
            }

            List<DateTime> mins = [];

            GetMinDate(drugExposures, mins);
            GetMinDate(conditionOccurrences, mins);
            GetMinDate(procedureOccurrences, mins);
            GetMinDate(observations, mins);
            GetMinDate(deviceExposure, mins);
            GetMinDate(measurements, mins);
            GetMinDate(visitOccurrences.Values, mins);
            GetMinDate(visitDetails, mins);
            GetMinDate(observationPeriods, mins);

            person.MonthOfBirth = 6;
            person.DayOfBirth = 1;


            if (mins.Count != 0)
            {
                var min = mins.Min();
                if (min.Year == person.YearOfBirth)
                {
                    person.MonthOfBirth = min.Month;
                    person.DayOfBirth = min.Day;
                }
            }

            person.TimeOfBirth = new DateTime(person.YearOfBirth.Value, person.MonthOfBirth.Value, person.DayOfBirth.Value);

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death,
                observationPeriods,
                payerPlanPeriods,
                [.. drugExposures],
                UpdateRSourceConcept(conditionOccurrences).ToArray(),
                UpdateRSourceConcept(procedureOccurrences).ToArray(),
                UpdateRSourceConcept(observations).ToArray(),
                UpdateRSourceConcept(measurements).ToArray(),
                visitOccurrences, 
                [.. visitDetails], 
                [],
                UpdateRSourceConcept(deviceExposure).ToArray(), 
                []);

            Complete = true;

            var pg = new PregnancyAlgorithm();
            foreach (var episode in pg.GetPregnancyEpisodes(Vocabulary, person, observationPeriods,
                ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
            {
                episode.Id = Offset.GetKeyOffset(episode.PersonId).ConditionEraId;
                ChunkData.ConditionEra.Add(episode);

                if (episode.ConceptId == 433260 && _potentialChilds.Count > 0)
                {
                    foreach (var child in _potentialChilds)
                    {
                        var childId = child.Key;

                        foreach (var birthdate in child.Value)
                        {
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

        protected static void GetMinDate<T>(IEnumerable<T> inputRecords, List<DateTime> result) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;
            var dates = inputRecords.Where(e => e.StartDate > DateTime.MinValue);
            if (dates != null && dates.Any())
                result.Add(dates.Min(e => e.StartDate));
        }

        private void AddToChunk(Person person, Death death, ObservationPeriod[] observationPeriods,
            PayerPlanPeriod[] ppp, DrugExposure[] drugExposures,
            ConditionOccurrence[] conditionOccurrences,
            ProcedureOccurrence[] procedureOccurrences, Observation[] observations,
            Measurement[] measurements, Dictionary<long, VisitOccurrence> visitOccurrences, VisitDetail[] visitDetails, Cohort[] cohort,
            DeviceExposure[] devExposure, Note[] notes)
        {
            ChunkData.AddData(person);

            if (death != null)
            {
                ChunkData.AddData(death);
            }

            foreach (var observationPeriod in observationPeriods)
            {
                ChunkData.AddData(observationPeriod);
            }

            foreach (var payerPlanPeriod in ppp)
            {
                ChunkData.AddData(payerPlanPeriod);
            }

            foreach (var visitOccurrence in visitOccurrences.Values)
            {
                ChunkData.AddData(visitOccurrence);
            }

            if (visitDetails != null)
            {
                foreach (var visitDetail in visitDetails)
                {
                    ChunkData.AddData(visitDetail);
                }
            }

            if (cohort != null)
            {
                foreach (var c in cohort)
                {
                    ChunkData.AddData(c);
                }
            }

            if (notes != null)
            {
                foreach (var n in notes)
                {
                    ChunkData.Note.Add(n);
                    //TMP: NOTE
                    //ChunkData.AddData(n);
                }
            }

            AddToChunk("Condition", conditionOccurrences, visitOccurrences);
            AddToChunk("Drug", drugExposures, visitOccurrences);
            AddToChunk("Procedure", procedureOccurrences, visitOccurrences);
            AddToChunk("Observation", observations, visitOccurrences);
            AddToChunk("Measurement", measurements, visitOccurrences);
            AddToChunk("Device", devExposure, visitOccurrences);

            var drugEra = BuildDrugEra([.. DrugForEra], observationPeriods).ToArray();
            var conditionEra = BuildConditionEra([.. ConditionForEra], observationPeriods).ToArray();

            foreach (var eraEntity in drugEra)
            {
                ChunkData.AddData(eraEntity, EntityType.DrugEra);
            }

            foreach (var eraEntity in conditionEra)
            {
                ChunkData.AddData(eraEntity, EntityType.ConditionEra);
            }
        }

        private void AddToChunk(string domain, IEnumerable<IEntity> entities, Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            foreach (var entity in entities)
            {
                if (!entity.VisitDetailId.HasValue)
                    SetVisitDetailId(entity, false);

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
                                           Id = Offset.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                       };

                            if (cond.TypeConceptId == 32850) //HRA
                            {
                                cond.EndDate = null; //HIX-1299
                            }

                            if (cond.TypeConceptId < 2000)
                            {
                                // DX1 PDX PPROC PROC1
                                if (cond.TypeConceptId == 0 ||
                                    cond.TypeConceptId == 100 ||
                                    cond.TypeConceptId == 1000)
                                {
                                    cond.StatusConceptId = 32902;
                                }
                                else
                                    cond.StatusConceptId = 32908;

                                string fieldName;
                                if (cond.TypeConceptId < 100)
                                {
                                    fieldName = "PROC";
                                }
                                else
                                    fieldName = "DX";

                                if (cond.TypeConceptId == 0 || cond.TypeConceptId == 100 || cond.TypeConceptId == 1000)
                                    fieldName = "P" + fieldName;
                                else
                                {
                                    if (cond.TypeConceptId >= 100 && cond.TypeConceptId < 1000)
                                        cond.TypeConceptId -= 100;
                                    else if (cond.TypeConceptId >= 1000)
                                        cond.TypeConceptId -= 1000;

                                    fieldName += cond.TypeConceptId;
                                }

                                cond.StatusSourceValue = fieldName;
                            }

                            
                            SetTypeId(cond, visitOccurrences);
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        var mes = entity as Measurement ??
                                  new Measurement(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                                  };

                        if (mes.TypeConceptId == 32856 && mes.ValueAsNumber.HasValue && mes.ValueAsNumber > 100000 &&
                            mes.UnitConceptId == 8739 && (mes.SourceValue == "3142-7" ||
                                                          mes.SourceValue == "29463-7" || mes.SourceValue == "3141-9"))
                        {
                            mes.ValueAsNumber = mes.ValueAsNumber.Value / 10000;
                        }

                        if ((!mes.ValueAsConceptId.HasValue || mes.ValueAsConceptId == 0) && !string.IsNullOrEmpty(mes.ValueSourceValue))
                        {
                            var result = Vocabulary.Lookup(mes.ValueSourceValue, "ValueAsConcept", DateTime.MinValue);

                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId.Value > 0)
                                mes.ValueAsConceptId = result[0].ConceptId.Value;
                        }

                        // LOIN from LAB
                        if (mes.TypeConceptId == 32856 && mes.ConceptId > 0 && entity.Domain.Equals("note", StringComparison.CurrentCultureIgnoreCase))
                        {
                            mes.ConceptId = 0;
                        }

                        SetTypeId(mes, visitOccurrences);
                        ChunkData.AddData(mes);
                        //AddCost(mes.Id, entity, CostV5ToV51("Measurement", mes.TypeConceptId));
                        break;

                    case "Meas Value":
                        var mv = entity as Measurement ??
                                 new Measurement(entity)
                                 {
                                     Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                                 };
                                                
                        SetTypeId(mv, visitOccurrences);
                        ChunkData.AddData(mv);
                        break;

                    case "Observation":
                        var obser = entity as Observation ??
                                    new Observation(entity)
                                    {
                                        Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                                    };
                        
                        if ((!obser.ValueAsConceptId.HasValue || obser.ValueAsConceptId == 0) && !string.IsNullOrEmpty(obser.ValueAsString))
                        {
                            var result = Vocabulary.Lookup(obser.ValueAsString, "ValueAsConcept", DateTime.MinValue);

                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId.Value > 0)
                                obser.ValueAsConceptId = result[0].ConceptId.Value;
                        }
                        SetTypeId(obser, visitOccurrences);
                        ChunkData.AddData(obser);
                        break;

                    case "Procedure":
                        var p = entity as ProcedureOccurrence ??
                                new ProcedureOccurrence(entity)
                                {
                                    Id =
                                        Offset.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
                                };

                        if (p.Quantity.HasValue && p.Quantity <= 0)
                            p.Quantity = 1;

                        if (p.ConceptId > 0 || !string.IsNullOrEmpty(p.SourceValue))
                        {
                            SetTypeId(p, visitOccurrences);

                            if (!string.IsNullOrEmpty(p.SourceValue))
                                ChunkData.AddData(p);
                        }
                        break;

                    case "Device":
                        var dev = entity as DeviceExposure ??
                                  new DeviceExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId
                                  };

                        if (dev.Quantity.HasValue && dev.Quantity <= 0)
                            dev.Quantity = 1;

                        SetTypeId(dev, visitOccurrences);
                        ChunkData.AddData(dev);                        
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DrugExposureId
                                  };

                        if (!drg.EndDate.HasValue)
                        {
                            drg.EndDate = drg.StartDate;
                        }

                        if (drg.StartDate > drg.EndDate.Value)
                            drg.EndDate = drg.StartDate;

                        SetTypeId(drg, visitOccurrences);
                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;
                }
            }
        }

        private static void SetTypeId(IEntity entity, Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            if (entity.TypeConceptId < 2000 && entity.VisitOccurrenceId.HasValue && visitOccurrences.ContainsKey(entity.VisitOccurrenceId.Value))
            {
                entity.TypeConceptId = visitOccurrences[entity.VisitOccurrenceId.Value].TypeConceptId;
            }
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
         Dictionary<long, VisitOccurrence> visitOccurrences,
         ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(measurements, visitOccurrences, observationPeriods, false);
        }

        public override IEnumerable<DeviceExposure> BuildDeviceExposure(DeviceExposure[] devExposure,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(devExposure, visitOccurrences, observationPeriods, false);
        }

        private static Death CleanUpDeath(IEnumerable<IEntity> items, Death death)
        {
            if (death == null) return null;

            return items.Any(item => item.StartDate > death.StartDate.AddDays(30)) ? null : death;
        }

        /// <summary>
        /// 	Projects Enumeration of drug exposure from the raw set of drug exposure & procedure occurrence entities. 
        /// 	During build:
        ///	overide TypeConceptId per CDM Mapping spec. 
        /// </summary>
        /// <param name="drugExposure">raw set of drug exposures entities</param>
        /// <param name="procedureOccurrence">set of procedure occurrence entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of drug exposure entities</returns>
        private IEnumerable<DrugExposure> BuildDrugExposure(IEnumerable<DrugExposure> drugExposure,
            IEnumerable<ProcedureOccurrence> procedureOccurrence, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var drugs = new Dictionary<Guid, List<DrugExposure>>();
            var drugClaims = new Dictionary<Guid, List<DrugExposure>>();

            foreach (var de in drugExposure)
            {
                if (de.TypeConceptId == 32857 || de.TypeConceptId == 32869)
                {
                    if (!drugClaims.ContainsKey(de.SourceRecordGuid))
                        drugClaims.Add(de.SourceRecordGuid, []);

                    drugClaims[de.SourceRecordGuid].Add(de);
                    continue;
                }

                if (!drugs.ContainsKey(de.SourceRecordGuid))
                    drugs.Add(de.SourceRecordGuid, []);

                drugs[de.SourceRecordGuid].Add(de);
            }

            // Create drug exposure entities from procedure occurrence
            foreach (var po in procedureOccurrence)
            {
                if (!drugs.ContainsKey(po.SourceRecordGuid)) continue;

                var de = drugs[po.SourceRecordGuid].FirstOrDefault(d => d.SourceValue == po.SourceValue);
                if (de == null) continue;
                if (de.ConceptId > 0)
                {
                    de.StartDate = po.StartDate;
                    de.EndDate = null;
                    de.ProviderKey = po.ProviderKey;
                    de.VisitOccurrenceId = po.VisitOccurrenceId;
                    de.Refills = null;

                    yield return de;
                }
            }

            // Remove duplicate drug claim records as well as eliminate drug claims that have been administratively backed 
            // out with negative values and apply base logic for drug claims records
            foreach (var de in BuildDrugExposures(FilteroutDrugClaims(drugClaims).ToArray(), visitOccurrences,
                observationPeriods))
            {
                yield return de;
            }
        }


        /// <summary>
        /// Remove duplicate drug claim records as well as eliminate drug claims that have been administratively backed out with negative values
        /// </summary>
        /// <param name="drugClaims">set of drug exposure entities</param>
        /// <returns>Enumeration of filtired drug exposure entities</returns>
        private static IEnumerable<DrugExposure> FilteroutDrugClaims(Dictionary<Guid, List<DrugExposure>> drugClaims)
        {
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

        /// <summary>
        /// Projects Enumeration of Visit Occurrence from the raw set of Visit Occurrence entities. 
        ///  </summary>
        /// <param name="rawVisitOccurrences">raw set of Visit Occurrence entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Visit Occurrence</returns>
        public override IEnumerable<VisitOccurrence> BuildVisitOccurrences(VisitOccurrence[] rawVisitOccurrences,
            ObservationPeriod[] observationPeriods)
        {

            foreach (var vo in PrepareVisitOccurrences(rawVisitOccurrences.Where(vo => vo.ConceptId != 1).ToArray(),
                observationPeriods))
            {
                yield return vo;
            }
        }

        private IEnumerable<VisitOccurrence> PrepareVisitOccurrences(VisitOccurrence[] rawVisitOccurrences,
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

        private static void TruncateDatesToObservationPeriod(IEnumerable<ObservationPeriod> observationPeriods,
            IEntity entity)
        {
            if (!entity.EndDate.HasValue)
                entity.EndDate = entity.StartDate;
            else if (entity.StartDate > entity.EndDate)
                entity.EndDate = entity.StartDate;

            var observationPeriod = observationPeriods.FirstOrDefault(op =>
                op.StartDate.Between(entity.StartDate, entity.EndDate.Value) ||
                op.EndDate.Value.Between(entity.StartDate, entity.EndDate.Value));
            if (observationPeriod == null) return;

            if (entity.StartDate < observationPeriod.StartDate)
                entity.StartDate = observationPeriod.StartDate;

            if (entity.StartDate > observationPeriod.EndDate)
                entity.StartDate = observationPeriod.EndDate.Value;

            if (entity.EndDate > observationPeriod.EndDate)
                entity.EndDate = observationPeriod.EndDate;
        }


        private List<VisitOccurrence> CollapseVisits(List<VisitOccurrence> visits)
        {
            var collapsed = new List<VisitOccurrence>();
            foreach (var claim in visits.OrderBy(vo => vo.StartDate)
                .ThenBy(vo => vo.EndDate))
            {
                if (collapsed.Count > 0)
                {
                    var previousClaim = collapsed.Last();
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
                collapsed.Add(claim);
            }

            return collapsed;
        }

        private void AddRawVisitOccurrence(VisitOccurrence rawVisit, VisitOccurrence finalVisit)
        {
            if (!_rawVisits.TryAdd(rawVisit.SourceRecordGuid, finalVisit))
                _rawVisits[rawVisit.SourceRecordGuid] = finalVisit;
        }

        private void SetVisitDetailId<T>(T e, bool updateDates) where T : class, IEntity
        {
            if (e.AdditionalFields == null || !e.AdditionalFields.ContainsKey("hlthplan"))
                return;

            var hlthplan = e.AdditionalFields["hlthplan"];

            if (_rawVisitDetails.ContainsKey(hlthplan))
            {
                VisitDetail vd = null;

                VisitDetail vdByDate = null;
                VisitDetail vdByDate2 = null;

                if (_rawVisitDetails[hlthplan].ContainsKey(e.SourceRecordGuid))
                {
                    vd = _rawVisitDetails[hlthplan][e.SourceRecordGuid].FirstOrDefault();
                }

                if (vd == null && _rawVisitDetailsByDate[hlthplan].ContainsKey(e.StartDate))
                {
                    vdByDate = _rawVisitDetailsByDate[hlthplan][e.StartDate].FirstOrDefault();

                    if (vdByDate != null)
                    {
                        vdByDate2 = _rawVisitDetailsByDate[hlthplan][e.StartDate].FirstOrDefault(v => e.StartDate.Between(v.StartDate, v.EndDate.Value));
                    }
                }

                if (vd == null)
                {
                    if (vdByDate != null)
                        vd = vdByDate;

                    if (vdByDate2 != null)
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

        private void SetVisitDetailIds<T>(IEnumerable<T> entities, bool updateDates) where T : class, IEntity
        {
            foreach (var e in entities)
            {
                SetVisitDetailId(e, updateDates);
            }
        }

    }
}