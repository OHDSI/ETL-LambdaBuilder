using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class DrugExposureDefinition : EntityDefinition
    {
        public string DaysSupply { get; set; }
        public string Refill { get; set; }
        public string Quantity { get; set; }
        public string Sig { get; set; }

        public string RouteConceptId { get; set; }
        public string RouteSourceValue { get; set; }
        public string DoseUnitConceptId { get; set; }
        public string DoseUnitSourceValue { get; set; }
        public string StopReason { get; set; }
        public string LotNumber { get; set; }
        

        // CDM v5.2 props
        public string VerbatimEndDate { get; set; }


        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            DateTime? endDate = null;

            long? routeConceptId = null;
            string routeSourceValue;
            if (Concepts.Length == 2)
            {
                var routeConcepts = base.GetConcepts(Concepts[1], reader, null).ToList();
                routeSourceValue = reader.GetString(Concepts[1].Fields[0].Key);
                if (routeConcepts.Count > 0)
                {
                    routeConceptId = routeConcepts[0].ConceptId;
                    routeSourceValue = routeConcepts[0].SourceValue;
                }
            }
            else
            {
                routeConceptId = reader.GetInt(RouteConceptId);
                routeSourceValue = reader.GetString(RouteSourceValue);
            }


            foreach (var c in base.GetConcepts(concept, reader, offset))
            {
                var e = (Entity)c;

                var calculatedDaysSupply = reader.GetInt(DaysSupply) ?? 1;

                if (string.IsNullOrEmpty(DaysSupply) && !string.IsNullOrEmpty(EndDate))
                {
                    endDate = reader.GetDateTime(EndDate);
                }
                else if (calculatedDaysSupply > 0 && calculatedDaysSupply <= 365)
                {
                    endDate = e.StartDate.AddDays(calculatedDaysSupply - 1);
                }
                else if (!string.IsNullOrEmpty(EndDate))
                {
                    endDate = reader.GetDateTime(EndDate);
                }

                var verbatimEndDate = reader.GetDateTime(VerbatimEndDate);

                var de = new DrugExposure(e)
                {
                    Refills = reader.GetIntSafe(Refill),
                    DaysSupply = reader.GetInt(DaysSupply),
                    CalculatedDaysSupply = calculatedDaysSupply,
                    Quantity = reader.GetDecimal(Quantity),
                    Sig = reader.GetString(Sig),
                    EndDate = endDate == DateTime.MinValue ? null : endDate,
                    VerbatimEndDate = verbatimEndDate == DateTime.MinValue ? (DateTime?)null : verbatimEndDate,
                    RouteConceptId = routeConceptId,
                    RouteSourceValue = routeSourceValue,
                    DoseUnitConceptId = reader.GetInt(DoseUnitConceptId) ?? 0,
                    DoseUnitSourceValue = reader.GetString(DoseUnitSourceValue),
                    StopReason = reader.GetString(StopReason) == "" ? null : reader.GetString(StopReason),
                    LotNumber = reader.GetString(LotNumber)
                };

                var id = reader.GetLong(Id);

                if (id.HasValue)
                {
                    de.Id = id.Value;
                }
                else
                {
                    de.Id = offset.GetKeyOffset(e.PersonId).DrugExposureId;
                }

                yield return de;
            }
        }
    }
}
