using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class CostRawDefinition : EntityDefinition
    {
        public string TypeConceptId { get; set; }

        public string EventId { get; set; }
        public string DomainId { get; set; }
        public string CurrencyConceptId { get; set; }
        public string TotalCharge { get; set; }
        public string TotalCost { get; set; }
        public string TotalPaid { get; set; }
        

        public string PaidByPayer { get; set; }
        public string PaidByPatient { get; set; }
        public string PaidPatientCopay { get; set; }
        public string PaidPatientCoinsurance { get; set; }
        public string PaidPatientDeductible { get; set; }
        public string PaidIngredientCost { get; set; }
        public string PaidDispensingFee { get; set; }

        public string PayerPlanPeriodId { get; set; }
        
        public string AmountAllowed { get; set; }
        
        public string RevenueCodeConceptId { get; set; }
        public string RevenueCodeSourceValue { get; set; }

        public string DrgConceptId { get; set; }
        public string DrgSourceValue { get; set; }


        public IEnumerable<Cost> GetCost(Concept concept, IDataRecord reader,
           KeyMasterOffsetManager offset)
        {
            var presonId = reader.GetLong(PersonId);
            yield return new Cost(presonId.Value)
            {
                Id = reader.GetLong(Id),

                PersonId = presonId.Value,
                TypeId = reader.GetLong(TypeConceptId),
                
                EventId = reader.GetLong(EventId) ?? 0,
                Domain = reader.GetString(DomainId),
                CurrencyConceptId = reader.GetLong(CurrencyConceptId) ?? 0,
                TotalCharge = reader.GetDecimal(TotalCharge),
                TotalCost = reader.GetDecimal(TotalCost),
                TotalPaid = reader.GetDecimal(TotalPaid),

                PaidByPayer = reader.GetDecimal(PaidByPayer),
                PaidByPatient = reader.GetDecimal(PaidByPatient),
                PaidPatientCopay = reader.GetDecimal(PaidPatientCopay),
                PaidPatientCoinsurance = reader.GetDecimal(PaidPatientCoinsurance),
                PaidPatientDeductible = reader.GetDecimal(PaidPatientDeductible),
                PaidIngredientCost = reader.GetDecimal(PaidIngredientCost),
                PaidDispensingFee = reader.GetDecimal(PaidDispensingFee),
                
                PayerPlanPeriodId = reader.GetLong(PayerPlanPeriodId),

                AmountAllowed = reader.GetDecimal(AmountAllowed),

                RevenueCodeConceptId = reader.GetLong(RevenueCodeConceptId),
                RevenueCodeSourceValue = reader.GetString(RevenueCodeSourceValue),

                DrgConceptId = reader.GetLong(DrgConceptId),
                DrgSourceValue = reader.GetString(DrgSourceValue)
            };
        }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            throw new NotImplementedException("CostDefinitionRaw.GetConcepts()");
        }
    }
}
