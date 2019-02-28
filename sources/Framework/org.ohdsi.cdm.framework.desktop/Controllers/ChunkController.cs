using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Transfer;
using CsvHelper;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;

namespace org.ohdsi.cdm.framework.desktop.Controllers
{
    public class ChunkController
    {
        private readonly DbChunk _dbChunk;
        private readonly DbSource _dbSource;

        public ChunkController()
        {
            _dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
            _dbSource = new DbSource(Settings.Settings.Current.Building.SourceConnectionString, Path.Combine(new[]
            {
                Settings.Settings.Current.Builder.Folder,
                "Common",
                Settings.Settings.Current.Building.SourceEngine.Database.ToString()
            }), Settings.Settings.Current.Building.SourceSchemaName);
        }


        public void ClenupChunks()
        {
            _dbSource.DropChunkTable();
        }

        public void CreateChunks(bool restart)
        {
            if (restart && Settings.Settings.Current.Building.SourceEngine.Database != Database.Redshift)
                restart = false;

            Console.WriteLine("Source connection string=" + Settings.Settings.Current.Building.SourceConnectionString);

            if (!restart)
            {
                Console.WriteLine("Generating ids...");
                _dbChunk.ClearChunks(Settings.Settings.Current.Building.Id.Value);
                _dbSource.CreateChunkTable();

                if (Settings.Settings.Current.Building.SourceEngine.Database == Database.Redshift)
                {
                    try
                    {
                        _dbSource.GrantAccessToChunkTable();
                    }
                    catch (Exception e)
                    {
                        Logger.Write(null, LogMessageTypes.Warning,
                            "GrantAccessToChunkTable " + Logger.CreateExceptionString(e));
                    }
                }

                var chunkId = 0;
                //int i = 0;
                int k = 0;

                //var chunkSizeOnS3 = 0;
                //if (Settings.Settings.Current.Building.BatchSize >= 10000 && Settings.Settings.Current.Building.BatchSize < 500000)
                //    chunkSizeOnS3 = 50;
                //else if (Settings.Settings.Current.Building.BatchSize >= 500000 && Settings.Settings.Current.Building.BatchSize < 2000000)
                //    chunkSizeOnS3 = 5;
                //else if (Settings.Settings.Current.Building.BatchSize >= 2000000)
                //    chunkSizeOnS3 = 1;

                using (var saver = Settings.Settings.Current.Building.SourceEngine.GetSaver().Create(Settings.Settings.Current.Building.SourceConnectionString))
                {
                    var chunks = new List<ChunkRecord>();
                    foreach (var chunk in GetPersonKeys(Settings.Settings.Current.Building.BatchSize))
                    {
                        _dbChunk.AddChunk(chunkId, Settings.Settings.Current.Building.Id.Value);
                        
                        chunks.AddRange(chunk.Select(c => new ChunkRecord { Id = chunkId, PersonId = Convert.ToInt64(c.Key), PersonSource = c.Value }));

                        if (Settings.Settings.Current.Building.SourceEngine.Database == Database.Redshift)
                        //if (Settings.Settings.Current.Building.SourceEngine.Database == Database.Redshift &&
                        //    Settings.Settings.Current.Building.BatchSize >= 10000 && i == chunkSizeOnS3)
                        {
                            saver.AddChunk(chunks, k);
                            chunks.Clear();
                            GC.Collect();
                            //i = 0;
                            k++;
                        }
                        //i++;
                        chunkId++;
                    }
                    if (chunks.Count > 0)
                    {
                        saver.AddChunk(chunks, k);
                    }

                    saver.Commit();
                }
                Console.WriteLine("chunk ids were generated and saved, total count=" + chunkId);
            }

            if (Settings.Settings.Current.Building.SourceEngine.Database == Database.Redshift)
            {
                Console.WriteLine("Moving raw data to S3...");
                MoveChunkDataToS3();
                Console.WriteLine("Moving data - complete");
            }
        }

        private void MoveChunkDataToS3()
        {
            var chunkIds = _dbChunk.GetNotMovedToS3Chunks(Settings.Settings.Current.Building.Id.Value).ToArray();

            if(chunkIds.Length == 0)
                return;

            var baseFolder =
                $"{Settings.Settings.Current.Bucket}/{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw";
            Console.WriteLine("S3 raw folder - " + baseFolder);

            Parallel.ForEach(Settings.Settings.Current.Building.SourceQueryDefinitions, queryDefinition =>
            {
                if (queryDefinition.Providers != null) return;
                if (queryDefinition.Locations != null) return;
                if (queryDefinition.CareSites != null) return;

                var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                    queryDefinition.GetSql(Settings.Settings.Current.Building.Vendor,
                        Settings.Settings.Current.Building.SourceSchemaName),
                    Settings.Settings.Current.Building.SourceSchemaName);

                if (string.IsNullOrEmpty(sql)) return;

                sql = string.Format(sql, chunkIds[0]);

                if (queryDefinition.FieldHeaders == null)
                {
                    StoreMetadataToS3(queryDefinition, sql);
                }
            });

