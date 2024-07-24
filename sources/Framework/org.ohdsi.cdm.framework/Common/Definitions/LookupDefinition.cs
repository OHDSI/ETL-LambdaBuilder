namespace org.ohdsi.cdm.framework.common.Definitions
{
    public enum Aggregation
    {
        None,
        Min,
        Max,
        Avg,
        MostFrequent
    }

    public class SourceLookup
    {
        public string Key1 { get; set; }
        public string Value1 { get; set; }
        public string Key2 { get; set; }
        public string Value2 { get; set; }
        public string Query { get; set; }
    }

    public class VocabularyLookup
    {
        public string Key1 { get; set; }
        public string Value1 { get; set; }
        public string Key2 { get; set; }
        public string Value2 { get; set; }
        public string Query { get; set; }
    }


    public class LookupDefinition
    {
        public Aggregation Aggregation { get; set; }
        public SourceLookup SourceLookup { get; set; }
        public VocabularyLookup VocabularyLookup { get; set; }
        public string FileName { get; set; }
    }
}
