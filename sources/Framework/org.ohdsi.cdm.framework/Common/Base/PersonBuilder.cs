﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using System.Collections.Concurrent;

namespace org.ohdsi.cdm.framework.common.Base
{
    /// <summary>
    ///  Base implementation of PersonBuilder
    /// </summary>
    public class PersonBuilder : IPersonBuilder
    {
        #region Variables

        protected ChunkData ChunkData;
        protected KeyMasterOffsetManager Offset;
        protected IVocabulary Vocabulary;
        protected List<EraEntity> ObservationPeriodsRaw = [];
        protected List<Person> PersonRecords = [];
        protected List<Death> DeathRecords = [];
        protected List<Cohort> CohortRecords = [];
        protected List<PayerPlanPeriod> PayerPlanPeriodsRaw = [];
        protected List<ConditionOccurrence> ConditionOccurrencesRaw = [];
        protected List<DrugExposure> DrugExposuresRaw = [];
        protected List<ProcedureOccurrence> ProcedureOccurrencesRaw = [];
        protected List<Observation> ObservationsRaw = [];
        protected List<Measurement> MeasurementsRaw = [];
        protected List<VisitOccurrence> VisitOccurrencesRaw = [];
        protected List<VisitDetail> VisitDetailsRaw = [];

        protected List<VisitCost> VisitCostsRaw = [];
        protected List<DeviceExposure> DeviceExposureRaw = [];
        protected List<DeviceCost> DeviceCostRaw = [];

        protected List<Cost> CostRaw = [];

        protected List<DrugExposure> DrugForEra = [];
        protected List<ConditionOccurrence> ConditionForEra = [];
        protected List<Note> NoteRecords = [];
        protected List<NoteNlp> NoteNlpRecords = [];
        protected List<Episode> EpisodeRecords = [];


        #endregion

        #region Properties

        public Vendor Vendor { get; private set; }

        #endregion

        #region Constructors
        /// <summary>
        /// This should not be used. Use PersonBuilder.CreateBuilder instead.
        /// </summary>
        /// <param name="vendor"></param>
        public PersonBuilder(Vendor vendor)
        {
            this.Vendor = vendor;
        }

        #endregion


        #region Methods

        public bool AddCost(long eventId, IEntity entity, Func<ICostV5, Cost> createCost)
        {
            // TMP
            var costDataExists = false;
            if (entity == null) return false;

            switch (entity.GeEntityType())
            {
                case EntityType.DrugExposure:
                    {
                        var de = (DrugExposure)entity;

                        if (de.DrugCost != null)
                        {
                            costDataExists |= AddCost(eventId, createCost, de, de.DrugCost);
                        }

                        de.DrugCost = null;
                        break;
                    }

                case EntityType.ProcedureOccurrence:
                    {
                        var p = (ProcedureOccurrence)entity;
                        if (p.ProcedureCosts != null && p.ProcedureCosts.Count > 0)
                        {
                            foreach (var pc in p.ProcedureCosts)
                            {
                                costDataExists |= AddCost(eventId, createCost, p, pc);
                            }

                            p.ProcedureCosts.Clear();
                            p.ProcedureCosts = null;
                        }
                        break;
                    }


                case EntityType.Observation:
                    {
                        var o = (Observation)entity;
                        if (o.ObservationCost != null && o.ObservationCost.Count > 0)
                        {
                            foreach (var oc in o.ObservationCost)
                            {
                                costDataExists |= AddCost(eventId, createCost, o, oc);
                            }
                            o.ObservationCost.Clear();
                            o.ObservationCost = null;
                        }
                        break;
                    }

                case EntityType.VisitOccurrence:
                    {
                        var vo = (VisitOccurrence)entity;
                        if (vo.VisitCosts != null && vo.VisitCosts.Count > 0)
                        {
                            foreach (var vc in vo.VisitCosts)
                            {
                                costDataExists |= AddCost(eventId, createCost, vo, vc);
                            }
                            vo.VisitCosts.Clear();
                            vo.VisitCosts = null;
                        }
                        break;
                    }

                case EntityType.Measurement:
                    {
                        var m = (Measurement)entity;
                        if (m.MeasurementCost != null && m.MeasurementCost.Count > 0)
                        {
                            foreach (var mc in m.MeasurementCost)
                            {
                                costDataExists |= AddCost(eventId, createCost, m, mc);
                            }
                            m.MeasurementCost.Clear();
                            m.MeasurementCost = null;
                        }
                        break;
                    }

                case EntityType.DeviceExposure:
                    {
                        var d = (DeviceExposure)entity;
                        if (d.DeviceCosts != null && d.DeviceCosts.Count > 0)
                        {
                            foreach (var dc in d.DeviceCosts)
                            {
                                costDataExists |= AddCost(eventId, createCost, d, dc);
                            }

                            d.DeviceCosts.Clear();
                            d.DeviceCosts = null;
                        }
                        break;
                    }
            }

            return costDataExists;
        }

