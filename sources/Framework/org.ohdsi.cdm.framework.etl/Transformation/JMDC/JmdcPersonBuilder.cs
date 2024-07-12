using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.framework.etl.Transformation.JMDC
{
    public class JmdcPersonBuilder : PersonBuilder
    {
        #region Classes

        public class JmdcVendor : Vendor
        {
            public override string Name => "JMDC";
            public override string Folder => "JMDC";
            public override string Description => "JMDC v5.4";
            public override string CdmSource => "";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "Enrollment";
            public override string Citation => "";
            public override string Publication => @"When sending a manuscript for publication, the external data disclosure form must be filled out and sent to JMDC for approval. It can be found on the rwe catalog under ""Contracts and Licenses"". https://catalog.rwe.jnj.com/index#jnjexplore?dataSetUri=%2Fdataset%2F06d7e4d1-6000-4779-bdc9-16ace880912a.xml";
        }

        #endregion

        #region Fields

        readonly Dictionary<long, DateTime> _visitsDate = [];
        readonly Dictionary<long, DateTime> _visitsDateDiagnosis = [];
        readonly Dictionary<long, VisitOccurrence> _pharmacyVisits = [];

        #endregion

        #region Constructors

        public JmdcPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not JmdcVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods

        private void SetStartDate(Dictionary<long, VisitOccurrence> visitOccurrences, IEntity entity)
        {
            if (entity.StartDate == DateTime.MinValue && entity.VisitOccurrenceId.HasValue)
            {
                if (visitOccurrences.ContainsKey(entity.VisitOccurrenceId.Value))
                {
                    entity.StartDate = visitOccurrences[entity.VisitOccurrenceId.Value].StartDate;
                }
                else if (_pharmacyVisits.ContainsKey(entity.VisitOccurrenceId.Value))
                {
                    entity.StartDate = _pharmacyVisits[entity.VisitOccurrenceId.Value].StartDate;
                    entity.VisitOccurrenceId = null;
                }
            }
        }

        public override IEnumerable<VisitOccurrence> BuildVisitOccurrences(VisitOccurrence[] visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var visitOccurrence in visitOccurrences)
            {
                if (_visitsDate.ContainsKey(visitOccurrence.Id))
                {
                    visitOccurrence.StartDate = _visitsDate[visitOccurrence.Id];
                }
                else if (_visitsDateDiagnosis.ContainsKey(visitOccurrence.Id))
                {
                    if (visitOccurrence.StartDate.Year == _visitsDateDiagnosis[visitOccurrence.Id].Year &&
                        visitOccurrence.StartDate.Month == _visitsDateDiagnosis[visitOccurrence.Id].Month)
                    {
                        visitOccurrence.StartDate = _visitsDateDiagnosis[visitOccurrence.Id];
                    }
                }

                var daysValue = visitOccurrence.AdditionalFields["num_of_days"];
                var days = string.IsNullOrEmpty(daysValue) ? 0 : int.Parse(daysValue);

                visitOccurrence.EndDate = visitOccurrence.StartDate;

                if (days > 0)
                {
                    visitOccurrence.EndDate = visitOccurrence.StartDate.AddDays(days - 1);
                }
            }

            foreach (var visitOccurrence in base.BuildVisitOccurrences(visitOccurrences, observationPeriods))
            {
                if (visitOccurrence.SourceValue.Equals("pharmacy", StringComparison.CurrentCultureIgnoreCase))
                {
                    _pharmacyVisits.Add(visitOccurrence.Id, visitOccurrence);
                    continue;
                }

                yield return visitOccurrence;
            }
        }

        public override Death BuildDeath(Death[] death, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            // Enrollment - TypeConceptId = 32815
            // Diagnosis.Type_of_claim = 'DPC' and Diagnosis.Outcome in (6,7) - TypeConceptId = 1
            // Diagnosis.Type_of_claim != 'DPC' and Diagnosis.Outcome = 3 - TypeConceptId = 2
            if (death.Any(d => d.TypeConceptId == 32815 || d.TypeConceptId == 1 || d.TypeConceptId == 2))
            {
                foreach (var d in death)
                {
                    if (d.TypeConceptId != 32815)
                        d.TypeConceptId = 32812;

                    if (d.TypeConceptId == 32812 && d.VisitOccurrenceId.HasValue &&
                        visitOccurrences.ContainsKey(d.VisitOccurrenceId.Value))
                    {
                        d.StartDate = visitOccurrences[d.VisitOccurrenceId.Value].EndDate.Value;
                    }
                }

                return base.BuildDeath(death, visitOccurrences, observationPeriods);
            }

            return null;
        }

        private static IEnumerable<ConditionOccurrence> CleanupConditions(
            IEnumerable<ConditionOccurrence> conditionOccurrences)
        {
            foreach (var co in conditionOccurrences)
            {
                // This flag indicates that a test is being order to determine whether indeed the diagnosis is correct. 
                // A later record should confirm if it is, and the [month and year of start of medical care] will inform us what the right date of onset is, as already implements
                if (co.AdditionalFields != null && co.AdditionalFields.ContainsKey("suspicion_flag") &&
                    co.AdditionalFields["suspicion_flag"] == "1")
                    continue;

                yield return co;
            }
        }

        /*
          *	Projects Enumeration of ConditionOccurrence from the raw set of ConditionOccurrence entities. 
          *	During build:
          *		override the condition's start date using the end date of the corresponding visit.
          *		overide TypeConceptId per CDM Mapping spec. 
          *	
          */
        public override IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
            ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var annualHealthCheckups = conditionOccurrences.Where(co => co.TypeConceptId == 32836).ToArray();
            var others = conditionOccurrences.Where(co => co.TypeConceptId != 32836).ToArray();

            foreach (var co in others)
            {
                //DateTime dateOfMedicalCare;
                if (co.StartDate == DateTime.MinValue && co.VisitOccurrenceId.HasValue &&
                    visitOccurrences.ContainsKey(co.VisitOccurrenceId.Value))
                    co.StartDate = visitOccurrences[co.VisitOccurrenceId.Value].StartDate;

                co.EndDate = null;
            }

            var conditions =
                CleanupConditions(BuildEntities(others, visitOccurrences, observationPeriods, false))
                    .ToArray();

            foreach (var sameProviderId in conditions.GroupBy(c => c.ProviderId))
            {
                foreach (var sameSourceValue in sameProviderId.GroupBy(c => c.SourceValue))
                {
                    foreach (var episode in sameSourceValue.GroupBy(c => c.AdditionalFields["month_and_year_of_start"]))
                    {
                        var parentCondition = episode.FirstOrDefault();

                        if (string.IsNullOrEmpty(parentCondition?.AdditionalFields["start_m_and_y_date"])) continue;
                        if (!parentCondition.VisitOccurrenceId.HasValue ||
                            !visitOccurrences.ContainsKey(parentCondition.VisitOccurrenceId.Value)) continue;

                        var endDate = episode.Max(c => c.StartDate);
                        var startOfMedicalCare = DateTime.Parse(parentCondition.AdditionalFields["start_m_and_y_date"]);

                        var newCondition = new ConditionOccurrence(parentCondition)
                        {
                            Id = Offset.GetKeyOffset(parentCondition.PersonId).ConditionOccurrenceId,
                            VisitOccurrenceId = null,
                            //TypeConceptId = 38000246,
                            EndDate = endDate,
                            StartDate = startOfMedicalCare
                        };

                        if (startOfMedicalCare <
                            observationPeriods[0].StartDate)
                        {
                            newCondition.StartDate = observationPeriods[0].StartDate;
                        }

                        if (newCondition.StartDate > DateTime.MinValue && newCondition.StartDate < newCondition.EndDate)
                        {
                            yield return newCondition;
                        }
                    }
                }
            }

            foreach (var co in conditions)
            {
                yield return co;
            }

            foreach (var co in annualHealthCheckups)
            {
                co.EndDate = co.StartDate;
                yield return co;
            }
        }


        /*
         *	Projects Enumeration of ProcedureOccurrence from the raw set of ProcedureOccurence entities. 
         *	During build:
         *		override the procedure's start date using the end date of the corresponding visit.
         *		overide TypeConceptId per CDM Mapping spec. 
         *	
         */
        public override IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var procedures = new List<ProcedureOccurrence>();
            foreach (var row in procedureOccurrences.GroupBy(e => e.SourceRecordGuid))
            {
                var icd9proc = row.FirstOrDefault(r => r.TypeConceptId == 0 && r.ConceptId > 0);
                var jnjProcedures = row.FirstOrDefault(r => r.TypeConceptId == 1 && r.ConceptId > 0);

                ProcedureOccurrence procedure;
                if (icd9proc != null)
                {
                    procedure = icd9proc;
                }
                else if (jnjProcedures != null)
                {
                    procedure = jnjProcedures;
                }
                else
                {
                    procedure = row.FirstOrDefault(r => !string.IsNullOrWhiteSpace(r.SourceValue));

                    procedure ??= row.FirstOrDefault();
                }

                procedure.TypeConceptId = int.Parse(procedure.AdditionalFields["procedure_type_concept_id"]);
                SetStartDate(visitOccurrences, procedure);
                procedures.Add(procedure);
            }

            return BuildEntities(procedures, visitOccurrences, observationPeriods, false);
        }

        /*
          *	Projects Enumeration of ConditionOccurrence from the raw set of ConditionOccurrence entities. 
          *	During build:
          *		override the condition's start date using the end date of the corresponding visit.
          *		overide TypeConceptId per CDM Mapping spec. 
          *	
          */
        public override IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var de in drugExposures)
            {
                SetStartDate(visitOccurrences, de);

                var daysSupply = de.DaysSupply ?? 1;
                de.EndDate = de.StartDate.AddDays(daysSupply - 1);
            }

            return BuildEntities(drugExposures, visitOccurrences, observationPeriods, false);
        }

        public override IEnumerable<VisitCost> BuildVisitCosts(VisitOccurrence[] visitOccurrences)
        {
            foreach (var c in base.BuildVisitCosts(visitOccurrences).Where(vc => vc.TotalPaid.HasValue))
            {
                ChunkData.AddCostData(new Cost(c.PersonId)
                {
                    CostId = Offset.GetKeyOffset(c.PersonId).VisitCostId,
                    CurrencyConceptId = c.CurrencyConceptId,
                    TypeId = 5031,
                    Domain = "Visit",
                    EventId = c.Id,
                    TotalPaid = c.TotalPaid
                });

                yield return c;
            }
        }

        public override IEnumerable<DrugCost> BuildDrugCosts(DrugExposure[] drugExposures)
        {
            foreach (var c in base.BuildDrugCosts(drugExposures))
            {
                ChunkData.AddCostData(new Cost(c.PersonId)
                {
                    CostId = Offset.GetKeyOffset(c.PersonId).VisitCostId,
                    CurrencyConceptId = c.CurrencyConceptId,
                    TypeId = 5032,
                    Domain = "Drug",
                    EventId = c.Id,
                    TotalPaid = c.TotalPaid,
                    TotalCharge = c.PaidByCoordinationBenefits
                });

                yield return c;
            }
        }

        public override IEnumerable<ProcedureCost> BuildProcedureCosts(ProcedureOccurrence[] procedureOccurrences)
        {
            foreach (var c in base.BuildProcedureCosts(procedureOccurrences))
            {
                ChunkData.AddCostData(new Cost(c.PersonId)
                {
                    CostId = Offset.GetKeyOffset(c.PersonId).VisitCostId,
                    CurrencyConceptId = c.CurrencyConceptId,
                    TypeId = 5032,
                    Domain = "Procedure",
                    EventId = c.Id,
                    TotalPaid = c.TotalPaid,
                    TotalCharge = c.PaidByCoordinationBenefits
                });

                yield return c;
            }
        }

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            //"If the claim is associated with a diagnosis, " +
            //"and (1) that [Diagnosis].[Month and year of start of medical care] date falls within the [Month and year of medical care] and (2) " +
            //"there is no other diagnoses with the same level 4 ICD-10 code from the same institution for the same member with the same [Month and year of start of medical care] date, " +
            //"then the [Month and year of start of medical care] date is used as the visit_start_date."
            foreach (var sameSource in ConditionOccurrencesRaw
                .Where(c => c.TypeConceptId != 32836 && c.AdditionalFields != null && !string.IsNullOrEmpty(c.AdditionalFields["start_m_and_y_date"]))
                .GroupBy(c => c.SourceValue))
            {
                foreach (var sameInstitution in sameSource.GroupBy(c => c.ProviderId))
                {
                    foreach (var sameStartOfMedicalCare in sameInstitution.GroupBy(c =>
                        c.AdditionalFields["month_and_year_of_start"]))
                    {
                        var diagnosis = sameStartOfMedicalCare.ToList();
                        if (diagnosis.Count == 1)
                        {
                            if (!_visitsDateDiagnosis.ContainsKey(diagnosis[0].VisitOccurrenceId.Value))
                            {
                                _visitsDateDiagnosis.Add(diagnosis[0].VisitOccurrenceId.Value,
                                    DateTime.Parse(diagnosis[0].AdditionalFields["start_m_and_y_date"]));
                            }
                            else
                            {
                                var newValue = DateTime.Parse(diagnosis[0].AdditionalFields["start_m_and_y_date"]);

                                if (_visitsDateDiagnosis[diagnosis[0].VisitOccurrenceId.Value] < newValue)
                                    _visitsDateDiagnosis[diagnosis[0].VisitOccurrenceId.Value] = newValue;
                            }
                        }
                    }
                }
            }


            //If the claim is associated with a Drug.[Prescription date] or  Procedure.[Procedure date], use the minimum of those dates as the visit_start_date.
            foreach (var p in ProcedureOccurrencesRaw.GroupBy(p => p.VisitOccurrenceId))
            {
                var procedure = p.First();
                if (!procedure.VisitOccurrenceId.HasValue) continue;

                var procedures = p.Where(pp => pp.StartDate > DateTime.MinValue).ToArray();

                if (procedures.Length > 0)
                {
                    var minProcedureDate = procedures.Min(pp => pp.StartDate);

                    if (_visitsDate.ContainsKey(procedure.VisitOccurrenceId.Value))
                    {
                        _visitsDate[procedure.VisitOccurrenceId.Value] = minProcedureDate;
                        continue;
                    }

                    _visitsDate.Add(procedure.VisitOccurrenceId.Value, minProcedureDate);
                }
            }

            foreach (var d in DrugExposuresRaw.GroupBy(d => d.VisitOccurrenceId))
            {
                var drug = d.First();
                if (!drug.VisitOccurrenceId.HasValue) continue;

                var drugs = d.Where(dd => dd.StartDate > DateTime.MinValue).ToArray();

                if (drugs.Length > 0)
                {
                    var minDrugDate = drugs.Min(dd => dd.StartDate);

                    if (!_visitsDate.ContainsKey(drug.VisitOccurrenceId.Value))
                    {
                        _visitsDate.Add(drug.VisitOccurrenceId.Value, minDrugDate);
                        continue;
                    }

                    // [Date of prescription] < [Date of procedure]
                    // minDrugDate < visitsDate[drug.VisitOccurrenceId.Value]
                    if (minDrugDate < _visitsDate[drug.VisitOccurrenceId.Value])
                    {
                        _visitsDate[drug.VisitOccurrenceId.Value] = minDrugDate;
                    }
                }
            }

            return base.Build(data, o);
        }

        public override IEnumerable<T> BuildEntities<T>(IEnumerable<T> entitiesToBuild, IDictionary<long, VisitOccurrence> visitOccurrences, IEnumerable<ObservationPeriod> observationPeriods, bool withinTheObservationPeriod)
        {
            var uniqueEntities = new HashSet<T>();
            foreach (var e in Clean(entitiesToBuild, observationPeriods, withinTheObservationPeriod))
            {
                if (e.VisitOccurrenceId.HasValue && _pharmacyVisits.ContainsKey(e.VisitOccurrenceId.Value))
                {
                    e.VisitOccurrenceId = null;
                }

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

        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var o in base.BuildObservations(observations, visitOccurrences, observationPeriods))
            {
                //if (string.IsNullOrEmpty(o.ValueAsString) && !o.ValueAsNumber.HasValue &&
                //    (!o.ValueAsConceptId.HasValue || o.ValueAsConceptId == 0)) continue;

                yield return o;
            }
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var measurement in measurements)
            {
                if (decimal.TryParse(measurement.ValueSourceValue, out decimal valueAsNumber))
                    measurement.ValueAsNumber = valueAsNumber;
            }

            return base.BuildMeasurement(measurements, visitOccurrences, observationPeriods);
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
                                           Id = Offset.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                       };
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        //if (entity.TypeConceptId != 38000246)
                        {
                            var mes = entity as Measurement ??
                                      new Measurement(entity)
                                      {
                                          Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                                      };


                            //var result = Vocabulary.Lookup(mes.SourceValue, "JMDC-ICD10-MapsToValue", DateTime.MinValue, false);
                            var result = Vocabulary.Lookup(mes.SourceValue, "JMDC-ICD10-MapsToValue", DateTime.MinValue);
                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                            {
                                mes.ValueAsConceptId = result[0].ConceptId.Value;
                            }

                            ChunkData.AddData(mes);
                        }

                        break;

                    case "Meas Value":
                        ChunkData.AddData(entity as Measurement ??
                                          new Measurement(entity) { Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId });
                        break;

                    case "Observation":
                        //if (entity.TypeConceptId != 38000246)
                        {
                            var obser = entity as Observation ??
                                        new Observation(entity)
                                        {
                                            Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                                        };

                            //var result = Vocabulary.Lookup(obser.SourceValue, "JMDC-ICD10-MapsToValue", DateTime.MinValue, false);
                            var result = Vocabulary.Lookup(obser.SourceValue, "JMDC-ICD10-MapsToValue", DateTime.MinValue);

                            if (result.Count != 0 && result[0].ConceptId.HasValue && result[0].ConceptId > 0)
                            {
                                obser.ValueAsConceptId = result[0].ConceptId.Value;
                            }

                            ChunkData.AddData(obser);
                        }

                        break;

                    case "Procedure":
                        var p = entity as ProcedureOccurrence ??
                                new ProcedureOccurrence(entity)
                                {
                                    Id =
                                        Offset.GetKeyOffset(entity.PersonId)
                                            .ProcedureOccurrenceId
                                };

                        ChunkData.AddData(p);
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

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }
            }
        }

        #endregion
    }
}
