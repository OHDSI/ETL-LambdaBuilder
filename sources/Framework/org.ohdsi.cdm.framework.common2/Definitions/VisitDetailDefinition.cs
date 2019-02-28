using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
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

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager keyOffset)
        {
            var visitDetails = base.GetConcepts(concept, reader, keyOffset).ToList();

            if (visitDetails.Count > 0)
            {
                int? dischargeToConceptId = null;
                string dischargeToSourceValue = null;
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


                int? admittingSourceConceptId = null;
                string admittingSourceValue = null;
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

                string startTime = null;
                string endTime = null;

                if (!string.IsNullOrEmpty(StartTime))
                {
                    if (DateTime.TryParse(reader.GetString(StartTime), out var dt))
                    {
                        startTime = dt.ToString("HH:mm:ss", CultureInfo.InvariantCulture);
                    }
                }

                if (!string.IsNullOrEmpty(EndTime))
                {
                    if (DateTime.TryParse(reader.GetString(EndTime), out var dt))
                    {
                        endTime = dt.ToString("HH:mm:ss", CultureInfo.InvariantCulture);
                    }
                }

                var visitDetail = new VisitDetail((Entity)visitDetails[0])
                {
                    CareSiteId = reader.GetInt(CareSiteId) ?? 0,
                    StartTime = startTime,
                    EndTime = endTime,
                    AdmittingSourceConceptId = admittingSourceConceptId ?? 0,
                    AdmittingSourceValue = admittingSourceValue,
                    DischargeToConceptId = dischargeToConceptId ?? 0,
                    DischargeToSourceValue = dischargeToSourceValue,
                    PrecedingVisitDetailId = reader.GetInt(PrecedingVisitDetailId)
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
