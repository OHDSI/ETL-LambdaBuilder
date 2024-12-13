using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.Premier
{
    /// <summary>
    ///  Implementation of PersonBuilder for Premier, based on CDM Build spec
    /// </summary>
    public class PremierPersonBuilder : PersonBuilder
    {
        #region Classes

        public class PremierVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "Premier";
            public override string Folder => "Premier";
            public override string Description => "Premier v5.4";
            public override string CdmSource => "";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "pat";
            public override string Citation => "";
            public override string Publication => "No review required";
        }

        #endregion

        #region Fields

        //private readonly Dictionary<long, int> _visitsMaxServDays = new Dictionary<long, int>();
        private readonly string[] _covid =
            [
            "TRACKING/STATISTIC COVID19",
            "OBSERVATION COVID19 PER HR",
            "BRIEF CHECK-IN BY MD/QHP TO EST PT(VIRTUAL)COVID19",
            "VISIT NEW COMPREHENSIVE 45 MIN COVID19",
            "ANTIBODY COVID19",
            "VISIT ESTAB EXPANDED 15 MIN COVID19",
            "PLASMA CONVALESCENT COVID19 8-24 HRS PROCESSING",
            "TELEPHONE CALL E/M SERVICE 21-30 MIN COVID19",
            "INF AGENT DET NUCL ACID(DNA/RNA)COVID19 HIGH THR",
            "R&B CICU/CCU (CORONARY CARE)COVID19",
            "PLASMA CONVALESCENT COVID19 SINGLE DONOR PROC",
            "PLASMA CONVALESCENT COVID19 PROCESSING",
            "IMMUNO INF AGENT AB QL/SEMI-QL SINGLE STEP COVID19",
            "TELEPHONE CALL E/M SERVICE 11-20 MIN COVID19",
            "PF NON-CDC LAB TEST COVID19 HIGH THROUGHPUT TECH",
            "VISIT ESTAB BRIEF 10 MIN COVID19",
            "R&B MISC COVID19",
            "SPECIMEN COLLECTION OUTPATIENT COVID19 ANY SOURCE",
            "PLASMA CONVALESCENT COVID19 SINGLE DONOR",
            "TELEPHONE CALL E/M SERVICE 5-10 MIN COVID19",
            "PF INF AG DET NUCL ACID(DNA/RNA)COVID19 AMP PROBE",
            "VISIT NEW EXPANDED 20 MIN COVID19",
            "VISIT NEW DETAILED 30 MIN COVID19",
            "VISIT ESTAB COMPREHENSIVE 40 MIN COVID19",
            "VISIT ESTAB DETAILED 25 MIN COVID19",
            "R&B SNF COVID19",
            "SPECIMEN COLLECTION COVID19 ANY SPECIMEN SOURCE",
            "NON-CDC LAB TEST COVID19 HIGH THROUGHPUT TECHNOL"
            ];

        private static readonly char[] separator = [' '];

        #endregion

        #region Constructors

        public PremierPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not PremierVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods
        /// <summary>
        /// Build person entity and all person related entities like: DrugExposures, ConditionOccurrences, ProcedureOccurrences... from raw data sets 
        /// </summary>
        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;
            if (person == null) return result.Value;

            var observationPeriodsFromVisits = new List<EraEntity>();

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], null))
            {
                visitOccurrences.TryAdd(visitOccurrence.Id, visitOccurrence);
            }


            var death = BuildDeath([.. DeathRecords], visitOccurrences, null);

            //Exclude visits with start date after person death date
            var cleanedVisits = CleanUp(visitOccurrences.Values.ToArray(), death).ToArray();
            visitOccurrences.Clear();

            // Create set of observation period entities from set of visit entities
            var visitIds = new List<long>();
            var visitsDictionary = new Dictionary<Guid, VisitOccurrence>();
            foreach (var vo in cleanedVisits)
            {
                visitOccurrences.Add(vo.Id, vo);
                visitsDictionary.Add(vo.SourceRecordGuid, vo);
                visitIds.Add(vo.Id);
                observationPeriodsFromVisits.Add(new EraEntity
                {
                    Id = Offset.GetKeyOffset(vo.PersonId).ObservationPeriodId,
                    PersonId = vo.PersonId,
                    StartDate = vo.StartDate,
                    EndDate = vo.EndDate,
                    TypeConceptId = 32880
                });
            }

            long? prevVisitId = null;
            foreach (var visit in visitOccurrences.Values.OrderBy(v => v.EndDate.Value))
            {
                if (prevVisitId.HasValue)
                {
                    visit.PrecedingVisitOccurrenceId = prevVisitId;
                }

                prevVisitId = visit.Id;
            }

            var minYearOfBirth = 9999;
            var maxYearOfBirth = 0;
            var firstVOYear = 0;
            var firstYearOfBirth = 0;

            // Calculate max/min value of person year of birth
            // MONTH_OF_BIRTH and DAY_OF_BIRTH are not available in Premier, 
            // because age is the only available field. YEAR_OF_BIRTH is calculated from the first admission. 
            // The admission year minus the age results in the YEAR_OF_BIRTH. 
            foreach (var personRecord in PersonRecords.Where(p => p.YearOfBirth.HasValue))
            {
                if (!visitsDictionary.ContainsKey(personRecord.SourceRecordGuid)) continue;

                var yearOfBirth = visitsDictionary[personRecord.SourceRecordGuid].StartDate.Year -
                                  personRecord.YearOfBirth;

                if (yearOfBirth < 1900)
                    continue;

                if (yearOfBirth < minYearOfBirth)
                    minYearOfBirth = yearOfBirth.Value;

                if (yearOfBirth > maxYearOfBirth)
                    maxYearOfBirth = yearOfBirth.Value;

                if (firstVOYear < visitsDictionary[personRecord.SourceRecordGuid].StartDate.Year)
                {
                    firstVOYear = visitsDictionary[personRecord.SourceRecordGuid].StartDate.Year;
                    firstYearOfBirth = yearOfBirth.Value;
                }
            }


            // If a person has YEAR_OF_BIRTH that varies over two years then those records are eliminated
            if (maxYearOfBirth - minYearOfBirth > 2)
            {
                return Attrition.MultipleYearsOfBirth;
            }

            var minVOYear = visitOccurrences.Values.Min(vo => vo.StartDate).Year;
            //Person year of birth is after minumum visit start
            if (person.YearOfBirth > minVOYear)
            {
                return Attrition.ImplausibleYOBPast;
            }

            //person.YearOfBirth = minVOYear - person.YearOfBirth;
            person.YearOfBirth = firstYearOfBirth;

            if (person.YearOfBirth < 1900)
                return Attrition.ImplausibleYOBPast;

            if (person.YearOfBirth > DateTime.Now.Year)
                return Attrition.ImplausibleYOBFuture;

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap, observationPeriodsFromVisits.Distinct().ToArray())
                    .ToArray();

            if (observationPeriods.Any(op => op.StartDate < new DateTime(1999, 12, 1)))
            {
                return Attrition.InvalidObservationTime;
            }

            //Delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH
            if (Excluded(person, observationPeriods))
            {
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var payerPlanPeriods =
                CleanUp(BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], visitOccurrences), death).ToArray();

            var drugExposures =
                CleanUp(BuildDrugExposures([.. DrugExposuresRaw], visitOccurrences, observationPeriods), death)
                    .ToArray();
            var conditionOccurrences =
                CleanUp(
                    BuildConditionOccurrences([.. ConditionOccurrencesRaw], visitOccurrences, observationPeriods),
                    death).ToArray();
            var procedureOccurrences =
                CleanUp(
                    BuildProcedureOccurrences([.. ProcedureOccurrencesRaw], visitOccurrences, observationPeriods),
                    death).ToArray();
            var observations =
                CleanUp(BuildObservations([.. ObservationsRaw], visitOccurrences, observationPeriods), death)
                    .ToArray();

            var measurements =
                CleanUp(BuildMeasurement([.. MeasurementsRaw], visitOccurrences, observationPeriods), death)
                    .ToArray();

            var deviceExposure =
                CleanUp(BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods), death)
                    .ToArray();

            // set corresponding ProviderIds
            SetPayerPlanPeriodId(payerPlanPeriods, drugExposures, procedureOccurrences,
                [.. visitOccurrences.Values], deviceExposure);

            var visitCosts = BuildVisitCosts([.. visitOccurrences.Values]).ToArray();
            foreach (var v5 in visitCosts)
            {
                //if (cost.PaidCopay == null && cost.PaidCoinsurance == null && cost.PaidTowardDeductible == null &&
                //   cost.PaidByPayer == null && cost.PaidByCoordinationBenefits == null && cost.TotalOutOfPocket == null &&
                //   cost.TotalPaid == null)
                //   continue;

                var cost52 = new Cost(v5.PersonId)
                {
                    CostId = Offset.GetKeyOffset(v5.PersonId).VisitCostId,

                    Domain = "Visit",
                    EventId = v5.Id,

                    PayerPlanPeriodId = v5.PayerPlanPeriodId,

                    CurrencyConceptId = v5.CurrencyConceptId,
                    TotalCharge = v5.TotalPaid,
                    TotalCost = v5.PaidByPayer,
                    RevenueCodeConceptId = v5.RevenueCodeConceptId,
                    RevenueCodeSourceValue = v5.RevenueCodeSourceValue,
                    DrgConceptId = v5.DrgConceptId ?? 0,
                    DrgSourceValue = v5.DrgSourceValue,

                    TypeId = 32814
                };

                ChunkData.AddCostData(cost52);
            }

            ConditionForEra.Clear();

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death,
                observationPeriods,
                payerPlanPeriods,
                UpdateRSourceConcept(drugExposures).ToArray(),
                UpdateRSourceConcept(conditionOccurrences).ToArray(),
                UpdateRSourceConcept(procedureOccurrences).ToArray(),
                UpdateRSourceConcept(observations).ToArray(),
                UpdateRSourceConcept(measurements).ToArray(),
                [.. visitOccurrences.Values], null, [], UpdateRSourceConcept(deviceExposure).ToArray(),
                [], []);

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

        private static void SetTypeConceptId(IEntity e)
        {
            if (e == null)
                return;

            // vitals
            if (e.TypeConceptId != 32836)
                e.TypeConceptId = 32875;
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
                        ConditionForEra.Add(cond);
                        ChunkData.AddData(cond);
                        break;

                    case "Measurement":
                        var mes = entity as Measurement ??
                                  new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId };

                        SetTypeConceptId(mes);

                        if (mes.SourceValue == "LP17803-5-15")
                            mes.ConceptId = 4179840;

                        if (mes.SourceValue == "LP30736-0-3")
                            mes.ConceptId = 3045688;

                        ChunkData.AddData(mes);
                        AddCost(mes.Id, entity, CostV5ToV51("Measurement"));
                        break;

                    case "Meas Value":
                        var mv = entity as Measurement ??
                                 new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId };

                        SetTypeConceptId(mv);
                        ChunkData.AddData(mv);
                        AddCost(mv.Id, entity, CostV5ToV51("Measurement"));
                        break;

                    case "Observation":
                        var obser = entity as Observation ??
                                    new Observation(entity) { Id = Offset.GetKeyOffset(entity.PersonId).ObservationId };
                        SetTypeConceptId(obser);
                        ChunkData.AddData(obser);
                        AddCost(obser.Id, entity, CostV5ToV51("Observation"));
                        break;

                    case "Procedure":
                        var p = entity as ProcedureOccurrence ??
                                new ProcedureOccurrence(entity)
                                {
                                    Id =
                                        Offset.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
                                };


                        SetTypeConceptId(p);
                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("quantity") &&
                            !string.IsNullOrEmpty(entity.AdditionalFields["quantity"]))
                        {
                            if (decimal.TryParse(entity.AdditionalFields["quantity"], out decimal qty))
                            {
                                p.Quantity = Convert.ToInt32(qty);
                            }
                        }

                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("proc_phy"))
                        {
                            if (int.TryParse(entity.AdditionalFields["proc_phy"], out int providerId) &&
                                providerId != 999999999)
                            {
                                p.ProviderId = providerId;
                            }
                        }

                        if (p.ConceptId == 0 && _covid.Any(code => !string.IsNullOrEmpty(p.SourceValue) && p.SourceValue.StartsWith(code)))
                        {
                            var m = new Measurement(entity)
                            {
                                Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId,
                                ConceptId = 756055
                            };
                            ChunkData.AddData(m);

                            AddCost(m.Id, entity, CostV5ToV51("Measurement"));
                        }
                        else
                        {
                            ChunkData.AddData(p);
                            AddCost(p.Id, entity, CostV5ToV51("Procedure"));
                        }
                        break;

                    case "Device":
                        var dev = entity as DeviceExposure ??
                                  new DeviceExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId
                                  };

                        SetTypeConceptId(dev);
                        ChunkData.AddData(dev);
                        AddCost(dev.Id, entity, CostV5ToV51("Device"));
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity) { Id = Offset.GetKeyOffset(entity.PersonId).DrugExposureId };

                        SetTypeConceptId(drg);

                        if (!drg.EndDate.HasValue)
                            drg.EndDate = drg.StartDate;

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        AddCost(drg.Id, entity, CostV5ToV51("Drug"));
                        break;

                }
            }
        }

        private static Func<ICostV5, Cost> CostV5ToV51(string domain)
        {
            return v5 => new Cost(v5.PersonId)
            {
                CurrencyConceptId = v5.CurrencyConceptId,
                TotalCharge = v5.TotalPaid,
                TotalCost = v5.PaidByPayer,
                RevenueCodeConceptId = v5.RevenueCodeConceptId,
                RevenueCodeSourceValue = v5.RevenueCodeSourceValue,
                DrgConceptId = v5.DrgConceptId ?? 0,
                DrgSourceValue = v5.DrgSourceValue,
                Domain = domain,
                TypeId = 32814,

                PayerPlanPeriodId = v5.PayerPlanPeriodId
            };
        }

        public override bool Excluded(Person person, IEnumerable<ObservationPeriod> periods)
        {
            //Invalid Year Of Birth (Year of Birth after coverage start)
            return periods.Any(period => person.YearOfBirth > period.StartDate.Year);
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

            var ordered = records.OrderByDescending(p => p.StartDate);
            var person = ordered.Take(1).First();
            person.StartDate = ordered.Take(1).Last().StartDate;

            var gender = records[0];

            // if a person has multiple genders that are specified then those records are eliminated.
            if (records.Any(p => p.GenderConceptId != gender.GenderConceptId))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges);
            }

            if (!records.Any(r => r.YearOfBirth < 130))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);
            }

            // YearOfBirth contains age value, YearOfBirth calculated in Build() method 
            var maxYearOfBirth = records.Where(r => r.YearOfBirth < 130).Max(p => p.YearOfBirth);
            person.YearOfBirth = maxYearOfBirth;

            //take the maximum value of race for people that have multiple values 
            var race = records.GroupBy(r => r.RaceSourceValue)
                .OrderByDescending(g => g.Count())
                .First().First();

            var ethnicity = records.GroupBy(r => r.EthnicitySourceValue)
                .OrderByDescending(g => g.Count())
                .First().First();

            person.GenderConceptId = gender.GenderConceptId;
            person.GenderSourceValue = gender.GenderSourceValue;
            person.RaceConceptId = race.RaceConceptId;
            person.RaceSourceValue = race.RaceSourceValue;
            person.EthnicitySourceValue = ethnicity.EthnicitySourceValue;
            person.EthnicityConceptId = ethnicity.EthnicityConceptId;


            if (person.GenderConceptId == 8551) //UNKNOWN
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        public static int TryGetInt(string item)
        {
            bool success = int.TryParse(item, out int i);
            return success ? i : 0;
        }

         public override IEnumerable<DeviceExposure> BuildDeviceExposure(DeviceExposure[] devExposure,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var uniqueEntities = new HashSet<DeviceExposure>(new PatbillDeviceExposureComparer());
            var patbillEntities = new HashSet<DeviceExposure>(new PatbillDeviceExposureComparer());
            foreach (var de in devExposure)
            {
                if (!de.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(de.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[de.VisitOccurrenceId.Value];

                if (de.StartDate == DateTime.MinValue)
                {
                    de.StartDate = visitOccurrence.EndDate.Value;
                }

                if (de.AdditionalFields != null &&
                    de.AdditionalFields.ContainsKey("source") && de.AdditionalFields["source"] == "patbill") // coming from PATBILL
                {
                    patbillEntities.Add(de);
                }
                else
                {
                    uniqueEntities.Add(de);
                }
            }

            foreach (var byGuid in patbillEntities.GroupBy(d => d.SourceRecordGuid))
            {
                foreach (var bySource in byGuid.GroupBy(d => d.SourceValue))
                {
                    foreach (var byStart in bySource.GroupBy(d => d.StartDate))
                    {
                        foreach (var byVisit in byStart.GroupBy(d => d.VisitOccurrenceId))
                        {
                            foreach (var byProvider in byVisit.GroupBy(d => d.ProviderId))
                            {
                                var device = byProvider.OrderBy(d => d.TypeConceptId).FirstOrDefault();
                                uniqueEntities.Add(device);
                            }
                        }
                    }
                }
            }

            return uniqueEntities;
        }

        /// <summary>
        /// 	Projects Enumeration of drug exposure from the raw set of drug exposure entities. 
        /// 	During build:
        ///	override the drug's start date using the end date of the corresponding visit.
        ///	overide TypeConceptId per CDM Mapping spec. 
        /// </summary>
        /// <param name="drugExposures">raw set of drug exposures entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of drug exposure entities</returns>
        public override IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            var patbillEntities = new HashSet<DrugExposure>(new PatbillDrugExposureComparer());
            var otherEntities = new HashSet<DrugExposure>();

            foreach (var drugExposure in drugExposures)
            {
                if (!drugExposure.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(drugExposure.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[drugExposure.VisitOccurrenceId.Value];

                if (drugExposure.StartDate == DateTime.MinValue)
                    drugExposure.StartDate = visitOccurrence.EndDate.Value;

                if (drugExposure.AdditionalFields != null &&
                    drugExposure.AdditionalFields.ContainsKey("source") && drugExposure.AdditionalFields["source"] == "patbill") // coming from PATBILL
                {
                    //SetDate(drugExposure, visitOccurrence, drugExposure.AdditionalFields["serv_day"]);

                    patbillEntities.Add(drugExposure);
                }
                else //patcpt or paticd
                {
                    otherEntities.Add(drugExposure);
                }
            }

            foreach (var patbillEntity in patbillEntities)
            {
                yield return patbillEntity;
            }

            foreach (var uniqueEntity in otherEntities)
            {
                yield return uniqueEntity;
            }
        }


        /// <summary>
        /// Projects Enumeration of ConditionOccurrence from the raw set of ConditionOccurrence entities. 
        /// 	During build:
        /// 	override the condition's start date using the end date of the corresponding visit.
        /// </summary>
        /// <param name="conditionOccurrences">raw set of condition occurrence entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of condition occurrence entities</returns>
        public override IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
            ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var patbillEntities = new HashSet<ConditionOccurrence>(new PatbillConditionOccurrenceComparer());
            var uniqueEntities = new HashSet<ConditionOccurrence>();
            foreach (var conditionOccurrence in conditionOccurrences)
            {
                if (!conditionOccurrence.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(conditionOccurrence.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[conditionOccurrence.VisitOccurrenceId.Value];

                if (conditionOccurrence.StartDate == DateTime.MinValue)
                    conditionOccurrence.StartDate = visitOccurrence.StartDate;

                if (conditionOccurrence.AdditionalFields != null &&
                    conditionOccurrence.AdditionalFields.ContainsKey("source") && conditionOccurrence.AdditionalFields["source"] == "patbill") // coming from PATBILL
                {
                    //SetDate(conditionOccurrence, visitOccurrence, conditionOccurrence.AdditionalFields["serv_day"]);

                    patbillEntities.Add(conditionOccurrence);
                }
                else //patcpt or paticd
                {
                    uniqueEntities.Add(conditionOccurrence);
                }
            }

            foreach (var patbillEntity in patbillEntities)
            {
                yield return patbillEntity;
            }

            foreach (var uniqueEntity in uniqueEntities)
            {
                yield return uniqueEntity;
            }
        }

        /// <summary>
        /// Projects Enumeration of ProcedureOccurrence from the raw set of ProcedureOccurence entities.
        /// During build:
        /// override the procedure's start date using the end date of the corresponding visit.
        /// overide TypeConceptId per CDM Mapping spec. 
        /// </summary>
        /// <param name="procedureOccurrences">raw set of procedure occurrence entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of procedure occurrence entities</returns>
        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var uniqueEntities = new HashSet<ProcedureOccurrence>(new PatbillProcedureOccurrenceComparer());
            foreach (var procedureOccurrence in procedureOccurrences)
            {
                if (!procedureOccurrence.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(procedureOccurrence.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[procedureOccurrence.VisitOccurrenceId.Value];

                if (procedureOccurrence.StartDate == DateTime.MinValue)
                {
                    procedureOccurrence.StartDate = visitOccurrence.EndDate.Value;
                }

                uniqueEntities.Add(procedureOccurrence);
            }

            return uniqueEntities;
        }

        /// <summary>
        /// Projects Enumeration of payerPlanPeriod from the raw set of payerPlanPeriod entities.
        /// </summary>
        /// <param name="payerPlanPeriods">raw set of payerPlanPeriod entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <returns>Enumeration of payerPlanPeriod entities</returns>
        public override IEnumerable<PayerPlanPeriod> BuildPayerPlanPeriods(PayerPlanPeriod[] payerPlanPeriods,
            Dictionary<long, VisitOccurrence> visitOccurrences)
        {

            var ppp = new List<PayerPlanPeriod>();
            foreach (var pp in payerPlanPeriods)
            {
                if (!pp.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(pp.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[pp.VisitOccurrenceId.Value];

                pp.StartDate = visitOccurrence.StartDate;
                pp.EndDate = visitOccurrence.EndDate;

                ppp.Add(pp);
            }

            var result = new List<PayerPlanPeriod>();
            foreach (
                var currentPeriod in ppp.OrderBy(p => p.StartDate).ThenBy(p => p.EndDate)
                    .ThenBy(p => p.PayerSourceValue))
            {
                if (result.Count == 0)
                {
                    result.Add(currentPeriod);
                    continue;
                }

                if (result.Last().PayerSourceValue == currentPeriod.PayerSourceValue) // IF PLAN DOESN'T CHANGE
                {
                    // IF THERE IS A GAP
                    if (currentPeriod.StartDate.Subtract(result.Last().EndDate.Value).Days > 32)
                    {
                        result.Add(currentPeriod);
                    }
                    else // IF THERE IS NO GAP
                    {
                        result.Last().EndDate = currentPeriod.EndDate;
                    }
                }
                else
                {
                    //3.	If plan 1 end date is greater or equal or plan 2 end date, we will drop those records, and only use the first one. 
                    if (result.Last().EndDate >= currentPeriod.EndDate)
                    {
                        continue;
                    }

                    //1.	If a person has different payers with plan 1 end date that is less than plan 2 end date and if plan 2 start date is less than or equal to plan 1 end date +1 then plan 2 visit start date will equal plan 1 visit end +1.
                    //2.	The second change is when there is an overlap of two periods, we will keep the entire first payer plan period, and then increment the next start date by one day so there is no overlap.
                    if (result.Last().EndDate < currentPeriod.EndDate &&
                        currentPeriod.StartDate <= result.Last().EndDate.Value.AddDays(1))
                    {
                        currentPeriod.StartDate = result.Last().EndDate.Value.AddDays(1);
                    }

                    result.Add(currentPeriod);
                }
            }

            foreach (var payerPlanPeriod in result)
            {
                payerPlanPeriod.Id = Offset.GetKeyOffset(payerPlanPeriod.PersonId).PayerPlanPeriodId;

                if (payerPlanPeriod.EndDate < payerPlanPeriod.StartDate)
                    payerPlanPeriod.EndDate = payerPlanPeriod.StartDate;

                yield return payerPlanPeriod;
            }
        }

        /// <summary>
        /// Projects death entity from the raw set of death entities.
        /// During build:
        /// override the death's start date using the end date of the corresponding visit.
        /// </summary>
        /// <param name="inputDeaths">raw set of death entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>death entity</returns>
        public override Death BuildDeath(Death[] inputDeaths, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var deaths = inputDeaths.ToList();
            if (deaths.Count > 0)
            {
                deaths.RemoveAll(
                    d => !d.VisitOccurrenceId.HasValue || !visitOccurrences.ContainsKey(d.VisitOccurrenceId.Value));

                if (deaths.Count > 0)
                {
                    foreach (var death in deaths)
                    {
                        death.StartDate = visitOccurrences[death.VisitOccurrenceId.Value].EndDate.Value;
                    }

                    // Keep only one record for each patient, if both discharge status and ICD9 codes indicate death, use discharge status first
                    var primary_deaths = deaths.Where(d => d.Primary).ToList();
                    return primary_deaths.Count != 0
                        ? primary_deaths.OrderBy(d => d.StartDate).First()
                        : deaths.OrderBy(d => d.StartDate).First();
                }
            }

            return null;
        }

        /// <summary>
        /// Projects Enumeration of Observations from the raw set of Observation entities. 
        /// During build:
        /// override the observations start date using the start date of the corresponding visit.
        /// </summary>
        /// <param name="observations">raw set of observations entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Observation from the raw set of Observation entities</returns>
        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            var uniqueEntities = new HashSet<Observation>();
            var patbillEntities = new HashSet<Observation>(new PatbillObservationComparer());
            foreach (var observation in observations)
            {
                var valueAsStringConceptIds = new long[] { 4053609, 40757183, 40757177, 40769091 };
                if (valueAsStringConceptIds.Any(c => c == observation.ConceptId) &&
                    string.IsNullOrEmpty(observation.ValueAsString))
                {
                    continue;
                }

                if (!observation.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(observation.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[observation.VisitOccurrenceId.Value];

                if (observation.StartDate == DateTime.MinValue)
                    observation.StartDate = visitOccurrence.StartDate;

                // operation time
                if (observation.ConceptId == 3016562)
                    observation.UnitsConceptId = 8550;

                if (observation.AdditionalFields != null &&
                    observation.AdditionalFields.ContainsKey("source") && observation.AdditionalFields["source"] == "patbill") // coming from PATBILL
                {
                    //SetDate(observation, visitOccurrence, observation.AdditionalFields["serv_day"]);

                    patbillEntities.Add(observation);

                }
                else //patcpt or paticd
                {
                    //observation.StartDate = visitOccurrence.StartDate;

                    uniqueEntities.Add(observation);
                }
            }

            foreach (var patbillEntity in patbillEntities)
            {
                yield return patbillEntity;
            }

            foreach (var uniqueEntity in uniqueEntities)
            {
                yield return uniqueEntity;
            }
        }

        private static IEnumerable<Measurement> HandleSurgeryMeasurements(IEnumerable<Measurement> measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            foreach (var samePatKey in measurements.GroupBy(m => m.VisitOccurrenceId))
            {
                var sameDaySurgery = new Dictionary<string, List<Measurement>>();

                foreach (var m in samePatKey)
                {
                    var day = m.StartDate.ToShortDateString();

                    if (!m.VisitOccurrenceId.HasValue) continue;
                    if (!visitOccurrences.ContainsKey(m.VisitOccurrenceId.Value)) continue;

                    if (!sameDaySurgery.ContainsKey(day))
                        sameDaySurgery.Add(day, []);

                    sameDaySurgery[day].Add(m);
                }

                foreach (var surgeryDay in sameDaySurgery.Keys)
                {
                    var icd = new Dictionary<string, Measurement>();
                    var totalMinutes = new HashSet<decimal>();

                    foreach (var m in sameDaySurgery[surgeryDay])
                    {
                        if (m.AdditionalFields.ContainsKey("icd_code"))
                        {
                            var icdcode = m.AdditionalFields["icd_code"];
                            if (!string.IsNullOrEmpty(icdcode) && !icd.ContainsKey(icdcode))
                            {
                                icd.Add(icdcode, m);
                            }
                        }

                        if (m.AdditionalFields.ContainsKey("quantity"))
                        {
                            decimal.TryParse(m.AdditionalFields["quantity"], out decimal quantity);
                            var min = GetMinutes(m.AdditionalFields["std_chg_desc"]);
                            totalMinutes.Add(quantity * min);
                        }
                    }

                    foreach (var measurement in icd.Values)
                    {
                        //Logger.Write(null, LogMessageTypes.Debug, "*** 4) " + totalMinutes.Sum());
                        if (totalMinutes.Sum() <= 0) continue;
                        measurement.ValueAsNumber = totalMinutes.Sum();

                        yield return measurement;
                    }
                }
            }
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var uniqueEntities = new HashSet<Measurement>(new PatbillMeasurementComparer());
            var surgeryEntities = new List<Measurement>();
            foreach (var m in measurements)
            {
                if (!m.VisitOccurrenceId.HasValue) continue;
                if (!visitOccurrences.ContainsKey(m.VisitOccurrenceId.Value)) continue;

                var visitOccurrence = visitOccurrences[m.VisitOccurrenceId.Value];

                if (m.TypeConceptId == 45754907)
                {
                    m.StartDate = visitOccurrence.StartDate;
                    m.UnitConceptId = 8550;
                    surgeryEntities.Add(m);
                    continue;
                }

                if (m.StartDate == DateTime.MinValue)
                {
                    m.StartDate = visitOccurrence.EndDate.Value;
                }

                uniqueEntities.Add(m);
            }

            foreach (var surgeryMeasurement in HandleSurgeryMeasurements(surgeryEntities, visitOccurrences))
            {
                yield return surgeryMeasurement;
            }

            foreach (var measurement in uniqueEntities)
            {
                yield return measurement;
            }
        }


        /// <summary>
        /// Exclude records with start date after person death date
        /// </summary>
        /// <typeparam name="T">IEntity</typeparam>
        /// <param name="items">the set of entities for filtration</param>
        /// <param name="death">the death entity for current person</param>
        /// <returns>Enumeration of records prior to person death date</returns>
        private static IEnumerable<T> CleanUp<T>(IEnumerable<T> items, IEntity death) where T : IEntity
        {
            if (items == null) yield break;
            foreach (var item in items)
            {
                if (death == null)
                {
                    yield return item;
                }
                // No records should be populated for that person 32 days after the death date
                else if (item.StartDate < death.StartDate.AddDays(32))
                {
                    yield return item;
                }
            }
        }

        public static int GetMinutes(string description)
        {
            if (string.IsNullOrEmpty(description)) return 0;

            var words = description.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            string hr = null;
            string min = null;

            for (int i = 0; i < words.Length; i++)
            {
                if (string.Equals("hr", words[i], StringComparison.InvariantCultureIgnoreCase))
                {
                    hr = words[i - 1];
                }
                else if (string.Equals("min", words[i], StringComparison.InvariantCultureIgnoreCase))
                {
                    min = words[i - 1];
                }
            }

            int totalMinutes = 0;
            if (!string.IsNullOrEmpty(hr))
            {
                if (int.TryParse(hr, out int h))
                    totalMinutes = 60 * h;
                else
                    totalMinutes = 60;
            }

            if (!string.IsNullOrEmpty(min))
            {
                if (int.TryParse(min, out int m))
                    totalMinutes += m;
            }

            return totalMinutes;
        }

        #endregion
    }
}
