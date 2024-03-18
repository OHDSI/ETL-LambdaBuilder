using System;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class VisitCost(VisitOccurrence ent) : IEquatable<VisitCost>, ICostV5
    {
        public long Id { get; set; } = ent.Id;
        public long PersonId { get; set; } = ent.PersonId;

        public long VisitCostId { get; set; }

        public decimal? IngredientCost { get; set; }
        public decimal? DispensingFee { get; set; }
        public decimal? AverageWholesalePrice { get; set; }
        public long CurrencyConceptId { get; set; }

        public decimal? PaidCopay { get; set; }
        public decimal? PaidCoinsurance { get; set; }
        public decimal? PaidTowardDeductible { get; set; }
        public decimal? PaidByPayer { get; set; }
        public decimal? PaidByCoordinationBenefits { get; set; }
        public decimal? TotalOutOfPocket { get; set; }
        public decimal? TotalPaid { get; set; }

        public long? PayerPlanPeriodId { get; set; }
        public long? DrgConceptId { get; set; }
        public long? RevenueCodeConceptId { get; set; }
        public string DrgSourceValue { get; set; }
        public string RevenueCodeSourceValue { get; set; }

        public bool Equals(VisitCost other)
        {
            return this.PaidCopay.Equals(other.PaidCopay) &&
                   this.PaidCoinsurance == other.PaidCoinsurance &&
                   this.PaidTowardDeductible == other.PaidTowardDeductible &&
                   this.PaidByPayer == other.PaidByPayer &&
                   this.PaidByCoordinationBenefits == other.PaidByCoordinationBenefits &&
                   this.TotalOutOfPocket == other.TotalOutOfPocket &&
                   this.TotalPaid == other.TotalPaid &&
                   this.PayerPlanPeriodId == other.PayerPlanPeriodId &&
                   this.CurrencyConceptId == other.CurrencyConceptId;
        }

        public override int GetHashCode()
        {
            return PaidCopay.GetHashCode() ^
                   PaidCoinsurance.GetHashCode() ^
                   PaidTowardDeductible.GetHashCode() ^
                   PaidByPayer.GetHashCode() ^
                   PaidByCoordinationBenefits.GetHashCode() ^
                   TotalOutOfPocket.GetHashCode() ^
                   TotalPaid.GetHashCode() ^
                   PayerPlanPeriodId.GetHashCode() ^
                   CurrencyConceptId.GetHashCode();
        }

        public Cost CreateCost(long costId)
        {
            return new Cost(PersonId)
            {
                CostId = costId,
                CurrencyConceptId = CurrencyConceptId,
                TotalCharge = null,
                TotalCost = null,

                PayerPlanPeriodId = PayerPlanPeriodId,

                PaidPatientCopay = PaidCopay,
                PaidPatientCoinsurance = PaidCoinsurance,
                PaidPatientDeductible = PaidTowardDeductible,
                PaidByPrimary = PaidByCoordinationBenefits,

                DrgConceptId = DrgConceptId,
                DrgSourceValue = DrgSourceValue,

                TotalPaid =
                    PaidCopay + PaidCoinsurance + PaidTowardDeductible + PaidByPayer +
                    PaidByCoordinationBenefits,

                PaidByPatient = PaidCopay + PaidCoinsurance + PaidTowardDeductible,
                PaidByPayer = PaidByPayer,

                Domain = "Visit",
                TypeId = 0,
                EventId = Id
            };
        }
    }
}
