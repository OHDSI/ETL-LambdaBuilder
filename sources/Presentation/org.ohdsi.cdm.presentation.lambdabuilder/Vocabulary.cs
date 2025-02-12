using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Vocabulary(Vendor vendor) : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = [];
        private GenderLookup _genderConcepts;
        private PregnancyConcepts _pregnancyConcepts;
        private Dictionary<long, Tuple<string, string>> _conceptIdToSourceVocabularyId = [];

        public Vendor Vendor { get; } = vendor;

        private void Load(AmazonS3Client client, IEnumerable<EntityDefinition> definitions)
        {
            if (definitions == null) return;

            var conceptIdMappers = definitions
                .Where(a => a.Concepts != null)
                .SelectMany(a => a.Concepts)
                .Where(a => a.ConceptIdMappers != null)
                .SelectMany(a => a.ConceptIdMappers)
                .Where(a => !string.IsNullOrEmpty(a.Lookup))
                .ToList();

            foreach (var conceptIdMapper in conceptIdMappers)
            {
                if (!_lookups.ContainsKey(conceptIdMapper.Lookup))
                {
                    var lookup = new Lookup();

                    var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/Lookups/{conceptIdMapper.Lookup}.txt";
                    Console.WriteLine(Settings.Current.Bucket + "/" + prefix);
                    try
                    {
                        lookup.Fill(client, Settings.Current.Bucket, prefix);
                        Console.WriteLine(lookup.KeysCount);
                        _lookups.Add(conceptIdMapper.Lookup, lookup);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        throw;
                    }


                }
            }
        }

        private static void Attach(IEnumerable<EntityDefinition> definitions, Vocabulary vocabulary)
        {
            if (definitions == null) return;

            foreach (var ed in definitions)
            {
                ed.Vocabulary = vocabulary;
            }
        }

        public void Attach(Vocabulary vocabulary)
        {
            foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
            {
                Attach(qd.Persons, vocabulary);
                Attach(qd.ConditionOccurrence, vocabulary);
                Attach(qd.DrugExposure, vocabulary);
                Attach(qd.ProcedureOccurrence, vocabulary);
                Attach(qd.Observation, vocabulary);
                Attach(qd.VisitOccurrence, vocabulary);
                Attach(qd.VisitDetail, vocabulary);
                Attach(qd.CareSites, vocabulary);
                Attach(qd.Providers, vocabulary);
                Attach(qd.Death, vocabulary);
                Attach(qd.Measurement, vocabulary);
                Attach(qd.DeviceExposure, vocabulary);
                Attach(qd.Note, vocabulary);
                Attach(qd.Episodes, vocabulary);

                Attach(qd.VisitCost, vocabulary);
                Attach(qd.ProcedureCost, vocabulary);
                Attach(qd.DeviceCost, vocabulary);
                Attach(qd.ObservationCost, vocabulary);
                Attach(qd.MeasurementCost, vocabulary);
                Attach(qd.DrugCost, vocabulary);
            }
        }

        public void Fill(bool forLookup, bool readFromS3)
        {
            _genderConcepts = new GenderLookup();
            _genderConcepts.Load();

            _pregnancyConcepts = new PregnancyConcepts(Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location));

            Console.WriteLine(Settings.Current.S3AwsAccessKeyId);
            Console.WriteLine(Settings.Current.S3AwsSecretAccessKey);

            using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
                try
                {
                    if (!QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor))
                        continue;

                    Load(client, qd.ConditionOccurrence);
                    Load(client, qd.DrugExposure);
                    Load(client, qd.ProcedureOccurrence);
                    Load(client, qd.Observation);
                    Load(client, qd.VisitOccurrence);
                    Load(client, qd.VisitDetail);

                    Load(client, qd.Death);
                    Load(client, qd.Measurement);
                    Load(client, qd.DeviceExposure);
                    Load(client, qd.Note);
                    Load(client, qd.Episodes);

                    Load(client, qd.VisitCost);
                    Load(client, qd.ProcedureCost);
                    Load(client, qd.DeviceCost);
                    Load(client, qd.ObservationCost);
                    Load(client, qd.MeasurementCost);
                    Load(client, qd.DrugCost);
                }
                catch (Exception e)
                {
                    
                }

            var lookup = new Lookup();
            var prefix =
                $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/Lookups/PregnancyDrug.txt";
            Console.WriteLine(Settings.Current.Bucket + "/" + prefix);
            lookup.Fill(client, Settings.Current.Bucket, prefix);
            _lookups.Add("PregnancyDrug", lookup);


            lookup = new Lookup();
            prefix =
                $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/CombinedLookups";
            Console.WriteLine(Settings.Current.Bucket + "/" + prefix);

            var request = new ListObjectsV2Request
            {
                BucketName = Settings.Current.Bucket,
                Prefix = prefix
            };

            using var listObjects = client.ListObjectsV2Async(request);
            listObjects.Wait();

            foreach (var o in listObjects.Result.S3Objects)
            {
                lookup.Fill(client, Settings.Current.Bucket, o.Key);
                _lookups.Add(o.Key.Split('/')[3].Replace(".txt.gz", ""), lookup);
            }

            if (Vendor.Name == "CDM")
            {
                var getObjectRequest = new GetObjectRequest
                {
                    BucketName = Settings.Current.Bucket,
                    Key = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/Lookups/ConceptIdToSourceVocabularyId.txt.gz"
                };
                var getObject = client.GetObjectAsync(getObjectRequest);
                getObject.Wait();

                var spliter = new StringSplitter(3);

                using var responseStream = getObject.Result.ResponseStream;
                using var bufferedStream = new BufferedStream(responseStream);
                using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                using var reader = new StreamReader(gzipStream, Encoding.Default);
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    if (!string.IsNullOrEmpty(line))
                    {
                        spliter.SafeSplit(line, '\t');
                        _conceptIdToSourceVocabularyId.Add(long.Parse(spliter.Results[0]), new Tuple<string, string>(spliter.Results[1], spliter.Results[2]));
                    }
                }

                _conceptIdToSourceVocabularyId.TrimExcess();
                Console.WriteLine("_conceptIdToSourceVocabularyId: " + _conceptIdToSourceVocabularyId.Keys.Count);
            }
        }

        public string GetSourceVocabularyId(long conceptId)
        {
            if (_conceptIdToSourceVocabularyId.TryGetValue(conceptId, out Tuple<string, string> value))
                return value.Item1;

            return null;
        }

        public string GetSourceDomain(long conceptId)
        {
            if (_conceptIdToSourceVocabularyId.TryGetValue(conceptId, out Tuple<string, string> value))
                return value.Item2;

            return null;
        }

        public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
        {
            if (!_lookups.ContainsKey(key))
                return [];

            return _lookups[key].LookupValues(sourceValue, eventDate).ToList();
        }

        public int? LookupGender(string genderSourceValue)
        {
            var res = _genderConcepts.LookupValue(genderSourceValue);
            if (!res.HasValue || res.Value == 0)
                return 8551; // UNKNOWN

            return res;
        }

        public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId)
        {
            return _pregnancyConcepts.GetConcepts(conceptId);
        }
    }
}