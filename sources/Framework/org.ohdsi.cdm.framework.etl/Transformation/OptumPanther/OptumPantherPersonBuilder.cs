using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.OptumPanther
{
    /// <summary>
    ///  Implementation of PersonBuilder for Optum, based on CDM Build spec
    /// </summary>
    public class OptumPantherPersonBuilder : PersonBuilder
    {
        #region Classes

        public class OptumPantherVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "OptumPanther";
            public override string Folder => "OptumPanther";
            public override string Description => "Optum Panther v5.4";
            public override string CdmSource => "";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 1;
            public override string PersonTableName => "patient";
            public override string Citation => "";
            public override string Publication => "Any manuscripts submitted for review must be reviewed by Optum prior to publication. Please send to Kuklinski, Alyce M <alyce.kuklinski@optum.com> and Bree Tremain <bree.tremain@optum.com> allowing for a five day turn-around. ";
        }

        #endregion

        #region Fields

        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = [];
        private readonly Dictionary<string, long> _visitIds = [];
        private readonly Dictionary<string, long> _visitDetailIds = [];
        private readonly Dictionary<string, VisitDetail> _visitDetailsByEncid = [];

        private readonly Dictionary<string, ConditionOccurrence> _oncConditions = [];
        private Person _person;

        private readonly DateTime _minDate = new(2007, 1, 1);
        #endregion

        #region Constructors

        public OptumPantherPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not OptumPantherVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ThenBy(p => p.EndDate);
            var person = ordered.Last();

            person.LocationId = Entity.GetId(person.LocationSourceValue);

            if (person.GenderConceptId == 8551) //UNKNOWN
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (!person.YearOfBirth.HasValue)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownYearOfBirth);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        private IEnumerable<DrugExposure> PrepareDrugExposures(IEnumerable<DrugExposure> drugExposures)
        {
            var ndcDrugs = new Dictionary<Guid, List<DrugExposure>>();
            var vaxDrugs = new List<DrugExposure>();
            foreach (var de in drugExposures)
            {
                if (!de.DaysSupply.HasValue || de.DaysSupply.Value == 0)
                {
                    var result = Vocabulary.Lookup(de.ConceptId.ToString(), "DaysSupply",
                    DateTime.MinValue);

                    var daysSupply = result.Count != 0 ? result[0].ConceptId ?? 1 : 1;
                    de.DaysSupply = Convert.ToInt32(daysSupply);

                    if (de.DaysSupply > 0 && de.DaysSupply <= 365)
                        de.EndDate = de.StartDate.AddDays(de.DaysSupply.Value - 1);
                }

                if (de.AdditionalFields != null && de.AdditionalFields.ContainsKey("itndc"))
                {
                    if (!ndcDrugs.ContainsKey(de.SourceRecordGuid))
                        ndcDrugs.Add(de.SourceRecordGuid, []);

                    if (!de.AdditionalFields.ContainsKey("orig_source"))
                        de.AdditionalFields.Add("orig_source", de.SourceValue);
                    ndcDrugs[de.SourceRecordGuid].Add(de);
                    continue;
                }

                if (de.AdditionalFields != null && de.AdditionalFields.ContainsKey("vax"))
                {
                    //de.TypeConceptId = 32818;
                    if (!de.AdditionalFields.ContainsKey("orig_source"))
                        de.AdditionalFields.Add("orig_source", de.SourceValue.Replace(de.ConceptIdKey, "").TrimEnd('-'));
                    vaxDrugs.Add(de);
                    continue;
                }

                yield return de;
            }

            foreach (var de in vaxDrugs)
            {
                if (!ndcDrugs.ContainsKey(de.SourceRecordGuid))
                    ndcDrugs.Add(de.SourceRecordGuid, []);

                ndcDrugs[de.SourceRecordGuid].Add(de);
            }

            foreach (var similarDrugs in ndcDrugs.SelectMany(drugs => drugs.Value.GroupBy(d => d.AdditionalFields["orig_source"])))
            {
                var drugs = similarDrugs.Where(d => d.ConceptId > 0).ToArray();
                if (drugs.Length > 0)
                {
                    yield return drugs.OrderByDescending(d => d.ConceptIdKey.Length).First();
                    continue;
                }

                var drugs1 = similarDrugs.Where(d => d.SourceConceptId > 0)
                    .ToArray();
                if (drugs1.Length > 0)
                {
                    yield return drugs1.OrderByDescending(d => d.ConceptIdKey.Length)
                        .First();
                    continue;
                }

                yield return similarDrugs.OrderByDescending(d => d.ConceptIdKey.Length).First();
            }
        }

        public static void UpdateVisitOccurrenceId(IEntity entity,
            Dictionary<long, VisitOccurrence> visitOccurrences, Dictionary<long, VisitDetail> visitDetails)
        {
            if (entity.VisitOccurrenceId.HasValue && visitDetails.ContainsKey(entity.VisitOccurrenceId.Value))
            {
                entity.VisitDetailId = entity.VisitOccurrenceId;
            }

            if (entity.VisitOccurrenceId.HasValue && !visitOccurrences.ContainsKey(entity.VisitOccurrenceId.Value) &&
                visitDetails.ContainsKey(entity.VisitOccurrenceId.Value) &&
                visitDetails[entity.VisitOccurrenceId.Value].VisitOccurrenceId.HasValue &&
                visitDetails[entity.VisitOccurrenceId.Value].VisitOccurrenceId.Value > 0)
            {
                entity.VisitOccurrenceId = visitDetails[entity.VisitOccurrenceId.Value].VisitOccurrenceId;
            }
        }


        public override IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)

        {
            foreach (var drugExposure in base.BuildDrugExposures(PrepareDrugExposures(drugExposures).ToArray(), visitOccurrences, observationPeriods))
            {
                if (drugExposure.StartDate.Date < _minDate.Date)
                    continue;

                if (drugExposure.StartDate.Year < _person.YearOfBirth)
                    continue;

                if (drugExposure.DaysSupply.HasValue && drugExposure.DaysSupply >= 365)
                    continue;

                if (!drugExposure.Quantity.HasValue && drugExposure.AdditionalFields != null)
                {
                    int? quantity = null;
                    if (drugExposure.AdditionalFields.ContainsKey("quantity_per_fill") &&
                        !string.IsNullOrEmpty(drugExposure.AdditionalFields["quantity_per_fill"]))
                    {
                        var q = drugExposure.AdditionalFields["quantity_per_fill"].Split(' ')[0];
                        if (int.TryParse(q, out var qValue))
                        {
                            quantity = qValue;
                        }
                    }

                    if (quantity == null && drugExposure.AdditionalFields.ContainsKey("quantity_of_dose") &&
                        !string.IsNullOrEmpty(drugExposure.AdditionalFields["quantity_of_dose"]))
                    {
                        var q = drugExposure.AdditionalFields["quantity_of_dose"].Split(' ')[0];
                        if (int.TryParse(q, out var qValue))
                        {
                            quantity = qValue;
                        }
                    }

                    drugExposure.Quantity = quantity;

                }

                yield return drugExposure;
            }
        }

        public override Death BuildDeath(Death[] death, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var d in death)
            {
                d.StartDate = d.StartDate.AddMonths(1).AddDays(-1);
            }

            return base.BuildDeath(death, visitOccurrences, observationPeriods);
        }

        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var item in base.BuildProcedureOccurrences(procedureOccurrences, visitOccurrences, observationPeriods))
            {
                if (item.StartDate.Date < _minDate.Date)
                    continue;

                //if (item.StartDate.Year + 1 <= _person.YearOfBirth)
                //    continue;

                if (item.StartDate.Year < _person.YearOfBirth)
                    continue;

                yield return item;
            }
        }

        public override IEnumerable<Note> BuildNote(Note[] notes, Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var item in base.BuildNote(notes, visitOccurrences, observationPeriods))
            {
                if (item.StartDate.Date < _minDate.Date)
                    continue;

                //if (item.StartDate.Year + 1 <= _person.YearOfBirth)
                //    continue;

                if (item.StartDate.Year < _person.YearOfBirth)
                    continue;

                yield return item;
            }
        }

        public override IEnumerable<Episode> BuildEpisode(Episode[] episodes, Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            //foreach (var groupByType in episodes.GroupBy(e => e.AdditionalFields["cancer_type"]))
            {
                //foreach (var groupBySourceValue in groupByType.GroupBy(t => t.SourceValue))
                foreach (var groupBySourceValue in episodes.GroupBy(t => t.SourceValue))
                {
                    //foreach (var groupByEpisodeNumber in groupBySourceValue.GroupBy(s => s.EpisodeNumber))
                    {
                        var filterd = groupBySourceValue.Where(e =>
                        e.StartDate.Date >= _minDate.Date &&
                        e.StartDate.Year + 1 > _person.YearOfBirth &&
                        (!e.VisitOccurrenceId.HasValue || visitOccurrences.ContainsKey(e.VisitOccurrenceId.Value)));

                        if (filterd.Any())
                        {
                            var episodeNumber = 1;
                            foreach (var era in EraHelper.GetEras(filterd, 1, 0))
                            {
                                var episode = filterd.First();

                                yield return new Episode(episode)
                                {
                                    Id = Offset.GetKeyOffset(episode.PersonId).EpisodeId,
                                    EpisodeNumber = episodeNumber,
                                    EpisodeParentId = episode.EpisodeParentId,
                                    EpisodeObjectConceptId = episode.EpisodeObjectConceptId,
                                    StartDate = era.StartDate,
                                    EndDate = era.EndDate
                                };

                                episodeNumber++;
                            }
                        }
                    }
                }
            }
        }

        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            Observation idnObservation = null;
            foreach (var observation in base.BuildObservations(observations, visitOccurrences, observationPeriods))
            {
                if (observation.ConceptId == 44804235)
                {
                    // observation.StartDate will be o_p.start_date
                    idnObservation = observation;
                    continue;
                }
                else
                {
                    if (observation.StartDate.Date < _minDate.Date)
                        continue;

                    //if (observation.StartDate.Year + 1 <= _person.YearOfBirth)
                    //    continue;

                    if (observation.StartDate.Year < _person.YearOfBirth)
                        continue;
                }

                if (observation.AdditionalFields != null && observation.AdditionalFields.ContainsKey("neoplasm_histology_key"))
                {
                    ConditionOccurrence conditionOccurrenceEvent = null;
                    var histologyKey = observation.AdditionalFields["neoplasm_histology_key"];
                    if (_oncConditions.ContainsKey(histologyKey))
                    {
                        conditionOccurrenceEvent = _oncConditions[histologyKey];
                    }

                    if (conditionOccurrenceEvent != null)
                    {
                        observation.AddEvent(common.Enums.EntityType.ConditionOccurrence,
                                             conditionOccurrenceEvent.Id);
                    }
                }

                if (observation.AdditionalFields != null && observation.AdditionalFields.ContainsKey("test_result") && observation.AdditionalFields["test_result"] != null)
                {
                    if (decimal.TryParse(observation.AdditionalFields["test_result"], out var value))
                        observation.ValueAsNumber = value;
                    else
                        observation.ValueAsString = observation.AdditionalFields["test_result"];

                    var result = Vocabulary.Lookup(observation.AdditionalFields["test_result"].Trim(), "LabRes", DateTime.MinValue);
                    if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                    {
                        observation.ValueAsConceptId = result[0].ConceptId.Value;
                    }
                }

                yield return observation;
            }

            if (idnObservation != null)
                yield return idnObservation;
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var oncMeasurements = new List<Measurement>();
            var tumorSize = new List<Measurement>();
            foreach (var measurement in base.BuildMeasurement(measurements, visitOccurrences, observationPeriods))
            {
                //if (measurement.StartDate.Year + 1 <= _person.YearOfBirth)
                //    continue;

                if (measurement.StartDate.Year < _person.YearOfBirth)
                    continue;

                if (measurement.StartDate.Date < _minDate.Date)
                    continue;


                if (measurement.AdditionalFields != null && measurement.AdditionalFields.ContainsKey("neoplasm_histology_key"))
                {
                    ConditionOccurrence conditionOccurrenceEvent = null;
                    var histologyKey = measurement.AdditionalFields["neoplasm_histology_key"];
                    if (histologyKey != null && _oncConditions.ContainsKey(histologyKey))
                    {
                        conditionOccurrenceEvent = _oncConditions[histologyKey];
                    }

                    if (conditionOccurrenceEvent != null)
                    {
                        measurement.AddEvent(common.Enums.EntityType.ConditionOccurrence,
                                             conditionOccurrenceEvent.Id);
                    }

                    if (measurement.AdditionalFields != null && measurement.AdditionalFields.ContainsKey("numeric_result"))
                    {
                        var numericResult = measurement.AdditionalFields["numeric_result"];
                        var operatorValue = string.Empty;
                        var units = string.Empty;

                        if (!string.IsNullOrEmpty(numericResult))
                        {
                            if (numericResult.Contains("=>"))
                            {
                                operatorValue = "=>";
                                numericResult = numericResult.Replace("=>", "");
                            }
                            else if (numericResult.Contains('>'))
                            {
                                operatorValue = ">";
                                numericResult = numericResult.Replace(">", "");
                            }
                            else if (numericResult.Contains("<="))
                            {
                                operatorValue = "<=";
                                numericResult = numericResult.Replace("<=", "");
                            }
                            else if (numericResult.Contains('<'))
                            {
                                operatorValue = "<";
                                numericResult = numericResult.Replace("<", "");
                            }

                            if (numericResult.Contains('%'))
                            {
                                units = "%";
                                numericResult = numericResult.Replace("%", "");
                            }

                            if (numericResult.Contains("Muts/Mb"))
                            {
                                units = "Muts/Mb";
                                numericResult = numericResult.Replace("Muts/Mb", "");
                            }

                            if (numericResult.Contains('+'))
                            {
                                var result = Vocabulary.Lookup(numericResult.Trim(), "LabRes", DateTime.MinValue);

                                if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                                {
                                    measurement.ValueAsConceptId = result[0].ConceptId.Value;
                                }
                            }
                            else if (decimal.TryParse(numericResult, out decimal value))
                            {
                                measurement.ValueAsNumber = value;
                            }
                        }


                        if (!string.IsNullOrEmpty(operatorValue))
                        {
                            var result = Vocabulary.Lookup(operatorValue.Trim(), "Operators", DateTime.MinValue);
                            long conceptId = 0;

                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                                conceptId = result[0].ConceptId.Value;

                            measurement.OperatorConceptId = conceptId;
                        }

                        if (!string.IsNullOrEmpty(units))
                        {
                            var result = Vocabulary.Lookup(units.Trim(), "Lab_Units", DateTime.MinValue);
                            long conceptId = 0;

                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                                conceptId = result[0].ConceptId.Value;

                            measurement.UnitConceptId = conceptId;
                            measurement.UnitSourceValue = units;
                        }
                    }

                    if (measurement.AdditionalFields != null && measurement.AdditionalFields.ContainsKey("result_numeric"))
                    {
                        var numericResult = measurement.AdditionalFields["result_numeric"];

                        if (!string.IsNullOrEmpty(numericResult))
                        {
                            if (numericResult.Contains('/'))
                            {
                                numericResult = numericResult.Split('/')[0];
                            }

                            if (decimal.TryParse(numericResult, out decimal value))
                            {
                                measurement.ValueAsNumber = value;
                            }
                        }
                    }
                }

                if (measurement.AdditionalFields != null && measurement.AdditionalFields.ContainsKey("test_result"))
                {
                    if (decimal.TryParse(measurement.AdditionalFields["test_result"], out var value))
                        measurement.ValueAsNumber = value;
                }

                if (measurement.AdditionalFields != null && measurement.AdditionalFields.ContainsKey("normal_range"))
                {
                    var range = measurement.AdditionalFields["normal_range"];

                    if (!string.IsNullOrEmpty(range) && range.Contains('-'))
                    {
                        var lowValue = range.Split('-')[0];
                        var highValue = range.Split('-')[1];

                        if (decimal.TryParse(lowValue, out var low))
                            measurement.RangeLow = low;

                        if (decimal.TryParse(highValue, out var high))
                            measurement.RangeHigh = high;
                    }
                }


                // onc
                if (measurement.TypeConceptId == 32882)
                {
                    if (measurement.ConceptId == 36768664)
                        tumorSize.Add(measurement);
                    else
                        oncMeasurements.Add(measurement);
                }
                else
                    yield return measurement;
            }

            foreach (var item in oncMeasurements.GroupBy(g =>
                new
                {
                    g.StartDate,
                    g.SourceValue,
                    g.ConceptId,
                    g.ValueAsConceptId,
                    g.UnitSourceValue,
                    g.ValueSourceValue,
                    g.EventId
                }))
            {
                yield return item.First();
            }


            foreach (var byDate in tumorSize.GroupBy(t => t.StartDate))
            {
                var mes = byDate.First();
                foreach (var mv in byDate.Select(t => t.AdditionalFields["max_value"]).Distinct())
                {
                    var maxTumorSize = new Measurement(mes)
                    {
                        Id = Offset.GetKeyOffset(mes.PersonId).MeasurementId,
                        ConceptId = 36768255,
                        ValueAsNumber = decimal.Parse(mv),
                        UnitConceptId = mes.UnitConceptId,
                        UnitSourceValue = mes.UnitSourceValue
                    };

                    if (mes.EventId.HasValue)
                        maxTumorSize.AddEvent(common.Enums.EntityType.ConditionOccurrence, mes.EventId.Value);

                    yield return maxTumorSize;
                }
            }

            foreach (var ts in tumorSize)
            {
                var maxValue = decimal.Parse(ts.AdditionalFields["max_value"]);

                if (ts.ValueAsNumber != maxValue)
                    yield return ts;
            }
        }

        private static Death CleanUpDeath(IEnumerable<IEntity> items, Death death)
        {
            if (death == null) return null;

            return items.Any(item => item.StartDate.Date > death.StartDate.AddDays(30).Date) ? null : death;
        }

        protected static void SetProviderIds<T>(IEnumerable<T> inputRecords, Dictionary<long, VisitOccurrence> visits)
            where T : class, IEntity
        {
            if (inputRecords == null)
                return;
            var records = inputRecords as T[] ?? inputRecords.ToArray();
            if (records.Length == 0)
                return;

            if (visits.Count > 0)
            {
                foreach (var e in records.Where(e => !e.ProviderId.HasValue))
                {
                    if (!e.VisitOccurrenceId.HasValue) continue;

                    if (visits.ContainsKey(e.VisitOccurrenceId.Value))
                        e.ProviderId = visits[e.VisitOccurrenceId.Value].ProviderId;
                }
            }
        }

        private long? GetVisitOccurrenceId(IEntity e)
        {
            if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("encid") && !string.IsNullOrEmpty(e.AdditionalFields["encid"]))
            {
                string encid = e.AdditionalFields["encid"];
                if (!_visitIds.ContainsKey(encid))
                    _visitIds.Add(encid, Offset.GetKeyOffset(e.PersonId).VisitOccurrenceId);

                return _visitIds[encid];
            }

            return null;
        }

        private long GetVisitDetailId(IEntity e)
        {
            if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("encid") && !string.IsNullOrEmpty(e.AdditionalFields["encid"]))
            {
                string encid = e.AdditionalFields["encid"];
                if (!_visitDetailIds.ContainsKey(encid))
                    _visitDetailIds.Add(encid, Offset.GetKeyOffset(e.PersonId).VisitDetailId);

                return _visitDetailIds[encid];
            }

            return Offset.GetKeyOffset(e.PersonId).VisitDetailId;
        }

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails, VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            List<VisitDetail> details = [];
            foreach (var visitOccurrence in visitOccurrences)
            {
                if (visitOccurrence.StartDate.Date < _minDate.Date)
                    continue;

                //if (visitOccurrence.StartDate.Year + 1 <= _person.YearOfBirth)
                //    continue;

                if (visitOccurrence.StartDate.Year < _person.YearOfBirth)
                    continue;

                var visitDetail =
                    new VisitDetail(visitOccurrence)
                    {
                        Id = GetVisitDetailId(visitOccurrence),
                        DischargeToConceptId = visitOccurrence.DischargeToConceptId,
                        DischargeToSourceValue = visitOccurrence.DischargeToSourceValue,
                        CareSiteId = visitOccurrence.CareSiteId
                    };

                details.Add(visitDetail);
            }

            foreach (var visitDetail in Clean(details, observationPeriods, false).Distinct())
            {
                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;

                yield return visitDetail;
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
                if (visitOccurrence.StartDate.Date < _minDate.Date)
                    continue;

                //if (visitOccurrence.StartDate.Year + 1 <= _person.YearOfBirth)
                //    continue;

                if (visitOccurrence.StartDate.Year < _person.YearOfBirth)
                    continue;

                if (!visitOccurrence.EndDate.HasValue)
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
            foreach (var erGroup in erVisitsRaw.GroupBy(v => v.StartDate.Date))
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
            foreach (var byStart in remaining.GroupBy(v => v.StartDate.Date))
            {
                foreach (var byEnd in byStart.GroupBy(v => v.EndDate.Value.Date))
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

        public override IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
        ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
        ObservationPeriod[] observationPeriods)
        {
            foreach (var co in BuildEntities(conditionOccurrences, visitOccurrences, observationPeriods, false))
            {
                if (co.StartDate.Date < _minDate.Date)
                    continue;

                if (co.StartDate.Year < _person.YearOfBirth)
                    continue;

                if (co.AdditionalFields != null && co.AdditionalFields.ContainsKey("neoplasm_histology_key"))
                {
                    var histologyKey = co.AdditionalFields["neoplasm_histology_key"];

                    _oncConditions.TryAdd(histologyKey, co);
                }

                yield return co;
            }
        }

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager om)
        {
            this.Offset = om;
            this.ChunkData = data;
            
            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;
            if (person == null)
                return result.Value;

            _person = person;

            var observationPeriods = new ObservationPeriod[]
            {
                new()
                {
                    PersonId = person.PersonId,
                    StartDate = DateTime.MinValue,
                    EndDate = DateTime.MaxValue,
                    TypeConceptId = 32827
                }
            };

            var payerPlanPeriods = BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], null).ToArray();
            var dedupVisits = VisitOccurrencesRaw.Where(v => v.AdditionalFields["sort_index"] == "1").ToArray();
            var vDetails = BuildVisitDetails(null, dedupVisits, observationPeriods).ToArray();

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            foreach (var visitOccurrence in BuildVisitOccurrences(dedupVisits, observationPeriods))
            {
                visitOccurrence.Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;

                if (visitOccurrence.ConceptId == 0)
                    visitOccurrence.ConceptId = 9202;

                if (!visitOccurrence.EndDate.HasValue)
                    visitOccurrence.EndDate = visitOccurrence.StartDate;

                _rawVisits.TryAdd(visitOccurrence.SourceRecordGuid, visitOccurrence);
                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
            }

            var visitDetails = new Dictionary<long, VisitDetail>();
            foreach (var group in vDetails.GroupBy(d => d.Id))
            {
                var vd = group.First();
                var visitOccurrenceId = GetVisitOccurrenceId(vd);
                if (visitOccurrenceId.HasValue && visitOccurrences.ContainsKey(visitOccurrenceId.Value))
                {
                    vd.VisitOccurrenceId = visitOccurrenceId;
                }
                else
                {
                    var visits = visitOccurrences.Values
                        .Where(vo => vd.StartDate.Date >= vo.StartDate.Date
                        && vd.EndDate.Value.Date <= vo.EndDate.Value.Date).ToArray();

                    if (visits.Length != 0)
                        vd.VisitOccurrenceId = visits.First().Id;
                }

                visitDetails.Add(vd.Id, vd);

                var encid = vd.AdditionalFields["encid"];
                _visitDetailsByEncid.TryAdd(encid, vd);
            }

            var drugExposures =
                BuildDrugExposures([.. DrugExposuresRaw], visitOccurrences, observationPeriods).ToArray();
            var conditionOccurrences =
                BuildConditionOccurrences([.. ConditionOccurrencesRaw], visitOccurrences, observationPeriods)
                    .ToArray();

            var procedureOccurrences =
                BuildProcedureOccurrences([.. ProcedureOccurrencesRaw], visitOccurrences, observationPeriods)
                    .ToArray();
            var observations = BuildObservations([.. ObservationsRaw], visitOccurrences, observationPeriods)
                .ToArray();

            var measurements = BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods)
                .ToArray();

            var deviceExposure =
                BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods)
                .Where(d => d.StartDate.Date >= _minDate.Date)
                .ToArray();

            // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
            SetPayerPlanPeriodId(payerPlanPeriods, drugExposures, procedureOccurrences,
                [.. visitOccurrences.Values],
                deviceExposure);

            var notes = BuildNote([.. NoteRecords], visitOccurrences, observationPeriods).ToList();
            var episodes = BuildEpisode([.. EpisodeRecords], visitOccurrences, observationPeriods).ToArray();

            List<DateTime> mins = [];
            List<DateTime> maxs = [];

            FixDates(drugExposures);
            FixDates(conditionOccurrences);
            FixDates(procedureOccurrences);
            FixDates(observations);
            FixDates(deviceExposure);
            FixDates(measurements);
            FixDates(visitOccurrences.Values);
            FixDates(visitDetails.Values);

            GetMinDate(drugExposures, mins);
            GetMinDate(conditionOccurrences, mins);
            GetMinDate(procedureOccurrences, mins);
            GetMinDate(observations.Where(o => o.ConceptId != 44804235), mins);
            GetMinDate(deviceExposure, mins);
            GetMinDate(measurements, mins);
            GetMinDate(visitOccurrences.Values, mins);
            GetMinDate(visitDetails.Values, mins);

            GetMaxDate(drugExposures, maxs, true);
            GetMaxDate(conditionOccurrences, maxs, false);
            GetMaxDate(procedureOccurrences, maxs, false);
            GetMaxDate(observations.Where(o => o.ConceptId != 44804235), maxs, false);
            GetMaxDate(deviceExposure, maxs, false);
            GetMaxDate(measurements, maxs, false);
            GetMaxDate(visitOccurrences.Values, maxs, false);
            GetMaxDate(visitDetails.Values, maxs, false);

            var observationPeriodsFinal = new List<ObservationPeriod>(1)
            {
                observationPeriods[0]
            };

            if (mins.Count != 0)
            {
                var min = mins.Min();
                observationPeriodsFinal[0].StartDate = min;

                if (maxs.Count != 0)
                    observationPeriodsFinal[0].EndDate = maxs.Max();
                else
                    observationPeriodsFinal[0].EndDate = min;
            }

            foreach (var o in observations)
            {
                if (o.ConceptId == 44804235)
                {
                    o.StartDate = observationPeriodsFinal[0].StartDate;
                    break;
                }
            }

            // Delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH
            // TMP visitDetails.Values.Any() only for ONCO
            if (PersonRecords[0].AdditionalFields == null && Excluded(person, observationPeriodsFinal))
            {
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            if (observationPeriodsFinal[0].EndDate.Value.Date < _minDate.Date)
            {
                return Attrition.InvalidObservationTime;
            }

            // there are a small number of patients who have weird observation_period_end_date between 2025 - 6011.
            // These should be truncated to the current year.
            if (observationPeriodsFinal[0].EndDate.Value.Year > DateTime.Now.Year)
            {
                observationPeriodsFinal[0].EndDate = new DateTime(DateTime.Now.Year, 
                    observationPeriodsFinal[0].EndDate.Value.Month,
                    observationPeriodsFinal[0].EndDate.Value.Day);
            }

            if(Vendor.SourceReleaseDate.HasValue && observationPeriodsFinal[0].EndDate.Value.Date > Vendor.SourceReleaseDate.Value.Date)
            {
                observationPeriodsFinal[0].EndDate = Vendor.SourceReleaseDate;
            }

            // set corresponding ProviderIds
            SetProviderIds(drugExposures);
            SetProviderIds(conditionOccurrences);
            SetProviderIds(procedureOccurrences);
            SetProviderIds(observations);
            SetProviderIds(deviceExposure);
            SetProviderIds(measurements);
            SetProviderIds(visitOccurrences.Values);
            SetProviderIds(visitDetails.Values);

            SetVisitOccurrenceId(conditionOccurrences, [.. visitDetails.Values]);
            SetVisitOccurrenceId(procedureOccurrences, [.. visitDetails.Values]);
            SetVisitOccurrenceId(drugExposures, [.. visitDetails.Values]);
            SetVisitOccurrenceId(deviceExposure, [.. visitDetails.Values]);
            SetVisitOccurrenceId(observations, [.. visitDetails.Values]);
            SetVisitOccurrenceId(measurements, [.. visitDetails.Values]);

            SetProviderIds(drugExposures, visitOccurrences);
            SetProviderIds(conditionOccurrences, visitOccurrences);
            SetProviderIds(measurements, visitOccurrences);
            SetProviderIds(procedureOccurrences, visitOccurrences);
            SetProviderIds(deviceExposure, visitOccurrences);
            SetProviderIds(observations, visitOccurrences);

            int noteNlpId = 0;
            if (notes.Count != 0)
            {
                if (visitOccurrences.Count > 0)
                {
                    foreach (var e in notes)
                    {
                        //NoteNlp
                        if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("temporality"))
                        {
                            ChunkData.AddNoteNlp(new NoteNlp
                            {
                                NoteNlpId = noteNlpId,
                                PersonId = e.PersonId,
                                NoteId = e.Id,

                                NlpDate = e.StartDate,
                                LexicalVariant = e.Text,
                                TermExists = e.AdditionalFields["qualifier"].Equals("actual", StringComparison.OrdinalIgnoreCase),
                                TermTemporal = e.AdditionalFields["temporality"],
                                TermModifiers = $"Severity={e.AdditionalFields["severity"]}| Chronicity={e.AdditionalFields["chronicity"]}| Stage={e.AdditionalFields["stage"]}| Change={e.AdditionalFields["change"]}"
                            });
                            noteNlpId++;
                        }

                        if (!e.ProviderId.HasValue)
                        {
                            if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("encid") && !string.IsNullOrEmpty(e.AdditionalFields["encid"]))
                            {
                                var encid = e.AdditionalFields["encid"];

                                //var vd = visitDetails.Values.FirstOrDefault(v => v.AdditionalFields["encid"] == encid);
                                //if (vd == null) continue;
                                if (_visitDetailsByEncid.TryGetValue(encid, out VisitDetail? vd))
                                {
                                    e.VisitDetailId = vd.Id;
                                    e.VisitOccurrenceId = vd.VisitOccurrenceId;
                                }
                            }

                            if (!e.VisitOccurrenceId.HasValue) continue;

                            if (visitOccurrences.ContainsKey(e.VisitOccurrenceId.Value))
                                e.ProviderId = visitOccurrences[e.VisitOccurrenceId.Value].ProviderId;
                        }
                    }
                }
            }

            var death = BuildDeath([.. DeathRecords], visitOccurrences, [.. observationPeriodsFinal]);
            var drugCosts = BuildDrugCosts(drugExposures).ToArray();
            var procedureCosts = BuildProcedureCosts(procedureOccurrences).ToArray();
            var visitCosts = BuildVisitCosts([.. visitOccurrences.Values]).ToArray();
            var devicCosts = BuildDeviceCosts(deviceExposure).ToArray();

            var cohort = BuildCohort([.. CohortRecords], [.. observationPeriodsFinal]).ToArray();


            if (death != null)
            {
                death = CleanUpDeath(visitDetails.Values, death);
                death = CleanUpDeath(visitOccurrences.Values, death);
                death = CleanUpDeath(drugExposures, death);
                death = CleanUpDeath(conditionOccurrences, death);
                death = CleanUpDeath(procedureOccurrences, death);
                death = CleanUpDeath(measurements, death);
                death = CleanUpDeath(observations, death);
                death = CleanUpDeath(deviceExposure, death);
            }

            if (death != null && death.StartDate.Date < _minDate.Date)
            {
                return Attrition.UnacceptablePatientQuality;
            }

            foreach (var p in procedureOccurrences)
            {
                if (p.TypeConceptId != 32858)
                    continue;

                
                if (p.AdditionalFields == null || !p.AdditionalFields.ContainsKey("findings"))
                    continue;

                // alz_imaging
                notes.Add(
                    new Note
                    {
                        Id = Offset.GetKeyOffset(p.PersonId).NoteId,
                        PersonId = p.PersonId,
                        StartDate = p.StartDate,
                        TypeConceptId = 32858,
                        Text = string.Concat("imaging:", p.AdditionalFields["findings"]),
                        LanguageConceptId = 40639387,
                        ProviderId = p.ProviderId,
                        VisitOccurrenceId = p.VisitOccurrenceId,
                        SourceValue = $"{p.AdditionalFields["findings"]}|{p.AdditionalFields["reasons"]}",
                        EventId = p.Id
                    });
            }

            SetPrecedingVisitOccurrenceId(visitOccurrences.Values);
            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, 
                death, 
                [.. observationPeriodsFinal], 
                payerPlanPeriods,
                [.. UpdateRSourceConcept(drugExposures)],
                [.. UpdateRSourceConcept(conditionOccurrences)],
                [.. UpdateRSourceConcept(procedureOccurrences)],
                [.. UpdateRSourceConcept(observations)],
                [.. UpdateRSourceConcept(measurements)],
                [.. visitOccurrences.Values], 
                [.. visitDetails.Values], 
                cohort,
                [.. UpdateRSourceConcept(deviceExposure)],
                [.. notes], 
                episodes);

            var pg = new PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, [.. observationPeriodsFinal],
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
        protected void FixDates<T>(IEnumerable<T> inputRecords) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any() || !Vendor.SourceReleaseDate.HasValue)
                return;
            
            foreach (var i in inputRecords)
            {
                if (i.StartDate.Date > Vendor.SourceReleaseDate.Value.Date)
                    i.StartDate = Vendor.SourceReleaseDate.Value;

                if (i.EndDate.HasValue && i.EndDate.Value.Date > Vendor.SourceReleaseDate.Value.Date)
                    i.EndDate = Vendor.SourceReleaseDate.Value;
            }
        }

        protected static void GetMinDate<T>(IEnumerable<T> inputRecords, List<DateTime> result) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;

            // TypeConceptId = 32882 - onco events, not used for observation_period
            var dates = inputRecords.Where(e => e.TypeConceptId != 32882 && e.StartDate != DateTime.MinValue);
            if (dates != null && dates.Any())
                result.Add(dates.Min(e => e.StartDate));
        }

        protected static void GetMaxDate<T>(IEnumerable<T> inputRecords, List<DateTime> result, bool onlyStartDate) where T : class, IEntity
        {
            if (inputRecords == null || !inputRecords.Any())
                return;

            var dates = new HashSet<DateTime>();
            foreach (var i in inputRecords)
            {
                if (i.TypeConceptId == 32882)
                    continue;

                if (!onlyStartDate && i.EndDate.HasValue && i.EndDate.Value != DateTime.MinValue && i.EndDate.Value != DateTime.MaxValue)
                    dates.Add(i.EndDate.Value);
                else if (i.StartDate != DateTime.MinValue)
                    dates.Add(i.StartDate);
            }

            if (dates != null && dates.Count != 0)
                result.Add(dates.Max());
        }

        protected void SetVisitOccurrenceId<T>(IEnumerable<T> inputRecords, VisitDetail[] visitDetail)
      where T : class, IEntity
        {
            foreach (var e in inputRecords)
            {
                if (e.AdditionalFields != null && e.AdditionalFields.ContainsKey("encid") && !string.IsNullOrEmpty(e.AdditionalFields["encid"]))
                {
                    var encid = e.AdditionalFields["encid"];

                    if (_visitDetailsByEncid.TryGetValue(encid, out VisitDetail? vd))
                    {
                        e.VisitDetailId = vd.Id;
                        e.VisitOccurrenceId = vd.VisitOccurrenceId;
                    }
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
                                       Id = Offset.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                   };

                        if (cond.StatusConceptId.HasValue && cond.StatusConceptId == 1340204)
                        {
                            var observationHistoryOf = new Observation(cond)
                            {
                                Id = Offset.GetKeyOffset(entity.PersonId).ObservationId,
                                ValueAsConceptId = cond.ConceptId,
                                ConceptId = cond.StatusConceptId.Value
                            };
                            ChunkData.AddData(observationHistoryOf);
                        }
                        else if (string.IsNullOrEmpty(entity.Domain) || entity.Domain.ToLower().Trim() != "spec anatomic site")
                        {
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        var mes = entity as Measurement ??
                                  new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId };

                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("test_result"))
                        {
                            mes.ValueSourceValue = entity.AdditionalFields["test_result"];
                        }

                        if (mes.ValueAsNumber != null && mes.ValueAsNumber != 0 && string.IsNullOrEmpty(mes.ValueSourceValue))
                        {
                            mes.ValueSourceValue = mes.ValueAsNumber.ToString();
                        }

                        if (mes.ConceptId == 0 && !string.IsNullOrEmpty(mes.SourceValue) && mes.SourceValue == "SARS coronavirus 2 antigen (COVID-19).respiratory")
                            mes.ConceptId = 37310257;


                        if ((!mes.ValueAsConceptId.HasValue || mes.ValueAsConceptId == 0) && !string.IsNullOrEmpty(mes.ValueSourceValue))
                        {
                            if (mes.ValueSourceValue.Equals("notdet", StringComparison.CurrentCultureIgnoreCase))
                            {
                                mes.ValueAsConceptId = 9190;
                            }
                            else if (mes.ValueSourceValue.Equals("det", StringComparison.CurrentCultureIgnoreCase))
                            {
                                mes.ValueAsConceptId = 4126681;
                            }
                        }


                        switch (mes.SourceValue)
                        {
                            case "Kappa/lambda light chain ratio.free (FLC).urine":
                                mes.ConceptId = 4136733;
                                break;

                            case "Lambda light chain.free (FLC).urine.concentration":
                                mes.ConceptId = 4136577;
                                break;

                            case "Kappa light chain.free (FLC).urine.concentration":
                                mes.ConceptId = 4133528;
                                break;

                            case "Kappa light chain.free (FLC).urine.24 hour":
                                mes.ConceptId = 4133528;
                                break;

                            case "Lambda light chain.free (FLC).urine.24 hour":
                                mes.ConceptId = 4136577;
                                break;

                            case "Lambda light chain.free (FLC).concentration":
                                mes.ConceptId = 44804924;
                                break;

                            case "Kappa light chain.free (FLC).concentration":
                                mes.ConceptId = 44804922;
                                break;

                            case "Kappa/lambda light chain ratio.free (FLC)":
                                mes.ConceptId = 4136733;
                                break;

                            default:
                                break;
                        }

                        //  for body mass index measurements from NLP_Measurement
                        if (mes.ConceptId == 3038553 && mes.TypeConceptId == 32858)
                        {
                            if (!mes.UnitConceptId.HasValue || // No matching concept
                                mes.UnitConceptId == 0 || // No matching concept
                                mes.UnitConceptId == 9529 || // kilogram
                                mes.UnitConceptId == 8617)     // square meter
                            {
                                mes.UnitConceptId = 9531; // kilogram per square meter
                            }
                        }

                        ChunkData.AddData(mes);
                        break;

                    case "Meas Value":
                        var m = entity as Measurement ??
                                new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId };

                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("test_result"))
                        {
                            m.ValueSourceValue = entity.AdditionalFields["test_result"];
                        }

                        ChunkData.AddData(m);
                        break;

                    case "Observation":
                        var o = entity as Observation ??
                            new Observation(entity)
                            {
                                Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                            };
                        ChunkData.AddData(o);
                        break;

                    case "Procedure":
                        var proc = entity as ProcedureOccurrence ??
                                   new ProcedureOccurrence(entity)
                                   {
                                       Id =
                                           Offset.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
                                   };

                        ChunkData.AddData(proc);
                        break;

                    case "Device":
                        var dev = entity as DeviceExposure ??
                                  new DeviceExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId
                                  };

                        if (dev.Quantity < 1)
                        {
                            dev.Quantity = null;
                        }

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

                        if (drg.Refills.HasValue && drg.Refills > 24)
                        {
                            drg.Refills = null;
                        }

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }
            }
        }

        #endregion
    }
}