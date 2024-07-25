using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class PayerPlanPeriod : EraEntity
    {
        public string FamilySourceValue { get; set; }

        public long PayerConceptId { get; set; }
        public long PayerSourceConceptId { get; set; }
        public string PayerSourceValue { get; set; }

        public long PlanConceptId { get; set; }
        public long PlanSourceConceptId { get; set; }
        public string PlanSourceValue { get; set; }

        public long SponsorConceptId { get; set; }
        public long SponsorSourceConceptId { get; set; }
        public string SponsorSourceValue { get; set; }

        public long StopReasonConceptId { get; set; }
        public long StopReasonSourceConceptId { get; set; }
        public string StopReasonSourceValue { get; set; }

        public long? ContractPersonId { get; set; }
        public long? ContractConceptId { get; set; }
        public string ContractSourceValue { get; set; }
        public long? ContractSourceConceptId { get; set; }

        public override EntityType GeEntityType()
        {
            return EntityType.PayerPlanPeriod;
        }
    }
}