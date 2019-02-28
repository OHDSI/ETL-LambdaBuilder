using System;
using System.Collections.Generic;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Core.Transformation.CPRD
{
    /// <summary>
    ///  Implementation of PersonBuilder for CPRD, based on CDM Build spec
    /// </summary>
    public class CprdPersonBuilder : PersonBuilder
    {
        /// <summary>
        /// Build person entity and all person related entities like: DrugExposures, ConditionOccurrences, ProcedureOccurrences... from raw data sets 
        /// </summary>
        public override Attrition Build(ChunkData data, KeyMasterOffsetManager om)
        {
            this.Offset = om;
            this.ChunkData = data;
            var result = BuildPerson(PersonRecords.ToList());
            var person = result.Key;
            if (person == null)
                return result.Value;

            if (!ObservationPeriodsRaw.Any(op => op.StartDate < op.EndDate))
                return Attrition.InvalidObservationTime;

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap,
                    ObservationPeriodsRaw.Where(op => op.StartDate < op.EndDate).ToArray()).ToArray();

            var payerPlanPeriods = BuildPayerPlanPeriods(PayerPlanPeriodsRaw.ToArray(), null).ToArray();
            var cohort = BuildCohort(CohortRecords.ToArray(), observationPeriods).ToArray();


            var visitOccurrences = new Dictionary<long, VisitOccurrence>();
            var visitIds = new List<long>();

            // Build and clenaup visit occurrences entities
            foreach (var visitOccurrence in CleanupVisits(
                BuildVisitOccurrences(VisitOccurrencesRaw.ToArray(), observationPeriods), cohort,
                observationPeriods))
            {
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

            var drugExposures = BuildDrugExposures(DrugExposuresRaw.Where(de => de.StartDate < DateTime.Now).ToArray(),
                    visitOccurrences, observationPeriods)
                .ToArray();
            var deviceExposure = BuildDeviceExposure(DeviceExposureRaw.ToArray(), visitOccurrences, observationPeriods)
                .ToArray();
            var conditionOccurrences =
                Cleanup(
                    BuildConditionOccurrences(
                        ConditionOccurrencesRaw.Where(co => co.StartDate < DateTime.Now).ToArray(), visitOccurrences,
                        observationPeriods),
                    cohort).ToArray();
            var procedureOccurrences =
                Cleanup(
                    BuildProcedureOccurrences(ProcedureOccurrencesRaw.ToArray(), visitOccurrences, observationPeriods),
                    cohort).ToArray();

            var observations =
                Cleanup(BuildObservations(ObservationsRaw.ToArray(), visitOccurrences, observationPeriods), cohort)
                    .ToArray();
            var measurements =
                Cleanup(BuildMeasurement(MeasurementsRaw.ToArray(), visitOccurrences, observationPeriods), cohort)
                    .ToArray();

            // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
            SetPayerPlanPeriodId(payerPlanPeriods, drugExposures, procedureOccurrences,
                visitOccurrences.Values.ToArray(), new DeviceExposure[] { });

            // set corresponding ProviderIds
            SetProviderIds(drugExposures);
            SetProviderIds(conditionOccurrences);
            SetProviderIds(procedureOccurrences);
            SetProviderIds(observations);

            var death = BuildDeath(DeathRecords.ToArray(), visitOccurrences, observationPeriods);
            var drugCosts = BuildDrugCosts(drugExposures).ToArray();
            var procedureCosts = BuildProcedureCosts(procedureOccurrences).ToArray();

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death,
                observationPeriods,
                payerPlanPeriods,
                drugExposures,
                CleanupCondition(conditionOccurrences).ToArray(),
                procedureOccurrences,
                CleanupObservations(observations, measurements, conditionOccurrences, procedureOccurrences).ToArray(),
                measurements,
                visitOccurrences.Values.ToArray(), null, cohort, deviceExposure, new Note[0]);

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

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ToArray();
            var person = ordered.Take(1).First();

            if(person.AdditionalFields["accept"] != "1")
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

            if(person.YearOfBirth < 1900)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        private static IEnumerable<Observation> CleanupObservations(Observation[] observations,
            Measurement[] measurements, ConditionOccurrence[] conditions, ProcedureOccurrence[] procedures)
        {
            foreach (var observation in observations)
            {
                if (observation.ConceptId > 0)
                    yield return observation;
                else if (!measurements.Any(m => m.ConceptId > 0 && m.SourceValue == observation.SourceValue) &&
                         !conditions.Any(m => m.ConceptId > 0 && m.SourceValue == observation.SourceValue) &&
                         !procedures.Any(m => m.ConceptId > 0 && m.SourceValue == observation.SourceValue))
                    yield return observation;
            }

        }

        public override IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var m in base.BuildMeasurement(measurements, visitOccurrences, observationPeriods))
            {
                if (m.AdditionalFields != null && m.AdditionalFields.ContainsKey("value_as_string"))
                {
                    decimal valueAsNumber;

                    if (decimal.TryParse(m.AdditionalFields["value_as_string"], out valueAsNumber))
                    {
                        m.ValueAsNumber = valueAsNumber;

                        if (m.TypeConceptId == 900000007)
                            m.TypeConceptId = 900000006;
                    }
                }

                yield return m;
            }
        }

        /// <summary>
        /// Projects Enumeration of Observations from the raw set of Observation entities. 
        /// During build:
        /// override the observations start date using the start date of the corresponding obervation period.
        /// overide TypeConceptId per CDM Mapping spec.
        /// exclude the observations without observation periods and observation that out of current observation period
        /// </summary>
        /// <param name="observations">raw set of observations entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Observation from the raw set of Observation entities</returns>
        public override IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var observation in observations)
            {
                // exclude observations for person without observation periods
                if (!observationPeriods.Any())
                    continue;

                if (observation.AdditionalFields != null && observation.AdditionalFields.ContainsKey("value_as_string"))
                {
                    decimal valueAsNumber;

                    if (decimal.TryParse(observation.AdditionalFields["value_as_string"], out valueAsNumber))
                    {
                        observation.ValueAsNumber = valueAsNumber;

                        if (observation.TypeConceptId == 900000007)
                            observation.TypeConceptId = 900000006;
                    }
                }

                //Medical History Read code records
                if (observation.TypeConceptId >= 1 && observation.TypeConceptId <= 3)
                {
                    // Medical history records are additional observation read code records that occur prior to the observation period start date
                    if (observation.StartDate < observationPeriods[0].StartDate)
                    {
                        // assign Concept Type:
                        switch (observation.TypeConceptId)
                        {
                            case 1:
                                observation.TypeConceptId = 38000245;
                                break;
                            case 2:
                                observation.TypeConceptId = 38000280;
                                break;
                            case 3:
                                observation.TypeConceptId = 42898140;
                                break;
                        }

                        // set VisitOccurrenceId, ValueAsConceptId, ConceptId, StartDate based on CDM Build spec for Medical History Read code records
                        observation.VisitOccurrenceId = null;
                        observation.ValueAsConceptId = observation.ConceptId;
                        observation.ConceptId = 43054928;
                        observation.StartDate = observationPeriods[0].StartDate;
                        observation.Domain = "Observation";

                        yield return observation;
                    }

                }
                else if (observation.StartDate.Between(observationPeriods[0].StartDate,
                    observationPeriods[0].EndDate.Value))
                {

                    // set to NULL VisitOccurrenceId for not existing VisitOccurrenceIds
                    if (observation.VisitOccurrenceId != null &&
                        !visitOccurrences.ContainsKey(observation.VisitOccurrenceId.Value))
                        observation.VisitOccurrenceId = null;

                    yield return observation;
                }
            }
        }

        /// <summary>
        /// Projects Enumeration of Cohort from the raw set of Cohort entities. 
        /// During build:
        /// override the cohort's start date using the start date of the corresponding obervation period.
        /// override the cohort's end date using the end date of the corresponding obervation period.
        /// exclude the cohort's without observation periods
        ///  </summary>
        /// <param name="cohort">raw set of Cohort entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Cohort from the raw set of Cohort entities</returns>
        public override IEnumerable<Cohort> BuildCohort(Cohort[] cohort, ObservationPeriod[] observationPeriods)
        {
            foreach (var c in cohort)
            {
                //exclude the Cohort without observation periods
                if (!observationPeriods.Any()) continue;

                if (c.StartDate < observationPeriods[0].StartDate)
                    c.StartDate = observationPeriods[0].StartDate;

                if (c.EndDate > observationPeriods[0].EndDate)
                    c.EndDate = observationPeriods[0].EndDate;

                if (c.StartDate > c.EndDate) continue;

                yield return c;
            }
        }

        /// <summary>
        /// Filtering and start/end date adjustment for visit occurrence entities
        /// </summary>
        /// <param name="visits">the visit occurrence entities for current person</param>
        /// <param name="cohorts">the cohort entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of filtered out and adjusted visit occurrence entities</returns>
        private static IEnumerable<VisitOccurrence> CleanupVisits(IEnumerable<VisitOccurrence> visits,
            IList<Cohort> cohorts, ObservationPeriod[] observationPeriods)
        {
            foreach (var visitOccurrence in visits)
            {
                if (!observationPeriods.Any()) continue;

                if (visitOccurrence.StartDate > visitOccurrence.EndDate) continue;

                // Adjust visit start/end date for outpatient Visit
                if (visitOccurrence.ConceptId == 9202)
                    yield return AdjustVisitDates(visitOccurrence, observationPeriods);
                else
                {
                    // exclude not outpatient visit for person without cohort records
                    if (!cohorts.Any()) continue;

                    // Adjust visit start/end date for not outpatient visit that out of current cohort start & end dates
                    if (visitOccurrence.StartDate >= cohorts[0].StartDate &&
                        visitOccurrence.EndDate <= cohorts[0].EndDate)
                    {
                        yield return AdjustVisitDates(visitOccurrence, observationPeriods);
                    }
                }
            }
        }

        /// <summary>
        /// override the visit's start/end date for visit entities that out of current obervation period 
        /// using the start/end date of the corresponding obervation period.
        /// </summary>
        /// <param name="visitOccurrence">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of adjusted visit occurrence entities</returns>
        private static VisitOccurrence AdjustVisitDates(VisitOccurrence visitOccurrence,
            ObservationPeriod[] observationPeriods)
        {
            if (visitOccurrence.StartDate < observationPeriods[0].StartDate)
                visitOccurrence.StartDate = observationPeriods[0].StartDate;

            if (visitOccurrence.EndDate > observationPeriods[0].EndDate)
                visitOccurrence.EndDate = observationPeriods[0].EndDate;

            return visitOccurrence;
        }

        /// <summary>
        ///  Filtering for HES records
        /// </summary>
        /// <typeparam name="T">IEntity</typeparam>
        /// <param name="items">the set of entities</param>
        /// <param name="cohorts">the cohort entities for current person</param>
        /// <returns>Enumeration of filtered entities</returns>
        private static IEnumerable<T> Cleanup<T>(IEnumerable<T> items, IList<Cohort> cohorts) where T : class, IEntity
        {
            foreach (var item in items)
            {
                // hes records
                if ((item.TypeConceptId >= 38000183 && item.TypeConceptId <= 38000198) ||
                    (item.TypeConceptId >= 44818709 && item.TypeConceptId <= 44818713) ||
                    (item.TypeConceptId >= 900000006 && item.TypeConceptId <= 900000007))
                {
                    // exclude hes records for person without cohort records
                    if (!cohorts.Any()) continue;
                    //exclude hes records without VisitOccurrenceId
                    if (!item.VisitOccurrenceId.HasValue) continue;

                    // exclude hes records that out of current cohort start & end dates
                    if (item.StartDate >= cohorts[0].StartDate && item.EndDate <= cohorts[0].EndDate)
                    {
                        yield return item;
                    }
                }
                else
                {
                    yield return item;
                }
            }
        }

        private static IEnumerable<ConditionOccurrence> CleanupCondition(IEnumerable<ConditionOccurrence> items)
        {
            foreach (var item in items)
            {
                // hes records
                if ((item.TypeConceptId >= 38000183 && item.TypeConceptId <= 38000198) ||
                    (item.TypeConceptId >= 44818709 && item.TypeConceptId <= 44818713) ||
                    (item.TypeConceptId >= 900000006 && item.TypeConceptId <= 900000007))
                {
                    if (item.EndDate.HasValue && item.StartDate > item.EndDate)
                    {
                        item.StartDate = item.EndDate.Value;
                    }

                    yield return item;
                }
                else
                {
                    item.EndDate = null;
                    yield return item;
                }
            }
        }

        /// <summary>
        /// Filtering raw set of entities (DrugExposures, ConditionOccurrences, ProcedureOccurrences...)
        /// </summary>
        /// <param name="entitiesToBuild">the raw set of entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of filtered entities</returns>
        public override IEnumerable<T> BuildEntities<T>(IEnumerable<T> entitiesToBuild,
            IDictionary<long, VisitOccurrence> visitOccurrences, IEnumerable<ObservationPeriod> observationPeriods, bool withinTheObservationPeriod)
        {
            var uniqueEntities = new HashSet<T>();
            foreach (var e in Clean(entitiesToBuild, observationPeriods, withinTheObservationPeriod))
            {
                var entity = e;
                if (entity.VisitOccurrenceId != null && !visitOccurrences.ContainsKey(entity.VisitOccurrenceId.Value))
                    entity.VisitOccurrenceId = null;

                if (entity.IsUnique)
                {
                    uniqueEntities.Add(entity);
                }
                else
                {
                    yield return entity;
                }
            }

            foreach (var ue in uniqueEntities)
            {
                yield return ue;
            }
        }

    }
}
