using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.HealthVerity
{
    public class HealthVerityPersonBuilder : PersonBuilder
    {
        #region Classes

        public class HealthVerityVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "HealthVerity";
            public override string Folder => "HealthVerity";
            public override string Description => "HealthVerity v5.4";
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
        
        private readonly DateTime _minDate = new(2009, 1, 1);
        private readonly HashSet<string> _races = [];
        private readonly HashSet<long> _racesConceptId = [];

        readonly List<DateTime> _mins = [];
        readonly List<DateTime> _maxs = [];
        #endregion

        #region Constructors

        public HealthVerityPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not HealthVerityVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods
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

            foreach (var item in filtered)
            {
                if(item.AdditionalFields != null)
                {
                    if(item.AdditionalFields.ContainsKey("race") && !string.IsNullOrEmpty(item.AdditionalFields["race"]))
                    {
                        _races.Add(item.AdditionalFields["race"]);
                    }

                    if (item.AdditionalFields.ContainsKey("race_concept_id") && !string.IsNullOrEmpty(item.AdditionalFields["race_concept_id"]))
                    {
                        if (long.TryParse(item.AdditionalFields["race_concept_id"], out long raceConceptId))
                        {
                            if(raceConceptId != 0)
                                _racesConceptId.Add(raceConceptId);
                        }
                    }
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
                        foreach (var byConceptId in byCareSiteId.GroupBy(v => v.ConceptId))
                        {
                            var visit = byConceptId.First();
                            foreach (var vo in byConceptId)
                            {
                                AddRawVisitOccurrence(vo, visit);
                            }
                            yield return visit;
                        }
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
                if (vo.Id == 0 && 
                    _rawVisits.TryGetValue(vo.SourceRecordGuid, out VisitOccurrence value) &&
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
                        AdmittingSourceValue = visitOccurrence.AdmittingSourceValue
                    };

                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;


                yield return visitDetail;
            }
        }

        private void FixStartEndDates(IEnumerable<EraEntity> input)
        {
            foreach (var i in input)
            {
                if (_mins.Count > 0 && i.StartDate.Year < _minDate.Year)
                    i.StartDate = _mins.Min();

                if (i.EndDate.Value.Date > Vendor.SourceReleaseDate)
                    i.EndDate = Vendor.SourceReleaseDate;

                if (i.StartDate.Date > i.EndDate.Value.Date)
                    i.EndDate = Vendor.SourceReleaseDate.Value.Date;

                if (_mins.Count > 0 && i.StartDate.Date > i.EndDate.Value.Date)
                    i.StartDate = _mins.Min();
            }
        }

        private static string GetRace(long raceConceptId)
        {
            switch (raceConceptId)
            {
                case 8527:
                    return "White";
                case 8515:
                    return "Asian";
                case 8516:
                    return "Black";
                default:
                    return null;
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

            if(string.IsNullOrEmpty(person.RaceSourceValue))
            {
                if(_racesConceptId.Count == 1)
                {
                    person.RaceConceptId = _racesConceptId.First();
                    person.RaceSourceValue = GetRace(person.RaceConceptId.Value);
                }
                else if (_racesConceptId.Count > 1)
                {
                    person.RaceSourceValue = "Multiple Races";
                    person.RaceConceptId = 44814659; //(Multiple Races)
                }
            }

            if (person.EthnicityConceptId.HasValue && person.EthnicityConceptId == 0)
            {
                if (_races.Any(r => r.Equals("Hispanic", StringComparison.OrdinalIgnoreCase)))
                {
                    person.EthnicityConceptId = 38003563;
                    person.EthnicitySourceValue = "Hispanic";
                }
            }

            GetMinDate(DrugExposuresRaw, _mins);
            GetMinDate(ConditionOccurrencesRaw, _mins);
            GetMinDate(ProcedureOccurrencesRaw, _mins);
            GetMinDate(ObservationsRaw, _mins);
            GetMinDate(DeviceExposureRaw, _mins);
            GetMinDate(MeasurementsRaw, _mins);
            GetMinDate(VisitOccurrencesRaw, _mins);
            GetMinDate(VisitDetailsRaw, _mins);

            GetMaxDate(DrugExposuresRaw, _maxs);
            GetMaxDate(ConditionOccurrencesRaw, _maxs);
            GetMaxDate(ProcedureOccurrencesRaw, _maxs);
            GetMaxDate(ObservationsRaw, _maxs);
            GetMaxDate(DeviceExposureRaw, _maxs);
            GetMaxDate(MeasurementsRaw, _maxs);
            GetMaxDate(VisitOccurrencesRaw, _maxs);
            GetMaxDate(VisitDetailsRaw, _maxs);

            if (VisitOccurrencesRaw.Count > 1000 * 1000)
            {
                Console.WriteLine("UnacceptablePatientQuality " + person.PersonSourceValue + " " + VisitOccurrencesRaw.Count);
                return Attrition.UnacceptablePatientQuality;
            }

            if(_mins.Count == 0 && _maxs.Count == 0)
            {
                Console.WriteLine("UnacceptablePatientQuality " + person.PersonSourceValue + " " + VisitOccurrencesRaw.Count);
                return Attrition.UnacceptablePatientQuality;
            }

            var observationPeriods = new[] {
                new ObservationPeriod
                {
                    Id = Offset.GetKeyOffset(person.PersonId).ObservationPeriodId,
                    StartDate = _mins.Min(),
                    EndDate = _maxs.Max(),
                    TypeConceptId = 32813,
                    PersonId = person.PersonId
                }
            };

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
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], observationPeriods))
            {
                visitOccurrence.Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;
                visitOccurrence.AdmittingSourceValue = null;
                visitOccurrences.TryAdd(visitOccurrence.Id, visitOccurrence);
            }

            VisitDetail mostRecentVisit = null;
            foreach (var visitDetail in visitDetails)
            {
                if(mostRecentVisit == null)
                    mostRecentVisit = visitDetail;
                else if(mostRecentVisit.StartDate.Date < visitDetail.StartDate.Date)
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
                .ToList();
            foreach (var ob in observations)
            {
                ob.Id = Offset.GetKeyOffset(ob.PersonId).ObservationId;
            }
                        
            if(_racesConceptId.Count > 1)
            {
                foreach (var conceptId in _racesConceptId)
                {
                    var oRace = new Observation(person)
                    {
                        Id = Offset.GetKeyOffset(person.PersonId).ObservationId,
                        ConceptId = 4013886, // (Race)
                        SourceValue = "Multiple Races",
                        ValueAsConceptId = conceptId,
                        ValueAsString = GetRace(conceptId),
                        TypeConceptId = 32810
                    };

                    if (mostRecentVisit != null)
                    {
                        oRace.StartDate = mostRecentVisit.StartDate;
                    }
                    else if (observationPeriods.Length > 0)
                    {
                        oRace.StartDate = observationPeriods.Max(op => op.EndDate.Value.Date);
                    }
                    else
                    {
                        oRace.StartDate = Vendor.SourceReleaseDate.Value;
                    }

                    // oRace.ValueSourceValue = GetRace(conceptId); // ??
                    observations.Add(oRace);
                }
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

            FixStartEndDates(PayerPlanPeriodsRaw);
            var payerPlanPeriods = BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], visitOccurrences).ToArray();

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);
            death = UpdateDeath(death, person, observationPeriods);

            // Remove any death dates where the associated observation_period_end_date >= 365 days after the death.
            if (death != null)
            {
                if (observationPeriods.Max(op => op.EndDate.Value.Date) >= death.StartDate.Date.AddDays(365))
                    death = null;
            }

            var visits = FilterByDeathDate(visitOccurrences.Values, death, 60).ToArray();
            SetPrecedingVisitOccurrenceId(visits);

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death,
                observationPeriods,
                payerPlanPeriods,
                [.. UpdateRSourceConcept(FilterByDeathDate(drugExposures, death, 60))],
                [.. UpdateRSourceConcept(FilterByDeathDate(conditionOccurrences, death, 60))],
                [.. UpdateRSourceConcept(FilterByDeathDate(procedureOccurrences, death, 60))],
                [.. UpdateRSourceConcept(FilterByDeathDate(observations, death, 60))],
                [.. UpdateRSourceConcept(FilterByDeathDate(measurements, death, 60))],
                visits,
                FilterByDeathDate(visitDetails, death, 60).ToArray(), 
                [],
                [.. UpdateRSourceConcept(FilterByDeathDate(deviceExposure, death, 60))], 
                [], 
                []);

            Complete = true;

            var pg = new PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, observationPeriods,
                [.. ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId)],
                [.. ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId)],
                [.. ChunkData.Observations.Where(e => e.PersonId == person.PersonId)],
                [.. ChunkData.Measurements.Where(e => e.PersonId == person.PersonId)],
                [.. ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId)]))
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

        public override void AddToChunk(string domain, IEnumerable<IEntity> entities)
        {
            foreach (var entity in entities)
            {
                var entityDomain = GetDomain(domain, entity.Domain, "Observation");

                switch (entityDomain)
                {
                    case "Condition":
                        var cond = entity as ConditionOccurrence ??
                                   new ConditionOccurrence(entity)
                                   {
                                       Id = Offset.GetKeyOffset(entity.PersonId)
                                           .ConditionOccurrenceId
                                   };
                        ConditionForEra.Add(cond);
                        ChunkData.AddData(cond);
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

        #endregion
    }
}