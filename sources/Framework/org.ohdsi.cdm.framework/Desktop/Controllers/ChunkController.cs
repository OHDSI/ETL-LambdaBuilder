using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data.Odbc;
using System.Text.RegularExpressions;

namespace org.ohdsi.cdm.framework.desktop.Controllers
{
    public class ChunkController
    {
        private readonly DbChunk _dbChunk;
        private readonly DbSource _dbSource;
        private readonly string _chunksSchema;

        public ChunkController(string chunksSchema)
        {
            _dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
            _dbSource = new DbSource(
                Settings.Settings.Current.Building.SourceConnectionString, 
                Settings.Settings.Current.Building.SourceEngine.Database.ToString(), 
                Settings.Settings.Current.Building.SourceSchemaName);

            _chunksSchema = chunksSchema;
        }


        public void CleanupChunks()
        {
            _dbSource.DropChunkTable(_chunksSchema);
        }

        public void CreateChunks(int partitionSize)
        {
            Console.WriteLine("Generating chunk ids...");
            _dbChunk.ClearChunks(Settings.Settings.Current.Building.Id.Value);
            _dbSource.CreateChunkTable(_chunksSchema);

            var chunkId = 0;
            var cnt = 0;
            var partitionId = 0;
            var index = 0;

            var chunksConnectionString = Regex.Replace(Settings.Settings.Current.Building.RawSourceConnectionString, "sc=" + _chunksSchema + ";", "", RegexOptions.IgnoreCase);
            using (var saver = Settings.Settings.Current.Building.SourceEngine.GetSaver()
                .Create(chunksConnectionString))
            {
                var chunks = new List<ChunkRecord>();
                foreach (var chunk in GetPersonKeys(Settings.Settings.Current.Building.BatchSize))
                {
                    _dbChunk.AddChunk(chunkId, Settings.Settings.Current.Building.Id.Value);
                    foreach (var item in chunk)
                    {
                        if (cnt == partitionSize)
                        {
                            cnt = 0;
                            partitionId++;
                        }

                        chunks.Add(new ChunkRecord
                        {
                            Id = chunkId,
                            PersonId = item.Key,
                            PartitionId = partitionId,
                            PersonSource = item.Value
                        });
                        cnt++;
                    }

                    saver.AddChunk(chunks, index, _chunksSchema);
                    chunks.Clear();

                    chunkId++;
                    index++;
                }

                if (chunks.Count > 0)
                {
                    saver.AddChunk(chunks, index, _chunksSchema);
                }

                saver.Commit();
            }

            CopyIntoFromCloudStorage(chunksConnectionString);

            Console.WriteLine("***** Chunk ids were generated and saved, total count=" + chunkId + " *****");
        }


        private void CopyIntoFromCloudStorage(string connectionString)
        {
            string query;
            if (Settings.Settings.Current.Building.SourceEngine.Database == Enums.Database.Databricks)
            {
                var storage = Settings.Settings.Current.CloudStorageUri.Split("//")[1].Replace(".blob.", ".dfs.");
                query = $@"COPY INTO {_chunksSchema}._chunks BY POSITION " +
                    $@"FROM 'abfss://{Settings.Settings.Current.CloudStorageName}@{storage}/{Settings.Settings.Current.BuildingPrefix}' " +
                    @"FILEFORMAT = CSV " +
                    @"PATTERN = 'chunks*.txt.gz' " +
                    @"FORMAT_OPTIONS( " +
                    @"'recursiveFileLookup' = 'true', " +
                    @"'header' = 'false', " +
                    @"'delimiter' = '\t', " +
                    @"'quote' = '`', " +
                    @"'nullValue' = '\\0', " +
                    @"'unescapedQuoteHandling' = 'RAISE_ERROR', " +
                    @"'mode' = 'FAILFAST', " +
                    @"'multiLine' = 'true', " +
                    @"'compression' = 'gzip');";
            }
            else if (Settings.Settings.Current.Building.SourceEngine.Database == Enums.Database.Redshift)
            {
                query = $@"copy {_chunksSchema}._chunks from 's3://{Settings.Settings.Current.CloudStorageName}/_chunks' " +
                    $@"credentials 'aws_access_key_id={Settings.Settings.Current.CloudStorageKey};aws_secret_access_key={Settings.Settings.Current.CloudStorageSecret}' " +
                    @"IGNOREBLANKLINES " +
                    @"DELIMITER '\t' " +
                    @"NULL AS '\000' " +
                    @"csv quote as '`' " +
                    @"GZIP";
            }
            else
            {
                return;
            }

            using var connection = SqlConnectionHelper.OpenOdbcConnection(connectionString);
            using var c = new OdbcCommand(query, connection);
            c.CommandTimeout = 900;
            c.ExecuteNonQuery();
        }

        public IEnumerable<List<KeyValuePair<long, string>>> GetPersonKeys(int batchSize)
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

        public IEnumerable<List<KeyValuePair<long, string>>> GetPersonKeys(long batches, int batchSize)
        {
            var batch = new List<KeyValuePair<long, string>>(batchSize);

            Console.WriteLine("SourceEngine.Database: " + Settings.Settings.Current.Building.SourceEngine.Database);
            Console.WriteLine("BatchScript: " + Settings.Settings.Current.Building.BatchScript);
            Console.WriteLine("SourceSchemaName: " + Settings.Settings.Current.Building.SourceSchemaName);

            var query = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                Settings.Settings.Current.Building.BatchScript, Settings.Settings.Current.Building.SourceSchemaName);

            foreach (var reader in _dbSource.GetPersonKeys(query, batches, batchSize))
            {
                if (batch.Count == batchSize)
                {
                    yield return batch;
                    batch.Clear();
                }

                var id = reader.GetInt64(0);
                var source = reader[1].ToString().Trim();

                batch.Add(new KeyValuePair<long, string>(id, source));
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