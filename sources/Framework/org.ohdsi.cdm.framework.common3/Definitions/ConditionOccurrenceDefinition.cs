using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class ConditionOccurrenceDefinition : EntityDefinition
    {
        public string StopReason { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            long? statusConceptId = null;
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

            var records = base.GetConcepts(concept, reader, offset)
                    .Select(
                        e =>
                            new ConditionOccurrence(e)
                            {
                                StatusConceptId = statusConceptId,
                                StatusSourceValue = statusSource,
                                StopReason = reader.GetString(StopReason)
                            });
            
            var id = reader.GetLong(Id);

            if (id.HasValue)
            {
                var c = records.FirstOrDefault();
                c.Id = id.Value;
                yield return c;
            }
            else
            {
                foreach (var co in records)
                {
                    co.Id = offset.GetKeyOffset(co.PersonId).ConditionOccurrenceId;

                    yield return co;
                }
            }
        }
    }
}
