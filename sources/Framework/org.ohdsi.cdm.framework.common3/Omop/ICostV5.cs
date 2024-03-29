﻿namespace org.ohdsi.cdm.framework.common.Omop
{
    public interface ICostV5
    {
        long PersonId { get; set; }
        decimal? PaidCopay { get; set; }
        decimal? PaidCoinsurance { get; set; }
        decimal? PaidTowardDeductible { get; set; }
        decimal? PaidByPayer { get; set; }
        decimal? PaidByCoordinationBenefits { get; set; }
        decimal? TotalOutOfPocket { get; set; }
        decimal? TotalPaid { get; set; }

        long? PayerPlanPeriodId { get; set; }

        long? DrgConceptId { get; set; }
        long? RevenueCodeConceptId { get; set; }
        string DrgSourceValue { get; set; }
        string RevenueCodeSourceValue { get; set; }

        decimal? IngredientCost { get; set; }
        decimal? DispensingFee { get; set; }
        decimal? AverageWholesalePrice { get; set; }

        long CurrencyConceptId { get; set; }
    }
}
