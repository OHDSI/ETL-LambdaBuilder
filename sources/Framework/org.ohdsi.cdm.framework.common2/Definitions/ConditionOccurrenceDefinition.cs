using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
    public class ConditionOccurrenceDefinition : EntityDefinition
    {

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            int? statusConceptId = 0;
            string statusSource = null;
            if (Concepts.Length == 2)
            {
                var statusConcepts = Concepts[1].GetConceptIdValues(Vocabulary, Concepts[1].Fields[0], reader);
                statusSource = reader.GetString(Concepts[1].Fields[0].Key);

                if (statusConcepts.Count > 0)
                {
                    statusConceptId = statusConcepts.Min(c => c.ConceptId);
                    statusSource = statusConcepts.Min(c => c.SourceCode);

                    if (string.IsNullOrEmpty(statusSource))
                        statusSource = reader.GetString(Concepts[1].Fields[0].Key);

                    if (string.IsNullOrEmpty(statusSource))
                        statusSource = reader.GetString(Concepts[1].Fields[0].SourceKey);
                }
            }

            return
                base.GetConcepts(concept, reader, offset)
                    .Select(
                        e =>
                            new ConditionOccurrence(e)
                            {
                                Id = KeyMasterOffsetManager.GetKeyOffset(e.PersonId).ConditionOccurrenceId,
                                StatusConceptId = statusConceptId.HasValue ? statusConceptId.Value : 0,
                                StartTime = e.StartTime ??
                                            e.StartDate.ToString("HH:mm:ss", CultureInfo.InvariantCulture),
                                StatusSourceValue = statusSource
                            });
        }
    }
}
