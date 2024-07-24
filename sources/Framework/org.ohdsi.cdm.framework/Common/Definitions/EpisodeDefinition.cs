using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class EpisodeDefinition : EntityDefinition
    {
        public string EpisodeParentId { get; set; }
        public string EpisodeNumber { get; set; }
        public string EpisodeObjectConceptId { get; set; }

        public KeyValuePair<long?, string> GetObjectConceptId(IDataRecord reader)
        {
            if (Concepts.Length < 2)
                return new KeyValuePair<long?, string>(null, string.Empty);

            var objectsConcepts = base.GetConcepts(Concepts[1], reader, null).Where(c => c.ConceptId != 0).ToList();
            var sourceValue = reader.GetString(Concepts[1].Fields[0].Key);

            if (objectsConcepts.Count > 0)
            {
                foreach (var uc in objectsConcepts)
                {
                    if (!string.IsNullOrEmpty(sourceValue) && !string.IsNullOrEmpty(uc.VocabularySourceValue) &&
                        sourceValue.Equals(uc.VocabularySourceValue, StringComparison.Ordinal))
                        return new KeyValuePair<long?, string>(uc.ConceptId, sourceValue);
                }

                return new KeyValuePair<long?, string>(objectsConcepts[0].ConceptId, objectsConcepts[0].SourceValue);
            }

            return new KeyValuePair<long?, string>(null, sourceValue);
        }

        public IEnumerable<Episode> GetEpisodes(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            var objectConcept = GetObjectConceptId(reader);

            foreach (var e in base.GetConcepts(concept, reader, offset))
            {
                yield return new Episode(e)
                {
                    Id = offset.GetKeyOffset(e.PersonId).NoteId,

                    PersonId = e.PersonId,
                    ConceptId = e.ConceptId,
                    StartDate = e.StartDate,
                    EndDate = e.EndDate,
                    TypeConceptId = e.TypeConceptId,
                    SourceValue = e.SourceValue,
                    AdditionalFields = e.AdditionalFields,

                    EpisodeParentId = reader.GetLong(EpisodeParentId) ?? 0,
                    EpisodeNumber = reader.GetInt(EpisodeNumber) ?? 0,
                    //EpisodeObjectConceptId = reader.GetInt(EpisodeObjectConceptId) ?? 0,

                    EpisodeObjectConceptId = objectConcept.Key ?? 0
                };
            }
        }
    }
}