        public void Reset()
        {
            //ChunkData.Clean();

            Vocabulary = null;
            ObservationPeriodsRaw.Clear();
            ObservationPeriodsRaw = null;

            PersonRecords.Clear();
            PersonRecords = null;
            DeathRecords.Clear();
            DeathRecords = null;
            CohortRecords.Clear();
            CohortRecords = null;

            PayerPlanPeriodsRaw.Clear();
            PayerPlanPeriodsRaw = null;

            ConditionOccurrencesRaw.Clear();
            ConditionOccurrencesRaw = null;

            DrugExposuresRaw.Clear();
            DrugExposuresRaw = null;

            ProcedureOccurrencesRaw.Clear();
            ProcedureOccurrencesRaw = null;

            ObservationsRaw.Clear();
            ObservationsRaw = null;

            MeasurementsRaw.Clear();
            MeasurementsRaw = null;

            VisitOccurrencesRaw.Clear();
            VisitOccurrencesRaw = null;

            VisitDetailsRaw.Clear();
            VisitDetailsRaw = null;

            VisitCostsRaw.Clear();
            VisitCostsRaw = null;

            DeviceExposureRaw.Clear();
            DeviceExposureRaw = null;

            DeviceCostRaw.Clear();
            DeviceCostRaw = null;

            DrugForEra.Clear();
            DrugForEra = null;

            ConditionForEra.Clear();
            ConditionForEra = null;

            NoteRecords.Clear();
            NoteRecords = null;

            NoteNlpRecords.Clear();
            NoteNlpRecords = null;

            EpisodeRecords.Clear();
            EpisodeRecords = null;

            CostRaw.Clear();
            CostRaw = null;
        }

        protected virtual bool AddCost(long eventId, Func<ICostV5, Cost> createCost, IEntity entity, ICostV5 entityCost)
        {
            if (entityCost == null) return false;

            var cost = createCost(entityCost);
            cost.CostId = Offset.GetKeyOffset(entityCost.PersonId).VisitCostId;
            cost.EventId = eventId;

            return ChunkData.AddCostData(cost);
        }

        public void AddCost(Cost data)
        {
            CostRaw.Add(data);
        }

        public ChunkData Result => ChunkData;

        public bool Complete { get; set; }


        public void AddChildData(ProcedureOccurrence parent, ProcedureCost pc)
        {
            parent.ProcedureCosts = [pc];
        }

        public void AddChildData(DrugExposure parent, DrugCost child)
        {
            parent.DrugCost = child;
        }

        public void AddChildData(DeviceExposure parent, DeviceCost child)
        {
            parent.DeviceCosts = [child];
        }

        public void AddChildData(Measurement parent, MeasurementCost child)
        {
            parent.MeasurementCost = [child];
        }

        public void AddChildData(Observation parent, ObservationCost child)
        {
            parent.ObservationCost = [child];
        }

        public void AddChildData(VisitOccurrence parent, VisitCost child)
        {
            parent.VisitCosts = [child];
        }

        public void AddNote(Note data)
        {
            NoteRecords.Add(data);
        }

        public void AddNoteNlpRecords(NoteNlp data)
        {
            NoteNlpRecords.Add(data);
        }        

        public void AddEpisode(Episode data)
        {
            EpisodeRecords.Add(data);
        }

        public void AddObservationPeriod(EraEntity data)
        {
            ObservationPeriodsRaw.Add(data);
        }

