using Amazon.S3;
using org.ohdsi.cdm.framework.common2.Attributes;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Lookups;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Linq;

namespace org.ohdsi.cdm.framework.desktop
{
    public class Vocabulary : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = new Dictionary<string, Lookup>();
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
                Ingredients = new HashSet<int>()
            };

            if (reader.FieldCount > 5)
            {
                lv.SourceConceptId = int.TryParse(reader[6].ToString(), out var scptId) ? scptId : 0;

                if (int.TryParse(reader[9].ToString(), out var ingredient))
                    lv.Ingredients.Add(ingredient);
            }


            return lv;
        }

        private void LoadPregnancyDrug(bool storeToS3)
        {
            var sql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder,
                @"Core\Lookups\PregnancyDrug.sql"));
            sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);
            
            
            Console.WriteLine("PregnancyDrug - Loading...");
            using (var connection =
                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
            using (var command = new OdbcCommand(sql, connection) {CommandTimeout = 0})
            using (var reader = command.ExecuteReader())
            {
                if (storeToS3)
                {
                    var fileName =
                        $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/Lookups/PregnancyDrug.txt.gz";

                    Console.WriteLine("PregnancyDrug - store to S3 | " + fileName);

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
                            reader);
                    }
                }
                else
                {
                    Console.WriteLine( "PregnancyDrug - filling");
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


        private void Load(IEnumerable<EntityDefinition> definitions, bool storeToS3)
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
                                var vendorFolder = Settings.Settings.Current.Building.Vendor.GetAttribute<FolderAttribute>().Value;
                                var sqlFileDestination = Path.Combine(Settings.Settings.Current.Builder.Folder, "Core", "Transformation",
                                    vendorFolder, "Lookups", conceptIdMapper.Lookup + ".sql");

                                var baseSql =
                                    File.ReadAllText(Path.Combine(Settings.Settings.Current.Builder.Folder, @"Core\Lookups\Base.sql"));

                                sql = File.ReadAllText(sqlFileDestination);

                                sql = sql.Replace("{base}", baseSql);
                                sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

                                try
                                {
                                    Console.WriteLine(conceptIdMapper.Lookup + " - Loading...");
                                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
                                    using (var command = new OdbcCommand(sql, connection) {CommandTimeout = 0})
                                    using (var reader = command.ExecuteReader())
                                    {
                                        
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
                                                    reader);
                                            }
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
                                        }
                                    }
                                    Console.WriteLine(conceptIdMapper.Lookup + " - Done");
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
        public void Fill(bool forLookup)
        {
            
            _genderConcepts = new GenderLookup();
            _genderConcepts.Load();

            _pregnancyConcepts = new PregnancyConcepts();

            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                if (forLookup)
                {
                    Load(qd.CareSites, false);
                    Load(qd.Providers, false);
                    Load(qd.Locations, false);
                }
                else
                {
                    Load(qd.Persons, false);
                    Load(qd.ConditionOccurrence, false);
                    Load(qd.DrugExposure, false);
                    Load(qd.ProcedureOccurrence, false);
                    Load(qd.Observation, false);
                    Load(qd.VisitOccurrence, false);
                    Load(qd.Death, false);
                    Load(qd.Measurement, false);
                    Load(qd.DeviceExposure, false);
                    Load(qd.Note, false);

                    Load(qd.VisitCost, false);
                    Load(qd.ProcedureCost, false);
                    Load(qd.DeviceCost, false);
                    Load(qd.ObservationCost, false);
                    Load(qd.MeasurementCost, false);
                    Load(qd.DrugCost, false);
                }
            }
            LoadPregnancyDrug(false);
        }

        public void SaveToS3()
        {
            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                Load(qd.Persons, true);
                Load(qd.ConditionOccurrence, true);
                Load(qd.DrugExposure, true);
                Load(qd.ProcedureOccurrence, true);
                Load(qd.Observation, true);
                Load(qd.VisitOccurrence, true);
                Load(qd.Death, true);
                Load(qd.Measurement, true);
                Load(qd.DeviceExposure, true);
                Load(qd.Note, true);

                Load(qd.VisitCost, true);
                Load(qd.ProcedureCost, true);
                Load(qd.DeviceCost, true);
                Load(qd.ObservationCost, true);
                Load(qd.MeasurementCost, true);
                Load(qd.DrugCost, true);
            }
            LoadPregnancyDrug(true);
        }

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
