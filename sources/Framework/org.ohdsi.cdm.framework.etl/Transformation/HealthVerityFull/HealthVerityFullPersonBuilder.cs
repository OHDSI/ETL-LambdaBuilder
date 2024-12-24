using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.HealthVerityFull
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

    public class HealthVerityFullPersonBuilder : PersonBuilder
    {
        #region Classes

        public class HealthVerityFullVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "HealthVerityFull";
            public override string Folder => "HealthVerityFull";
            public override string Description => "HealthVerityFull v5.4";
            public override string CdmSource => "CdmSource.sql";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "enrollment";
            public override string Citation => "";
            public override string Publication => "No review required";
        }

        #endregion

        #region Fields

        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = [];
        private readonly Dictionary<long, List<VisitDetail>> _visitDetails = [];
        private readonly Dictionary<string, List<VisitDetail>> _visitDetailsByHvEncId = [];
        private readonly Dictionary<string, HashSet<DateTime>> _minsMaxs = [];
        private readonly DateTime _minDate = new(2009, 1, 1);

        List<DateTime> _mins = [];
        //List<DateTime> _maxs = [];

        //private int _personYoB;
        #endregion

        #region Constructors

        public HealthVerityFullPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not HealthVerityFullVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods


        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            /*if (records.All(p => p.GenderConceptId == 8551))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }*/

            if (records.All(p => p.YearOfBirth < 1900))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);
            }

            if (records.All(p => p.YearOfBirth > Vendor.SourceReleaseDate.Value.Date.Year))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBFuture);
            }

            var filtered = records.Where(p =>
                //p.GenderConceptId != 8551 &&
                p.YearOfBirth >= 1900 &&
                p.YearOfBirth <= Vendor.SourceReleaseDate.Value.Date.Year).ToArray();

            if (filtered.Length == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            //var ordered = filtered.OrderByDescending(p => p.GenderConceptId).ToArray();
            var person = filtered.FirstOrDefault(p => p.GenderConceptId != 8551) ?? filtered.First();
            //person.StartDate = ordered.Take(1).Last().StartDate;

            /*if (person.GenderConceptId == 8551)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }*/

            if (records.Any(r => r.GenderConceptId != 8551 && r.GenderConceptId != person.GenderConceptId))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges); // Gender changed over different enrollment period 
            }

            if (person.YearOfBirth < 1900)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            if (person.YearOfBirth > Vendor.SourceReleaseDate.Value.Date.Year)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBFuture);

            if (records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Max(r => r.YearOfBirth) -
                records.Where(r => r.YearOfBirth.HasValue && r.YearOfBirth > 1900).Min(r => r.YearOfBirth) > 2)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.MultipleYearsOfBirth);
            }

            var raceValues = filtered
                .Where(item => item.AdditionalFields.ContainsKey("race") && !string.IsNullOrEmpty(item.AdditionalFields["race"]))
                .Select(item => item.AdditionalFields["race"])
                .Distinct()
                .ToList();

            if (person.RaceSourceValue == null)
            {
                if (raceValues.Count == 1)
                {
                    person.RaceSourceValue = raceValues.First();
                }
                else if (raceValues.Count > 1)
                {
                    person.RaceSourceValue = "Multiple Races";
                }
            }
            person.RaceConceptId = GetRaceConceptId(person.RaceSourceValue);

            if (person.EthnicitySourceValue == null)
            {
                /*if (raceValues.Count == 1)
                {
                    person.EthnicitySourceValue = raceValues.First();
                }
                else */
                if (raceValues.Contains("Hispanic"))
                {
                    person.EthnicitySourceValue = "Hispanic";
                }
            }
            person.EthnicityConceptId = GetEthnicityConceptId(person.EthnicitySourceValue);

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
                        foreach (var byConceptId in byCareSiteId.GroupBy(v => v.ConceptId))
                        {
                            var visit = byConceptId.First();
                            foreach (var vo in byConceptId)
                            {
                                AddRawVisitOccurrence(vo, visit);
                            }
                            yield return visit;
                        }

                        //var visit = byCareSiteId.OrderBy(v => v.ConceptId).First();
                        //foreach (var vo in byCareSiteId)
                        //{
                        //    AddRawVisitOccurrence(vo, visit);
                        //}

                        //yield return visit;
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
                        Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitDetailId,
                        AdmittingSourceValue = visitOccurrence.AdmittingSourceValue,
                        AdmittingSourceConceptId = visitOccurrence.AdmittingSourceConceptId,
                        DischargeToSourceValue = visitOccurrence.DischargeToSourceValue,
                        DischargeToConceptId = visitOccurrence.DischargeToConceptId,
                        ProviderId = visitOccurrence.ProviderId,
                        CareSiteId = visitOccurrence.CareSiteId
                    };

                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;

                yield return visitDetail;
            }
        }

        public override IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
        {
            if (observationPeriods.Length > 0)
            {
                if (observationPeriods.Any(op => op.StartDate != DateTime.MinValue && (op.EndDate.HasValue && op.EndDate.Value != DateTime.MinValue)))
                {
                    var minStartDate = observationPeriods.Where(op => op.StartDate != DateTime.MinValue).Min(op => op.StartDate);
                    var maxEndDate = observationPeriods.Where(op => op.EndDate.HasValue && op.EndDate.Value != DateTime.MinValue).Max(op => op.EndDate.Value);

                    yield return new ObservationPeriod
                    {
                        StartDate = minStartDate,
                        EndDate = maxEndDate,
                        TypeConceptId = 32815,
                        PersonId = observationPeriods[0].PersonId
                    };
                }
            }
        }

        /*public override IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
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
                                TypeConceptId = 32813,
                                PersonId = observationPeriods[0].PersonId
                            };
                        }
                    }
                }
            }
        }*/

        /*private void FixObservationPeriodDates(IEnumerable<EraEntity> observationPeriods, Table table)
        {
            foreach (var op in observationPeriods)
            {
                if (op.StartDate.Year < _minDate.Year)
                    op.StartDate = _mins.Min();

                if (op.EndDate.Value.Date > Vendor.SourceReleaseDate)
                    op.EndDate = Vendor.SourceReleaseDate;

                if(op.StartDate.Date > op.EndDate.Value.Date)
                    op.EndDate = Vendor.SourceReleaseDate.Value.Date;

                if (op.StartDate.Date > op.EndDate.Value.Date)
                    op.StartDate = _mins.Min();
            }
            //foreach (var g in observationPeriods.GroupBy(m => m.AdditionalFields["data_vendor"]))
            //{
            //    DataVendor? vendor = null;

            //    if (g.First().AdditionalFields["data_vendor"].StartsWith("private source 17", StringComparison.CurrentCultureIgnoreCase))
            //        vendor = DataVendor.PrivateSource17;
            //    else if (g.First().AdditionalFields["data_vendor"].StartsWith("private source 20", StringComparison.CurrentCultureIgnoreCase))
            //        vendor = DataVendor.PrivateSource20;
            //    else
            //        continue;

            //    foreach (var item in g.ToArray())
            //    {
            //        if (item.StartDate.Year < _minDate.Year ||
            //            item.StartDate.Date > Vendor.SourceReleaseDate.Value.Date)
            //        {
            //            //item.StartDate = min.Value;
            //            var key = GetDateKey(table, vendor.Value, AggregationType.Min);
            //            if (_minsMaxs.ContainsKey(key))
            //                item.StartDate = _minsMaxs[key].Min();
            //            else
            //            {
            //                if (_minDate > new DateTime(_personYoB, 1, 1))
            //                    item.StartDate = _minDate;
            //                else
            //                    item.StartDate = new DateTime(_personYoB, 1, 1);
            //            }
            //        }

            //        if (item.EndDate.Value.Date > Vendor.SourceReleaseDate.Value.Date)
            //        {
            //            var key = GetDateKey(table, vendor.Value, AggregationType.Max);
            //            if (_minsMaxs.ContainsKey(key))
            //            {
            //                item.EndDate = _minsMaxs[key].Max();

            //                if(item.StartDate.Date > item.EndDate.Value.Date)
            //                    item.EndDate = Vendor.SourceReleaseDate.Value.Date;
            //            }
            //            else
            //                item.EndDate = Vendor.SourceReleaseDate.Value.Date;
            //        }
            //    }
            //}
        }*/

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

            //_personYoB = person.YearOfBirth.Value;

            if (VisitOccurrencesRaw.Count > 1000 * 1000)
            {
                Console.WriteLine("UnacceptablePatientQuality " + person.PersonSourceValue + " " + VisitOccurrencesRaw.Count);
                return Attrition.UnacceptablePatientQuality;
            }

            // Build and clean death
            var death = BuildDeath([.. DeathRecords], [], []);
            if (death != null)
            {
                if (person.YearOfBirth.HasValue && person.YearOfBirth.Value > 0 && person.YearOfBirth > death.StartDate.Year)
                    death = null;
                if (death.StartDate.Date > Vendor.SourceReleaseDate.Value.Date)
                    death = null;
            }

            /*foreach (var op in observationPeriods)
            {
                op.Id = Offset.GetKeyOffset(op.PersonId).ObservationPeriodId;

                if (op.EndDate.Value.Date > Vendor.SourceReleaseDate.Value.Date)
                    op.EndDate = Vendor.SourceReleaseDate.Value;
            }*/

            VisitOccurrencesRaw = FilterAndUpdateRecords(VisitOccurrencesRaw, death, 60).ToList();

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

            var visitDetails = BuildVisitDetails(null, [.. VisitOccurrencesRaw], []).ToArray();

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], []))
            {
                visitOccurrence.Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;
                visitOccurrence.AdmittingSourceValue = null;
                visitOccurrence.AdmittingSourceConceptId = null;
                visitOccurrence.DischargeToSourceValue = null;
                visitOccurrence.DischargeToConceptId = null;

                if (visitOccurrences.TryAdd(visitOccurrence.Id, visitOccurrence))
                {
                    visitIds.Add(visitOccurrence.Id);
                }
            }
            VisitDetail mostRecentVisit = null;
            foreach (var visitDetail in visitDetails)
            {
                if (mostRecentVisit == null)
                    mostRecentVisit = visitDetail;
                else if (mostRecentVisit.StartDate.Date < visitDetail.StartDate.Date)
                    mostRecentVisit = visitDetail;

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
                FilterAndUpdateRecords(BuildConditionOccurrences([.. ConditionOccurrencesRaw], visitOccurrences, []), death, 60)
                    .ToArray();
            foreach (var co in conditionOccurrences)
            {
                co.Id = Offset.GetKeyOffset(co.PersonId).ConditionOccurrenceId;
            }

            var procedureOccurrences =
                FilterAndUpdateRecords(BuildProcedureOccurrences([.. ProcedureOccurrencesRaw], visitOccurrences, []), death, 60)
                    .ToArray();
            foreach (var procedureOccurrence in procedureOccurrences)
            {
                procedureOccurrence.Id =
                    Offset.GetKeyOffset(procedureOccurrence.PersonId).ProcedureOccurrenceId;
            }

            var observations = FilterAndUpdateRecords(BuildObservations([.. ObservationsRaw], visitOccurrences, []), death, 60)
                .ToArray();
            foreach (var ob in observations)
            {
                ob.Id = Offset.GetKeyOffset(ob.PersonId).ObservationId;
            }

            var drugExposures =
                FilterAndUpdateRecords(BuildDrugExposures([.. DrugExposuresRaw], visitOccurrences, []), death, 60)
                    .ToArray();

            foreach (var de in drugExposures)
            {
                if (death != null && de.EndDate > death.StartDate.Date.AddDays(60))
                {
                    de.EndDate = death.StartDate.Date.AddDays(60);
                }
                else if (de.EndDate > Vendor.SourceReleaseDate.Value.Date)
                {
                    de.EndDate = Vendor.SourceReleaseDate.Value.Date;
                }
            }

            /*if (observationPeriods.Length > 0)
            {
                var maxEndDate = observationPeriods.Max(op => op.EndDate.Value);
                foreach (var de in drugExposures)
                {
                    if (de.EndDate > DateTime.Now)
                    {
                        de.EndDate = maxEndDate;
                    }
                }
            }*/

            var measurements = FilterAndUpdateRecords(BuildMeasurement([.. MeasurementsRaw], visitOccurrences, []), death, 60)
                .ToArray();

            var deviceExposure = FilterAndUpdateRecords(BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, []), death, 60)
                .ToArray();


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

            var observationPeriodRawNew = BuildObservationPeriodRawNew(
                death, drugExposures, conditionOccurrences, procedureOccurrences, observations,
                measurements, [.. visitOccurrences.Values], visitDetails, deviceExposure);

            var observationPeriods =
                   BuildObservationPeriods(person.ObservationPeriodGap, [.. observationPeriodRawNew])
                       .ToArray();

            if (Excluded(person, observationPeriods))
            {
                Complete = true;
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var payerPlanPeriods = BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], null).ToArray();

            if (observationPeriods.Length == 0 && payerPlanPeriods.Length == 0)
            {
                return Attrition.InvalidObservationTime;
            } 

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death,
                observationPeriods,
                payerPlanPeriods,
                UpdateRSourceConcept(drugExposures).ToArray(),
                UpdateRSourceConcept(conditionOccurrences).ToArray(),
                UpdateRSourceConcept(procedureOccurrences).ToArray(),
                UpdateRSourceConcept(observations).ToArray(),
                UpdateRSourceConcept(measurements).ToArray(),
                [.. visitOccurrences.Values], 
                visitDetails, 
                [],
                UpdateRSourceConcept(deviceExposure).ToArray(), 
                [], 
                []);

            Complete = true;

            var pg = new PregnancyAlgorithm();
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
                if (de.AdditionalFields != null && de.AdditionalFields.ContainsKey("medctn_days_supply_cnt"))
                {
                    int? daysSupply = 1;
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

                    de.EndDate = de.StartDate.AddDays(daysSupply.Value - 1);
                    de.DaysSupply = daysSupply;
                }

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

        protected static void GetMinDate<T>(IEnumerable<T> inputRecords, List<DateTime> result) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;
            
            var dates = inputRecords.Where(e => e.StartDate != DateTime.MinValue);
            if (dates != null && dates.Any())
                result.Add(dates.Min(e => e.StartDate));
        }

        protected static void GetMaxDate<T>(IEnumerable<T> inputRecords, List<DateTime> result) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;

            var dates = new HashSet<DateTime>();
            foreach (var i in inputRecords)
            {
                if (i.StartDate != DateTime.MinValue)
                    dates.Add(i.StartDate);
            }

            if (dates != null && dates.Count != 0)
                result.Add(dates.Max());
        }

        private void SetUnitConceptId(IEntity e)
        {
            if (e.GeEntityType() != common.Enums.EntityType.Measurement ||
                e.GeEntityType() != common.Enums.EntityType.Observation)
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

                    if (e.GeEntityType() == common.Enums.EntityType.Measurement)
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
                var entityDomain = GetDomain(domain, entity.Domain, null);

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
        public List<EraEntity> BuildObservationPeriodRawNew(Death death, DrugExposure[] drugExposures,
            ConditionOccurrence[] conditionOccurrences,
            ProcedureOccurrence[] procedureOccurrences, Observation[] observations,
            Measurement[] measurements, VisitOccurrence[] visitOccurrences, VisitDetail[] visitDetails,
            DeviceExposure[] deviceExposure)
        {
            var observationPeriodRawNew = new List<EraEntity>();

            void AddObservationPeriod(List<IEntity> entities)
            {
                if (entities == null || entities.Count == 0) return;

                var minStartDate = entities.Min(e => e.StartDate);
                var maxEndDate = entities.Max(e => e.GetEndDate() != DateTime.MinValue ? e.GetEndDate() : e.StartDate);

                observationPeriodRawNew.Add(new EraEntity
                {
                    StartDate = minStartDate,
                    EndDate = maxEndDate,
                    TypeConceptId = 32815,
                    PersonId = entities[0].PersonId
                });
            }

            AddObservationPeriod(drugExposures.Cast<IEntity>().ToList());
            AddObservationPeriod(conditionOccurrences.Cast<IEntity>().ToList());
            AddObservationPeriod(procedureOccurrences.Cast<IEntity>().ToList());
            AddObservationPeriod(observations.Cast<IEntity>().ToList());
            AddObservationPeriod(measurements.Cast<IEntity>().ToList());
            AddObservationPeriod(visitOccurrences.Cast<IEntity>().ToList());
            AddObservationPeriod(visitDetails.Cast<IEntity>().ToList());
            if (death != null)
            {
                AddObservationPeriod(new List<IEntity> { death });
            }             

            return observationPeriodRawNew;
        }
        private long GetRaceConceptId(string raceSourceValue)
        {
            return raceSourceValue switch
            {
                "White" => 8527,
                "Black" => 8516,
                "Asian" => 8515,
                _ => 0
            };
        }
        private long GetEthnicityConceptId(string ethnicitySourceValue)
        {
            return ethnicitySourceValue switch
            {
                "Hispanic" => 38003563,
                "Non-Hispanic" => 38003564,
                _ => 0
            };
        }
        private IEnumerable<T> FilterAndUpdateRecords<T>(IEnumerable<T> items, Death death, int gap) where T : IEntity
        {
            var filteredItems = new List<T>();

            foreach (var item in items)
            {
                if (item.StartDate > Vendor.SourceReleaseDate.Value.Date ||
                    (item.EndDate.HasValue && item.EndDate.Value > Vendor.SourceReleaseDate.Value.Date))
                {
                    continue;
                }

                if (death != null &&
                    (item.StartDate > death.StartDate.Date.AddDays(gap) ||
                    (item.EndDate.HasValue && item.EndDate.Value > death.StartDate.Date.AddDays(gap))))
                {
                    continue;
                }

                if (item.EndDate.HasValue && item.EndDate.Value < item.StartDate)
                {
                    item.EndDate = item.StartDate;
                }

                filteredItems.Add(item);
            }

            return filteredItems;
        }
        public int? GetLocationId(string patientState, string patientZip3)
        {
            if (string.IsNullOrEmpty(patientState) && string.IsNullOrEmpty(patientZip3))
            {
                return null;
            }

            int stateCode = string.IsNullOrEmpty(patientState) ? 0 : patientState switch
            {
                "AK" => 1,
                "AL" => 2,
                "AR" => 3,
                "AZ" => 4,
                "CA" => 5,
                "CO" => 6,
                "CT" => 7,
                "DC" => 8,
                "DE" => 9,
                "FL" => 10,
                "GA" => 11,
                "HI" => 12,
                "IA" => 13,
                "ID" => 14,
                "IL" => 15,
                "IN" => 16,
                "KS" => 17,
                "KY" => 18,
                "LA" => 19,
                "MA" => 20,
                "MD" => 21,
                "ME" => 22,
                "MI" => 23,
                "MN" => 24,
                "MO" => 25,
                "MS" => 26,
                "MT" => 27,
                "NC" => 28,
                "ND" => 29,
                "NE" => 30,
                "NH" => 31,
                "NJ" => 32,
                "NM" => 33,
                "NV" => 34,
                "NY" => 35,
                "OH" => 36,
                "OK" => 37,
                "OR" => 38,
                "PA" => 39,
                "PR" => 40,
                "RI" => 41,
                "SC" => 42,
                "SD" => 43,
                "TN" => 44,
                "TX" => 45,
                "UT" => 46,
                "VA" => 47,
                "VT" => 48,
                "WA" => 49,
                "WI" => 50,
                "WV" => 51,
                "WY" => 52,
                _ => 0
            };

            int zipCode = string.IsNullOrEmpty(patientZip3) ? 0 : patientZip3.Length switch
            {
                1 => (int)patientZip3[0],
                2 => (int)patientZip3[0] * 100 + (int)patientZip3[1],
                _ => (int)patientZip3[0] * 10000 + (int)patientZip3[1] * 100 + (int)patientZip3[2]
            };

            return stateCode * 1000000 + zipCode;
        }

        #endregion
    }


}