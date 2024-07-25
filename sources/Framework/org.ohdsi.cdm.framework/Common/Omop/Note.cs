namespace org.ohdsi.cdm.framework.common.Omop
{
    public class Note : IEquatable<Note>
    {
        public long EncodingConceptId { get; set; }
        public long LanguageConceptId { get; set; }

        public string Title { get; set; }
        public string Text { get; set; }

        public long Id { get; set; }

        public long PersonId { get; set; }
        public DateTime StartDate { get; set; }


        public long? ProviderId { get; set; }

        public long? TypeConceptId { get; set; }

        public long? VisitOccurrenceId { get; set; }

        public long? VisitDetailId { get; set; }

        public long ConceptId { get; set; }

        public string SourceValue { get; set; }

        public long? EventId { get; set; }

        public long? EventFieldConceptId { get; set; }

        public Dictionary<string, string> AdditionalFields { get; set; }

        public Note()
        {
        }

        public bool Equals(Note other)
        {
            return this.PersonId.Equals(other.PersonId) &&
                   this.ConceptId.Equals(other.ConceptId) &&
                   this.StartDate.Equals(other.StartDate) &&
                   this.VisitOccurrenceId.Equals(other.VisitOccurrenceId) &&
                   this.TypeConceptId.Equals(other.TypeConceptId) &&
                   this.SourceValue.Equals(other.SourceValue);
        }

        public override int GetHashCode()
        {
            return PersonId.GetHashCode() ^
                   ConceptId.GetHashCode() ^
                   (StartDate.GetHashCode()) ^
                   TypeConceptId.GetHashCode() ^
                   VisitOccurrenceId.GetHashCode() ^
                   (SourceValue != null ? SourceValue.GetHashCode() : 0);
        }
    }
}