using Amazon.S3;
using Amazon.S3.Model;
using CommandLine;
using Microsoft.Data.Sqlite;
using Microsoft.Extensions.Configuration;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Settings;
using org.ohdsi.cdm.framework.desktop3.Monitor;
using System;
using System.IO;
using System.Reflection;
using System.Threading.Tasks;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.presentation.etl
{

    class Program
    {
        static void Main(string[] arguments)
        {
            bool skipETL = true;
            bool skipValidation = true;

            bool skipTransformToSpectrum = true;
            var skipLookupCreation = true;
            var skipBuild = true;
            var skipVocabularyCopying = true;
            var skipChunkCreation = true;
            var resumeChunkCreation = true;
                        
            var versionId = 0;

            var sourceCluster = "";
            var sourceDb = "";
            var sourceSchema = "";

            var vocabularySchema = "";
            Vendors vendor = Vendors.None;
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
                      skipTransformToSpectrum = o.SkipTransformToSpectrum.Value;
                      versionId = o.VersionId;
                      sourceCluster = o.SourceCluster;
                      sourceSchema = o.SourceSchema;
                      sourceDb = o.SourceDb;
                      vocabularySchema = o.VocabularySchema;
                      vendor = Vendor.GetVendorByName(o.Vendor);
                      batchSize = o.BatchSize;
                      createNewBuildingId = o.CreateNewBuildingId.Value;
                      skipCdmsource = o.CdmSource.Value;
                      resumeChunkCreation = o.ResumeChunk.Value;
                  });

            if (r.Tag.ToString() != "Parsed")
                return;

            try
            {
                Console.WriteLine("CurrentDirectory: " + Path.GetDirectoryName(Assembly.GetEntryAssembly().Location));
                
                var builder = new ConfigurationBuilder()
                    .AddJsonFile("appsettings.json");

                IConfigurationRoot configuration = builder.Build();

                var builderConnectionString = configuration.GetConnectionString("Builder");

                if (builderConnectionString == "Data Source=builder.db")
                {
                    if (!File.Exists("builder.db"))
                    {
                        using var connection = new SqliteConnection("Data Source=builder.db");
                        connection.Open();

                        var command = connection.CreateCommand();
                        command.CommandText = File.ReadAllText("builderdll.sql");
                        command.ExecuteNonQuery();
                    }
                }

                Console.WriteLine("builderConnectionString: " + builderConnectionString);
                var s3awsAccessKeyId = configuration.GetSection("AppSettings")["s3_aws_access_key_id"];
                var s3awsSecretAccessKey = configuration.GetSection("AppSettings")["s3_aws_secret_access_key"];

                var bucket = configuration.GetSection("AppSettings")["bucket"];
                var cdmFolder = configuration.GetSection("AppSettings")["cdm_folder"];
                var cdmFolderCsv = configuration.GetSection("AppSettings")["cdm_folder_csv"];
                var rawFolder = configuration.GetSection("AppSettings")["raw_folder"];

                var s3MessagesAccessKeyId = configuration.GetSection("AppSettings")["s3_messages_access_key_id"];
                var s3MessagesSecretAccessKey = configuration.GetSection("AppSettings")["s3_messages_secret_access_key"];

                var msgBucket = configuration.GetSection("AppSettings")["messages_bucket"];
                var msgBucketMerge = configuration.GetSection("AppSettings")["messages_bucket_merge"];

                var iamRole = configuration.GetSection("AppSettings")["iam_role"];

                Settings.Initialize(builderConnectionString, Environment.MachineName);
                Settings.Current.S3AwsAccessKeyId = s3awsAccessKeyId;
                Settings.Current.S3AwsSecretAccessKey = s3awsSecretAccessKey;
                Settings.Current.Bucket = bucket;

                Settings.Current.MessageS3AwsAccessKeyId = s3MessagesAccessKeyId;
                Settings.Current.MessageS3AwsSecretAccessKey = s3MessagesSecretAccessKey;
                Settings.Current.MessageBucket = msgBucket;

                Settings.Current.CDMFolder = cdmFolder;
                Settings.Current.SaveOnlyToS3 = true;
                Settings.Current.Builder.Folder = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);

                Settings.Current.ParallelQueries = int.Parse(configuration.GetSection("AppSettings")["parallel_queries"]);
                Settings.Current.ParallelChunks = int.Parse(configuration.GetSection("AppSettings")["parallel_chunks"]);
                //Settings.Current.LocalPath = configuration.GetSection("AppSettings")["local_path"];

                Console.WriteLine($"ParallelQueries {Settings.Current.ParallelQueries}; ParallelChunks {Settings.Current.ParallelChunks}");

                Console.WriteLine();
                Console.WriteLine("initializing building settings...");
                var sourceConnectionString = configuration.GetConnectionString("Source");
                var vocabularyConnectionString = configuration.GetConnectionString("Vocabulary");

                sourceConnectionString = sourceConnectionString.Replace("{db}", sourceDb).Replace("{sc}", sourceSchema);
                vocabularyConnectionString = vocabularyConnectionString.Replace("{db}", vocabularySchema);
                var destinationConnectionString = "Driver={Amazon Redshift (x64)};Server=fake;Database={db};Sc=cdm;UID=user1;PWD=pswd;Port=5439;SSL=true;Sslmode=Require";
                destinationConnectionString =
                    destinationConnectionString.Replace("{db}", "cdm_" + vendor + DateTime.Now.ToString("d_MMM_HHmmss"));


                if (vendor == Vendors.None)
                    throw new Exception("Error: Vendors.None");

                if (batchSize <= 0)
                    throw new Exception("Error: batchSize <= 0");

                Settings.Current.Building.BatchSize = batchSize;
                Settings.Current.Building.RawSourceConnectionString = sourceConnectionString;
                Settings.Current.Building.RawVocabularyConnectionString = vocabularyConnectionString;
                Settings.Current.Building.RawDestinationConnectionString = destinationConnectionString;
                Settings.Current.Building.Vendor = vendor;

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

                Settings.Current.Building.Save();
                Console.WriteLine($"sourceConnectionString:{sourceConnectionString}");
                Console.WriteLine($"vocabularyConnectionString:{vocabularyConnectionString}");
                Console.WriteLine($"vendor:{vendor}");
                Console.WriteLine($"Cdm:{Settings.Current.Building.Cdm}");
                Console.WriteLine($"BatchSize:{Settings.Current.Building.BatchSize}");
                Console.WriteLine($"BuildingId:{Settings.Current.Building.Id}");
                Console.WriteLine("building settings - initialized successfully");

                var useLocalSettings = string.IsNullOrEmpty(configuration.GetSection("AppSettings")["vendor_settings"]);

                if (useLocalSettings)
                {
                    Console.WriteLine("vendor settings loaded from local");
                }
                else
                {
                    SettingsLoader.LoadVendorSettings(configuration);
                }

                var lambdaUtility = new LambdaUtility(Settings.Current.S3AwsAccessKeyId,
                    Settings.Current.S3AwsSecretAccessKey,
                    s3MessagesAccessKeyId, s3MessagesSecretAccessKey, msgBucket, Settings.Current.Bucket,
                    msgBucketMerge, rawFolder);

                if (skipETL)
                {
                    Console.WriteLine("ETL step was skipped");
                }
                else
                {
                    var etl = new ETL();
                    etl.Start(skipChunkCreation, resumeChunkCreation, skipLookupCreation, skipBuild, skipVocabularyCopying, lambdaUtility, configuration.GetSection("AppSettings")["cdm_folder_csv"], !useLocalSettings);
                }

                if (skipValidation)
                {
                    Console.WriteLine("Validation step was skipped");
                }
                else
                {
                    var validation = new Validation();
                    validation.Start(lambdaUtility, cdmFolderCsv);
                }

                if (skipTransformToSpectrum)
                {
                    Console.WriteLine("Transform to Spectrum step was skipped");
                }
                else
                {
                    lambdaUtility.TriggerMergeFunction(Settings.Current.Building.Vendor,
                        Settings.Current.Building.Id.Value, versionId, cdmFolderCsv,
                        false);

                    var checkMerging = Task.Run(() => lambdaUtility.AllChunksWereDone(Settings.Current.Building.Vendor,
                      Settings.Current.Building.Id.Value, lambdaUtility.MergeMessageBucket));
                    checkMerging.Wait();
                }

                if (skipCdmsource)
                {
                    Console.WriteLine("Update CDM_SOURCE table step was skipped");
                }
                else
                {
                    var dbSource = new DbSource(sourceConnectionString, null, sourceSchema);
                    var sourceReleaseDate = dbSource.GetSourceReleaseDate();
                    var vocabularyVersion = DbBuildingSettings.GetVocabularyVersion(vocabularyConnectionString, vocabularySchema);

                    if (Settings.Current.Building.Cdm == CdmVersions.V54)
                    {
                        var reader = new CdmSourceDataReader54(vendor, DateTime.Parse(sourceReleaseDate), vocabularyVersion);
                        using var stream = reader.GetStreamCsv();
                        SaveToS3(stream, 0, "cdmCSV", "CDM_SOURCE", "gz", vendor, Settings.Current.Building.Id.Value);
                    }
                    else
                    {
                        var reader = new CdmSourceDataReader(vendor, DateTime.Parse(sourceReleaseDate), vocabularyVersion);
                        using var stream = reader.GetStreamCsv();
                        SaveToS3(stream, 0, "cdmCSV", "CDM_SOURCE", "gz", vendor, Settings.Current.Building.Id.Value);
                    }

                    Console.WriteLine($"****************************************************************");
                }

                Console.WriteLine("DONE.");
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }
        }

        private static void SaveToS3(Stream memoryStream, int index, string folder, string table, string extension, Vendors vendor, int buildingId)
        {
            if (memoryStream == null)
                return;

            Console.WriteLine($"{table}.{index} size={memoryStream.Length / 1024f / 1024f}Mb | Saving...");

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                BufferSize = 512 * 1024,
                MaxErrorRetry = 20
            };

            var fileName = $"{vendor}/{buildingId}/{folder}/{table}/{table}.0.{index}.{extension}";

            Console.WriteLine($"Bucket={Settings.Current.Bucket}");
            Console.WriteLine("Key=" + fileName);

            using (var c = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey, config))
            {
                var putObject = c.PutObjectAsync(new PutObjectRequest
                {
                    BucketName = $"{Settings.Current.Bucket}",
                    Key = fileName,
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                    StorageClass = S3StorageClass.Standard,
                    InputStream = memoryStream,
                    AutoCloseStream = false
                });
                putObject.Wait();

                var response = putObject.Result;

                if (string.IsNullOrEmpty(response.ETag))
                {
                    Console.WriteLine("!!! PutObject response is empty !!! | " + fileName);
                    throw new Exception("PutObject response.ETag is empty");
                }

            }
            Console.WriteLine($"{table}.{index} SAVED");
        }
    }
}