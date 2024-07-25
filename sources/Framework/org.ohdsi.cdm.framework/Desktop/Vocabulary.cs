using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;
using System.Data.Odbc;
using System.Globalization;
using System.Text;

namespace org.ohdsi.cdm.framework.desktop
{
    public class Vocabulary : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = [];
        private GenderLookup _genderConcepts;
        private PregnancyConcepts _pregnancyConcepts;

        private static LookupValue CreateLookupValue(IDataRecord reader)
        {
            //source_code,	target_concept_id,	target_domain_id,	validstartdate,	validenddate,	source_vocabulary_id,	source_target_concept_id,	source_validstartdate,	source_validenddate,	ingredient_concept_id
            //    1                       2                 3                  4               5               6                       7                                 8                    9                        10


            //source_code,	target_concept_id,	target_domain_id,	validstartdate,	validenddate
            //    1                       2                 3                  4               5

            var sourceCode = string.Intern(reader[0].ToString().Trim());
            int conceptId = -1;
            if (int.TryParse(reader[1].ToString(), out var cptId))
                conceptId = cptId;

            if (reader.FieldCount == 2)
            {
                return new LookupValue
                {
                    ConceptId = conceptId,
                    SourceCode = sourceCode,
                    ValidStartDate = DateTime.MinValue,
                    ValidEndDate = DateTime.MaxValue,
                    Ingredients = []
                };
            }

            if (!DateTime.TryParse(reader[3].ToString(), out var validStartDate))
                validStartDate = DateTime.MinValue;

            if (!DateTime.TryParse(reader[4].ToString(), out var validEndDate))
                validEndDate = DateTime.MaxValue;

            var lv = new LookupValue
            {
                ConceptId = conceptId,
                SourceCode = sourceCode,
                Domain = string.Intern(reader[2].ToString().Trim()),
                ValidStartDate = validStartDate,
                ValidEndDate = validEndDate,
                Ingredients = []
            };

            if (reader.FieldCount > 5)
            {
                //lv.SourceConceptId = int.TryParse(reader[6].ToString(), out var scptId) ? scptId : 0;
                var sourceConceptId = int.TryParse(reader[6].ToString(), out var scptId) ? scptId : 0;
                lv.SourceConcepts.Add(new SourceConcepts { ConceptId = sourceConceptId });

                if (int.TryParse(reader[9].ToString(), out var ingredient))
                    lv.Ingredients.Add(ingredient);
            }


            return lv;
        }

