using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using org.ohdsi.cdm.presentation.etl.ETLController;
using org.ohdsi.cdm.presentation.etl.Monitor;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.Odbc;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.etl
{
    class ETL
    {
        private static IETLController _etlController;

        private static IETLController EtlController
        {
            get
            {
                if(_etlController == null)
                {
                    if (Settings.Current.Building.SourceEngine.Database == framework.desktop.Enums.Database.Databricks)
                    {
                        _etlController = new DatabricksETLController();
                    }
                    else
                        _etlController = new RedshiftETLController();
                }
                return _etlController;
            }
        }

        #region ETL
        public static void SaveEtlLookupsToCloudStorage()
        {
            var vocabulary = new Vocabulary();
            foreach (var cl in vocabulary.GetCombinedLookups())
            {
                var reader = cl.Item1;
                var name = cl.Item2;

                var fileName = $"{Settings.Current.BuildingPrefix}/CombinedLookups/{name}.txt.gz";
                Console.WriteLine(name + " - store to CloudStorage | " + fileName);

                CloudStorageHelper.UploadFile(fileName, reader);
            }

            var created = new Dictionary<string, bool>();
            foreach (var ri in vocabulary.GetClinicalDataReaders())
            {
                using (ri)
                {
                    var fileName = $"{Settings.Current.BuildingPrefix}/Lookups/{ri.Name}.txt.gz";

                    if(created.ContainsKey(fileName))
                        continue;

                    Console.WriteLine(ri.Name + " - store to CloudStorage | " + fileName);

                    CloudStorageHelper.UploadFile(fileName, ri.DataReader);

                    created.Add(fileName, false);
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
                    CloudStorageHelper.UploadFile(fileName, reader);
                }
                Console.WriteLine("ConceptIdToSourceVocabularyId - Done");
            }

            Console.WriteLine("Vocabulary was saved to CloudStorage");
        }
        public static void CreateChunks(string chunksSchema, int functionChunkSize)
        {
            Console.WriteLine("Chunks creation in progress...");
            var chunkController = new ChunkController(chunksSchema);
            chunkController.CreateChunks(functionChunkSize);
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
                        
                        CloudStorageHelper.UploadFile(fileName, reader);
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

        public static void CreateSystemDataTables()
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

        public static void MoveRawDataCloudStorage(string chunksSchema, string sourceSchema)
        {
            var chunkController = new ChunkController(chunksSchema);
            Console.WriteLine("Moving raw data to CloudStorage...");
            var chunkIds = chunkController.GetNotMovedToCloudStorage().ToArray();

            if (chunkIds.Length == 0)
                return;

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, new ParallelOptions { MaxDegreeOfParallelism = 1 },  queryDefinition =>
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

                    EtlController.StoreMetadataToCloudStorage(queryDefinition, sql);
                }
            });

            Console.WriteLine($"PersonFileName:{Settings.Current.Building.PersonFileName}");
            Console.WriteLine($"PersonIdFieldName:{Settings.Current.Building.PersonIdFieldName}");
            Console.WriteLine($"PersonIdFieldIndex:{Settings.Current.Building.PersonIdFieldIndex}");
            using var queue = new BlockingCollection<string>();
            
            Task save = Task.Run(() =>
            {
                foreach (var item in queue.GetConsumingEnumerable())
                {
                    while(true)
                    {
                        var unprocessed = CloudStorageHelper.GetRunningFunctionInfo(Settings.Current.CloudTriggerStorageName, $"{Settings.Current.GetCDMBuildingPrefix}").Item1;
                        var canBeLaunched = Settings.Current.MaxFunctions - unprocessed;

                        if(canBeLaunched > 0)
                        {
                            CloudStorageHelper.TriggerFunctions(item);
                            break;
                        }
                        else
                            Thread.Sleep(TimeSpan.FromMinutes(1));
                    }
                }
            });

            using (var chunkManager = new ChunkManager())
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
                    foreach (var item in EtlController.GetTriggerMessages(chunksSchema, chunkId))
                    {
                        queue.Add(item);
                    }
                    
                    chunkManager.AddChunk(chunkId);
                });

                queue.CompleteAdding();
                Task.WaitAll(save);
                chunkManager.CompleteAdding();
                chunkManager.AwaitingCompletion();

                if (chunkManager.InvalidCount > 0)
                    throw new Exception($"ERROR - {chunkManager.InvalidCount} - Invalid chunks");
            }

            Console.WriteLine("Moving raw data to cloud storage - complete");
        }

        private static void MoveTableDataToCloudStorage(string chunksSchema, int chunkId, string sourceSchema)
        {
            var timer = new Stopwatch();
            timer.Start();

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions,
                new ParallelOptions { MaxDegreeOfParallelism = Settings.Current.ParallelQueries }, qd =>
                {
                    if (qd.Providers != null) return;
                    if (qd.Locations != null) return;
                    if (qd.CareSites != null) return;

                    EtlController.UnloadNative(chunksSchema, chunkId, sourceSchema, qd);
                });

            timer.Stop();
            Console.WriteLine($"chunkId={chunkId} | {timer.Elapsed.TotalSeconds}s");
        }
        #endregion

        #region Save System Data

        private static void SaveProvider()
        {
            Console.WriteLine("[Creating lookup] Loading providers...");
            var path = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/provider/";

            var provider = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Providers != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (provider == null)
                return;

            var index = 0;
            var providers = new List<Provider>();
            foreach (var entity in Helper.GetEntities<Provider>(provider, provider.Providers[0]))
            {
                providers.Add(entity);

                if (providers.Count == 250 * 1000)
                {
                    CloudStorageHelper.UploadFile(path + $"provider{index}.txt.gz", new ProviderDataReader(providers));
                    index++;
                    providers.Clear();
                }
            }

            if (providers.Count > 0)
                CloudStorageHelper.UploadFile(path + $"provider{index}.txt.gz", new ProviderDataReader(providers));

            Console.WriteLine("[Creating lookup] Providers was loaded");
        }

        private static void SaveCareSite()
        {
            Console.WriteLine("[Creating lookup] Loading care sites...");

            var path = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/care_site/";

            var careSite = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.CareSites != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (careSite == null)
                return;

            var index = 0;
            var careSites = new List<CareSite>();
            foreach (var entity in Helper.GetEntities<CareSite>(careSite, careSite.CareSites[0]))
            {
                careSites.Add(entity);

                if (careSites.Count == 250 * 1000)
                {
                    CloudStorageHelper.UploadFile(path + $"care_site{index}.txt.gz", new CareSiteDataReader(careSites));
                    index++;
                    careSites.Clear();
                }
            }

            if (careSites.Count == 0)
            {
                careSites.Add(new CareSite
                {
                    Id = 0,
                    LocationId = null,
                    OrganizationId = 0,
                    PlaceOfSvcSourceValue = null
                });
            }

            CloudStorageHelper.UploadFile(path + $"care_site{index}.txt.gz", new CareSiteDataReader(careSites));

            Console.WriteLine("[Creating lookup] Care sites was loaded");
        }

        private static void SaveLocation()
        {
            Console.WriteLine("[Creating lookup] Loading locations...");

            var path = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/location/";

            var location = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd =>
                qd.Locations != null && QueryDefinition.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));

            if (location == null)
                return;

            var index = 0;
            var locations = new List<Location>();
            foreach (var entity in Helper.GetEntities<Location>(location, location.Locations[0]))
            {
                locations.Add(entity);

                if (locations.Count == 250 * 1000)
                {
                    CloudStorageHelper.UploadFile(path + $"location{index}.txt.gz", new LocationDataReader(locations));
                    index++;
                    locations.Clear();
                }
            }

            if (locations.Count > 0)
                CloudStorageHelper.UploadFile(path + $"location{index}.txt.gz", new LocationDataReader(locations));

            Console.WriteLine("[Creating lookup] Locations was loaded " + Settings.Current.Building.Cdm);
        }
        #endregion

        #region Save Metadata

        public static void SaveMetadata(string sourceVersionId, string cdmVersionId)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/metadata/metadata.0.gz";

            List<MetadataOMOP> metadata = [];
            metadata.Add(new MetadataOMOP { Id = 0, MetadataConceptId = 0, Name = "NativeLoadId", ValueAsString = sourceVersionId, MetadataDate = DateTime.Now.Date });
            metadata.Add(new MetadataOMOP { Id = 1, MetadataConceptId = 0, Name = "CDMLoadId", ValueAsString = cdmVersionId.ToString(), MetadataDate = DateTime.Now.Date });
            metadata.Add(new MetadataOMOP { Id = 2, MetadataConceptId = 37116952, Name = "Source data citation", ValueAsString = Settings.Current.Building.Vendor.Citation, MetadataDate = DateTime.Now.Date });
            metadata.Add(new MetadataOMOP { Id = 3, MetadataConceptId = 4123211, Name = "Publication review requirements", ValueAsString = Settings.Current.Building.Vendor.Publication, MetadataDate = DateTime.Now.Date });

            CloudStorageHelper.UploadFile(file, new MetadataOMOPDataReader(metadata));
        }

        public static void SaveVersion(int versionId)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/_version/version.txt.gz";

            CloudStorageHelper.UploadFile(file, new VersionDataReader(versionId));
        }

        public static void SaveCdmSource(DateTime sourceReleaseDate, string vocabularyVersion)
        {
            var file = $"{Settings.Current.BuildingPrefix}/{Settings.Current.CDMFolder}/cdm_source/cdm_source.txt.gz";

            CloudStorageHelper.UploadFile(file, new framework.common.DataReaders.v5.v55.CdmSourceDataReader(sourceReleaseDate, vocabularyVersion));
        }
        #endregion
    }
}