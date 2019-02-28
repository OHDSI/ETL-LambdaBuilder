using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
   public class NoteDefinition : EntityDefinition
    {
       public string EncodingConceptId { get; set; }
       public string LanguageConceptId { get; set; }

       public string Title { get; set; }
       public string Text { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
           return
           base.GetConcepts(concept, reader, offset)
              .Select(
                 e =>
                    new Note(e)
                    {
                       Id = KeyMasterOffsetManager.GetKeyOffset(e.PersonId).NoteId,
                       EncodingConceptId = reader.GetInt(EncodingConceptId) ?? 0,
                       LanguageConceptId = reader.GetInt(LanguageConceptId) ?? 0,
                       Title = reader.GetString(Title),
                       Text = reader.GetString(Text),
                       StartTime = e.StartTime ?? e.StartDate.ToString("HH:mm:ss", CultureInfo.InvariantCulture),
                    });
        }
    }
}