        private void LoadCombinedLookups(bool readFromS3, bool storeToS3)
        {
            if (Settings.Settings.Current.Building.LookupDefinitions == null || Settings.Settings.Current.Building.LookupDefinitions.Count == 0)
            {
                Console.WriteLine("CombinedLookups - empty");
                return;
            }

            Console.WriteLine("CombinedLookups - Loading...");
            var baseSql = string.Empty;

            if (readFromS3)
            {
                baseSql = S3ReadAllText($@"{Settings.Settings.Current.VendorSettings}\Core\Lookups\Base.sql");
            }
            else
            {
                baseSql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder,
                    @"Core\Lookups\Base.sql"));
            }

            foreach (var lookup in Settings.Settings.Current.Building.LookupDefinitions)
            {
                var sourceQuery = lookup.SourceLookup.Query.Replace("{sc}", Settings.Settings.Current.Building.SourceSchemaName);
                var vocabularyQuery = lookup.VocabularyLookup.Query;

                vocabularyQuery = vocabularyQuery.Replace("{base}", baseSql);
                vocabularyQuery = vocabularyQuery.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

                try
                {
                    var sourceLookup = new Dictionary<string, List<string>>();
                    var vocabularyLookup = new Dictionary<string, List<string>>();
                    var combinedLookup = new Dictionary<string, List<string>>();
                    var finalLookup = new Dictionary<string, string>();

                    Console.WriteLine(sourceQuery);
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString))
                    using (var command = new OdbcCommand(sourceQuery, connection) { CommandTimeout = 600 })
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var key1 = reader[lookup.SourceLookup.Key1].ToString().Trim();
                            if (!sourceLookup.ContainsKey(key1))
                                sourceLookup.Add(key1, []);

                            sourceLookup[key1].Add(reader[lookup.SourceLookup.Value1].ToString().Trim());
                        }
                    }

                    Console.WriteLine(sourceLookup.Keys.Count);

                    Console.WriteLine(vocabularyQuery);
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
                    using (var command = new OdbcCommand(vocabularyQuery, connection) { CommandTimeout = 600 })
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var key1 = reader[lookup.VocabularyLookup.Key1].ToString().Trim();
                            if (!vocabularyLookup.ContainsKey(key1))
                                vocabularyLookup.Add(key1, []);

                            var value1 = reader[lookup.VocabularyLookup.Value1].ToString().Trim();
                            vocabularyLookup[key1].Add(value1);
                        }
                    }
                    Console.WriteLine(vocabularyLookup.Keys.Count);

                    foreach (var source in sourceLookup)
                    {
                        if (!vocabularyLookup.ContainsKey(source.Key))
                            continue;

                        foreach (var vocabValue in vocabularyLookup[source.Key])
                        {
                            if (!combinedLookup.ContainsKey(vocabValue))
                                combinedLookup.Add(vocabValue, []);

                            foreach (var sourceValue in source.Value)
                            {
                                combinedLookup[vocabValue].Add(sourceValue);
                            }
                        }
                    }

                    foreach (var item in combinedLookup)
                    {
                        var mostFrequent = item.Value.GroupBy(i => i).OrderByDescending(grp => grp.Count()).Select(grp => grp.Key).First();

                        finalLookup.Add(item.Key, mostFrequent);
                    }

                    if (storeToS3)
                    {
                        var fileName =
                            $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/CombinedLookups/{lookup.FileName}.txt.gz";

                        Console.WriteLine(lookup.FileName + " - store to S3 | " + fileName);

                        using (var client = new AmazonS3Client(
                            Settings.Settings.Current.S3AwsAccessKeyId,
                            Settings.Settings.Current.S3AwsSecretAccessKey,
                            new AmazonS3Config
                            {
                                Timeout = TimeSpan.FromMinutes(60),
                                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                                MaxErrorRetry = 20,
                            }))
                        {
                            using var source = new MemoryStream();
                            using StreamWriter writer = new(source, new UTF8Encoding(false, true));
                            using var csv = new CsvWriter(writer,
                                  new CsvConfiguration(CultureInfo.InvariantCulture)
                                  {
                                      HasHeaderRecord = false,
                                      Delimiter = "\t",
                                      Quote = '`',
                                      Encoding = Encoding.UTF8
                                  });
                            foreach (var item in finalLookup)
                            {
                                csv.WriteField(item.Key ?? string.Empty);
                                csv.WriteField(item.Value ?? string.Empty);
                                csv.NextRecord();
                            }

                            writer.Flush();

                            using var gz = AmazonS3Helper.Compress(source);
                            using var directoryTransferUtility = new TransferUtility(client);
                            directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                            {
                                BucketName = Settings.Settings.Current.Bucket,
                                Key = fileName,
                                ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                                StorageClass = S3StorageClass.Standard,
                                InputStream = gz
                            });
                        }
                        _lookups.Add(lookup.FileName, null);
                    }
                    else
                    {
                        Console.WriteLine(lookup.FileName + " - filling");
                        var l = new Lookup();
                        foreach (var item in finalLookup)
                        {
                            l.Add(new LookupValue
                            {
                                ConceptId = int.Parse(item.Value),
                                SourceCode = item.Key,
                                ValidStartDate = DateTime.MinValue,
                                ValidEndDate = DateTime.MaxValue,
                                Ingredients = []
                            });
                        }

                        _lookups.Add(lookup.FileName, l);
                        Console.WriteLine(lookup.FileName + " - Done (" + _lookups[lookup.FileName].KeysCount + ")");
                    }

                }
                catch (Exception e)
                {
                    Console.WriteLine("LoadCombinedLookups " + e.Message);

                    throw;
                }
            }
        }

        private static void LoadConceptIdToSourceVocabularyId()
        {
            Console.WriteLine("ConceptIdToSourceVocabularyId - Loading...");

            var sql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder,
                @"Core\Lookups\ConceptIdToSourceVocabularyId.sql"));

            sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

            using (var connection =
                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
            using (var command = new OdbcCommand(sql, connection) { CommandTimeout = 0 })
            using (var reader = command.ExecuteReader())
            {
                var fileName =
                    $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/Lookups/ConceptIdToSourceVocabularyId.txt.gz";

                Console.WriteLine("ConceptIdToSourceVocabularyId - store to S3 | " + fileName);

                using var client = new AmazonS3Client(
                    Settings.Settings.Current.S3AwsAccessKeyId,
                    Settings.Settings.Current.S3AwsSecretAccessKey,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
                AmazonS3Helper.CopyFile(client, Settings.Settings.Current.Bucket,
                    fileName,
                    reader, "\t", '`', "\0");

            }
            Console.WriteLine("ConceptIdToSourceVocabularyId - Done");
        }

        private void LoadPregnancyDrug(bool readFromS3, bool storeToS3)
        {
            string sql;
            if (readFromS3)
            {
                sql = S3ReadAllText($@"{Settings.Settings.Current.VendorSettings}\Core\Lookups\PregnancyDrug.sql");
            }
            else
            {
                sql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder,
                    @"Core\Lookups\PregnancyDrug.sql"));
            }

            sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

            Console.WriteLine("PregnancyDrug - Loading...");
            using (var connection =
                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
            using (var command = new OdbcCommand(sql, connection) { CommandTimeout = 0 })
            using (var reader = command.ExecuteReader())
            {
                if (storeToS3)
                {
                    var fileName =
                        $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/Lookups/PregnancyDrug.txt.gz";

                    Console.WriteLine("PregnancyDrug - store to S3 | " + fileName);

                    using var client = new AmazonS3Client(
                        Settings.Settings.Current.S3AwsAccessKeyId,
                        Settings.Settings.Current.S3AwsSecretAccessKey,
                        new AmazonS3Config
                        {
                            Timeout = TimeSpan.FromMinutes(60),
                            RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                            MaxErrorRetry = 20,
                        });
                    AmazonS3Helper.CopyFile(client, Settings.Settings.Current.Bucket,
                        fileName,
                        reader, "\t", '`', "\0");
                }
                else
                {
                    Console.WriteLine("PregnancyDrug - filling");
                    var lookup = new Lookup();
                    while (reader.Read())
                    {
                        lookup.Add(new LookupValue
                        {
                            ConceptId = int.Parse(reader[0].ToString()),
                            SourceCode = reader[0].ToString()
                        });
                    }

                    _lookups.Add("PregnancyDrug", lookup);
                }
            }
            Console.WriteLine("PregnancyDrug - Done");
        }


        private void Load(IEnumerable<EntityDefinition> definitions, bool readFromS3, bool storeToS3)
        {
            if (definitions == null) return;

            foreach (var ed in definitions)
            {
                ed.Vocabulary = this;

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
                                string sql = string.Empty;
                                var vendorFolder = Settings.Settings.Current.Building.Vendor.Folder;

                                var baseSql = string.Empty;
                                var sqlFileDestination = string.Empty;

                                if (readFromS3)
                                {
                                    baseSql = S3ReadAllText($@"{Settings.Settings.Current.VendorSettings}\Core\Lookups\Base.sql");

                                    sqlFileDestination = Path.Combine(Settings.Settings.Current.VendorSettings, "Core", "Transformation",
                                        vendorFolder, "Lookups", conceptIdMapper.Lookup + ".sql");

                                    sql = S3ReadAllText(sqlFileDestination);
                                }
                                else
                                {
                                    baseSql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder,
                                        @"Core\Lookups\Base.sql"));

                                    sqlFileDestination = Path.Combine(Settings.Settings.Current.Builder.Folder, "Core", "Transformation",
                                        vendorFolder, "Lookups", conceptIdMapper.Lookup + ".sql");

                                    sql = File.ReadAllText(sqlFileDestination);
                                }

                                sql = sql.Replace("{base}", baseSql);
                                sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

                                try
                                {
                                    Console.WriteLine(conceptIdMapper.Lookup + " - Loading...");
                                    using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString);
                                    using var command = new OdbcCommand(sql, connection) { CommandTimeout = 0 };
                                    using var reader = command.ExecuteReader();

                                    if (storeToS3)
                                    {
                                        var fileName =
                                            $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/Lookups/{conceptIdMapper.Lookup}.txt.gz";

                                        Console.WriteLine(conceptIdMapper.Lookup + " - store to S3 | " + fileName);

                                        using (var client = new AmazonS3Client(
                                            Settings.Settings.Current.S3AwsAccessKeyId,
                                            Settings.Settings.Current.S3AwsSecretAccessKey,
                                            new AmazonS3Config
                                            {
                                                Timeout = TimeSpan.FromMinutes(60),
                                                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                                                MaxErrorRetry = 20,
                                            }))
                                        {
                                            AmazonS3Helper.CopyFile(client, Settings.Settings.Current.Bucket,
                                                fileName,
                                                reader, "\t", '`', "\0");
                                        }
                                        _lookups.Add(conceptIdMapper.Lookup, null);
                                    }
                                    else
                                    {
                                        Console.WriteLine(conceptIdMapper.Lookup + " - filling");
                                        var lookup = new Lookup();
                                        while (reader.Read())
                                        {
                                            var lv = CreateLookupValue(reader);
                                            lookup.Add(lv);
                                        }

                                        _lookups.Add(conceptIdMapper.Lookup, lookup);
                                        Console.WriteLine(conceptIdMapper.Lookup + " - Done (" + _lookups[conceptIdMapper.Lookup].KeysCount + ")");
                                    }

                                }
                                catch (Exception)
                                {
                                    Console.WriteLine("Lookup error [file]: " + sqlFileDestination);
                                    Console.WriteLine("Lookup error [query]: " + sql);
                                    Logger.WriteWarning("Lookup error [file]: " + sqlFileDestination);
                                    Logger.WriteWarning("Lookup error [query]: " + sql);
                                    throw;
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Fill vocabulary for source to conceptId mapping
        /// </summary>
        /// <param name="forLookup">true - fill vocab. for: CareSites, Providers, Locations; false - rest of us</param>
        public void Fill(bool forLookup, bool readFromS3)
        {

            _genderConcepts = new GenderLookup();
            _genderConcepts.Load();

            _pregnancyConcepts = new PregnancyConcepts(Settings.Settings.Current.Builder.Folder);

            LoadCombinedLookups(readFromS3, false);

            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                if (forLookup)
                {
                    Load(qd.CareSites, readFromS3, false);
                    Load(qd.Providers, readFromS3, false);
                    Load(qd.Locations, readFromS3, false);
                }
                else
                {
                    Load(qd.Persons, readFromS3, false);
                    Load(qd.ConditionOccurrence, readFromS3, false);
                    Load(qd.DrugExposure, readFromS3, false);
                    Load(qd.ProcedureOccurrence, readFromS3, false);
                    Load(qd.Observation, readFromS3, false);
                    Load(qd.VisitOccurrence, readFromS3, false);
                    Load(qd.VisitDetail, readFromS3, false);
                    Load(qd.Death, readFromS3, false);
                    Load(qd.Measurement, readFromS3, false);
                    Load(qd.DeviceExposure, readFromS3, false);
                    Load(qd.Note, readFromS3, false);

                    Load(qd.VisitCost, readFromS3, false);
                    Load(qd.ProcedureCost, readFromS3, false);
                    Load(qd.DeviceCost, readFromS3, false);
                    Load(qd.ObservationCost, readFromS3, false);
                    Load(qd.MeasurementCost, readFromS3, false);
                    Load(qd.DrugCost, readFromS3, false);
                }
            }
            LoadPregnancyDrug(readFromS3, false);

            if (Settings.Settings.Current.Building.Vendor.Name == "CDM")
                LoadConceptIdToSourceVocabularyId();
        }

        public void SaveToS3(bool readFromS3)
        {
            LoadCombinedLookups(readFromS3, true);
            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                Load(qd.Persons, readFromS3, true);
                Load(qd.ConditionOccurrence, readFromS3, true);
                Load(qd.DrugExposure, readFromS3, true);
                Load(qd.ProcedureOccurrence, readFromS3, true);
                Load(qd.Observation, readFromS3, true);
                Load(qd.VisitOccurrence, readFromS3, true);
                Load(qd.VisitDetail, readFromS3, true);
                Load(qd.Death, readFromS3, true);
                Load(qd.Measurement, readFromS3, true);
                Load(qd.DeviceExposure, readFromS3, true);
                Load(qd.Note, readFromS3, true);
                Load(qd.Episodes, readFromS3, true);

                Load(qd.VisitCost, readFromS3, true);
                Load(qd.ProcedureCost, readFromS3, true);
                Load(qd.DeviceCost, readFromS3, true);
                Load(qd.ObservationCost, readFromS3, true);
                Load(qd.MeasurementCost, readFromS3, true);
                Load(qd.DrugCost, readFromS3, true);
            }
            LoadPregnancyDrug(readFromS3, true);

            if (Settings.Settings.Current.Building.Vendor.Name == "CDM")
                LoadConceptIdToSourceVocabularyId();

            _lookups.Clear();
        }

        public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
        {
            if (!_lookups.TryGetValue(key, out Lookup value))
                return [];

            return value.LookupValues(sourceValue, eventDate).ToList();
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

        private static string S3ReadAllText(string key)
        {
            key = key.Replace("\\", "/");
            var fileName = $@"s3:\\{Settings.Settings.Current.Bucket}\{key}";

            Console.Write($"loading {fileName}");

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId,
                Settings.Settings.Current.S3AwsSecretAccessKey, config);
            var getObjectRequest = new GetObjectRequest
            {
                BucketName = Settings.Settings.Current.Bucket,
                Key = key
            };

            try
            {
                var getObject = client.GetObjectAsync(getObjectRequest);
                getObject.Wait();
                using var response = getObject.Result;
                using var responseStream = response.ResponseStream;
                using var reader = new StreamReader(responseStream, Encoding.Default);
                var content = reader.ReadToEnd();
                Console.WriteLine(", COMPLETE");
                return content;

            }
            catch (Exception ex)
            {
                if (((Amazon.Runtime.AmazonServiceException)ex.InnerException).StatusCode ==
                    System.Net.HttpStatusCode.NotFound)
                {
                    Console.Write(" - not exists");
                    return null;
                }

                throw;
            }
        }

        public string GetSourceVocabularyId(long conceptId)
        {
            throw new NotImplementedException();
        }

        public string GetSourceDomain(long conceptId)
        {
            throw new NotImplementedException();
        }
    }
}