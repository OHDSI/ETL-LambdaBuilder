namespace org.ohdsi.cdm.framework.common2.Omop
{
    public class Cost
    {
        public long PersonId { get; set; }
        public string Domain { get; set; }
        public long CostId { get; set; }
        public long EventId { get; set; }

        public int TypeId { get; set; }
        public int CurrencyConceptId { get; set; }

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

        public int? RevenueCodeConceptId { get; set; }
        public string RevenueCodeSourceValue { get; set; }

        public int? DrgConceptId { get; set; }
        public string DrgSourceValue { get; set; }

        public Cost(long personId)
        {
            PersonId = personId;
        }
    }
}
