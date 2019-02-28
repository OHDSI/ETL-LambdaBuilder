using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
   public class ProcedureOccurrenceDefinition : EntityDefinition
   {
      // CDM v5 props
      public string ModifierConceptId { get; set; }
      public string Quantity { get; set; }
      public string QualifierSourceValue { get; set; }

      public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
      {
         int? relevantConditionConceptId = null;
         int? modifierConceptId = reader.GetInt(ModifierConceptId) ?? 0;
         if (Concepts.Length == 2)
         {
            var relevantConcepts = Concepts[1].GetConceptIdValues(Vocabulary, Concepts[1].Fields[0], reader);

            if (relevantConcepts.Count > 0)
            {
               relevantConditionConceptId = relevantConcepts.Min(c => c.ConceptId); //CDM v4
               modifierConceptId = relevantConditionConceptId; //CDM v5
            }
         }

         foreach (var e in base.GetConcepts(concept, reader, offset))
         {
            yield return
               new ProcedureOccurrence(e)
                  {
                     Id = KeyMasterOffsetManager.GetKeyOffset(e.PersonId).ProcedureOccurrenceId,
                     ReleventConditionConceptId = relevantConditionConceptId,
                     ModifierConceptId = modifierConceptId ?? 0,
                     StartTime = e.StartTime ?? e.StartDate.ToString("HH:mm:ss", CultureInfo.InvariantCulture),
                     Quantity = reader.GetInt(Quantity),
                     QualifierSourceValue = reader.GetString(QualifierSourceValue)
                  };
         }
      }
   }
}
