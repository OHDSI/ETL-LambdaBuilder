using Amazon.S3;
using Azure.Identity;
using Azure.Storage.Blobs;
using Microsoft.Extensions.Configuration;
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
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.etl
{
    class ETL
    {
        private string _cdmFolderCsv;

        private static string ServiceUri { get; set; }
        private static string BlobContainerName { get; set; }

        private static string AzurePrefix { get; set; }
        private static string TenantId { get; set; }
        private static string ClientId { get; set; }
        private static string ClientSecret { get; set; }

        private static string BuildingPrefix
        {
            get
            {
                if(string.IsNullOrEmpty(AzurePrefix))
                    return $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";

                return $"{AzurePrefix}/{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";
            }
        }

        private static AmazonS3Client GetAwsStorageClient()
        {
            if (string.IsNullOrEmpty(Settings.Current.S3AwsAccessKeyId))
                return null;

            return new AmazonS3Client(
                    Settings.Current.S3AwsAccessKeyId,
                    Settings.Current.S3AwsSecretAccessKey,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
        }

        private static BlobContainerClient GetAzureStorageClient()
        {
            if (string.IsNullOrEmpty(TenantId))
                return null;

            var credential = new ClientSecretCredential(TenantId, ClientId, ClientSecret);
            var client = new BlobServiceClient(new Uri(ServiceUri), credential, null);
            return client.GetBlobContainerClient(BlobContainerName);
        }

        private static void CopyFile(IDataReader reader, string fileName)
        {
            FileTransferHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.Bucket,
                fileName,
                reader, "\t", '`', "\0");
        }

        private static void SaveVocabularyToCloudStorage()
        {
            var vocabulary = new Vocabulary();
            foreach (var cl in vocabulary.GetCombinedLookups())
            {
                var reader = cl.Item1;
                var name = cl.Item2;

                var fileName = $"{BuildingPrefix}/CombinedLookups/{name}.txt.gz";
                Console.WriteLine(name + " - store to S3 | " + fileName);
                CopyFile(reader, fileName);
            }

            foreach (var ri in vocabulary.GetClinicalDataReaders())
            {
                using (ri)
                {
                    var fileName = $"{BuildingPrefix}/Lookups/{ri.Name}.txt.gz";
                    Console.WriteLine(ri.Name + " - store to S3 | " + fileName);
                    CopyFile(ri.DataReader, fileName);
                }
            }

            using (var ri = vocabulary.GetPregnancyDrug())
            {
                using (ri)
                {
                    var fileName = $"{BuildingPrefix}/Lookups/PregnancyDrug.txt.gz";
                    Console.WriteLine("PregnancyDrug - store to S3 | " + fileName);
                    CopyFile(ri.DataReader, fileName);
                }
            }

            if (Settings.Current.Building.Vendor.Name == "CDM")
            {
                Console.WriteLine("ConceptIdToSourceVocabularyId - Loading...");

                var sql = File.ReadAllText(Path.Combine(Settings.Current.Folder, @"Core\Lookups\ConceptIdToSourceVocabularyId.sql"));
                sql = sql.Replace("{sc}", Settings.Current.Building.VocabularySchemaName);

                using (var connection =
                    SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.VocabularyConnectionString))
                using (var command = new OdbcCommand(sql, connection) { CommandTimeout = 0 })
                using (var reader = command.ExecuteReader())
                {
                    var fileName = $"{BuildingPrefix}/Lookups/ConceptIdToSourceVocabularyId.txt.gz";
                    Console.WriteLine("ConceptIdToSourceVocabularyId - store to S3 | " + fileName);
                    CopyFile(reader, fileName);
                }
                Console.WriteLine("ConceptIdToSourceVocabularyId - Done");
            }

            Console.WriteLine("Vocabulary was saved to S3");
        }

        public void Start(bool skipChunkCreation, bool resumeChunkCreation, bool skipLookupCreation, bool skipBuild, bool skipVocabularyCopying, LambdaUtility utility)
        {
            var builder = new ConfigurationBuilder()
                   .AddJsonFile("appsettings.json");
            IConfigurationRoot configuration = builder.Build();

            _cdmFolderCsv = configuration.GetSection("AppSettings")["cdm_folder_csv"];
            var chunksSchema = configuration.GetSection("AppSettings")["chunks_schema"];

            ServiceUri = configuration.GetSection("AppSettings")["blobURI"];
            BlobContainerName = configuration.GetSection("AppSettings")["containerName"];
            AzurePrefix = configuration.GetSection("AppSettings")["prefix"];
            TenantId = configuration.GetSection("AppSettings")["tenantId"];
            ClientId = configuration.GetSection("AppSettings")["clientId"];
            ClientSecret = configuration.GetSection("AppSettings")["clientSecret"];

            SaveVocabularyToCloudStorage();

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
                CreateLookupTables(skipLookupCreation);

                chunkController.MoveChunkDataToS3(true, true, utility);
            }
            else
            {
                Console.WriteLine("Chunk creation skipped");
                createLookupTables = Task.Run(() => CreateLookupTables(skipLookupCreation));
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

                    var folder = $"{BuildingPrefix}/{Settings.Current.CDMFolder}";
                    
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.VocabularyConnectionString))
                    using (var c = new OdbcCommand(query, connection))
                    {
                        c.CommandTimeout = 600;
                        using var reader = c.ExecuteReader();

                        var fileName = $"{folder}/{tableName}/{tableName}.txt.gz";
                        
                        FileTransferHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.Bucket, fileName, reader, ",", '"', @"\N");
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

        private void CreateLookupTables(bool skipLookupCreation)
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
                var vocabulary = new Vocabulary();
                vocabulary.Fill(true);
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