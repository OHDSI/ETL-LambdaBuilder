using Azure.Core;
using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.Extensions.Logging;
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

                    var fileName = $"{AzureHelper.Path}/Lookups/{conceptIdMapper.Lookup}.txt.gz";

                    Settings.Current.Logger.LogInformation(fileName);

                    try
                    {
                        ClientSecretCredential credential = new(Settings.Current.TenantId, Settings.Current.ClientId, Settings.Current.ClientSecret);
                        var client = new BlobServiceClient(new Uri(Settings.Current.ServiceUri), (TokenCredential)credential, null);

                        var bcc = client.GetBlobContainerClient(Settings.Current.BlobContainerName);
                        var bc = bcc.GetBlobClient(fileName);
                                                
                        lookup.Fill(bc.OpenRead());

                        Settings.Current.Logger.LogInformation(lookup.KeysCount.ToString());
                        _lookups.Add(conceptIdMapper.Lookup, lookup);
                    }
                    catch (Exception e)
                    {
                        Settings.Current.Logger.LogInformation("ERROR " + fileName);
                        Settings.Current.Logger.LogInformation(e.Message);
                        Settings.Current.Logger.LogInformation(e.StackTrace);
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

        public void Attach()
        {
            foreach (var qd in Settings.Current.Building.SourceQueryDefinitions)
            {
                Attach(qd.Persons, this);
                Attach(qd.ConditionOccurrence, this);
                Attach(qd.DrugExposure, this);
                Attach(qd.ProcedureOccurrence, this);
                Attach(qd.Observation, this);
                Attach(qd.VisitOccurrence, this );
                Attach(qd.VisitDetail, this);
                Attach(qd.CareSites, this);
                Attach(qd.Providers, this);
                Attach(qd.Death, this);
                Attach(qd.Measurement, this);
                Attach(qd.DeviceExposure, this);
                Attach(qd.Note, this);
                Attach(qd.Episodes, this);

                Attach(qd.VisitCost, this);
                Attach(qd.ProcedureCost, this);
                Attach(qd.DeviceCost, this);
                Attach(qd.ObservationCost, this);
                Attach(qd.MeasurementCost, this);
                Attach(qd.DrugCost, this);
            }
        }

        public void Fill(bool forLookup)
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
            lookup.Fill(AzureHelper.OpenStream($"{AzureHelper.Path}/Lookups/PregnancyDrug.txt.gz"));
            _lookups.Add("PregnancyDrug", lookup);


            lookup = new Lookup();
            foreach (var blob in AzureHelper.GetBlobContainer().GetBlobs(BlobTraits.None, BlobStates.None, $"{AzureHelper.Path}/CombinedLookups"))
            {
                Settings.Current.Logger.LogInformation(blob.Name);

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
                        spliter.SafeSplit(line, ',');
                        _conceptIdToSourceVocabularyId.Add(long.Parse(spliter.Results[0]), new Tuple<string, string>(spliter.Results[1], spliter.Results[2]));
                    }
                }

                _conceptIdToSourceVocabularyId.TrimExcess();
                Settings.Current.Logger.LogInformation("_conceptIdToSourceVocabularyId: " + _conceptIdToSourceVocabularyId.Keys.Count);
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