using Azure.Core;
using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using System.IO.Compression;
using System.Text;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class Vocabulary(Vendor vendor) : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = [];
        private GenderLookup _genderConcepts;
        private PregnancyConcepts _pregnancyConcepts;
        private Dictionary<long, Tuple<string, string>> _conceptIdToSourceVocabularyId = [];

        public Vendor Vendor { get; } = vendor;

        private void Load(IEnumerable<EntityDefinition> definitions)
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

                    var fileName = $"{AzureHelper.Path}/Lookups/{conceptIdMapper.Lookup}.txt";
                    
                    try
                    {
                        ClientSecretCredential credential = new(Settings.Current.TenantId, Settings.Current.ClientId, Settings.Current.ClientSecret);
                        var client = new BlobServiceClient(new Uri(Settings.Current.ServiceUri), (TokenCredential)credential, null);

                        var bcc = client.GetBlobContainerClient(Settings.Current.BlobContainerName);
                        var bc = bcc.GetBlobClient(fileName);
                                                
                        lookup.Fill(bc.OpenRead());

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

        public static void Attach(Vocabulary vocabulary)
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
            
            foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
                try
                {
                    if (!QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor))
                        continue;

                    Load(qd.ConditionOccurrence);
                    Load(qd.DrugExposure);
                    Load(qd.ProcedureOccurrence);
                    Load(qd.Observation);
                    Load(qd.VisitOccurrence);
                    Load(qd.VisitDetail);

                    Load(qd.Death);
                    Load(qd.Measurement);
                    Load(qd.DeviceExposure);
                    Load(qd.Note);
                    Load(qd.Episodes);

                    Load(qd.VisitCost);
                    Load(qd.ProcedureCost);
                    Load(qd.DeviceCost);
                    Load(qd.ObservationCost);
                    Load(qd.MeasurementCost);
                    Load(qd.DrugCost);
                }
                catch (Exception e)
                {
                    
                }

            var lookup = new Lookup();
            lookup.Fill(AzureHelper.OpenStream($"{AzureHelper.Path}/Lookups/PregnancyDrug.txt"));
            _lookups.Add("PregnancyDrug", lookup);


            lookup = new Lookup();
            foreach (var blob in AzureHelper.GetBlobContainer().GetBlobs(BlobTraits.None, BlobStates.None, $"{AzureHelper.Path}/CombinedLookups"))
            {
                Console.WriteLine(blob.Name);

                lookup.Fill(AzureHelper.OpenStream(blob.Name));
                _lookups.Add(blob.Name.Split('/')[3].Replace(".txt.gz", ""), lookup);
            }

            if (Vendor.Name == "CDM")
            {
                var spliter = new StringSplitter(3);

                using var responseStream = AzureHelper.OpenStream($"{AzureHelper.Path}/Lookups/ConceptIdToSourceVocabularyId.txt.gz");
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