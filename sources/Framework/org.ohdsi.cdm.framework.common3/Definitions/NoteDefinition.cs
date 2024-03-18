using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class NoteDefinition : EntityDefinition
    {
        public string EncodingConceptId { get; set; }
        public string LanguageConceptId { get; set; }

        public string Title { get; set; }
        public string Text { get; set; }
        public string EventId { get; set; }
        public string EventFieldConceptId { get; set; }

        public IEnumerable<Note> GetNotes(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            return
                base.GetConcepts(concept, reader, offset)
                    .Select(
                        e =>
                            new Note
                            {
                                Id = offset.GetKeyOffset(e.PersonId).NoteId,
                                EncodingConceptId = reader.GetInt(EncodingConceptId) ?? 0,
                                LanguageConceptId = reader.GetInt(LanguageConceptId) ?? 0,
                                Title = reader.GetString(Title),
                                Text = reader.GetString(Text),

                                PersonId = e.PersonId,
                                ConceptId = e.ConceptId,
                                StartDate = e.StartDate,

                                TypeConceptId = e.TypeConceptId,
                                VisitOccurrenceId = e.VisitOccurrenceId,
                                VisitDetailId = e.VisitDetailId,
                                SourceValue = e.SourceValue,
                                ProviderId = e.ProviderId,

                                AdditionalFields = e.AdditionalFields,

                                EventId = reader.GetLong(EventId),
                                EventFieldConceptId = reader.GetInt(EventFieldConceptId)
                            });
        }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            throw new NotImplementedException("NoteDefinition.GetConcepts()");
        }
    }
}