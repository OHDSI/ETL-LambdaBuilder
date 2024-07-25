namespace org.ohdsi.cdm.framework.common.Omop
{
    public class DoseEra : EraEntity
    {
        public long UnitConceptId { get; set; }
        public decimal DoseValue { get; set; }
    }
}
