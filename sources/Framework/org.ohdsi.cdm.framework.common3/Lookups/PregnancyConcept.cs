using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class PregnancyConcept
    {
        public int EventId { get; set; }
        public long ConceptId { get; set; }
        public string Category { get; set; }
        public string DataValue { get; set; }
        public int? GestValue { get; set; }

        public decimal? ValueAsNumber { get; set; }

        public IEntity Entity { get; set; }
    }
}