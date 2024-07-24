namespace org.ohdsi.cdm.framework.common.Omop
{
    public class Cost(long personId)
    {
        public long PersonId { get; set; } = personId;
        public string Domain { get; set; }
        public long CostId { get; set; }
        public long EventId { get; set; }

        public long? TypeId { get; set; }
        public long CurrencyConceptId { get; set; }

        public decimal? TotalCharge { get; set; }
        public decimal? TotalCost { get; set; }
        public decimal? TotalPaid { get; set; }
        public decimal? PaidByPayer { get; set; }
        public decimal? PaidByPatient { get; set; }
        public decimal? PaidPatientCopay { get; set; }
        public decimal? PaidPatientCoinsurance { get; set; }
        public decimal? PaidPatientDeductible { get; set; }
        public decimal? PaidByPrimary { get; set; }
        public decimal? PaidIngredientCost { get; set; }
        public decimal? PaidDispensingFee { get; set; }
        public long? PayerPlanPeriodId { get; set; }
        public decimal? AmountAllowed { get; set; }

        public long? RevenueCodeConceptId { get; set; }
        public string RevenueCodeSourceValue { get; set; }

        public long? DrgConceptId { get; set; }
        public string DrgSourceValue { get; set; }


        public string SourceValue { get; set; }
        public long? SourceConceptId { get; set; }

        public long? CostConceptId { get; set; }
        public long? EventFieldConceptId { get; set; }
        public decimal? CostValue { get; set; }

        public DateTime IncurredDate { get; set; }
        public DateTime? BilledDate { get; set; }
        public DateTime? PaidDate { get; set; }
    }
}