            Parallel.ForEach(chunkIds, new ParallelOptions {MaxDegreeOfParallelism = 2}, cId =>
            {
                var chunkId = cId;

                Parallel.ForEach(Settings.Settings.Current.Building.SourceQueryDefinitions,
                    new ParallelOptions {MaxDegreeOfParallelism = 5}, queryDefinition =>
                    {
                        try
                        {
                            if (queryDefinition.Providers != null) return;
                            if (queryDefinition.Locations != null) return;
                            if (queryDefinition.CareSites != null) return;

                            var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                                queryDefinition.GetSql(Settings.Settings.Current.Building.Vendor,
                                    Settings.Settings.Current.Building.SourceSchemaName),
                                Settings.Settings.Current.Building.SourceSchemaName);

                            if (string.IsNullOrEmpty(sql)) return;

                            sql = string.Format(sql, chunkId);

                            //if (queryDefinition.FieldHeaders == null)
                            //{
                            //    StoreMetadataToS3(queryDefinition, sql);
                            //}

                            var personIdField = queryDefinition.GetPersonIdFieldName();
                            var tmpTableName = "#" + queryDefinition.FileName + "_" + chunkId;


                            var folder = $"{baseFolder}/{chunkId}/{queryDefinition.FileName}";
                            var fileName = $@"{folder}/{queryDefinition.FileName}";

                            var unloadQuery = string.Format(@"create table {0} sortkey ({1}) distkey ({1}) as {2}; " +
                                                            @"UNLOAD ('select * from {0} order by {1}') to 's3://{3}' " +
                                                            @"DELIMITER AS '\t' " +
                                                            @"credentials 'aws_access_key_id={4};aws_secret_access_key={5}' " +
                                                            @"GZIP ALLOWOVERWRITE PARALLEL ON",
                                tmpTableName, //0
                                personIdField, //1
                                sql, //2
                                fileName, //3
                                Settings.Settings.Current.S3AwsAccessKeyId, //4
                                Settings.Settings.Current.S3AwsSecretAccessKey); //5

                            using (var connection =
                                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building
                                    .SourceConnectionString))
                            using (var c = new OdbcCommand(unloadQuery, connection))
                            {
                                c.CommandTimeout = 999999999;
                                c.ExecuteNonQuery();
                            }
                        }
                        catch (Exception e)
                        {
                            Logger.WriteError(chunkId, e);
                            throw;
                        }
                    });

                _dbChunk.ChunkCreated(chunkId, Settings.Settings.Current.Building.Id.Value);
                Console.WriteLine("Raw data for chunkId=" + chunkId + " is available on S3");
            });

        }

        private static void StoreMetadataToS3(QueryDefinition queryDefinition, string query)
        {
            Console.WriteLine("StoreMetadataToS3 start - " + queryDefinition.FileName);
            var sql = query + " limit 1";
            var metadataKey =
                $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw/metadata/{queryDefinition.FileName + ".txt"}";

            using (var conn =
                SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString))
            using (var c = Settings.Settings.Current.Building.SourceEngine.GetCommand(sql, conn))
            using (var reader = c.ExecuteReader(CommandBehavior.SchemaOnly))
            {
                using (var source = new MemoryStream())
                using (TextWriter writer = new StreamWriter(source, new UTF8Encoding(false, true)))
                using (var csv = new CsvWriter(writer, new CsvHelper.Configuration.Configuration
                {
                    HasHeaderRecord = false,
                    Delimiter = ",",
                    Encoding = Encoding.UTF8
                }))
                {
                    for (var i = 0; i < reader.FieldCount; i++)
                    {
                        csv.WriteField(reader.GetName(i));
                    }

                    csv.NextRecord();
                    writer.Flush();

                    using (var client = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId,
                        Settings.Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                    using (var directoryTransferUtility = new TransferUtility(client))
                    {
                        directoryTransferUtility.Upload(new TransferUtilityUploadRequest
                        {
                            BucketName = Settings.Settings.Current.Bucket,
                            Key = metadataKey,
                            ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                            StorageClass = S3StorageClass.Standard,
                            InputStream = source
                        });
                    }
                }
            }
            Console.WriteLine("StoreMetadataToS3 end - " + queryDefinition.FileName);
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

            var query = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                Settings.Settings.Current.Building.BatchScript, Settings.Settings.Current.Building.SourceSchemaName);

            foreach (var reader in _dbSource.GetPersonKeys(query, batches, batchSize))
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