        /// <summary>
        /// Add raw entities to builder for further build
        /// </summary>
        /// <param name="data">raw entity</param>
        public void AddData(IEntity data)
        {
            switch (data.GeEntityType())
            {
                case EntityType.Person:
                    {
                        AddEntity((Person)data, PersonRecords);

                        if (data.TypeConceptId.HasValue)
                        {
                            AddEntity(
                                new EraEntity
                                {
                                    PersonId = data.PersonId,
                                    StartDate = data.StartDate,
                                    EndDate = data.EndDate,
                                    TypeConceptId = data.TypeConceptId,
                                    AdditionalFields = data.AdditionalFields
                                }, ObservationPeriodsRaw);
                        }
                        break;
                    }

                case EntityType.Death:
                    {
                        AddEntity((Death)data, DeathRecords);
                        break;
                    }

                case EntityType.PayerPlanPeriod:
                    {
                        AddEntity((PayerPlanPeriod)data, PayerPlanPeriodsRaw);
                        break;
                    }

                case EntityType.ConditionOccurrence:
                    {
                        AddEntity((ConditionOccurrence)data, ConditionOccurrencesRaw);
                        break;
                    }

                case EntityType.DrugExposure:
                    {
                        AddEntity((DrugExposure)data, DrugExposuresRaw);
                        break;
                    }

                case EntityType.ProcedureOccurrence:
                    {
                        AddEntity((ProcedureOccurrence)data, ProcedureOccurrencesRaw);
                        break;
                    }

                case EntityType.Observation:
                    {
                        AddEntity((Observation)data, ObservationsRaw);
                        break;
                    }

                case EntityType.VisitOccurrence:
                    {
                        AddEntity((VisitOccurrence)data, VisitOccurrencesRaw);
                        break;
                    }

                case EntityType.VisitDetail:
                    {
                        AddEntity((VisitDetail)data, VisitDetailsRaw);
                        break;
                    }

                case EntityType.Cohort:
                    {
                        AddEntity((Cohort)data, CohortRecords);
                        break;
                    }

                case EntityType.Measurement:
                    {
                        AddEntity((Measurement)data, MeasurementsRaw);
                        break;
                    }

                case EntityType.DeviceExposure:
                    {
                        AddEntity((DeviceExposure)data, DeviceExposureRaw);
                        break;
                    }

                case EntityType.Note:
                    {
                        //AddEntity((Note)data, NoteRecords); TMP: NOTE 
                        break;
                    }
            }
        }

        protected static void AddEntity<T>(T entity, List<T> list) where T : IEntity
        {
            list.Add(entity);
        }

        protected static bool AddEntity<T>(T entity, ConcurrentDictionary<T, T> dictionary) where T : IEntity
        {
            return dictionary.TryAdd(entity, entity);
        }

        // set corresponding ProviderIds
        protected static void SetProviderIds<T>(IEnumerable<T> inputRecords) where T : class, IEntity
        {
            if (inputRecords == null)
                return;

            var records = inputRecords as T[] ?? inputRecords.ToArray();

            if (records.Length == 0)
                return;


            foreach (var e in records.Where(e => !string.IsNullOrEmpty(e.ProviderKey)))
            {
                e.ProviderId = Entity.GetId(e.ProviderKey);
            }
        }

        protected static void SetPrecedingVisitOccurrenceId(IEnumerable<VisitOccurrence> visitOccurrences)
        {
            if (visitOccurrences == null)
                return;

            long? priorVisitId = null;
            foreach (var visit in visitOccurrences
                .OrderBy(v => v.StartDate)
                .ThenBy(v => v.EndDate)
                .ThenBy(v => v.Id))
            {
                if (priorVisitId.HasValue)
                {
                    visit.PrecedingVisitOccurrenceId = priorVisitId;
                }

                priorVisitId = visit.Id;
            }
        }

        protected static void SetPrecedingVisitDetailId(IEnumerable<VisitDetail> visitDetails)
        {
            if (visitDetails == null)
                return;

            long? priorVisitId = null;
            foreach (var visit in visitDetails
                .OrderBy(v => v.StartDate)
                .ThenBy(v => v.EndDate)
                .ThenBy(v => v.Id))
            {
                if (priorVisitId.HasValue)
                {
                    visit.PrecedingVisitDetailId = priorVisitId;
                }

                priorVisitId = visit.Id;
            }
        }

        // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
        protected virtual void SetPayerPlanPeriodId(PayerPlanPeriod[] payerPlanPeriods, DrugExposure[] drugExposures,
            ProcedureOccurrence[] procedureOccurrences, VisitOccurrence[] visitOccurrences,
            DeviceExposure[] deviceExposure)
        {
            if (payerPlanPeriods.Length == 0) return;

            foreach (var de in drugExposures)
            {
                if (de.DrugCost == null) continue;
                foreach (var planPeriod in payerPlanPeriods)
                {
                    if (de.StartDate.Between(planPeriod.StartDate, planPeriod.EndDate.Value))
                    {
                        de.DrugCost.PayerPlanPeriodId = planPeriod.Id;
                        break;
                    }
                }
            }

            foreach (var po in procedureOccurrences)
            {
                if (po.ProcedureCosts == null) continue;
                foreach (var planPeriod in payerPlanPeriods)
                {
                    if (po.StartDate.Between(planPeriod.StartDate, planPeriod.EndDate.Value))
                    {
                        foreach (var procedureCost in po.ProcedureCosts)
                        {
                            procedureCost.PayerPlanPeriodId = planPeriod.Id;
                        }

                        break;
                    }
                }
            }

            foreach (var vo in visitOccurrences)
            {
                if (vo.VisitCosts == null) continue;
                foreach (var planPeriod in payerPlanPeriods)
                {
                    if (vo.StartDate.Between(planPeriod.StartDate, planPeriod.EndDate.Value))
                    {
                        foreach (var visitCost in vo.VisitCosts)
                        {
                            visitCost.PayerPlanPeriodId = planPeriod.Id;
                        }

                        break;
                    }
                }
            }

            foreach (var de in deviceExposure)
            {
                if (de.DeviceCosts == null) continue;
                foreach (var planPeriod in payerPlanPeriods)
                {
                    if (de.StartDate.Between(planPeriod.StartDate, planPeriod.EndDate.Value))
                    {
                        foreach (var deviceCost in de.DeviceCosts)
                        {
                            deviceCost.PayerPlanPeriodId = planPeriod.Id;
                        }

                        break;
                    }
                }
            }
        }

