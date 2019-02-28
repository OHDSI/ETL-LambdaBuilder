using System;
using System.Collections.Generic;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Core.Transformation.OptumOncology
{
    /// <summary>
    ///  Implementation of PersonBuilder for Optum, based on CDM Build spec
    /// </summary>
    public class OptumOncologyPersonBuilder : PersonBuilder
    {
        //private readonly Dictionary<Guid, VisitDetail> _visitDetails = new Dictionary<Guid, VisitDetail>();
        private readonly Dictionary<Guid, VisitOccurrence> _rawVisits = new Dictionary<Guid, VisitOccurrence>();

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ThenBy(p => p.EndDate);
            var person = ordered.Take(1).Last();

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

        private static IEnumerable<DrugExposure> PrepareDrugExposures(IEnumerable<DrugExposure> drugExposures)
        {
            var ndcDrugs = new Dictionary<Guid, List<DrugExposure>>();
            foreach (var de in drugExposures)
            {
                if (de.TypeConceptId == 44787730 ||
                    de.TypeConceptId == 43542358 ||
                    de.TypeConceptId == 38000177 ||
                    de.TypeConceptId == 38000180)
                {
                    if (!ndcDrugs.ContainsKey(de.SourceRecordGuid))
                        ndcDrugs.Add(de.SourceRecordGuid, new List<DrugExposure>());

                    ndcDrugs[de.SourceRecordGuid].Add(de);
                    continue;
                }

                yield return de;

            }

            foreach (var similarDrugs in ndcDrugs.SelectMany(drugs => drugs.Value.GroupBy(d => d.SourceValue)))
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

        public void UpdateVisitOccurrenceId(IEntity entity,
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

        public override IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
        {
            foreach (var op in observationPeriods)
            {
                op.EndDate = op.EndDate.Value.AddMonths(1).AddDays(-1);
            }

            return base.BuildObservationPeriods(gap, observationPeriods);
        }

        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var observation in base.BuildObservations(observations, visitOccurrences, observationPeriods))
            {
                if (observation.AdditionalFields != null && observation.AdditionalFields.ContainsKey("test_result"))
                {
                    if (decimal.TryParse(observation.AdditionalFields["test_result"], out var value))
                        observation.ValueAsNumber = value;
                    else
                        observation.ValueAsString = observation.AdditionalFields["test_result"];
                }

                yield return observation;
            }
        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var measurement in base.BuildMeasurement(measurements, visitOccurrences, observationPeriods))
            {
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

                if (measurement.TypeConceptId == 0)
                    measurement.TypeConceptId = 44818701;

                yield return measurement;
            }
        }

        private static Death CleanUpDeath(IEnumerable<IEntity> items, Death death)
        {
            if (death == null) return null;

            return items.Any(item => item.StartDate > death.StartDate.AddDays(30)) ? null : death;
        }

        protected void SetProviderIds<T>(IEnumerable<T> inputRecords, Dictionary<long, VisitOccurrence> visits)
            where T : class, IEntity
        {
            var records = inputRecords as T[] ?? inputRecords.ToArray();
            if (inputRecords == null || !records.Any()) return;

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

        public override IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails, VisitOccurrence[] visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            List<VisitDetail> details = new List<VisitDetail>();
            foreach (var visitOccurrence in visitOccurrences)
            {

                var visitDetail =
                    new VisitDetail(visitOccurrence)
                    {
                        Id = visitOccurrence.Id,
                        DischargeToConceptId = visitOccurrence.DischargeToConceptId,
                        DischargeToSourceValue = visitOccurrence.DischargeToSourceValue
                    };

                details.Add(visitDetail);
            }

            foreach (var visitDetail in Clean(details, observationPeriods, true).Distinct())
            {
                //_visitDetails.Add(visitDetail.SourceRecordGuid, visitDetail);

                if (!visitDetail.EndDate.HasValue)
                    visitDetail.EndDate = visitDetail.StartDate;
                
                yield return visitDetail;
            }
        }

        //private VisitOccurrence GetVisitOccurrence(IEntity ent)
        //{
        //    if (_rawVisits.ContainsKey(ent.SourceRecordGuid))
        //    {
        //        var vo = _rawVisits[ent.SourceRecordGuid];
        //        if (vo.Id == 0 && _rawVisits.ContainsKey(vo.SourceRecordGuid) &&
        //            _rawVisits[vo.SourceRecordGuid].SourceRecordGuid != ent.SourceRecordGuid)
        //        {
        //            vo = _rawVisits[vo.SourceRecordGuid];
        //        }

        //        return vo;
        //    }

        //    return null;
        //}

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager om)
        {
            this.Offset = om;
            this.ChunkData = data;

            var result = BuildPerson(PersonRecords.ToList());
            var person = result.Key;
            if (person == null)
                return result.Value;

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap, ObservationPeriodsRaw.ToArray()).ToArray();

            // Delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH
            if (Excluded(person, observationPeriods))
            {
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var payerPlanPeriods = BuildPayerPlanPeriods(PayerPlanPeriodsRaw.ToArray(), null).ToArray();


            var vDetails = BuildVisitDetails(null, VisitOccurrencesRaw.ToArray(), observationPeriods).ToArray();

            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();
            foreach (var visitOccurrence in BuildVisitOccurrences(
                VisitOccurrencesRaw
                    .Where(v => v.AdditionalFields["sort_index"] == "1" && v.AdditionalFields["ordinal"] == "1")
                    .ToArray(), observationPeriods))
            {

                if (!_rawVisits.ContainsKey(visitOccurrence.SourceRecordGuid))
                    _rawVisits.Add(visitOccurrence.SourceRecordGuid, visitOccurrence);

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
                visitIds.Add(visitOccurrence.Id);
            }

            var visitDetails = new Dictionary<long, VisitDetail>();
            foreach (var group in vDetails.GroupBy(d => d.Id))
            {
                var vd = group.First();
                if (visitOccurrences.ContainsKey(vd.Id))
                {
                    vd.VisitOccurrenceId = vd.Id;
                    vd.ProviderId = visitOccurrences[vd.Id].ProviderId;
                }
                else
                {
                    var visits = visitOccurrences.Values.Where(vo =>
                        vo.TypeConceptId == vd.TypeConceptId && vo.StartDate >= vd.StartDate &&
                        vo.EndDate <= vo.EndDate).ToArray();

                    vd.VisitOccurrenceId = visits.Any() ? visits.First().Id : 0;
                }

                vd.SourceValue = $"visitid:{vd.VisitOccurrenceId};encid:{vd.AdditionalFields["encid"]}";
                visitDetails.Add(vd.Id, vd);
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

            UpdateVisitOccurrenceIds(visitOccurrences, visitDetails);

            var drugExposures =
                BuildDrugExposures(DrugExposuresRaw.ToArray(), visitOccurrences, observationPeriods).ToArray();
            var conditionOccurrences =
                BuildConditionOccurrences(ConditionOccurrencesRaw.ToArray(), visitOccurrences, observationPeriods)
                    .ToArray();

            var procedureOccurrences =
                BuildProcedureOccurrences(ProcedureOccurrencesRaw.ToArray(), visitOccurrences, observationPeriods)
                    .ToArray();
            var observations = BuildObservations(ObservationsRaw.ToArray(), visitOccurrences, observationPeriods)
                .ToArray();
            var measurements = BuildMeasurement(MeasurementsRaw.ToArray(), visitOccurrences, observationPeriods)
                .ToArray();
            var deviceExposure =
                BuildDeviceExposure(DeviceExposureRaw.ToArray(), visitOccurrences, observationPeriods).ToArray();

            // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
            SetPayerPlanPeriodId(payerPlanPeriods, drugExposures, procedureOccurrences,
                visitOccurrences.Values.ToArray(),
                deviceExposure);

            var notes = BuildNote(NoteRecords.ToArray(), visitOccurrences, observationPeriods).ToArray();

            // set corresponding ProviderIds
            SetProviderIds(drugExposures);
            SetProviderIds(conditionOccurrences);
            SetProviderIds(procedureOccurrences);
            SetProviderIds(observations);
            //SetProviderIds(visitDetails);

            SetProviderIds(drugExposures, visitOccurrences);
            SetProviderIds(conditionOccurrences, visitOccurrences);
            SetProviderIds(measurements, visitOccurrences);
            SetProviderIds(procedureOccurrences, visitOccurrences);
            SetProviderIds(deviceExposure, visitOccurrences);
            SetProviderIds(observations, visitOccurrences);
            SetProviderIds(notes, visitOccurrences);
            

            var death = BuildDeath(DeathRecords.ToArray(), visitOccurrences, observationPeriods);
            var drugCosts = BuildDrugCosts(drugExposures).ToArray();
            var procedureCosts = BuildProcedureCosts(procedureOccurrences).ToArray();
            var visitCosts = BuildVisitCosts(visitOccurrences.Values.ToArray()).ToArray();
            var devicCosts = BuildDeviceCosts(deviceExposure).ToArray();

            var cohort = BuildCohort(CohortRecords.ToArray(), observationPeriods).ToArray();


            if (death != null)
            {
                death = CleanUpDeath(visitOccurrences.Values, death);
                death = CleanUpDeath(drugExposures, death);
                death = CleanUpDeath(conditionOccurrences, death);
                death = CleanUpDeath(procedureOccurrences, death);
                death = CleanUpDeath(measurements, death);
                death = CleanUpDeath(observations, death);
                death = CleanUpDeath(deviceExposure, death);
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death, observationPeriods, payerPlanPeriods, drugExposures,
                conditionOccurrences, procedureOccurrences, observations, measurements,
                visitOccurrences.Values.ToArray(), visitDetails.Values.ToArray(), cohort, deviceExposure, notes);

            var pg = new PregnancyAlgorithm.PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, observationPeriods,
                ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
            {
                r.Id = KeyMasterOffsetManager.GetKeyOffset(r.PersonId).ConditionEraId;
                ChunkData.ConditionEra.Add(r);
            }

            return Attrition.None;
        }

        private void UpdateVisitOccurrenceIds(Dictionary<long, VisitOccurrence> visitOccurrences, Dictionary<long, VisitDetail> visitDetails)
        {
            foreach (var e in DrugExposuresRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in ConditionOccurrencesRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in ProcedureOccurrencesRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in ObservationsRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in MeasurementsRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in DeviceExposureRaw)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
            }

            foreach (var e in NoteRecords)
            {
                UpdateVisitOccurrenceId(e, visitOccurrences, visitDetails);
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
                                           Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).ConditionOccurrenceId
                                       };
                            ConditionForEra.Add(cond);
                            ChunkData.AddData(cond);
                        }

                        break;

                    case "Measurement":
                        var mes = entity as Measurement ??
                                  new Measurement(entity) {Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).MeasurementId};

                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("test_result"))
                        {
                            mes.ValueSourceValue = entity.AdditionalFields["test_result"];
                        }

                        // HIX-1363
                        //if rslt_nbr is non-zero, take it for both fields, otherwise, 
                        //use NULL for value_as_number and take rslt_txt for value_as_string.
                        if (mes.ValueAsNumber != null && mes.ValueAsNumber != 0)
                        {
                            mes.ValueSourceValue = mes.ValueAsNumber.ToString();
                        }

                        if (mes.TypeConceptId != 44786627 && mes.TypeConceptId != 44786629)
                            mes.TypeConceptId = 45754907;

                        ChunkData.AddData(mes);
                        break;

                    case "Meas Value":
                        var m = entity as Measurement ??
                                new Measurement(entity) {Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).MeasurementId};

                        if (entity.AdditionalFields != null && entity.AdditionalFields.ContainsKey("test_result"))
                        {
                            m.ValueSourceValue = entity.AdditionalFields["test_result"];
                        }

                        if (m.TypeConceptId != 44786627 && m.TypeConceptId != 44786629)
                            m.TypeConceptId = 45754907;

                        m.TypeConceptId = 45754907;
                        ChunkData.AddData(m);
                        break;

                    case "Observation":
                        var o = entity as Observation ??
                            new Observation(entity)
                            {
                                Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).ObservationId
                            };
                        ChunkData.AddData(o);
                        break;

                    case "Procedure":
                        var proc = entity as ProcedureOccurrence ??
                                   new ProcedureOccurrence(entity)
                                   {
                                       Id =
                                           KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
                                   };

                        
                        if (proc.TypeConceptId == 0)
                            proc.TypeConceptId = 38000275;
                        else if (proc.TypeConceptId == 44786627 || proc.TypeConceptId == 44786629)
                            proc.TypeConceptId = 42865906;

                        ChunkData.AddData(proc);
                        break;

                    case "Device":
                        var dev = entity as DeviceExposure ??
                                  new DeviceExposure(entity)
                                  {
                                      Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).DeviceExposureId
                                  };

                        ChunkData.AddData(dev);
                        break;

                    case "Drug":
                        var drg = entity as DrugExposure ??
                                  new DrugExposure(entity)
                                  {
                                      Id = KeyMasterOffsetManager.GetKeyOffset(entity.PersonId).DrugExposureId
                                  };

                        if (drg.TypeConceptId == 0)
                            drg.TypeConceptId = 38000275;

                        if (!drg.EndDate.HasValue)
                        {
                            drg.EndDate = drg.StartDate;
                        }

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }

                //HIX-823
                if (domain == "Procedure" && entityDomain != "Procedure")
                {
                    var po = (ProcedureOccurrence) entity;
                    po.ConceptId = 0;
                    ChunkData.AddData(po);
                }

                if (domain == "Observation" && entityDomain != "Observation")
                {
                    var o = (Observation) entity;
                    o.ConceptId = 0;
                    ChunkData.AddData(o);
                }

            }
        }
    }
}
