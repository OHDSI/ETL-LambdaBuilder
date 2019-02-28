using System;
using System.Collections.Generic;

namespace org.ohdsi.cdm.framework.common2.Lookups
{
    public interface IVocabulary
    {
        void Fill(bool forLookup);

        //List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate, bool caseSensitive);
        List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate);

        int? LookupGender(string genderSourceValue);
        IEnumerable<PregnancyConcept> LookupPregnancyConcept(int conceptId);
    }
}
