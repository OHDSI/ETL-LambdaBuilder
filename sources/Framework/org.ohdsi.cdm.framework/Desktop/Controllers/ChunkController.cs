using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop3.Monitor;
using System.Data;
using System.Data.Odbc;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace org.ohdsi.cdm.framework.desktop.Controllers
{
    public class ChunkController
    {
        private readonly DbChunk _dbChunk;
        private readonly DbSource _dbSource;
        private string _chunksSchema;

        public ChunkController(string chunksSchema)
        {
            _dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
            _dbSource = new DbSource(
                Settings.Settings.Current.Building.SourceConnectionString, 
                Settings.Settings.Current.Building.SourceEngine.Database.ToString(), 
                Settings.Settings.Current.Building.SourceSchemaName);

            _chunksSchema = chunksSchema;
        }


        public void ClenupChunks()
        {
            _dbSource.DropChunkTable(_chunksSchema);
        }

        public void CreateChunks()
        {
            Console.WriteLine("Generating chunk ids...");
            _dbChunk.ClearChunks(Settings.Settings.Current.Building.Id.Value);
            _dbSource.CreateChunkTable(_chunksSchema);

            var chunkId = 0;
            var k = 0;

            var chunksConnectionString = Regex.Replace(Settings.Settings.Current.Building.RawSourceConnectionString, "sc=" + _chunksSchema + ";", "", RegexOptions.IgnoreCase);
            using (var saver = Settings.Settings.Current.Building.SourceEngine.GetSaver()
                .Create(chunksConnectionString))
            {
                var chunks = new List<ChunkRecord>();
                foreach (var chunk in GetPersonKeys(Settings.Settings.Current.Building.BatchSize))
                {
                    _dbChunk.AddChunk(chunkId, Settings.Settings.Current.Building.Id.Value);
                    chunks.AddRange(chunk.Select(c =>
                        new ChunkRecord { Id = chunkId, PersonId = Convert.ToInt64(c.Key), PersonSource = c.Value }));

                    if (Settings.Settings.Current.Building.SourceEngine.Database == Database.Redshift)
                    {
                        saver.AddChunk(chunks, k, _chunksSchema);
                        chunks.Clear();
                        GC.Collect();
                        k++;
                    }

                    chunkId++;
                }

                if (chunks.Count > 0)
                {
                    saver.AddChunk(chunks, k, _chunksSchema);
                }

                saver.Commit();
            }

            Console.WriteLine("***** Chunk ids were generated and saved, total count=" + chunkId + " *****");
        }

        public void MoveChunkDataToS3(bool useMonitor, bool triggerLambdas, LambdaUtility utility)
        {
            Console.WriteLine("Moving raw data to S3...");
            var chunkIds = _dbChunk.GetNotMovedToS3Chunks(Settings.Settings.Current.Building.Id.Value).ToArray();

            if (chunkIds.Length == 0)
                return;

            var baseFolder =
                $"{Settings.Settings.Current.Bucket}/{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw";
            Console.WriteLine("[Moving raw data] S3 raw folder - " + baseFolder);

            Parallel.ForEach(Settings.Settings.Current.Building.SourceQueryDefinitions, queryDefinition =>
            {
                if (queryDefinition.Providers != null) return;
                if (queryDefinition.Locations != null) return;
                if (queryDefinition.CareSites != null) return;

                var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                    queryDefinition.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName, _chunksSchema, Settings.Settings.Current.Building.Param1), Settings.Settings.Current.Building.SourceSchemaName);

                if (string.IsNullOrEmpty(sql)) return;

                sql = string.Format(sql, chunkIds[0]);

                if (queryDefinition.FieldHeaders == null)
                {
                    if (queryDefinition.Persons != null)
                    {
                        Settings.Settings.Current.Building.PersonIdFieldName = queryDefinition.GetPersonIdFieldName();
                        Settings.Settings.Current.Building.PersonFileName = queryDefinition.FileName;
                    }
                    StoreMetadataToS3(queryDefinition, sql);
                }
            });

            Console.WriteLine($"PersonFileName:{Settings.Settings.Current.Building.PersonFileName}");
            Console.WriteLine($"PersonIdFieldName:{Settings.Settings.Current.Building.PersonIdFieldName}");
            Console.WriteLine($"PersonIdFieldIndex:{Settings.Settings.Current.Building.PersonIdFieldIndex}");

            Task monitorHandle = null;
            using (var monitor = new ChunksMonitor())
            {
                Parallel.ForEach(chunkIds, new ParallelOptions { MaxDegreeOfParallelism = Settings.Settings.Current.ParallelChunks }, cId =>
                  {
                      var chunkId = cId;

                      var attempt = 0;
                      var complete = false;
                      while (!complete)
                      {
                          attempt++;
                          try
                          {
                              MoveChunkRawData(chunkId, baseFolder);
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

                      _dbChunk.ChunkCreated(chunkId, Settings.Settings.Current.Building.Id.Value);
                      Console.WriteLine("[Moving raw data] Raw data for chunkId=" + chunkId + " is available on S3");

                      if (triggerLambdas)
                      {
                          var tasks = utility.TriggerBuildFunction(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.Id.Value, chunkId, false);
                          Task.WaitAll([.. tasks]);
                          Console.WriteLine($"[Moving raw data] Lambda functions for cuhnkId={chunkId} were triggered | {tasks.Count} functions");
                      }

                      if (useMonitor)
                      {
                          monitor.TryAddChunk(chunkId, _chunksSchema);

                          monitorHandle ??= monitor.Handle();
                      }

                      var unprocessed = 0;
                      do
                      {
                          using (var client = new AmazonS3Client(Settings.Settings.Current.MessageS3AwsAccessKeyId, Settings.Settings.Current.MessageS3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                          {
                              var bucket = LambdaUtility.GetBucket(Settings.Settings.Current.MessageBucket);
                              var prefix = LambdaUtility.GetPrefix(Settings.Settings.Current.MessageBucket,
                                  $"{Settings.Settings.Current.Building.Vendor}.{Settings.Settings.Current.Building.Id.Value}.");

                              var request = new ListObjectsV2Request
                              {
                                  BucketName = bucket,
                                  Prefix = prefix
                              };

                              Task<ListObjectsV2Response> task;
                              task = client.ListObjectsV2Async(request);
                              task.Wait();

                              unprocessed = task.Result.S3Objects.Count;
                          }

                          Console.WriteLine($"[Moving raw data] Unprocessed lambda functions={unprocessed}");

                          if (unprocessed > 700)
                          {
                              Console.WriteLine($"[Moving raw data] unprocessed > 700, waiting 3 minutes...");
                              Thread.Sleep(TimeSpan.FromMinutes(3));
                          }
                      }
                      while (unprocessed > 700);
                  });

                monitor.CompleteAdding();
                if (useMonitor)
                {
                    monitorHandle?.Wait();
                }

                monitorHandle?.Dispose();

                if (useMonitor && monitor.InvalidCount > 0)
                    throw new Exception($"ERROR - {monitor.InvalidCount} - Invalid chunks");
            }

            Console.WriteLine("Moving raw data to S3 - complete");
        }

        private void MoveChunkRawData(int chunkId, string baseFolder)
        {
            Parallel.ForEach(Settings.Settings.Current.Building.SourceQueryDefinitions,
                new ParallelOptions { MaxDegreeOfParallelism = Settings.Settings.Current.ParallelQueries }, queryDefinition =>
                {

                    if (queryDefinition.Providers != null) return;
                    if (queryDefinition.Locations != null) return;
                    if (queryDefinition.CareSites != null) return;

                    var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                        queryDefinition.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName,
                            _chunksSchema, Settings.Settings.Current.Building.Param1), Settings.Settings.Current.Building.SourceSchemaName);

                    if (string.IsNullOrEmpty(sql)) return;

                    sql = string.Format(sql, chunkId);

                    var personIdField = queryDefinition.GetPersonIdFieldName();
                    var tmpTableName = "#" + queryDefinition.FileName + "_" + chunkId;


                    var folder = $"{baseFolder}/{chunkId}/{queryDefinition.FileName}";
                    var fileName = $@"{folder}/{queryDefinition.FileName}";

                    var unloadQuery = string.Format(@"create table {0} sortkey ({1}) distkey ({1}) as {2}; " +
                                                    @"UNLOAD ('select * from {0} order by {1}') to 's3://{3}' " +
                                                    @"DELIMITER AS '\t' " +
                                                    @"NULL AS '\\N' " +
                                                    @"credentials 'aws_access_key_id={4};aws_secret_access_key={5}' " +
                                                    @"ZSTD ALLOWOVERWRITE PARALLEL ON",
                        tmpTableName, //0
                        personIdField, //1
                        sql, //2
                        fileName, //3
                        Settings.Settings.Current.S3AwsAccessKeyId, //4
                        Settings.Settings.Current.S3AwsSecretAccessKey); //5

                    using var connection =
                        SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building
                            .SourceConnectionString);
                    using var c = new OdbcCommand(unloadQuery, connection);
                    c.CommandTimeout = 900;
                    c.ExecuteNonQuery();
                });
        }

        private static void StoreMetadataToS3(QueryDefinition queryDefinition, string query)
        {
            Console.WriteLine("[Moving raw data] StoreMetadataToS3 start - " + queryDefinition.FileName);
            var sql = query + " limit 1";
            var metadataKey =
                $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw/metadata/{queryDefinition.FileName + ".txt"}";

            using (var conn =
                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString))
            using (var c = Settings.Settings.Current.Building.SourceEngine.GetCommand(sql, conn))
            using (var reader = c.ExecuteReader(CommandBehavior.SchemaOnly))
            {
                using var source = new MemoryStream();
                using StreamWriter writer = new(source, new UTF8Encoding(false, true));
                using var csv = new CsvWriter(writer, new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    HasHeaderRecord = false,
                    Delimiter = ",",
                    Encoding = Encoding.UTF8
                });
                for (var i = 0; i < reader.FieldCount; i++)
                {
                    var fieldName = reader.GetName(i);
                    if (Settings.Settings.Current.Building.PersonFileName == queryDefinition.FileName &&
                        Settings.Settings.Current.Building.PersonIdFieldName == fieldName)
                    {
                        Settings.Settings.Current.Building.PersonIdFieldIndex = i;
                    }

                    csv.WriteField(fieldName);
                }

                csv.NextRecord();
                writer.Flush();

                using var client = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId,
                    Settings.Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                using var directoryTransferUtility = new TransferUtility(client);
                directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                {
                    BucketName = Settings.Settings.Current.Bucket,
                    Key = metadataKey,
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                    StorageClass = S3StorageClass.Standard,
                    InputStream = source
                });
            }
            Console.WriteLine("[Moving raw data] StoreMetadataToS3 end - " + queryDefinition.FileName);
        }

        public IEnumerable<List<KeyValuePair<string, string>>> GetPersonKeys(int batchSize)
        {
            return GetPersonKeys(Settings.Settings.Current.Building.Batches, batchSize);
        }

        public bool AllChunksStarted()
        {
            return _dbChunk.AllChunksStarted(Settings.Settings.Current.Building.Id.Value);
        }

        public bool AllChunksComplete()
        {
            return _dbChunk.AllChunksComplete(Settings.Settings.Current.Building.Id.Value);
        }

        public int GetChunksCount()
        {
            return _dbChunk.GetChunksCount(Settings.Settings.Current.Building.Id.Value);
        }

        public int GetCompleteChunksCount()
        {
            return _dbChunk.GetCompleteChunksCount(Settings.Settings.Current.Building.Id.Value);
        }

        public IEnumerable<List<KeyValuePair<string, string>>> GetPersonKeys(long batches, int batchSize)
        {
            var batch = new List<KeyValuePair<string, string>>(batchSize);

            Console.WriteLine("SourceEngine.Database: " + Settings.Settings.Current.Building.SourceEngine.Database);
            Console.WriteLine("BatchScript: " + Settings.Settings.Current.Building.BatchScript);
            Console.WriteLine("SourceSchemaName: " + Settings.Settings.Current.Building.SourceSchemaName);

            var query = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                Settings.Settings.Current.Building.BatchScript, Settings.Settings.Current.Building.SourceSchemaName);

            foreach (var reader in _dbSource.GetPersonKeys(query, batches, batchSize, Settings.Settings.Current.Building.Param1))
            {
                if (batch.Count == batchSize)
                {
                    yield return batch;
                    batch.Clear();
                }

                var id = reader[0].ToString().Trim();
                var source = reader[1].ToString().Trim();

                batch.Add(new KeyValuePair<string, string>(id, source));
            }

            yield return batch;
        }

        public void ResetNotFinishedChunks()
        {
            _dbChunk.ResetNotFinishedChunks(Settings.Settings.Current.Building.Id.Value);
        }

        public void ResetChunks()
        {
            _dbChunk.ResetChunks(Settings.Settings.Current.Building.Id.Value);
        }
    }
}