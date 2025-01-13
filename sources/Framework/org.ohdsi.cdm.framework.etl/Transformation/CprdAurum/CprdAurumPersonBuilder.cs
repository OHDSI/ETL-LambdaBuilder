using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.framework.etl.Transformation.CprdAurum
{
    public class CprdAurumPersonBuilder : PersonBuilder
    {
        #region Classes

        public class CprdAurumVendor : Vendor
        {
            public override DateTime? SourceReleaseDate { get; set; }

            public override string Name => "CprdAurum";
            public override string Folder => "CprdAurum";
            public override string Description => "CPRD Aurum v5.4";
            public override string CdmSource => "CdmSource.sql";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "patient";
            public override string Citation => "";
            public override string Publication => "No review required";
        }

        #endregion

        #region Constructors

        public CprdAurumPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not CprdAurumVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var filtered = records.Where(p =>
                p.GenderConceptId != 8551 &&
                p.AdditionalFields["acceptable"] == "1").ToArray();

            if (filtered.Length == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = filtered.OrderByDescending(p => p.StartDate);
            var person = ordered.Take(1).First();


            if (person.GenderConceptId == 8551)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            // male - 8507, female - 8532
            // If a person's gender changes (male to female or female to male) at any point in their record then exclude.
            if (person.GenderConceptId == 8507 && filtered.Any(p => p.GenderConceptId == 8532))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges);
            }

            if (person.GenderConceptId == 8532 && filtered.Any(p => p.GenderConceptId == 8507))
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.GenderChanges);
            }


            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        public override IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
        {
            foreach (var op in observationPeriods)
            {
                if (op.EndDate.Value < op.StartDate)
                    op.EndDate = op.StartDate;
            }

            return base.BuildObservationPeriods(0, observationPeriods);
        }

        public override IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
            ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildConditionOccurrences(conditionOccurrences, visitOccurrences,
                observationPeriods))
            {

                yield return ent;
            }
        }

        public override IEnumerable<DeviceExposure> BuildDeviceExposure(DeviceExposure[] devExposure,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildDeviceExposure(devExposure, visitOccurrences, observationPeriods))
            {
                yield return ent;
            }
        }

        public override IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildDrugExposures(drugExposures, visitOccurrences, observationPeriods))
            {
                yield return ent;
            }
        }


        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildMeasurement(measurements, visitOccurrences, observationPeriods))
            {
                if (decimal.TryParse(ent.ValueSourceValue, out decimal valueAsNumber))
                    ent.ValueAsNumber = valueAsNumber;

                yield return ent;
            }
        }


        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildObservations(observations, visitOccurrences, observationPeriods))
            {
                yield return ent;
            }
        }

        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var ent in base.BuildProcedureOccurrences(procedureOccurrences, visitOccurrences,
                observationPeriods))
            {
                yield return ent;
            }
        }

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails,
          VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {

            foreach (var visitOccurrence in visitOccurrences)
            {
                long? visitDetailParentId = null;
                if (visitOccurrence.AdditionalFields != null && visitOccurrence.AdditionalFields.ContainsKey("parentobsid"))
                {
                    if (long.TryParse(visitOccurrence.AdditionalFields["parentobsid"], out var parentId))
                        visitDetailParentId = parentId;
                }

                var visitDetail =
                new VisitDetail(visitOccurrence)
                {
                    Id = visitOccurrence.Id,
                    CareSiteId = visitOccurrence.CareSiteId,
                    VisitDetailParentId = visitDetailParentId
                };

                yield return visitDetail;
            }
        }

        protected static void SetVisitOccurrenceId<T>(IEnumerable<T> inputRecords, IEnumerable<VisitOccurrence> visitOccurrence)
      where T : class, IEntity
        {
            foreach (var e in inputRecords)
            {
                var vo = visitOccurrence.FirstOrDefault(v => v.SourceRecordGuid == e.SourceRecordGuid);
                if (vo != null)
                {
                    e.VisitOccurrenceId = vo.Id;
                    continue;
                }

                var vo1 = visitOccurrence.FirstOrDefault(v => v.StartDate == e.StartDate);
                if (vo1 != null)
                {
                    e.VisitOccurrenceId = vo1.Id;
                    continue;
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

            var visitDetails = new Dictionary<long, VisitDetail>();
            var visitDetIds = new List<long>();
            foreach (var vd in BuildVisitDetails(null, VisitOccurrencesRaw.Where(vo =>
                    vo.StartDate.Year >= person.YearOfBirth &&
                    vo.EndDate.Value.Year >= person.YearOfBirth &&
                    vo.StartDate.Year <= DateTime.Now.Year &&
                    vo.EndDate.Value.Year <= DateTime.Now.Year).ToArray(), observationPeriods).ToArray())
            {
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


            if (person.YearOfBirth < 1900)
                return Attrition.ImplausibleYOBPast;

            if (person.YearOfBirth > DateTime.Now.Year)
                return Attrition.ImplausibleYOBFuture;

            SetVisitOccurrenceId(ConditionOccurrencesRaw, visitOccurrences.Values);
            SetVisitOccurrenceId(ProcedureOccurrencesRaw, visitOccurrences.Values);
            SetVisitOccurrenceId(DrugExposuresRaw, visitOccurrences.Values);
            SetVisitOccurrenceId(DeviceExposureRaw, visitOccurrences.Values);
            SetVisitOccurrenceId(ObservationsRaw, visitOccurrences.Values);
            SetVisitOccurrenceId(MeasurementsRaw, visitOccurrences.Values);

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
                BuildDeviceExposure([.. DeviceExposureRaw], visitOccurrences, observationPeriods).ToArray();

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);

            if (death != null)
            {
                person.TimeOfDeath = death.StartDate;

                if (death.StartDate < observationPeriods.Min(op => op.StartDate))
                    return Attrition.UnacceptablePatientQuality;

                if (death.StartDate.Year < person.YearOfBirth || death.StartDate.Year > DateTime.Now.Year)
                    death = null;
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death, observationPeriods, [], drugExposures,
                conditionOccurrences, procedureOccurrences, observations, measurements,
                [.. visitOccurrences.Values], [.. visitDetails.Values], [], deviceExposure, [], []);


            return Attrition.None;
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
                        cond.TypeConceptId = 43542353;
                        ConditionForEra.Add(cond);
                        ChunkData.AddData(cond);


                        break;

                    case "Measurement":
                        ChunkData.AddData(entity as Measurement ?? new Measurement(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId,
                            TypeConceptId = 44818702,
                            OperatorConceptId = 4172703 // TMP Add to ATD
                        });
                        break;


                    case "Observation":
                        ChunkData.AddData(entity as Observation ?? new Observation(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).ObservationId,
                            TypeConceptId = 38000280
                        });
                        break;

                    case "Procedure":
                        ChunkData.AddData(entity as ProcedureOccurrence ??
                                          new ProcedureOccurrence(entity)
                                          {
                                              Id =
                                                  Offset.GetKeyOffset(entity.PersonId)
                                                      .ProcedureOccurrenceId,
                                              TypeConceptId = 38000267
                                          });
                        break;

                    case "Device":
                        ChunkData.AddData(entity as DeviceExposure ??
                                          new DeviceExposure(entity)
                                          {
                                              Id = Offset.GetKeyOffset(entity.PersonId).DeviceExposureId,
                                              TypeConceptId = 44818707
                                          });
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity)
                                  {
                                      Id = Offset.GetKeyOffset(entity.PersonId).DrugExposureId,
                                      TypeConceptId = 38000177,
                                      EndDate = entity.StartDate.AddDays(29)
                                  };

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;
                }
            }
        }

        #endregion
    }
}
