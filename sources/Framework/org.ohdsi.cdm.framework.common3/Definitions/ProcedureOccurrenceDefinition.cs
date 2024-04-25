using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class ProcedureOccurrenceDefinition : EntityDefinition
    {
        // CDM v5 props
        public string ModifierConceptId { get; set; }
        public string Quantity { get; set; }
        public string QualifierSourceValue { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            long? relevantConditionConceptId = null;
            long? modifierConceptId = reader.GetLong(ModifierConceptId) ?? 0;
            var qualifierSourceValue = reader.GetString(QualifierSourceValue);
            if (Concepts.Length == 2)
            {
                var relevantConcepts = Concepts[1].GetConceptIdValues(Vocabulary, Concepts[1].Fields[0], reader);

                if (relevantConcepts.Count > 0)
                {
                    relevantConditionConceptId = relevantConcepts.Min(c => c.ConceptId); //CDM v4
                    modifierConceptId = relevantConditionConceptId; //CDM v5

                    if (string.IsNullOrEmpty(qualifierSourceValue))
                        qualifierSourceValue = reader.GetString(Concepts[1].Fields[0].Key);
                }
            }

            int? q = null;
            q = reader.GetInt2(Quantity);

            foreach (var e in base.GetConcepts(concept, reader, offset))
            {
                var id = reader.GetLong(Id);

                if (id.HasValue)
                {
                    e.Id = id.Value;
                }
                else
                {
                    e.Id = offset.GetKeyOffset(e.PersonId).ProcedureOccurrenceId;
                }

                yield return
                   new ProcedureOccurrence(e)
                   {
                       ReleventConditionConceptId = relevantConditionConceptId,
                       ModifierConceptId = modifierConceptId ?? 0,
                       Quantity = q,
                       QualifierSourceValue = qualifierSourceValue
                   };
            }
        }
    }
}