        /// <summary>
        /// Projects Enumeration of observation period from the raw set of observation period entities.
        /// </summary>
        /// <param name="gap">persistence window (duration that is allowed to elapse between two periods) </param>
        /// <param name="observationPeriods">raw set of observation period entities</param>
        /// <returns>Enumeration of observation period entities</returns>
        public virtual IEnumerable<ObservationPeriod> BuildObservationPeriods(int gap, EraEntity[] observationPeriods)
        {
            // All overlapping periods will be collapsed into one observation period
            return EraHelper.GetObservationPeriods(gap, observationPeriods, Offset);
        }

        /// <summary>
        /// Projects Enumeration of payerPlanPeriod from the raw set of payerPlanPeriod entities.
        /// </summary>
        /// <param name="payerPlanPeriods">raw set of payerPlanPeriod entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <returns>Enumeration of payerPlanPeriod entities</returns>
        public virtual IEnumerable<PayerPlanPeriod> BuildPayerPlanPeriods(PayerPlanPeriod[] payerPlanPeriods,
            Dictionary<long, VisitOccurrence> visitOccurrences)
        {
            // All overlapping periods will be collapsed into one observation period
            return EraHelper.GetPayerPlanPeriods(payerPlanPeriods, CanPayerPlanPeriodBeCombined,
                Offset);
        }

        /// <summary>
        /// Condition for the combining two periods
        /// </summary>
        /// <param name="current">1st period</param>
        /// <param name="other">2nd period</param>
        /// <returns>Can those periods be combined</returns>
        public virtual bool CanPayerPlanPeriodBeCombined(PayerPlanPeriod current, PayerPlanPeriod other)
        {
            if (string.IsNullOrEmpty(current.PlanSourceValue))
                return current.PayerSourceValue == other.PayerSourceValue;

            return current.PlanSourceValue == other.PlanSourceValue &&
                   current.PayerSourceValue == other.PayerSourceValue;
        }

        /// <summary>
        /// Projects death entity from the raw set of death entities.
        /// During build:
        /// override the death's start date using the end date of the corresponding visit.
        /// </summary>
        /// <param name="death">raw set of death entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>death entity</returns>
        public virtual Death BuildDeath(Death[] death, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            var ds = Clean(death, observationPeriods, false).ToList();
            if (ds.Count != 0)
            {
                var pd = ds.Where(d => d.Primary).ToList();
                return pd.Count != 0 ? pd.OrderBy(d => d.StartDate).Last() : ds.OrderBy(d => d.StartDate).Last();
            }

            return null;
        }

        /// <summary>
        /// Projects person etity from the raw set of persons entities. 
        /// </summary>
        /// <param name="records">raw set of Person entities</param>
        /// <returns>Person entity</returns>
        public virtual KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ToArray();
            var person = ordered.Take(1).First();
            person.StartDate = ordered.Take(1).Last().StartDate;

            var gender =
                records.GroupBy(p => p.GenderConceptId).OrderByDescending(gp => gp.Count()).Take(1).First().First();
            var race = records.GroupBy(p => p.RaceConceptId).OrderByDescending(gp => gp.Count()).Take(1).First()
                .First();

            person.GenderConceptId = gender.GenderConceptId;
            person.GenderSourceValue = gender.GenderSourceValue;
            person.RaceConceptId = race.RaceConceptId;
            person.RaceSourceValue = race.RaceSourceValue;

            if (person.GenderConceptId == 8551) //UNKNOWN
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        /// <summary>
        /// Projects Enumeration of Visit Occurrence from the raw set of Visit Occurrence entities. 
        ///  </summary>
        /// <param name="visitOccurrences">raw set of Visit Occurrence entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Visit Occurrence</returns>
        public virtual IEnumerable<VisitOccurrence> BuildVisitOccurrences(VisitOccurrence[] visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return Clean(visitOccurrences, observationPeriods, false).Distinct();
        }

        public virtual IEnumerable<VisitDetail> BuildVisitDetails(VisitDetail[] visitDetails, VisitOccurrence[] visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return Clean(visitDetails, observationPeriods, false).Distinct();
        }

        public virtual IEnumerable<Note> BuildNote(Note[] notes, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var e in notes)
            {
                if (e.VisitOccurrenceId == null || visitOccurrences.ContainsKey(e.VisitOccurrenceId.Value))
                {
                    yield return e;
                }
            }
        }

