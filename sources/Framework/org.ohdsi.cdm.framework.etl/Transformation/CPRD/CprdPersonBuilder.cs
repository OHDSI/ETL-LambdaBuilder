using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.CPRD
{
    /// <summary>
    ///  Implementation of PersonBuilder for CPRD, based on CDM Build spec
    /// </summary>
    public class CprdPersonBuilder : PersonBuilder
    {
        #region Classes

        public class CprdVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "Cprd";
            public override string Folder => "CPRD";
            public override string Description => "Cprd v5.4";
            public override string CdmSource => "";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "Patient";
            public override string Citation => "";
            public override string Publication => "Must have ISAC approval to conduct study. https://www.cprd.com/research-applications";
        }

        #endregion

        #region Constructors

        public CprdPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not CprdVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails,
            VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {

            foreach (var visitOccurrence in visitOccurrences)
            {
                var visitDetail =
                    new VisitDetail(visitOccurrence)
                    {
                        Id = visitOccurrence.Id,
                        CareSiteId = visitOccurrence.CareSiteId,

                    };

                yield return visitDetail;
            }
        }

        /// <summary>
        /// Build person entity and all person related entities like: DrugExposures, ConditionOccurrences, ProcedureOccurrences... from raw data sets 
        /// </summary>
        public override Attrition Build(ChunkData data, KeyMasterOffsetManager om)
        {
            this.Offset = om;
            this.ChunkData = data;
            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;
            if (person == null)
                return result.Value;

            if (!ObservationPeriodsRaw.Any(op => op.StartDate < op.EndDate))
                return Attrition.InvalidObservationTime;

            var op = ObservationPeriodsRaw.Where(op =>
                    op.StartDate < op.EndDate &&
                    op.StartDate.Year >= person.YearOfBirth &&
                    op.EndDate.Value.Year >= person.YearOfBirth &&
                    op.StartDate.Year <= DateTime.Now.Year).ToArray();

            if (op.Length == 0)
                return Attrition.InvalidObservationTime;

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap, op).ToArray();

            var payerPlanPeriods = BuildPayerPlanPeriods(PayerPlanPeriodsRaw.Where(pp =>
                    pp.StartDate.Year >= person.YearOfBirth &&
                    pp.EndDate.Value.Year >= person.YearOfBirth &&
                    pp.StartDate.Year <= DateTime.Now.Year).ToArray(), null).ToArray();

            var visitDetails = new Dictionary<long, VisitDetail>();
            var visitDetIds = new List<long>();
            foreach (var vd in BuildVisitDetails(null, VisitOccurrencesRaw.Where(vo =>
                    vo.StartDate.Year >= person.YearOfBirth &&
                    vo.EndDate.Value.Year >= person.YearOfBirth &&
                    vo.StartDate.Year <= DateTime.Now.Year &&
                    vo.EndDate.Value.Year <= DateTime.Now.Year).ToArray(), observationPeriods).ToArray())
            {
                if (person.MonthOfBirth.HasValue && vd.StartDate.Year < person.YearOfBirth.Value &&
                    vd.StartDate.Month < person.MonthOfBirth ||
                    vd.StartDate.Year < person.YearOfBirth.Value)
                    if (vd.StartDate.Year < person.YearOfBirth.Value)
                    {
                        if (DateTime.TryParse(person.AdditionalFields["frd"], out var frd))
                        {
                            vd.StartDate = frd;
                            vd.EndDate = frd;
                        }
                        else
                        {
                            continue;
                        }
                    }

                if (visitDetails.ContainsKey(vd.Id))
                    continue;

                visitDetails.Add(vd.Id, vd);
                visitDetIds.Add(vd.Id);
            }

            long? prevVisitDetId = null;
            foreach (var visitId in visitDetIds.OrderBy(v => v))
            {
                if (prevVisitDetId.HasValue)
                {
                    visitDetails[visitId].PrecedingVisitDetailId = prevVisitDetId;
                }

                prevVisitDetId = visitId;
            }

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var byStartDate in visitDetails.Values.GroupBy(v => v.StartDate))
            {
                var vd = byStartDate.First();
                var providerId = byStartDate.Min(v => v.ProviderId);
                var careSiteId = byStartDate.Min(v => v.CareSiteId);
                var sourceValue = byStartDate.Min(v => v.SourceValue);
                var visitOccurrenceId = byStartDate.Min(v => v.Id);
                var visitOccurrence = new VisitOccurrence(vd)
                {
                    //Id = Offset.GetKeyOffset(vd.PersonId).VisitOccurrenceId,
                    Id = visitOccurrenceId,
                    ProviderId = providerId,
                    CareSiteId = careSiteId,
                    SourceValue = sourceValue
                };

                foreach (var visitDetail in byStartDate)
                {
                    visitDetail.VisitOccurrenceId = visitOccurrence.Id;
                }

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
                visitIds.Add(visitOccurrence.Id);
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

            SetVisitOccurrenceId(ConditionOccurrencesRaw, visitDetails);
            SetVisitOccurrenceId(ProcedureOccurrencesRaw, visitDetails);
            SetVisitOccurrenceId(DrugExposuresRaw, visitDetails);
            SetVisitOccurrenceId(DeviceExposureRaw, visitDetails);
            SetVisitOccurrenceId(ObservationsRaw, visitDetails);
            SetVisitOccurrenceId(MeasurementsRaw, visitDetails);

            var drugExposures = BuildDrugExposures([.. DrugExposuresRaw], visitOccurrences, observationPeriods).ToArray();
            var deviceExposure = BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods).ToArray();
            var conditionOccurrences = BuildConditionOccurrences([.. ConditionOccurrencesRaw], visitOccurrences, observationPeriods).ToArray();
            var procedureOccurrences = BuildProcedureOccurrences([.. ProcedureOccurrencesRaw], visitOccurrences, observationPeriods).ToArray();

            var observations = BuildObservations([.. ObservationsRaw], visitOccurrences, observationPeriods).ToArray();
            var measurements = BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods).ToArray();

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);


            if (death != null)
            {
                person.TimeOfDeath = death.StartDate;
            }

            death = UpdateDeath(death, person, observationPeriods);

            var race = new List<IEntity>();
            race.AddRange(conditionOccurrences.Where(co => co.Domain == "Race"));
            race.AddRange(observations.Where(co => co.Domain == "Race"));

            if (race.Count > 0)
            {
                var pr = race.OrderByDescending(r => r.ConceptId).First();
                person.RaceConceptId = pr.ConceptId;
                person.RaceSourceValue = pr.SourceValue;
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person,
                death,
                observationPeriods,
                payerPlanPeriods,
                FilterByDeathDate(Clean(drugExposures, person), death, 60).ToArray(),
                FilterByDeathDate(Clean(conditionOccurrences, person), death, 60).ToArray(),
                FilterByDeathDate(Clean(procedureOccurrences, person), death, 60).ToArray(),
                FilterByDeathDate(Clean(observations, person), death, 60).ToArray(),
                FilterByDeathDate(Clean(measurements, person), death, 60).ToArray(),
                FilterByDeathDate(visitOccurrences.Values, death, 60).ToArray(),
                FilterByDeathDate(visitDetails.Values, death, 60).ToArray(),
                null,
                FilterByDeathDate(Clean(deviceExposure, person), death, 60).ToArray(), 
                null, 
                null);

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

        public override IEnumerable<T> BuildEntities<T>(IEnumerable<T> entitiesToBuild, IDictionary<long, VisitOccurrence> visitOccurrences, IEnumerable<ObservationPeriod> observationPeriods,
            bool withinTheObservationPeriod)
        {
            var uniqueEntities = new HashSet<T>();
            foreach (var e in entitiesToBuild)
            {
                if (e.VisitOccurrenceId == null || visitOccurrences.ContainsKey(e.VisitOccurrenceId.Value))
                {
                    if (e.IsUnique)
                    {
                        uniqueEntities.Add(e);
                    }
                    else
                    {
                        yield return e;
                    }
                }
            }

            foreach (var ue in uniqueEntities)
            {
                yield return ue;
            }
        }

        private static void SetVisitOccurrenceId<T>(IEnumerable<T> inputRecords, Dictionary<long, VisitDetail> vd)
            where T : class, IEntity
        {
            foreach (var e in inputRecords)
            {
                if (!e.VisitDetailId.HasValue)
                    continue;

                if (vd.ContainsKey(e.VisitDetailId.Value))
                {
                    e.VisitOccurrenceId = vd[e.VisitDetailId.Value].VisitOccurrenceId;
                }
            }
        }

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ToArray();
            var person = ordered.Take(1).First();

            if (person.AdditionalFields["accept"] != "1")
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            person.StartDate = ordered.Take(1).Last().StartDate;

            var gender =
                records.GroupBy(p => p.GenderConceptId).OrderByDescending(gp => gp.Count()).Take(1).First().First();
            var race = records.GroupBy(p => p.RaceConceptId).OrderByDescending(gp => gp.Count()).Take(1).First()
                .First();

            person.GenderConceptId = gender.GenderConceptId;
            person.GenderSourceValue = gender.GenderSourceValue;
            person.RaceConceptId = race.RaceConceptId;
            person.RaceSourceValue = race.RaceSourceValue;

            if (person.YearOfBirth < 1875)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            if (person.GenderConceptId == 8551) //UNKNOWN
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            if (person.GenderConceptId == 8507 && records.Any(p => p.GenderConceptId == 8532))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges);
            }

            if (person.GenderConceptId == 8532 && records.Any(p => p.GenderConceptId == 8507))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        private static string GetDomain2(string entityDomain, string conceptDomain)
        {
            if (conceptDomain == null)
                return entityDomain;

            if (conceptDomain.StartsWith("Condition", StringComparison.OrdinalIgnoreCase))
                return "Condition";

            if (conceptDomain.StartsWith("Measurement", StringComparison.OrdinalIgnoreCase))
                return "Measurement";

            if (conceptDomain.StartsWith("Observation", StringComparison.OrdinalIgnoreCase))
                return "Observation";

            if (conceptDomain.StartsWith("Procedure", StringComparison.OrdinalIgnoreCase))
                return "Procedure";

            if (conceptDomain.StartsWith("Device", StringComparison.OrdinalIgnoreCase))
                return "Device";

            if (conceptDomain.StartsWith("Drug", StringComparison.OrdinalIgnoreCase))
                return "Drug";


            return entityDomain;
        }

        private long? GetValueAsConceptId(IEntity e, string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            if (e.AdditionalFields == null || !e.AdditionalFields.ContainsKey("data"))
                return null;

            switch (e.AdditionalFields["data"].ToLower().Trim())
            {
                case "read code for condition":
                    var result = GetReadCodeConceptId(value, DateTime.MinValue);
                    return result?.ConceptId;

                case "drug code":
                    var result1 = Vocabulary.Lookup(value, "Drug", DateTime.MinValue);
                    return result1.Count != 0 ? result1[0].ConceptId : null;

                default:
                    return null;
            }
        }

        public override void AddToChunk(string domain, IEnumerable<IEntity> entities)
        {
            foreach (var entity in entities)
            {
                var entityDomain = GetDomain2(domain, entity.Domain);

                switch (entityDomain)
                {
                    case "Condition":

                        if (!string.IsNullOrEmpty(entity.Domain) &&
                            !entity.Domain.StartsWith("Condition") &&
                            entity.Domain != "Race")
                        {
                            var o = new Observation(entity)
                            {
                                Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                            };
                            ChunkData.AddData(o);
                        }
                        else if (entity.Domain != "Race")
                        {
                            var cond = entity as ConditionOccurrence ??
                                       new ConditionOccurrence(entity)
                                       {
                                           Id = Offset.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                       };
                            //cond.TypeConceptId = 32020; //EHR encounter diagnosis
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        var mes = entity as Measurement ?? new Measurement(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                        };

                        //mes.TypeConceptId = 44818702; //Lab result;

                        if (!string.IsNullOrEmpty(mes.SourceValue))
                        {
                            var result = GetReadCodeConceptId(mes.SourceValue, mes.StartDate);

                            if(result != null && result.SourceConcepts.Count > 0
                                && result.SourceConcepts.First().ConceptId > 0)
                            {
                                mes.SourceConceptId = result.SourceConcepts.First().ConceptId;
                            }
                        }

                        if (string.Equals(mes.SourceValue, "4J3R200", StringComparison.Ordinal))
                        {
                            mes.ConceptId = 756065;
                            mes.ValueSourceValue = "Not Detected";
                            mes.ValueAsConceptId = 9190;
                        }
                        else if (string.Equals(mes.SourceValue, "4J3R100", StringComparison.Ordinal))
                        {
                            mes.ConceptId = 756065;
                            mes.ValueSourceValue = "Detected";
                            mes.ValueAsConceptId = 4126681;
                        }
                        else if (string.Equals(mes.SourceValue, "4J3R.00", StringComparison.Ordinal))
                        {
                            mes.ConceptId = 706179;
                        }

                        if (entity is Observation)
                        {
                            mes.OperatorConceptId = ((Observation)entity).QualifierConceptId;
                        }

                        ChunkData.AddData(mes);
                        break;

                    case "Observation":
                        if (string.IsNullOrEmpty(entity.Domain) || entity.Domain != "Race")
                        {
                            var obs = entity as Observation ?? new Observation(entity)
                            {
                                Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                            };
                            //obs.TypeConceptId = 38000280; //Observation recorded from EHR
                            var valueAsConceptId = GetValueAsConceptId(obs, obs.ValueAsString);
                            if (valueAsConceptId.HasValue)
                                obs.ValueAsConceptId = valueAsConceptId.Value;

                            if (obs.ConceptId == 4275495)
                            {
                                if (obs.ValueAsNumber == 1)
                                    obs.ConceptId = 903654;
                                else if (obs.ValueAsNumber == 2)
                                    obs.ConceptId = 4052464;
                                else if (obs.ValueAsNumber == 3)
                                {
                                    obs.ConceptId = 1340204;
                                    obs.ValueAsConceptId = 903657;
                                }

                                obs.SourceValue = $"{obs.SourceValue}-{String.Format("{0:0.##}", obs.ValueAsNumber)}-{obs.ValueAsString}";
                                obs.ValueAsNumber = null;
                                obs.ValueAsString = null;
                            }

                            if (obs.TypeConceptId == 32856 && !string.IsNullOrEmpty(obs.SourceValue))
                            {
                                var result = GetReadCodeConceptId(obs.SourceValue, obs.StartDate);

                                if (result != null && result.SourceConcepts.Count > 0
                                    && result.SourceConcepts.First().ConceptId > 0)
                                {
                                    obs.SourceConceptId = result.SourceConcepts.First().ConceptId;
                                }
                            }

                            ChunkData.AddData(obs);

                            if (obs.ConceptId == 1340204 && obs.ValueAsConceptId == 903657)
                            {
                                var obs2 = new Observation(entity)
                                {
                                    Id = Offset.GetKeyOffset(entity.PersonId).ObservationId,
                                    ConceptId = 4052464
                                };
                                ChunkData.AddData(obs2);
                            }
                        }
                        break;

                    case "Procedure":
                        var proc = entity as ProcedureOccurrence ??
                                   new ProcedureOccurrence(entity)
                                   {
                                       Id = Offset.GetKeyOffset(entity.PersonId)
                                           .ProcedureOccurrenceId
                                   };
                        //proc.TypeConceptId = 38000275; //EHR order list entry
                        ChunkData.AddData(proc);
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

                        //drg.TypeConceptId = 38000177;

                        //Drug|CVX
                        //if (entity.Domain != null && entity.Domain.EndsWith("CVX", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    drg.TypeConceptId = 38000179; // Physician administered drug (identified as procedure)
                        //}

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }

            }
        }

        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(procedureOccurrences, visitOccurrences, observationPeriods, false);
        }

        public override Death BuildDeath(Death[] death, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var ds = Clean(death, observationPeriods, false).ToList();
            if (ds.Count != 0)
            {
                var pd = ds.Where(d => d.Primary).ToList();
                var result = pd.Count != 0 ? pd.OrderBy(d => d.StartDate).Last() : ds.OrderBy(d => d.StartDate).Last();

                if (result.StartDate.Year < 1900)
                    return null;

                return result;
            }

            return null;
        }

        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(observations, visitOccurrences, observationPeriods, false);
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var mes in BuildEntities(measurements, visitOccurrences, observationPeriods, false))
            {
                yield return mes;
            }
        }

        public override IEnumerable<EraEntity> BuildConditionEra(ConditionOccurrence[] conditionOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var eraEntity in EraHelper.GetEras(
                Clean(conditionOccurrences, observationPeriods, false), 30,
                38000247))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).ConditionEraId;
                yield return eraEntity;
            }
        }
        public override IEnumerable<EraEntity> BuildDrugEra(DrugExposure[] drugExposures, ObservationPeriod[] observationPeriods)
        {
            foreach (var eraEntity in EraHelper.GetEras(
                Clean(drugExposures, observationPeriods, false), 30, 38000182))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).DrugEraId;
                yield return eraEntity;
            }
        }

        public override IEnumerable<DeviceExposure> BuildDeviceExposure(DeviceExposure[] devExposure,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(devExposure, visitOccurrences, observationPeriods, false);
        }

        private LookupValue? GetReadCodeConceptId(string sourceValue, DateTime date)
        {
            var result = Vocabulary.Lookup(sourceValue, "Read_Code", date);

            if (result != null && result.Count > 0)
            {
                return result.FirstOrDefault(r => sourceValue.Equals(r.SourceCode, StringComparison.Ordinal));
            }

            return null;
        }

        #endregion
    }
}
