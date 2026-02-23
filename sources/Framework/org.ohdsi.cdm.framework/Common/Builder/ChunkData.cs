using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.framework.common.Builder
{
    public class ChunkData
    {

        public int SubChunkId { get; set; }
        public int ChunkId { get; set; }

        public List<Person> Persons { get; private set; }
        public List<Death> Deaths { get; private set; }
        public List<Note> Note { get; private set; }
        public List<NoteNlp> NoteNlp { get; private set; }
        public List<Episode> Episode { get; private set; }
        public List<EpisodeEvent> EpisodeEvent { get; private set; }
        public List<ObservationPeriod> ObservationPeriods { get; private set; }
        public List<PayerPlanPeriod> PayerPlanPeriods { get; private set; }
        public List<ConditionOccurrence> ConditionOccurrences { get; private set; }
        public List<DrugExposure> DrugExposures { get; private set; }
        public List<ProcedureOccurrence> ProcedureOccurrences { get; private set; }
        public List<Observation> Observations { get; private set; }
        public List<Measurement> Measurements { get; private set; }
        public List<VisitOccurrence> VisitOccurrences { get; private set; }
        public List<VisitDetail> VisitDetails { get; private set; }

        public List<EraEntity> ConditionEra { get; private set; }
        public List<EraEntity> DrugEra { get; private set; }
        public List<Cohort> Cohort { get; private set; }
        public List<DeviceExposure> DeviceExposure { get; private set; }

        public List<Cost> Cost { get; private set; }
        public Dictionary<long, Metadata> Metadata { get; private set; }

        public List<FactRelationship> FactRelationships { get; private set; }

        public ChunkData(int chunkId, int subChunkId)
        {
            ChunkId = chunkId;
            SubChunkId = subChunkId;
            Init();
        }

        public void AddAttrition(long personId, Attrition attrition, int count = 0) 
        {
            if (attrition == Attrition.None)
                return;

            if (!Metadata.ContainsKey(personId))
                Metadata.Add(personId, null);

            Metadata[personId] = new Metadata 
            { 
                PersonId = personId, 
                Name = attrition.ToName(), 
                Count = count
            };
        }


        public ChunkData()
        {
            Init();
        }

        public void Init()
        {
            Metadata = [];
            Persons = [];
            Deaths = [];
            ObservationPeriods = [];
            PayerPlanPeriods = [];
            ConditionOccurrences = [];
            DrugExposures = [];
            ProcedureOccurrences = [];
            Observations = [];
            Measurements = [];
            VisitOccurrences = [];
            VisitDetails = [];

            ConditionEra = [];
            DrugEra = [];
            Cohort = [];
            DeviceExposure = [];
            Cost = [];
            Note = [];
            NoteNlp = [];
            Episode = [];
            EpisodeEvent = [];
            FactRelationships = [];
        }

        public void Clean()
        {
            Metadata = null;
            Persons = null;
            Deaths = null;
            ObservationPeriods = null;
            PayerPlanPeriods = null;
            ConditionOccurrences = null;
            DrugExposures = null;
            ProcedureOccurrences = null;
            Observations = null;
            Measurements = null;
            VisitOccurrences = null;
            VisitDetails = null;

            ConditionEra = null;
            DrugEra = null;
            Cohort = null;
            DeviceExposure = null;
            Cost = null;
            Note = null;
            NoteNlp = null;
            Episode = null;
            EpisodeEvent = null;
            FactRelationships = null;
        }

        public bool AddCostData(Cost cost)
        {
            if (cost == null)
                return false;
            if (cost.PaidPatientCopay == 0 && cost.PaidPatientCoinsurance == 0 && cost.PaidPatientDeductible == 0 &&
                cost.PaidByPayer == 0 && cost.TotalPaid == 0)
                return false;

            Cost.Add(cost);
            return true;
        }

        public void AddNoteNlp(NoteNlp noteNlp)
        {
            NoteNlp.Add(noteNlp);
        }

        public void AddData(IEntity data, EntityType entityType)
        {
            switch (entityType)
            {
                case EntityType.Person:
                    {
                        Persons.Add((Person)data);
                        break;
                    }

                case EntityType.Death:
                    {
                        Deaths.Add((Death)data);
                        break;
                    }

                case EntityType.PayerPlanPeriod:
                    {
                        PayerPlanPeriods.Add((PayerPlanPeriod)data);
                        break;
                    }

                case EntityType.ConditionOccurrence:
                    {
                        ConditionOccurrences.Add((ConditionOccurrence)data);
                        break;
                    }

                case EntityType.DrugExposure:
                    {
                        DrugExposures.Add((DrugExposure)data);
                        break;
                    }

                case EntityType.ProcedureOccurrence:
                    {
                        ProcedureOccurrences.Add((ProcedureOccurrence)data);
                        break;
                    }

                case EntityType.Observation:
                    {
                        Observations.Add((Observation)data);
                        break;
                    }

                case EntityType.VisitOccurrence:
                    {
                        VisitOccurrences.Add((VisitOccurrence)data);
                        break;
                    }

                case EntityType.VisitDetail:
                    {
                        VisitDetails.Add((VisitDetail)data);
                        break;
                    }

                case EntityType.Cohort:
                    {
                        Cohort.Add((Cohort)data);
                        break;
                    }

                case EntityType.Measurement:
                    {
                        Measurements.Add((Measurement)data);
                        break;
                    }

                case EntityType.DeviceExposure:
                    {
                        DeviceExposure.Add((DeviceExposure)data);
                        break;
                    }

                case EntityType.ObservationPeriod:
                    {
                        ObservationPeriods.Add((ObservationPeriod)data);
                        break;
                    }

                case EntityType.DrugEra:
                    {
                        DrugEra.Add((EraEntity)data);
                        break;
                    }

                case EntityType.ConditionEra:
                    {
                        ConditionEra.Add((EraEntity)data);
                        break;
                    }

                case EntityType.Note:
                    {
                        Note.Add((Note)data);
                        break;
                    }

                case EntityType.Episode:
                    {
                        Episode.Add((Episode)data);
                        break;
                    }

                case EntityType.EpisodeEvent:
                    {
                        EpisodeEvent.Add((EpisodeEvent)data);
                        break;
                    }
            }
        }

        public void AddData(IEntity data)
        {
            AddData(data, data.GeEntityType());
        }
    }
}