        public virtual IEnumerable<Episode> BuildEpisode(Episode[] episodes, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            foreach (var e in episodes)
            {
                if (e.VisitOccurrenceId == null || visitOccurrences.ContainsKey(e.VisitOccurrenceId.Value))
                {
                    yield return e;
                }
            }
        }

        /// <summary>
        /// 	Projects Enumeration of drug exposure from the raw set of drug exposure entities. 
        /// </summary>
        /// <param name="drugExposures">raw set of drug exposures entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of drug exposure entities</returns>
        public virtual IEnumerable<DrugExposure> BuildDrugExposures(DrugExposure[] drugExposures,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(drugExposures, visitOccurrences, observationPeriods, false);
        }

        /// <summary>
        /// Projects Enumeration of ConditionOccurrence from the raw set of ConditionOccurrence entities. 
        /// </summary>
        /// <param name="conditionOccurrences">raw set of condition occurrence entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of condition occurrence entities</returns>
        public virtual IEnumerable<ConditionOccurrence> BuildConditionOccurrences(
            ConditionOccurrence[] conditionOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(conditionOccurrences, visitOccurrences, observationPeriods, false);
        }

        /// <summary>
        /// Projects Enumeration of ProcedureOccurrence from the raw set of ProcedureOccurence entities.
        /// </summary>
        /// <param name="procedureOccurrences">raw set of procedure occurrence entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <returns>Enumeration of procedure occurrence entities</returns>
        public virtual IEnumerable<ProcedureOccurrence> BuildProcedureOccurrences(
            ProcedureOccurrence[] procedureOccurrences, Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(procedureOccurrences, visitOccurrences, observationPeriods, false);
        }

        /// <summary>
        /// Projects Enumeration of Observations from the raw set of Observation entities. 
        /// </summary>
        /// <param name="observations">raw set of observations entities</param>
        /// <param name="visitOccurrences">the visit occurrences entities for current person</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Observation from the raw set of Observation entities</returns>
        public virtual IEnumerable<Observation> BuildObservations(Observation[] observations,
            Dictionary<long, VisitOccurrence> visitOccurrences, ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(observations, visitOccurrences, observationPeriods, false);
        }

        public virtual IEnumerable<Measurement> BuildMeasurement(Measurement[] measurements,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(measurements, visitOccurrences, observationPeriods, false);
        }

