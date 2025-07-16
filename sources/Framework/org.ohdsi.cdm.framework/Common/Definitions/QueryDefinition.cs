using org.ohdsi.cdm.framework.common.Enums;
using System.Data;
using System.Xml.Serialization;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    [XmlType(TypeName = "Variable")]
    [Serializable]
    public class QueryVariable
    {
        [XmlAttribute("database")]
        public string Database { get; set; }

        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlText]
        public string Value { get; set; }
    }

    [Serializable]
    public class Query
    {
        [XmlAttribute("database")]
        public string Database { get; set; }

        [XmlText]
        public string Text { get; set; }
    }

    public class QueryDefinition
    {
        private long _processedRowCount;

        public Guid Guid { get; set; }
        public Query Query { get; set; }
        public QueryVariable[] Variables { get; set; }
        public string FileName { get; set; }

        [XmlIgnore]
        public Dictionary<string, int> FieldHeaders { get; set; }

        [XmlIgnore]
        public bool DataProcessed { get; set; }

        [XmlIgnore]
        public bool Reading { get; set; }


        [XmlIgnore]
        public long ProcessedRowCount => _processedRowCount;

        [XmlIgnore]
        public Dictionary<long, long> ProcessedPersonIds { get; set; }


        [XmlIgnore]
        public EventWaitHandle WaitHandle { get; } = new ManualResetEvent(true);

        [XmlIgnore]
        public bool Awaiting { get; set; }

        public PersonDefinition[] Persons { get; set; }
        public PayerPlanPeriodDefinition[] PayerPlanPeriods { get; set; }
        public ConditionOccurrenceDefinition[] ConditionOccurrence { get; set; }
        public DeathDefinition[] Death { get; set; }
        public DrugExposureDefinition[] DrugExposure { get; set; }
        public DrugCostDefinition[] DrugCost { get; set; }
        public ProcedureCostDefinition[] ProcedureCost { get; set; }
        public MeasurementCostDefinition[] MeasurementCost { get; set; }
        public ObservationCostDefinition[] ObservationCost { get; set; }

        public ProcedureOccurrenceDefinition[] ProcedureOccurrence { get; set; }
        public NoteDefinition[] Note { get; set; }
        public ObservationDefinition[] Observation { get; set; }
        public MeasurementDefinition[] Measurement { get; set; }
        public VisitOccurrenceDefinition[] VisitOccurrence { get; set; }
        public VisitDetailDefinition[] VisitDetail { get; set; }
        public VisitCostDefinition[] VisitCost { get; set; }
        public CohortDefinition[] Cohort { get; set; }
        public DeviceExposureDefinition[] DeviceExposure { get; set; }
        public DeviceCostDefinition[] DeviceCost { get; set; }

        public LocationDefinition[] Locations { get; set; }
        //public LocationHistoryDefinition[] LocationHistory { get; set; }
        public OrganizationDefinition[] Organizations { get; set; }
        public CareSiteDefinition[] CareSites { get; set; }
        public ProviderDefinition[] Providers { get; set; }

        public EpisodeDefinition[] Episodes { get; set; }

        public EpisodeEventDefinition[] EpisodeEvents { get; set; }
        public ObservationPeriodDefinition[] ObservationPeriods { get; set; }

        public CostRawDefinition[] Costs { get; set; }

        private static readonly string[] separator = [","];

        public void RowProcessed()
        {
            _processedRowCount++;
        }

        public QueryDefinition()
        {
            ProcessedPersonIds = [];
        }

        public void Clean()
        {
            _processedRowCount = 0;
            ProcessedPersonIds = [];
            Awaiting = false;
            DataProcessed = false;
        }

        public static List<EntityDefinition> FindDefinition(IEnumerable<EntityDefinition> definitions, IDataRecord reader)
        {
            if (definitions == null) return null;
            var result = new List<EntityDefinition>();

            foreach (var definition in definitions)
            {
                if (!definition.Match(reader)) continue;

                result.Add(definition);
            }

            return result;
        }

        public string GetSql(Vendor vendor, string sourceSchema, string chunkSchema, string param1)
        {
            if (!IsSuitable(Query.Database, vendor))
                return null;

            if (Variables == null || Variables.Length == 0)
                return Query.Text.Replace("{sc}", sourceSchema).Replace("{ch_sc}", chunkSchema).Replace("{param1}", param1);

            foreach (var v in Variables)
            {
                if (!IsSuitable(v.Database, vendor))
                    continue;

                Query.Text = Query.Text.Replace("{" + v.Name + "}", v.Value);
            }

            return Query.Text.Replace("{sc}", sourceSchema).Replace("{ch_sc}", chunkSchema).Replace("{param1}", param1);
        }


        public string GetSql(Vendor vendor)
        {
            if (!IsSuitable(Query.Database, vendor))
                return null;

            if (Variables == null || Variables.Length == 0)
                return Query.Text;

            foreach (var v in Variables)
            {
                if (!IsSuitable(v.Database, vendor))
                    continue;

                Query.Text = Query.Text.Replace("{" + v.Name + "}", v.Value);
            }

            return Query.Text;
        }

        public static bool IsSuitable(string databases, Vendor vendor)
        {
            if (string.IsNullOrEmpty(databases))
                return true;

            if (databases.Equals("none", StringComparison.OrdinalIgnoreCase))
                return false;

            return
               databases.Split(separator, StringSplitOptions.RemoveEmptyEntries)
                  .Any(db => vendor.ToString().Contains(db.Trim(), StringComparison.CurrentCultureIgnoreCase));
        }

        public string GetPersonIdFieldName()
        {
            if (Persons != null && Persons.Length != 0)
            {
                return Persons[0].PersonId;
            }

            if (PayerPlanPeriods != null && PayerPlanPeriods.Length != 0)
            {
                return PayerPlanPeriods[0].PersonId;
            }

            if (ConditionOccurrence != null && ConditionOccurrence.Length != 0)
            {
                return ConditionOccurrence[0].PersonId;
            }

            if (Death != null && Death.Length != 0)
            {
                return Death[0].PersonId;
            }

            if (DrugExposure != null && DrugExposure.Length != 0)
            {
                return DrugExposure[0].PersonId;
            }

            if (ProcedureOccurrence != null && ProcedureOccurrence.Length != 0)
            {
                return ProcedureOccurrence[0].PersonId;
            }

            if (Observation != null && Observation.Length != 0)
            {
                return Observation[0].PersonId;
            }

            if (Measurement != null && Measurement.Length != 0)
            {
                return Measurement[0].PersonId;
            }

            if (VisitOccurrence != null && VisitOccurrence.Length != 0)
            {
                return VisitOccurrence[0].PersonId;
            }

            if (VisitDetail != null && VisitDetail.Length != 0)
            {
                return VisitDetail[0].PersonId;
            }

            if (Cohort != null && Cohort.Length != 0)
            {
                return Cohort[0].PersonId;
            }

            if (DeviceExposure != null && DeviceExposure.Length != 0)
            {
                return DeviceExposure[0].PersonId;
            }

            if (Note != null && Note.Length != 0)
            {
                return Note[0].PersonId;
            }

            if (Episodes != null && Episodes.Length != 0)
            {
                return Episodes[0].PersonId;
            }

            if (EpisodeEvents != null && EpisodeEvents.Length != 0)
            {
                return EpisodeEvents[0].PersonId;
            }

            if (ObservationPeriods != null && ObservationPeriods.Length != 0)
            {
                return ObservationPeriods[0].PersonId;
            }

            if (Costs != null && Costs.Length != 0)
            {
                return Costs[0].PersonId;
            }

            throw new Exception("Cant find PersonId FieldName " + this.FileName);
        }
    }
}