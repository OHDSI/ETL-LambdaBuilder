using System;
using org.ohdsi.cdm.framework.common2.Enums;

namespace org.ohdsi.cdm.framework.common2.Omop
{
   public class Note : Entity, IEquatable<Note>
   {
      public int EncodingConceptId { get; set; }
      public int LanguageConceptId { get; set; }

      public string Title { get; set; }
      public string Text { get; set; }

      public Note(IEntity ent)
      {
         Init(ent);
      }

      public bool Equals(Note other)
      {
         return this.PersonId.Equals(other.PersonId) &&
                this.ConceptId.Equals(other.ConceptId) &&
                this.StartDate.Equals(other.StartDate) &&
                this.EndDate.Equals(other.EndDate) &&
                this.VisitOccurrenceId.Equals(other.VisitOccurrenceId) &&
                this.SourceConceptId.Equals(other.SourceConceptId) &&
                this.TypeConceptId.Equals(other.TypeConceptId) &&
                this.SourceValue.Equals(other.SourceValue);
      }

      public override int GetHashCode()
      {
         return PersonId.GetHashCode() ^
                ConceptId.GetHashCode() ^
                (StartDate.GetHashCode()) ^
                (EndDate.GetHashCode()) ^
                TypeConceptId.GetHashCode() ^
                SourceConceptId.GetHashCode() ^
                VisitOccurrenceId.GetHashCode() ^
                (SourceValue != null ? SourceValue.GetHashCode() : 0);
      }

      public override EntityType GeEntityType()
      {
         return EntityType.Note;
      }
   }
}
