using Amazon.S3;
using Amazon.S3.Model;
using CommandLine;
using Microsoft.Data.Sqlite;
using Microsoft.Extensions.Configuration;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Data.Odbc;
using System.IO;
using System.Reflection;

namespace org.ohdsi.cdm.presentation.etl
{

    class Program
    {
        static int Main(string[] arguments)
        {
            bool skipETL = true;
            bool skipValidation = true;

            bool skipMerge = true;
            var skipLookupCreation = true;
            var skipBuild = true;
            var skipVocabularyCopying = true;
            var skipChunkCreation = true;
            var resumeChunkCreation = true;

            var versionId = 0;

            var sourceCluster = string.Empty;
            var sourceDb = string.Empty;
            var sourceSchema = string.Empty;

            var vocabularySchema = string.Empty;
            Vendor vendor = null;
            string vendorName = null;
            int batchSize = 0;

            bool createNewBuildingId = true;

            bool skipCdmsource = true;

            var r = Parser.Default.ParseArguments<Options>(arguments)
                  .WithParsed<Options>(o =>
                  {
                      skipETL = o.SkipETL.Value;
                      skipLookupCreation = o.SkipLookup.Value;
                      skipBuild = o.SkipBuild.Value;
                      skipChunkCreation = o.SkipChunk.Value;
                      skipValidation = o.SkipValidation.Value;
                      skipVocabularyCopying = o.SkipVocabulary.Value;
                      skipMerge = o.SkipMerge.Value;
                      versionId = o.VersionId;
                      sourceCluster = o.SourceCluster;
                      sourceSchema = o.SourceSchema;
                      sourceDb = o.SourceDb;
                      vocabularySchema = o.VocabularySchema;
                      vendorName = o.Vendor;
                      batchSize = o.BatchSize;
                      createNewBuildingId = o.CreateNewBuildingId.Value;
                      skipCdmsource = o.CdmSource.Value;
                      resumeChunkCreation = o.ResumeChunk.Value;
                  });

            if (r.Tag.ToString() != "Parsed")
                return -1;

            try
            {
                Console.WriteLine("CurrentDirectory: " + Path.GetDirectoryName(Assembly.GetEntryAssembly().Location));

                var builder = new ConfigurationBuilder()
                    .AddJsonFile("appsettings.json");

                IConfigurationRoot configuration = builder.Build();

                vendor = EtlLibrary.CreateVendorInstance(configuration.GetSection("AppSettings")["etlLibraryPath"], vendorName);

                var builderConnectionString = configuration.GetConnectionString("Builder");


                if (!File.Exists("builder.db"))
                {
                    using var connection = new SqliteConnection("Data Source=builder.db");
                    connection.Open();

                    var command = connection.CreateCommand();
                    command.CommandText = File.ReadAllText("builderddl.sql");
                    command.ExecuteNonQuery();
                }

                Console.WriteLine("builder: local file (builder.db)");


                //var s3MessagesAccessKeyId = configuration.GetSection("AppSettings")["s3_messages_access_key_id"];
                //var s3MessagesSecretAccessKey = configuration.GetSection("AppSettings")["s3_messages_secret_access_key"];

                //var msgBucket = configuration.GetSection("AppSettings")["messages_bucket"];
                //var msgBucketMerge = configuration.GetSection("AppSettings")["messages_bucket_merge"];

                //Settings.Current.MessageS3AwsAccessKeyId = s3MessagesAccessKeyId;
                //Settings.Current.MessageS3AwsSecretAccessKey = s3MessagesSecretAccessKey;
                //Settings.Current.MessageBucket = msgBucket;

                //var rawFolder = configuration.GetSection("AppSettings")["rawFolder"];

                Settings.Initialize(builderConnectionString, Environment.MachineName);

                Settings.Current.CloudStorageUri = configuration.GetSection("AppSettings")["cloudStorageUri"];
                Settings.Current.CloudStorageHolder = configuration.GetSection("AppSettings")["cloudStorageHolder"];
                Settings.Current.CloudPrefix = configuration.GetSection("AppSettings")["cloudPrefix"];

                Settings.Current.CloudTriggerStorageUri = configuration.GetSection("AppSettings")["cloudTriggerStorageUri"];
                Settings.Current.CloudTriggerStorageHolder = configuration.GetSection("AppSettings")["cloudTriggerStorageHolder"];
                Settings.Current.CloudTriggerPrefix = configuration.GetSection("AppSettings")["cloudTriggerPrefix"];

                Settings.Current.CloudStorageKey = configuration.GetSection("AppSettings")["cloudStorageKey"];
                Settings.Current.CloudStorageSecret = configuration.GetSection("AppSettings")["cloudStorageSecret"];
                Settings.Current.CloudStorageName = configuration.GetSection("AppSettings")["cloudStorageName"];

                Settings.Current.CDMFolder = configuration.GetSection("AppSettings")["cdmFolder"];
                Settings.Current.Folder = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);

                Settings.Current.ParallelQueries = int.Parse(configuration.GetSection("AppSettings")["parallelQueries"]);
                Settings.Current.ParallelChunks = int.Parse(configuration.GetSection("AppSettings")["parallelChunks"]);

                Console.WriteLine($"ParallelQueries {Settings.Current.ParallelQueries}; ParallelChunks {Settings.Current.ParallelChunks}");

                Console.WriteLine();
                Console.WriteLine("initializing building settings...");

                var vocabularyConnectionString = configuration.GetConnectionString("Vocabulary");

                var sourceConnectionString = string.Empty;
                if (string.IsNullOrWhiteSpace(sourceCluster))
                {
                    sourceConnectionString = configuration.GetConnectionString("Source");
                }
                else
                {
                    sourceConnectionString = sourceCluster;
                }

                sourceConnectionString = sourceConnectionString.Replace("{db}", sourceDb).Replace("{sc}", sourceSchema);

                vocabularyConnectionString = vocabularyConnectionString.Replace("{db}", vocabularySchema);
                var destinationConnectionString = "Driver={Amazon Redshift (x64)};Server=fake;Database={db};Sc=cdm;UID=user1;PWD=pswd;Port=5439;SSL=true;Sslmode=Require";
                destinationConnectionString =
                    destinationConnectionString.Replace("{db}", "cdm_" + vendor + DateTime.Now.ToString("d_MMM_HHmmss"));


                if (vendor == null)
                    throw new Exception("Error: Vendor.None");

                if (batchSize <= 0)
                    throw new Exception("Error: batchSize <= 0");

                Settings.Current.Building.BatchSize = batchSize;
                Settings.Current.Building.RawSourceConnectionString = sourceConnectionString;
                Settings.Current.Building.RawVocabularyConnectionString = vocabularyConnectionString;
                Settings.Current.Building.RawDestinationConnectionString = destinationConnectionString;
                Settings.Current.Building.Vendor = vendor;
                Settings.Current.Building.EtlLibraryPath = configuration.GetSection("AppSettings")["etlLibraryPath"];

                if (!createNewBuildingId)
                {
                    var dbBuildingSettings = new DbBuildingSettings(configuration.GetConnectionString("Builder"));
                    var buildingId = dbBuildingSettings.GetBuildingId(sourceConnectionString, vocabularyConnectionString, vendor);

                    if (buildingId.HasValue)
                    {
                        Settings.Current.Building.Load(buildingId.Value);
                    }
                    else
                    {
                        Console.WriteLine("buildingId not found");
                    }
                }

                //var sourceOdbc = new OdbcConnectionStringBuilder(sourceConnectionString);
                var vocabOdbc = new OdbcConnectionStringBuilder(vocabularyConnectionString);

                Settings.Current.Building.Save();
                //Console.WriteLine($"source:{sourceOdbc["server"]}; {sourceDb}; {sourceSchema}");
                Console.WriteLine($"vocabulary:{vocabOdbc["server"]}; {vocabularySchema}");
                Console.WriteLine($"vendor:{vendor}");
                Console.WriteLine($"Cdm:{Settings.Current.Building.Cdm}");
                Console.WriteLine($"BatchSize:{Settings.Current.Building.BatchSize}");
                Console.WriteLine($"BuildingId:{Settings.Current.Building.Id}");
                Console.WriteLine("building settings - initialized successfully");


                //var lambdaUtility = new LambdaUtility(Settings.Current.CloudStorageKey,
                //    Settings.Current.CloudStorageSecret,
                //    s3MessagesAccessKeyId, s3MessagesSecretAccessKey, msgBucket, Settings.Current.CloudStorageName,
                //    msgBucketMerge, rawFolder);

                if (skipCdmsource)
                {
                    Console.WriteLine("Update CDM_SOURCE table step was skipped");
                }
                else
                {
                    var dbSource = new DbSource(sourceConnectionString, null, sourceSchema);
                    var sourceReleaseDate = dbSource.GetSourceReleaseDate();
                    var sourceVersionId = dbSource.GetSourceVersionId();
                    var vocabularyVersion = DbBuildingSettings.GetVocabularyVersion(vocabularyConnectionString, vocabularySchema);

                    Console.WriteLine("SourceReleaseDate:" + sourceReleaseDate);
                    Console.WriteLine("VocabularyVersion:" + vocabularyVersion);

                    ETL.SaveCdmSource(DateTime.Parse(sourceReleaseDate), vocabularyVersion);
                    ETL.SaveMetadata(sourceVersionId);
                    ETL.SaveVersion(versionId);

                    Console.WriteLine($"****************************************************************");
                }

                if (skipETL)
                {
                    Console.WriteLine("ETL step was skipped");
                }
                else
                {
                    ETL.SaveEtlLookupsToCloudStorage();

                    if (skipChunkCreation)
                    {
                        Console.WriteLine("Chunk creation skipped");
                    }
                    else
                    {
                        var chunksSchema = configuration.GetSection("AppSettings")["chunksSchema"];
                        if (!resumeChunkCreation)
                        {
                            ETL.CreateChunks(chunksSchema);
                        }
                        else
                        {
                            Console.WriteLine("Chunk creation resumed");
                        }

                        ETL.MoveRawDataCloudStorage(chunksSchema, sourceSchema);
                    }

                    if (skipVocabularyCopying)
                    {
                        Console.WriteLine("Vocabulary tables copying skipped");
                    }
                    else
                    {
                        ETL.CopyVocabularyTables();
                    }

                    if (skipLookupCreation)
                    {
                        Console.WriteLine("Lookup tables creation skipped");
                    }
                    else
                    {
                        ETL.CreateLookupTables();
                    }

                    if (skipBuild)
                    {
                        ETL.Build();
                    }
                    else
                    {
                        Console.WriteLine("Build step was skipped");
                    }
                }

                if (skipValidation)
                {
                    Console.WriteLine("Validation step was skipped");
                }
                else
                {
                    //var validation = new Validation();
                    //validation.Start(lambdaUtility, cdmFolder);
                }

                if (skipMerge)
                {
                    Console.WriteLine("Merge step was skipped");
                }
                else
                {
                    //lambdaUtility.TriggerMergeFunction(Settings.Current.Building.Vendor,
                    //    Settings.Current.Building.Id.Value, versionId, cdmFolderCsv,
                    //    false);

                    //var checkMerging = Task.Run(() => lambdaUtility.AllChunksWereDone(Settings.Current.Building.Vendor,
                    //  Settings.Current.Building.Id.Value, lambdaUtility.MergeMessageBucket));
                    //checkMerging.Wait();
                }

                Console.WriteLine("DONE.");
                return Settings.Current.Building.Id.Value;
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