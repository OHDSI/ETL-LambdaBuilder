namespace org.ohdsi.cdm.framework.common.Omop
{
    public class NoteNlp
    {
        public long NoteNlpId { get; set; }
        public long NoteId { get; set; }
        public long PersonId { get; set; }
        public long SectionConceptId { get; set; }
        public string Snippet { get; set; }
        public string Offset { get; set; }
        public string LexicalVariant { get; set; }

        public long NoteNlpConceptId { get; set; }
        public long NoteNlpSourceConceptId { get; set; }

        public string NlpSystem { get; set; }
        public DateTime NlpDate { get; set; }

        public bool TermExists { get; set; }
        public string TermTemporal { get; set; }
        public string TermModifiers { get; set; }
    }
}