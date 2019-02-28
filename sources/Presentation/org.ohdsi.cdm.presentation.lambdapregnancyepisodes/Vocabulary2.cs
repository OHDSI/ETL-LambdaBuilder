using System;
using System.Collections.Generic;
using System.Linq;
using Amazon.S3;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Lookups;

namespace org.ohdsi.cdm.presentation.lambdapregnancyepisodes
{
    public class Vocabulary2 : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = new Dictionary<string, Lookup>();
        private PregnancyConcepts _pregnancyConcepts;

        public void Fill(AmazonS3Client client, string bucket, Vendors vendor, int buildingId)
        {
            _pregnancyConcepts = new PregnancyConcepts();

            var lookup = new Lookup();
            var prefix =
                $"{vendor}/{buildingId}/Lookups/PregnancyDrug.txt";
            Console.WriteLine(bucket + "/" + prefix);
            lookup.Fill(client, bucket, prefix);
            _lookups.Add("PregnancyDrug", lookup);
        }


        public int? LookupGender(string genderSourceValue)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PregnancyConcept> LookupPregnancyConcept(int conceptId)
        {
            return _pregnancyConcepts.GetConcepts(conceptId);
        }

        public void Fill(bool forLookup)
        {
            throw new NotImplementedException();
        }

        public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
        {
            if (!_lookups.ContainsKey(key))
                return new List<LookupValue>();

            return _lookups[key].LookupValues(sourceValue, eventDate).ToList();
        }
    }
}