        /// <summary>
        /// CONDITION_ERAs are chronological periods of condition occurrence.  
        /// There will only be one type of persistence window (duration that is allowed to elapse between condition occurrences) applied to this CDM, which is 30 days. 
        /// CONDITION_END_DATE will be the CONDITION_START_DATE.
        /// </summary>
        /// <param name="conditionOccurrences">Set of condition occurrence entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of condition era</returns>
        public virtual IEnumerable<EraEntity> BuildConditionEra(ConditionOccurrence[] conditionOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var eraEntity in EraHelper.GetEras(
                Clean(conditionOccurrences, observationPeriods, false).Where(c => string.IsNullOrEmpty(c.Domain) || c.Domain == "Condition"), 30,
                38000247))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).ConditionEraId;
                yield return eraEntity;
            }
        }

        /// <summary>
        /// A Drug Era is defined as a span of time when the Person is assumed to be exposed to a particular drug. 
        /// Successive periods of Drug Exposures are combined under certain rules to produce continuous Drug Eras.  
        /// The Drug Era  is populated by pulling from the set of drug exposure.  A drug era is therefore understood as exposure to a certain compound over a certain period of time. 
        /// There will only be one type of persistence window (duration that is allowed to elapse between drug exposures) applied to this CDM, which is 30 days. 
        /// </summary>
        /// <param name="drugExposures">set of drug exposure entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of drug era</returns>
        public virtual IEnumerable<EraEntity> BuildDrugEra(DrugExposure[] drugExposures, ObservationPeriod[] observationPeriods)
        {
            foreach (var eraEntity in EraHelper.GetEras(
                Clean(drugExposures, observationPeriods, false).Where(d => string.IsNullOrEmpty(d.Domain) || d.Domain == "Drug"), 30, 38000182))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).DrugEraId;
                yield return eraEntity;
            }
        }

        /// <summary>
        /// Projects Enumeration of Cohort from the raw set of Cohort entities. 
        ///  </summary>
        /// <param name="cohort">raw set of Cohort entities</param>
        /// <param name="observationPeriods">the observation periods entities for current person</param>
        /// <returns>Enumeration of Cohort from the raw set of Cohort entities</returns>
        public virtual IEnumerable<Cohort> BuildCohort(Cohort[] cohort, ObservationPeriod[] observationPeriods)
        {
            return cohort;
        }

        public IEnumerable<EraEntity> BuildPregnancyEpisodes(ConditionOccurrence[] conditionOccurrences,
            ProcedureOccurrence[] procedureOccurrences, Observation[] observations, Measurement[] measurements, DrugExposure[] drugExposures)
        {

            return null;
        }

        public virtual IEnumerable<DeviceExposure> BuildDeviceExposure(DeviceExposure[] devExposure,
            Dictionary<long, VisitOccurrence> visitOccurrences,
            ObservationPeriod[] observationPeriods)
        {
            return BuildEntities(devExposure, visitOccurrences, observationPeriods, false);
        }

        /// <summary>
        /// Projects Enumeration of drug cost from the set of drug exposure entities.
        /// </summary>
        /// <param name="drugExposures">set of drug exposure entities</param>
        /// <returns>set of drug cost entities</returns>
        public virtual IEnumerable<DrugCost> BuildDrugCosts(DrugExposure[] drugExposures)
        {
            foreach (var drugExposure in drugExposures.Where(drugExposure => drugExposure.DrugCost != null))
            {
                drugExposure.DrugCost.Id = drugExposure.Id;
                yield return drugExposure.DrugCost;
            }
        }

        /// <summary>
        /// Projects Enumeration of procedure cost from the set of procedure occurrence entities.
        /// </summary>
        /// <param name="procedureOccurrences">set of procedure occurrence entities</param>
        /// <returns>set of procedure cost entities</returns>
        public virtual IEnumerable<ProcedureCost> BuildProcedureCosts(ProcedureOccurrence[] procedureOccurrences)
        {
            foreach (var po in procedureOccurrences.Where(i => i.ProcedureCosts != null))
            {
                foreach (var pc in po.ProcedureCosts)
                {
                    pc.Id = po.Id;
                    yield return pc;
                }
            }
        }

        public virtual IEnumerable<VisitCost> BuildVisitCosts(VisitOccurrence[] visitOccurrences)
        {
            foreach (var vo in visitOccurrences.Where(i => i.VisitCosts != null))
            {
                foreach (var vc in vo.VisitCosts)
                {
                    vc.Id = vo.Id;
                    yield return vc;
                }
            }
        }

        public virtual IEnumerable<DeviceCost> BuildDeviceCosts(DeviceExposure[] deviceExposure)
        {
            foreach (var de in deviceExposure.Where(i => i.DeviceCosts != null))
            {
                foreach (var dc in de.DeviceCosts)
                {
                    dc.Id = de.Id;
                    yield return dc;
                }
            }
        }

        /// <summary>
        /// Filtering raw set of entities (DrugExposures, ConditionOccurrences, ProcedureOccurrences...)
        /// </summary>
        /// <param name="entitiesToBuild">the raw set of entities</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <param name="withinTheObservationPeriod">allow records that are only inside of the observation period</param>
        /// <returns>Enumeration of filtered entities</returns>
        public virtual IEnumerable<T> BuildEntities<T>(IEnumerable<T> entitiesToBuild,
            IDictionary<long, VisitOccurrence> visitOccurrences, IEnumerable<ObservationPeriod> observationPeriods, bool withinTheObservationPeriod)
            where T : IEntity
        {
            var uniqueEntities = new HashSet<T>();
            foreach (var e in Clean(entitiesToBuild, observationPeriods, withinTheObservationPeriod))
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

        /// <summary>
        /// Build person entity and all person related entities like: DrugExposures, ConditionOccurrences, ProcedureOccurrences... from raw data sets 
        /// </summary>
        public virtual Attrition Build(ChunkData data, KeyMasterOffsetManager o)
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
                BuildObservationPeriods(person.ObservationPeriodGap, [.. ObservationPeriodsRaw]).ToArray();

            // Delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH
            if (Excluded(person, observationPeriods))
            {
                Complete = true;
                return Attrition.ImplausibleYOBPostEarliestOP;
            }

            var payerPlanPeriods = BuildPayerPlanPeriods([.. PayerPlanPeriodsRaw], null).ToArray();
            var visitOccurrences = new Dictionary<long, VisitOccurrence>();

            foreach (var visitOccurrence in BuildVisitOccurrences([.. VisitOccurrencesRaw], observationPeriods))
            {
                if (visitOccurrence.IdUndefined)
                    visitOccurrence.Id = Offset.GetKeyOffset(visitOccurrence.PersonId).VisitOccurrenceId;

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
            }

            var visitDetails = BuildVisitDetails([.. VisitDetailsRaw], [.. VisitOccurrencesRaw],
                observationPeriods).ToArray();

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

            // set corresponding PlanPeriodIds to drug exposure entities and procedure occurrence entities
            SetPayerPlanPeriodId(payerPlanPeriods, drugExposures, procedureOccurrences,
                [.. visitOccurrences.Values],
                deviceExposure);

            // set corresponding ProviderIds
            SetProviderIds(drugExposures);
            SetProviderIds(conditionOccurrences);
            SetProviderIds(procedureOccurrences);
            SetProviderIds(observations);

            var death = BuildDeath([.. DeathRecords], visitOccurrences, observationPeriods);
            death = UpdateDeath(death, person, observationPeriods);

            // TODO: TMP
            var drugCosts = BuildDrugCosts(drugExposures).ToArray();
            var procedureCosts = BuildProcedureCosts(procedureOccurrences).ToArray();
            var visitCosts = BuildVisitCosts([.. visitOccurrences.Values]).ToArray();
            var devicCosts = BuildDeviceCosts(deviceExposure).ToArray();

            var cohort = BuildCohort([.. CohortRecords], observationPeriods).ToArray();
            var notes = BuildNote([.. NoteRecords], visitOccurrences, observationPeriods).ToArray();
            var episode = BuildEpisode([.. EpisodeRecords], visitOccurrences, observationPeriods).ToArray();

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(
                person, 
                death, 
                observationPeriods, 
                payerPlanPeriods,
                FilterByDeathDate(drugExposures, death, 60).ToArray(),
                FilterByDeathDate(conditionOccurrences, death, 60).ToArray(),
                FilterByDeathDate(procedureOccurrences, death, 60).ToArray(),
                FilterByDeathDate(observations, death, 60).ToArray(),
                FilterByDeathDate(measurements, death, 60).ToArray(),
                FilterByDeathDate(visitOccurrences.Values, death, 60).ToArray(),
                FilterByDeathDate(visitDetails, death, 60).ToArray(), 
                cohort,
                FilterByDeathDate(deviceExposure, death, 60).ToArray(), 
                notes, 
                episode);

            foreach (var c in CostRaw)
                ChunkData.AddCostData(c);

            Complete = true;

            var pg = new PregnancyAlgorithm.PregnancyAlgorithm();
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

        protected void AddToChunk(Person person, Death death, ObservationPeriod[] observationPeriods,
            PayerPlanPeriod[] ppp, DrugExposure[] drugExposures,
            ConditionOccurrence[] conditionOccurrences,
            ProcedureOccurrence[] procedureOccurrences, Observation[] observations,
            VisitOccurrence[] visitOccurrences, Cohort[] cohort)
        {
            AddToChunk(person, death, observationPeriods,
                ppp, drugExposures,
                conditionOccurrences,
                procedureOccurrences, observations, [], visitOccurrences, null, cohort, [],
                [], []);
        }

        /// <summary>
        /// Push built entities to ChunkBuilder for further save to CDM database
        /// </summary>
        /// <param name="person">person entity</param>
        /// <param name="death">death entity</param>
        /// <param name="observationPeriods">the observation period entities for current person</param>
        /// <param name="ppp">the payerplan period entities for current person</param>
        /// <param name="drugExposures">the drug exposure entities for current person</param>
        /// <param name="conditionOccurrences">the condition occurrence entities for current person</param>
        /// <param name="procedureOccurrences">the procedure occurrence entities for current person</param>
        /// <param name="observations">the observation entities for current person</param>
        /// <param name="visitOccurrences">the visit occurrence entities for current person</param>

        /// <param name="cohort">the cohort entities for current person</param>
        public virtual void AddToChunk(Person person, Death death, ObservationPeriod[] observationPeriods,
            PayerPlanPeriod[] ppp, DrugExposure[] drugExposures,
            ConditionOccurrence[] conditionOccurrences,
            ProcedureOccurrence[] procedureOccurrences, Observation[] observations,
            Measurement[] measurements, VisitOccurrence[] visitOccurrences, VisitDetail[] visitDetails, Cohort[] cohort,
            DeviceExposure[] devExposure, Note[] notes, Episode[] episodes)
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

            foreach (var visitOccurrence in visitOccurrences)
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
                }
            }

            if (episodes != null)
            {
                foreach (var e in episodes)
                {
                    ChunkData.Episode.Add(e);
                }
            }

            AddToChunk("Condition", conditionOccurrences);
            AddToChunk("Drug", drugExposures);
            AddToChunk("Procedure", procedureOccurrences);
            AddToChunk("Observation", observations);
            AddToChunk("Measurement", measurements);
            AddToChunk("Device", devExposure);

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

        public string GetDomain(string entityDomain, string conceptDomain, string defaultDomain)
        {
            switch (conceptDomain)
            {
                case "Condition":
                case "Measurement":
                case "Observation":
                case "Procedure":
                case "Device":
                case "Drug":
                    return conceptDomain;

                default:
                    {
                        if (string.IsNullOrEmpty(conceptDomain) && !string.IsNullOrEmpty(entityDomain))
                            return entityDomain;

                        if (string.IsNullOrEmpty(defaultDomain))
                            return entityDomain;

                        return defaultDomain;
                    }
            }
        }

        public virtual void AddToChunk(string domain, IEnumerable<IEntity> entities)
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
                        ChunkData.AddData(entity as Measurement ?? new Measurement(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                        });
                        break;

                    case "Meas Value":
                        ChunkData.AddData(entity as Measurement ?? new Measurement(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).MeasurementId
                        });
                        break;

                    case "Observation":
                        ChunkData.AddData(entity as Observation ?? new Observation(entity)
                        {
                            Id = Offset.GetKeyOffset(entity.PersonId).ObservationId
                        });
                        break;

                    case "Procedure":
                        ChunkData.AddData(entity as ProcedureOccurrence ??
                                          new ProcedureOccurrence(entity)
                                          {
                                              Id =
                                                  Offset.GetKeyOffset(entity.PersonId).ProcedureOccurrenceId
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

                        DrugForEra.Add(drg);
                        ChunkData.AddData(drg);
                        break;

                }
            }
        }


        /// exclude records that out of any available observation period records
        protected static IEnumerable<T> Clean<T>(IEnumerable<T> input,
            IEnumerable<ObservationPeriod> observationPeriods, bool withinTheObservationPeriod) where T : IEntity
        {
            if (withinTheObservationPeriod)
            {
                return input.Where(item =>
                    observationPeriods.FirstOrDefault(p => item.StartDate.Date.Between(p.StartDate.Date, p.EndDate.Value.Date)) !=
                    null);
            }

            return input;
        }

        /// <summary>
        /// Delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH
        /// </summary>
        /// <param name="person">the current person entity</param>
        /// <param name="periods">the observation period entities for current person</param>
        /// <returns>Enumeration of filtered entities</returns>
        public virtual bool Excluded(Person person, IEnumerable<ObservationPeriod> periods)
        {
            return periods.Any(period => person.YearOfBirth - period.StartDate.Year >= 2);
        }

        public void JoinToVocabulary(IVocabulary vocabulary)
        {
            Vocabulary ??= vocabulary;
        }

        //protected static void AddEntity<T>(T entity, List<T> list) where T : IEntity
        public static IEnumerable<T> UpdateRSourceConcept<T>(IEnumerable<T> records) where T : IEntity
        {
            var r = new List<T>();
            foreach (var record in records)
            {
                if (record.SourceConcepts != null && record.SourceConcepts.Any(r => char.ToLower(r.InvalidReason) == 'r'))
                {
                    r.Add(record);
                }
                else
                    yield return record;
            }

            if (r.Count > 1)
            {
                foreach (var byGuid in r.GroupBy(i => i.SourceRecordGuid))
                {
                    foreach (var bySource in byGuid.GroupBy(i => i.SourceValue))
                    {
                        foreach (var byStartDate in bySource.GroupBy(i => i.StartDate))
                        {
                            var e = byStartDate.Where(i => i.StartDate.Between(i.ValidStartDate, i.ValidEndDate)).FirstOrDefault();
                            e ??= byStartDate.First();

                            long newSourceConceptId = 0;
                            long newConceptId = 0;

                            foreach (var sc in e.SourceConcepts)
                            {
                                if (char.ToLower(sc.InvalidReason) != 'r')
                                    continue;

                                if (e.StartDate.Between(sc.ValidStartDate, sc.ValidEndDate))
                                {
                                    newSourceConceptId = sc.ConceptId;
                                }

                                if (e.StartDate.Between(e.ValidStartDate, e.ValidEndDate))
                                {
                                    newConceptId = e.ConceptId;
                                }
                            }

                            if (e.ConceptId != newConceptId || e.SourceConceptId != newSourceConceptId)
                            {
                                e.ConceptId = newConceptId;
                                e.SourceConceptId = newSourceConceptId;
                            }

                            yield return e;

                            if (e.SourceConcepts.Count != byStartDate.Count())
                            {

                            }
                        }
                    }
                }
            }
        }

        public static IEnumerable<T> FilterByDeathDate<T>(IEnumerable<T> items, Death death, int gap) where T : IEntity
        {
            foreach (var item in items)
            {
                if (death == null)
                    yield return item;
                else if (item.StartDate.Date <= death.StartDate.AddDays(gap))
                    yield return item;
            }
        }

        public static Death UpdateDeath(Death death, Person person, ObservationPeriod[] observationPeriods)
        {
            if (death == null)
                return null;

            if (observationPeriods.Any(op => death.StartDate.Date < op.StartDate.Date))
                return null;
            else if (person.YearOfBirth.HasValue && person.YearOfBirth.Value > 0 && person.YearOfBirth > death.StartDate.Year)
                return null;

            return death;
        }
        #endregion
    }
}