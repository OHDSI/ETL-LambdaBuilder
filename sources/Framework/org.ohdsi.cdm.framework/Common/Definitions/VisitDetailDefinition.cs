using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class VisitDetailDefinition : EntityDefinition
    {
        public string CareSiteId { get; set; }

        // CDM v5.2 props
        public string AdmittingSourceConceptId { get; set; }
        public string AdmittingSourceValue { get; set; }
        public string DischargeToConceptId { get; set; }
        public string DischargeToSourceValue { get; set; }
        public string PrecedingVisitDetailId { get; set; }
        public string ParentId { get; set; }
        

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager keyOffset)
        {
            var visitDetails = base.GetConcepts(concept, reader, keyOffset).ToList();

            if (visitDetails.Count > 0)
            {
                long? dischargeToConceptId = null;
                string dischargeToSourceValue;
                if (Concepts.Length > 1)
                {
                    var dischargeConcepts = base.GetConcepts(Concepts[1], reader, null).ToList();
                    dischargeToSourceValue = reader.GetString(Concepts[1].Fields[0].Key);
                    if (dischargeConcepts.Count > 0)
                    {
                        dischargeToConceptId = dischargeConcepts[0].ConceptId;
                        dischargeToSourceValue = dischargeConcepts[0].SourceValue;
                    }
                }
                else
                {
                    dischargeToConceptId = reader.GetInt(DischargeToConceptId);
                    dischargeToSourceValue = reader.GetString(DischargeToSourceValue);
                }


                long? admittingSourceConceptId = null;
                string admittingSourceValue;
                if (Concepts.Length > 2)
                {
                    var admittingConcepts = base.GetConcepts(Concepts[2], reader, null).ToList();
                    admittingSourceValue = reader.GetString(Concepts[2].Fields[0].Key);
                    if (admittingConcepts.Count > 0)
                    {
                        admittingSourceConceptId = admittingConcepts[0].ConceptId;
                        admittingSourceValue = admittingConcepts[0].SourceValue;
                    }
                }
                else
                {
                    admittingSourceConceptId = reader.GetInt(AdmittingSourceConceptId);
                    admittingSourceValue = reader.GetString(AdmittingSourceValue);
                }

                var id = reader.GetLong(Id);

                var visitDetail = new VisitDetail((Entity)visitDetails[0])
                {
                    CareSiteId = reader.GetLong(CareSiteId) ?? 0,
                    AdmittingSourceConceptId = admittingSourceConceptId,
                    AdmittingSourceValue = admittingSourceValue,
                    DischargeToConceptId = dischargeToConceptId,
                    DischargeToSourceValue = dischargeToSourceValue,
                    PrecedingVisitDetailId = reader.GetInt(PrecedingVisitDetailId),
                    VisitDetailParentId = reader.GetLong(ParentId),
                };
                if (id.HasValue)
                {
                    visitDetail.Id = id.Value;
                }
                else
                {
                    visitDetail.IdUndefined = true;
                }

                yield return visitDetail;
            }
        }
    }
}
