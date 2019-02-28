using System;
using System.Collections.Generic;
using System.Linq;
using Amazon.S3;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Lookups;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Vocabulary : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = new Dictionary<string, Lookup>();
        private GenderLookup _genderConcepts;
        private PregnancyConcepts _pregnancyConcepts;

        public Vendors Vendor { get; }

        public Vocabulary(Vendors vendor)
        {
            Vendor = vendor;
        }

        private void Load(AmazonS3Client client, IEnumerable<EntityDefinition> definitions)
        {
            if (definitions == null) return;

            foreach (var ed in definitions)
            {
                if (ed.Concepts == null) continue;

                foreach (var c in ed.Concepts)
                {
                    if (c.ConceptIdMappers == null) continue;

                    foreach (var conceptIdMapper in c.ConceptIdMappers)
                    {
                        if (!string.IsNullOrEmpty(conceptIdMapper.Lookup))
                        {
                            if (!_lookups.ContainsKey(conceptIdMapper.Lookup))
                            {
                                var lookup = new Lookup();

                                var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/Lookups/{conceptIdMapper.Lookup}.txt";
                                Console.WriteLine(Settings.Current.Bucket + "/" + prefix);
                                lookup.Fill(client, Settings.Current.Bucket, prefix);
                                _lookups.Add(conceptIdMapper.Lookup, lookup);
                                
                            }
                        }
                    }
                }
            }
        }

        private void Attach(IEnumerable<EntityDefinition> definitions)
        {
            if (definitions == null) return;

            foreach (var ed in definitions)
            {
                ed.Vocabulary = this;
            }
        }

        public void Attach()
        {
            foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
            {
                Attach(qd.Persons);
                Attach(qd.ConditionOccurrence);
                Attach(qd.DrugExposure);
                Attach(qd.ProcedureOccurrence);
                Attach(qd.Observation);
                Attach(qd.VisitOccurrence);
                Attach(qd.CareSites);
                Attach(qd.Providers);
                Attach(qd.Death);
                Attach(qd.Measurement);
                Attach(qd.DeviceExposure);
                Attach(qd.Note);

                Attach(qd.VisitCost);
                Attach(qd.ProcedureCost);
                Attach(qd.DeviceCost);
                Attach(qd.ObservationCost);
                Attach(qd.MeasurementCost);
                Attach(qd.DrugCost);
            }
        }

        public void Fill(bool forLookup)
        {
            _genderConcepts = new GenderLookup();
            _genderConcepts.Load();

            _pregnancyConcepts = new PregnancyConcepts();

            using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
                {
                    Load(client, qd.ConditionOccurrence);
                    Load(client, qd.DrugExposure);
                    Load(client, qd.ProcedureOccurrence);
                    Load(client, qd.Observation);
                    Load(client, qd.VisitOccurrence);
                    //Load(client, qd.CareSites);
                    //Load(client, qd.Providers);
                    Load(client, qd.Death);
                    Load(client, qd.Measurement);
                    Load(client, qd.DeviceExposure);
                    Load(client, qd.Note);

                    Load(client, qd.VisitCost);
                    Load(client, qd.ProcedureCost);
                    Load(client, qd.DeviceCost);
                    Load(client, qd.ObservationCost);
                    Load(client, qd.MeasurementCost);
                    Load(client, qd.DrugCost);
                }

                var lookup = new Lookup();
                var prefix =
                    $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/Lookups/PregnancyDrug.txt";
                Console.WriteLine(Settings.Current.Bucket + "/" + prefix);
                lookup.Fill(client, Settings.Current.Bucket, prefix);
                _lookups.Add("PregnancyDrug", lookup);
            }
        }

        //public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate, bool caseSensitive)
        //{
        //    return _lookups[key].LookupValues(sourceValue, eventDate, caseSensitive).ToList();
        //}

        public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
        {
            if (!_lookups.ContainsKey(key))
                return new List<LookupValue>();

            return _lookups[key].LookupValues(sourceValue, eventDate).ToList();
        }


        public int? LookupGender(string genderSourceValue)
        {
            var res = _genderConcepts.LookupValue(genderSourceValue);
            if (!res.HasValue || res.Value == 0)
                return 8551; // UNKNOWN

            return res;
        }

        public IEnumerable<PregnancyConcept> LookupPregnancyConcept(int conceptId)
        {
            return _pregnancyConcepts.GetConcepts(conceptId);
        }
    }
}
