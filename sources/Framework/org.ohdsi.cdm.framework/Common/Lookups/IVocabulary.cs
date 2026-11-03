namespace org.ohdsi.cdm.framework.common.Lookups
{
    public interface IVocabulary
    {
        void Fill(bool forLookup);

        //List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate, bool caseSensitive);
        List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate);

        int? LookupGender(string genderSourceValue);
        string GetSourceVocabularyId(long conceptId);
        string GetSourceDomain(long conceptId);
    }
}
