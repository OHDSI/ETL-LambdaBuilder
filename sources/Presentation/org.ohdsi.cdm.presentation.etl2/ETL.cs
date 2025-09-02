using Amazon.S3;
using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using org.ohdsi.cdm.presentation.etl.Monitor;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.etl
{
    class ETL
    {
        public static void SaveEtlLookupsToCloudStorage()
        {
            var vocabulary = new Vocabulary();
            foreach (var cl in vocabulary.GetCombinedLookups())
            {
                var reader = cl.Item1;
                var name = cl.Item2;

                var fileName = $"{Settings.Current.BuildingPrefix}/CombinedLookups/{name}.txt.gz";
                Console.WriteLine(name + " - store to CloudStorage | " + fileName);

                CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                fileName,
                reader);
            }

            foreach (var ri in vocabulary.GetClinicalDataReaders())
            {
                using (ri)
                {
                    var fileName = $"{Settings.Current.BuildingPrefix}/Lookups/{ri.Name}.txt.gz";
                    Console.WriteLine(ri.Name + " - store to CloudStorage | " + fileName);

                    CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                        fileName,
                        ri.DataReader);
                }
            }

            using (var ri = vocabulary.GetPregnancyDrug())
            {
                using (ri)
                {
                    var fileName = $"{Settings.Current.BuildingPrefix}/Lookups/PregnancyDrug.txt.gz";
                    Console.WriteLine("PregnancyDrug - store to CloudStorage | " + fileName);
                    
                    CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                        fileName,
                        ri.DataReader);
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
                    var fileName = $"{Settings.Current.BuildingPrefix}/Lookups/ConceptIdToSourceVocabularyId.txt.gz";
                    Console.WriteLine("ConceptIdToSourceVocabularyId - store to CloudStorage | " + fileName);
                    CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                        fileName,
                        reader);
                }
                Console.WriteLine("ConceptIdToSourceVocabularyId - Done");
            }

            Console.WriteLine("Vocabulary was saved to CloudStorage");
        }
        public static void CreateChunks(string chunksSchema)
        {
            Console.WriteLine("Chunks creation in progress...");
            var chunkController = new ChunkController(chunksSchema);
            chunkController.CreateChunks(5_000);
        }

        public static void CopyVocabularyTables()
        {
            try
            {
                Console.WriteLine("Copying vocabulary tables...");

                var vocabQueriesPath = Path.Combine(Settings.Current.Folder, "Common", "Queries", "Vocabulary");

                foreach (var filePath in Directory.GetFiles(vocabQueriesPath))
                {
                    var tableName = Path.GetFileNameWithoutExtension(filePath);
                    Console.WriteLine("[Vocabulary] copying " + tableName);

                    var schemaName = Settings.Current.Building.VocabularySchemaName;
                    var query = File.ReadAllText(filePath);
                    query = query.Replace("{sc}", schemaName);

                    var folder = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}";
                    
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.VocabularyConnectionString))
                    using (var c = new OdbcCommand(query, connection))
                    {
                        c.CommandTimeout = 600;
                        using var reader = c.ExecuteReader();
                        var fileName = $"{folder}/{tableName}/{tableName}.txt.gz";
                        
                        CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                            fileName,
                            reader);
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

        public static void CreateLookupTables()
        {
            try
            {
                Console.WriteLine("Creating lookup tables...");
                Console.WriteLine("[Creating lookup] Loading vocabulary...");
                var vocabulary = new Vocabulary();
                vocabulary.Fill(true);
                Console.WriteLine("[Creating lookup] Vocabulary was loaded");

                SaveLocation();
                SaveCareSite();
                SaveProvider();

                Console.WriteLine("[Creating lookup] Lookups was saved " +
                                  Settings.Current.Building.DestinationEngine.Database);
            }
            catch (Exception e)
            {
                Console.WriteLine("[Creating lookup] Tables Location, Provider, Care site were not created due error " + e.Message);
                Console.WriteLine(e.StackTrace);
            }
        }

        public static void Build()
        {
            //            //var tasks = utility.TriggerBuildFunction(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, null, false);
            //            //Task.WaitAll([.. tasks]);
            //            //Console.WriteLine("CDM Build lambda functions were triggered");

            //            //checkCreation = Task.Run(() => utility.AllChunksWereDone(Settings.Current.Building.Vendor,
            //            //    Settings.Current.Building.Id.Value, utility.BuildMessageBucket));
        }

        public static void SaveMetadata(string sourceVersionId)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/metadata/metadata.0.txt.gz";

            List<MetadataOMOP> metadata = [];
            metadata.Add(new MetadataOMOP { Id = 0, MetadataConceptId = 0, Name = "NativeLoadId", ValueAsString = sourceVersionId, MetadataDate = DateTime.Now.Date });

            CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new MetadataOMOPDataReader(metadata));
        }

        public static void SaveVersion(int versionId)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/_version/version.txt.gz";

            CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new VersionDataReader(versionId));
        }

        public static void SaveCdmSource(DateTime sourceReleaseDate, string vocabularyVersion)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/cdm_source/cdm_source.txt.gz";

            CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new CdmSourceDataReader(sourceReleaseDate, vocabularyVersion));
        }

        //public void MoveChunkDataToS3(bool useMonitor, bool triggerLambdas, LambdaUtility utility)
        public static void MoveRawDataCloudStorage(string chunksSchema, string sourceSchema)
        {
            var chunkController = new ChunkController(chunksSchema);
            Console.WriteLine("Moving raw data to CloudStorage...");
            var chunkIds = chunkController.GetNotMovedToCloudStorage().ToArray();

            if (chunkIds.Length == 0)
                return;

            var numberOfPartitions = GetNumberOfPartitions(chunksSchema);
            Console.WriteLine("ТumberOfPartitions=" + numberOfPartitions);

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, queryDefinition =>
            {
                if (queryDefinition.Providers != null) return;
                if (queryDefinition.Locations != null) return;
                if (queryDefinition.CareSites != null) return;

                var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
                    queryDefinition.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName, chunksSchema), Settings.Current.Building.SourceSchemaName);

                if (string.IsNullOrEmpty(sql)) return;

                sql = string.Format(sql, chunkIds[0]);

                if (queryDefinition.FieldHeaders == null)
                {
                    if (queryDefinition.Persons != null)
                    {
                        Settings.Current.Building.PersonIdFieldName = queryDefinition.GetPersonIdFieldName();
                        Settings.Current.Building.PersonFileName = queryDefinition.FileName;
                    }
                    StoreMetadataToCloudStorage(queryDefinition, sql);
                }
            });

            Console.WriteLine($"PersonFileName:{Settings.Current.Building.PersonFileName}");
            Console.WriteLine($"PersonIdFieldName:{Settings.Current.Building.PersonIdFieldName}");
            Console.WriteLine($"PersonIdFieldIndex:{Settings.Current.Building.PersonIdFieldIndex}");
                  
            using (var chunkManager = new ChunkManager(chunksSchema, numberOfPartitions))
            {
                Parallel.ForEach(chunkIds, new ParallelOptions { MaxDegreeOfParallelism = Settings.Current.ParallelChunks }, cId =>
                {
                    var chunkId = cId;

                    var attempt = 0;
                    var complete = false;
                    while (!complete)
                    {
                        attempt++;
                        try
                        {
                            MoveTableDataToCloudStorage(chunksSchema, chunkId, sourceSchema);
                            complete = true;
                        }
                        catch (Exception e)
                        {
                            Console.Write(e.Message + " | Exception | new attempt | attempt=" + attempt);
                            if (attempt > 3)
                            {
                                throw;
                            }
                        }
                    }

                    chunkController.ChunkCreated(chunkId, Settings.Current.Building.Id.Value);
                    Console.WriteLine("[Moving raw data] Raw data for chunkId=" + chunkId + " is available on cloud storage");

                    //var tasks = utility.TriggerBuildFunction(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, chunkId, false);
                    //Task.WaitAll([.. tasks]);
                    //Console.WriteLine($"[Moving raw data] Lambda functions for cuhnkId={chunkId} were triggered | {tasks.Count} functions");

                    chunkManager.AddChunk(chunkId);

                    var unprocessed = 0;
                    do
                    {
                        try
                        {
                            unprocessed = CloadStorageHelper.GetObjectInfo(
                                GetAwsTriggerStorageClient(),
                                GetAzureTriggerStorageClient(),
                                Settings.Current.CloudTriggerStorageName,
                                $"{Settings.Current.BuildingTriggerPrefix}.").Count();

                            Console.WriteLine($"[Moving raw data] Unprocessed functions={unprocessed}");

                            if (unprocessed > 700)
                            {
                                Console.WriteLine($"[Moving raw data] unprocessed > 700, waiting 3 minutes...");
                                Thread.Sleep(TimeSpan.FromMinutes(3));
                            }
                        }
                        catch(Exception ex) // TMP
                        {

                        }
                    }
                    while (unprocessed > 700);
                });

                chunkManager.CompleteAdding();
                chunkManager.AwaitingCompletion();

                if (chunkManager.InvalidCount > 0)
                    throw new Exception($"ERROR - {chunkManager.InvalidCount} - Invalid chunks");
            }

            Console.WriteLine("Moving raw data to cloud storage - complete");
        }

        private static void StoreMetadataToCloudStorage(QueryDefinition queryDefinition, string query)
        {
            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage start - " + queryDefinition.FileName);
            var fileName = $"{Settings.Current.BuildingPrefix}/raw/metadata/{queryDefinition.FileName + ".txt"}";

            using (var conn = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString))
            using (var c = Settings.Current.Building.SourceEngine.GetCommand(query, conn))
            using (var reader = c.ExecuteReader(CommandBehavior.SchemaOnly))
            {
                CloadStorageHelper.UploadFile(GetAwsStorageClient(), 
                    GetAzureStorageClient(), 
                    Settings.Current.CloudStorageName,
                    fileName,
                    reader,
                    false,
                    true);
            }
            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage end - " + queryDefinition.FileName);
        }

        private static AmazonS3Client GetAwsStorageClient()
        {
            if (!string.IsNullOrEmpty(Settings.Current.CloudStorageHolder))
                return null;

            return new AmazonS3Client(
                    Settings.Current.CloudStorageKey,
                    Settings.Current.CloudStorageSecret,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
        }

        private static BlobContainerClient GetAzureStorageClient()
        {
            if (string.IsNullOrEmpty(Settings.Current.CloudStorageHolder))
                return null;

            var credential = new ClientSecretCredential(Settings.Current.CloudStorageHolder, Settings.Current.CloudStorageKey, Settings.Current.CloudStorageSecret);
            var client = new BlobServiceClient(new Uri(Settings.Current.CloudStorageUri), credential, null);
            return client.GetBlobContainerClient(Settings.Current.CloudStorageName);
        }

        private static AmazonS3Client GetAwsTriggerStorageClient()
        {
            if (!string.IsNullOrEmpty(Settings.Current.CloudTriggerStorageHolder))
                return null;

            return new AmazonS3Client(
                    Settings.Current.CloudTriggerStorageKey,
                    Settings.Current.CloudTriggerStorageSecret,
                    new AmazonS3Config
                    {
                        Timeout = TimeSpan.FromMinutes(60),
                        RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                        MaxErrorRetry = 20,
                    });
        }

        private static BlobContainerClient GetAzureTriggerStorageClient()
        {
            if (string.IsNullOrEmpty(Settings.Current.CloudTriggerStorageHolder))
                return null;

            var credential = new ClientSecretCredential(Settings.Current.CloudTriggerStorageHolder, Settings.Current.CloudTriggerStorageKey, Settings.Current.CloudTriggerStorageSecret);
            var client = new BlobServiceClient(new Uri(Settings.Current.CloudTriggerStorageUri), credential, null);
            return client.GetBlobContainerClient(Settings.Current.CloudTriggerStorageName);
        }

        private static void SaveProvider()
        {
            Console.WriteLine("[Creating lookup] Loading providers...");
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/provider/provider.txt.gz";

            var provider = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Providers != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (provider == null)
                return;

            var providerConcepts = new List<Provider>();
            foreach (var entity in GetEntities<Provider>(provider, provider.Providers[0]))
            {
                providerConcepts.Add(entity);
            }

            if (providerConcepts.Count > 0)
                CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new ProviderDataReader(providerConcepts));

            Console.WriteLine("[Creating lookup] Providers was loaded");
        }

        private static void SaveCareSite()
        {
            Console.WriteLine("[Creating lookup] Loading care sites...");

            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/care_site/care_site.txt.gz";

            var careSite = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.CareSites != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (careSite == null)
                return;

            var careSiteConcepts = new List<CareSite>();
            foreach (var entity in GetEntities<CareSite>(careSite, careSite.CareSites[0]))
            {
                careSiteConcepts.Add(entity);
            }

            if (careSiteConcepts.Count == 0)
            {
                careSiteConcepts.Add(new CareSite
                {
                    Id = 0,
                    LocationId = null,
                    OrganizationId = 0,
                    PlaceOfSvcSourceValue = null
                });
            }

            CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new CareSiteDataReader(careSiteConcepts));

            Console.WriteLine("[Creating lookup] Care sites was loaded");
        }

        private static void SaveLocation()
        {
            Console.WriteLine("[Creating lookup] Loading locations...");

            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/location/location.txt.gz";

            var location = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Locations != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (location == null)
                return;

            var locationConcepts = new List<Location>();
            foreach (var entity in GetEntities<Location>(location, location.Locations[0]))
            {
                locationConcepts.Add(entity);
            }

            if (locationConcepts.Count > 0)
                CloadStorageHelper.UploadFile(GetAwsStorageClient(), GetAzureStorageClient(), Settings.Current.CloudStorageName,
                    file,
                    new LocationDataReader(locationConcepts));

            Console.WriteLine("[Creating lookup] Locations was loaded " + Settings.Current.Building.Cdm);
        }

        private static void MoveTableDataToCloudStorage(string chunksSchema, int chunkId, string sourceSchema)
        {
            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions,
                new ParallelOptions { MaxDegreeOfParallelism = Settings.Current.ParallelQueries }, qd =>
                {
                    if (qd.Providers != null) return;
                    if (qd.Locations != null) return;
                    if (qd.CareSites != null) return;

                    var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
                               qd.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName,
                                   chunksSchema), Settings.Current.Building.SourceSchemaName);

                    if (string.IsNullOrEmpty(sql))
                        return;

                    sql = string.Format(sql, chunkId);
                    string unloadQuery = null;

                    var personIdField = qd.GetPersonIdFieldName();
                    var tableName = "#" + qd.FileName + "_" + chunkId;
                    var folder = $"{Settings.Current.BuildingPrefix}/raw/{chunkId}/{qd.FileName}/";
                    // Azure
                    if (Settings.Current.Building.SourceEngine.Database == framework.desktop.Enums.Database.Databricks)
                    {
                        tableName = $"{chunksSchema}.{sourceSchema.Split('.')[1]}_{qd.FileName}_{chunkId}";

                        unloadQuery =
                            $@"CREATE EXTERNAL TABLE {tableName} " +
                            $@"USING csv " +
                            $@"PARTITIONED BY(PartitionId) " +
                            $@"LOCATION 'abfss://{Settings.Current.CloudStorageName}@{Settings.Current.CloudStorageUriDfs}/{folder}' " +
                            $@"OPTIONS(delimiter = '\t', nullValue = '\\N',  compression = 'gzip') " +
                            $@"AS({sql});";
                    }
                    // AWS
                    else
                    {
                        tableName = "#" + qd.FileName + "_" + chunkId;

                        unloadQuery =
                        $"create table {tableName} sortkey ({personIdField}) distkey ({personIdField}) as {sql}; " +
                        $@"UNLOAD ('select * from {tableName} order by {personIdField}') to 's3://{folder}/{qd.FileName}' " +
                        $@"DELIMITER AS '\t' " +
                        $@"NULL AS '\\N' " +
                        $@"credentials 'aws_access_key_id={Settings.Current.CloudStorageKey};aws_secret_access_key={Settings.Current.CloudStorageSecret}' " +
                        $@"ZSTD ALLOWOVERWRITE PARALLEL ON";
                    }

                    using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);
                    using var c = new OdbcCommand(unloadQuery, connection);
                    c.CommandTimeout = 900;
                    c.ExecuteNonQuery();

                    if (Settings.Current.Building.SourceEngine.Database == framework.desktop.Enums.Database.Databricks)
                    {
                        var drop = new OdbcCommand($"drop table {tableName}", connection);
                        drop.ExecuteNonQuery();
                    }
                });
        }

        private static int GetNumberOfPartitions(string chunksSchema)
        {
            // Azure
            if (Settings.Current.Building.SourceEngine.Database == framework.desktop.Enums.Database.Databricks)
            {
                using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);
                using var c = new OdbcCommand($"select count(distinct PartitionId) from {chunksSchema}._chunks;", connection);
                return Convert.ToInt32(c.ExecuteScalar());
            }
            // AWS
            else
            {
                using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);
                using var c = new OdbcCommand("SELECT count(*) FROM stv_slices;", connection);
                
                return Convert.ToInt32(c.ExecuteScalar());
            }
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