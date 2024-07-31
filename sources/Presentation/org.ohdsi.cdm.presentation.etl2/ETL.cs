using Amazon.S3;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Savers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.etl
{
    class ETL
    {
        private string _cdmFolderCsv;

        public void Start(bool skipChunkCreation, bool resumeChunkCreation, bool skipLookupCreation, bool skipBuild, bool skipVocabularyCopying, LambdaUtility utility, string cdmFolderCsv, bool readFromS3, string chunksSchema)
        {
            _cdmFolderCsv = cdmFolderCsv;

            var vocabulary = new Vocabulary();
            vocabulary.SaveToS3(!string.IsNullOrEmpty(Settings.Current.VendorSettings));
            Console.WriteLine("Vocabulary was saved to S3");

            Task createLookupTables = null;
            Task copyVocabularyTables = null;
            Task checkCreation = null;

            if (!skipChunkCreation)
            {
                Console.WriteLine("Chunks creation in progress...");

                var chunkController = new ChunkController(chunksSchema);

                if (!resumeChunkCreation)
                    chunkController.CreateChunks();

                CopyVocabularyTables(skipVocabularyCopying);
                CreateLookupTables(vocabulary, skipLookupCreation, readFromS3);

                chunkController.MoveChunkDataToS3(true, true, utility);
            }
            else
            {
                Console.WriteLine("Chunk creation skipped");
                createLookupTables = Task.Run(() => CreateLookupTables(vocabulary, skipLookupCreation, readFromS3));
                copyVocabularyTables = Task.Run(() => CopyVocabularyTables(skipVocabularyCopying));

                if (!skipBuild)
                {
                    var tasks = utility.TriggerBuildFunction(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, null, false);
                    Task.WaitAll([.. tasks]);
                    Console.WriteLine("CDM Build lambda functions were triggered");

                    checkCreation = Task.Run(() => utility.AllChunksWereDone(Settings.Current.Building.Vendor,
                        Settings.Current.Building.Id.Value, utility.BuildMessageBucket));
                }
                else
                {
                    Console.WriteLine("Build step was skipped");
                }
            }

            createLookupTables?.Wait();
            copyVocabularyTables?.Wait();
            checkCreation?.Wait();
        }

        private static void CopyVocabularyTables(bool skipVocabularyCopying)
        {
            try
            {
                if (skipVocabularyCopying)
                {
                    Console.WriteLine("Vocabulary tables copying skipped");
                    return;
                }

                Console.WriteLine("Copying vocabulary tables...");

                var vocabQueriesPath = Path.Combine(Settings.Current.Folder, "Common", "Redshift", "v5.2",
                    "Vocabulary");

                foreach (var filePath in Directory.GetFiles(vocabQueriesPath))
                {
                    var tableName = Path.GetFileNameWithoutExtension(filePath);
                    Console.WriteLine("[Vocabulary] copying " + tableName);

                    var schemaName = Settings.Current.Building.VocabularySchemaName;
                    var query = File.ReadAllText(filePath);
                    query = query.Replace("{sc}", schemaName);

                    var folder =
                        $"{Settings.Current.Building.Vendor}/" +
                        $"{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}";

                    var config = new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    };

                    using (var currentClient = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey, config))
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.VocabularyConnectionString))
                    using (var c = new OdbcCommand(query, connection))
                    {
                        c.CommandTimeout = 600;
                        using var reader = c.ExecuteReader();

                        var fileName = $"{folder}/{tableName}/{tableName}.txt.gz";
                        AmazonS3Helper.CopyFile(currentClient, Settings.Current.Bucket, fileName, reader, ",", '"', @"\N");
                    }

                    Console.WriteLine("[Vocabulary] " + tableName + " SAVED");
                }

                Console.WriteLine("[Vocabulary] DONE.");
            }
            catch (Exception e)
            {
                Console.WriteLine("[Vocabulary] ERROR " + e.Message);
            }
        }

        private void CreateLookupTables(Vocabulary vocabulary, bool skipLookupCreation, bool readFromS3)
        {
            try
            {
                if (skipLookupCreation)
                {
                    Console.WriteLine("Lookup tables creation skipped");
                    return;
                }

                Console.WriteLine("Creating lookup tables...");
                Console.WriteLine("[Creating lookup] Loading vocabulary...");

                vocabulary.Fill(true, readFromS3);
                Console.WriteLine("[Creating lookup] Vocabulary was loaded");

                var saver = new RedshiftSaver();
                using (saver.Create(Settings.Current.Building.DestinationConnectionString))
                {
                    SaveLocation(saver);
                    SaveCareSite(saver);
                    SaveProvider(saver);
                }

                Console.WriteLine("[Creating lookup] Lookups was saved " +
                                  Settings.Current.Building.DestinationEngine.Database);
            }
            catch (Exception e)
            {
                Console.WriteLine("[Creating lookup] Tables Location, Provider, Care site were not created due error " + e.Message);
                Console.WriteLine(e.StackTrace);
            }
        }

        private void SaveProvider(RedshiftSaver saver)
        {
            var provider = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Providers != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));
            if (provider != null)
            {
                Console.WriteLine("[Creating lookup] Loading providers...");

                var providerConcepts = new List<Provider>();
                var count = 0;
                var index = 0;
                foreach (var entity in GetEntities<Provider>(provider, provider.Providers[0]))
                {
                    providerConcepts.Add(entity);
                    if (providerConcepts.Count == 250 * 1000)
                    {
                        saver.SaveEntityLookup(providerConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv);
                        index++;
                        providerConcepts.Clear();
                    }

                    count++;
                }

                if (providerConcepts.Count > 0)
                    saver.SaveEntityLookup(providerConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv);

                Console.WriteLine("[Creating lookup] Providers was loaded");
            }
        }

        private void SaveCareSite(RedshiftSaver saver)
        {
            Console.WriteLine("[Creating lookup] Loading care sites...");

            var careSiteConcepts = new List<CareSite>();
            var count = 0;
            var index = 0;

            var careSite = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.CareSites != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (careSite != null)
            {
                foreach (var entity in GetEntities<CareSite>(careSite, careSite.CareSites[0]))
                {
                    careSiteConcepts.Add(entity);
                    if (careSiteConcepts.Count == 250 * 1000)
                    {
                        saver.SaveEntityLookup(careSiteConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv);
                        index++;
                        careSiteConcepts.Clear();
                    }

                    count++;
                }
            }

            if (count == 0)
                careSiteConcepts.Add(new CareSite
                {
                    Id = 0,
                    LocationId = null,
                    OrganizationId = 0,
                    PlaceOfSvcSourceValue = null
                });

            if (careSiteConcepts.Count > 0)
                saver.SaveEntityLookup(careSiteConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv);

            Console.WriteLine("[Creating lookup] Care sites was loaded");
        }

        private void SaveLocation(RedshiftSaver saver)
        {
            Console.WriteLine("[Creating lookup] Loading locations...");

            var location = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Locations != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            var locationConcepts = new List<Location>();
            var count = 0;
            var index = 0;

            if (location != null)
            {
                foreach (var entity in GetEntities<Location>(location, location.Locations[0]))
                {
                    locationConcepts.Add(entity);
                    if (locationConcepts.Count == 250 * 1000)
                    {
                        saver.SaveEntityLookup(locationConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv, Settings.Current.Building.Cdm);
                        index++;
                        locationConcepts.Clear();
                    }

                    count++;
                }

            }

            if (locationConcepts.Count > 0)
                saver.SaveEntityLookup(locationConcepts, index, Settings.Current.CDMFolder, _cdmFolderCsv, Settings.Current.Building.Cdm);

            Console.WriteLine("[Creating lookup] Locations was loaded " + Settings.Current.Building.Cdm);
        }

        private static IEnumerable<T> GetEntities<T>(QueryDefinition qd, EntityDefinition ed) where T : IEntity
        {
            var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
                qd.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName, Settings.Current.Building.SourceSchemaName), Settings.Current.Building.SourceSchemaName);
            var keys = new Dictionary<string, bool>();
            if (!string.IsNullOrEmpty(sql))
            {
                using var connection = new OdbcConnection(Settings.Current.Building.SourceConnectionString);
                connection.Open();
                using var c = new OdbcCommand(sql, connection);
                c.CommandTimeout = 30000;
                using var reader = c.ExecuteReader();
                while (reader.Read())
                {
                    Concept conceptDef = null;
                    if (ed.Concepts != null && ed.Concepts.Length != 0)
                        conceptDef = ed.Concepts[0];

                    var concept = (T)ed.GetConcepts(conceptDef, reader, null).ToList()[0];

                    var key = concept.GetKey();
                    if (key == null) continue;

                    if (keys.ContainsKey(key))
                        continue;

                    keys.Add(key, false);

                    yield return concept;
                }
            }
        }
    }
}