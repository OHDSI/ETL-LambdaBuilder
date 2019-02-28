using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class RedshiftSaver : Saver
    {
        private AmazonS3Client _currentClient;
        private string _connectionString;

        public override ISaver Create(string connectionString)
        {
            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20,
            };

            _currentClient = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId,
                Settings.Settings.Current.S3AwsSecretAccessKey,
                config);

            _connectionString = connectionString;

            return this;
        }

        public override void Write(ChunkData chunk, string table)
        {
            var attempt = 0;
            var copied = false;
            while (!copied)
            {
                try
                {
                    attempt++;
                    Write(chunk.ChunkId, chunk.SubChunkId, CreateDataReader(chunk, table), table);
                    copied = true;
                }
                catch (Exception e)
                {
                    if (attempt <= 5)
                    {
                        Logger.Write(chunk.ChunkId, LogMessageTypes.Warning,
                            "MoveToS3 attempt=" + attempt + ") | " + table + " | " + Logger.CreateExceptionString(e));
                    }
                    else
                    {
                        throw;
                    }
                }
            }
        }

        public override void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName)
        {
            if (Settings.Settings.Current.SaveOnlyToS3 && !chunkId.HasValue && !tableName.ToLower().StartsWith("_chunks"))
            {
                var b =
                    $"{Settings.Settings.Current.Bucket}/{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/{Settings.Settings.Current.CDMFolder}";

                if (Settings.Settings.Current.StorageType == S3StorageType.Parquet)
                    SaveToS3Snappy(b, tableName, reader);
                else
                    SaveToS3CSV(_currentClient, b, null, subChunkId, reader, tableName);
                return;
            }

            var bucket =
                $"{Settings.Settings.Current.Bucket}/{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}";

            if (!tableName.ToLower().StartsWith("_chunks"))
            {
                bucket = bucket + "/" + Settings.Settings.Current.Building.DestinationSchemaName;
            }

            if (chunkId.HasValue)
            {
                bucket = bucket + "/" + "chunks";
            }

            var fileName = SaveToS3CSV(_currentClient, bucket, chunkId, subChunkId, reader, tableName);
            var schemaName = Settings.Settings.Current.Building.DestinationSchemaName;

            if (tableName.ToLower().StartsWith("_chunks"))
            {
                schemaName = Settings.Settings.Current.Building.SourceSchemaName;
                tableName = "_chunks";
            }

            using (var currentConnection = SqlConnectionHelper.OpenOdbcConnection(_connectionString))
            using (var currentTransaction = currentConnection.BeginTransaction())
            {
                CopyToRedshift(bucket, schemaName, tableName, fileName, currentConnection, currentTransaction);
                currentTransaction.Commit();
            }
        }

        private static void CopyToRedshift(string bucket, string schemaName, string tableName, string fileName,
            OdbcConnection connection, OdbcTransaction transaction)
        {
            const string query = @"copy {0}.{1} from 's3://{2}/{3}' " +
                                 @"credentials 'aws_access_key_id={4};aws_secret_access_key={5}' " +
                                 @"IGNOREBLANKLINES " +
                                 @"DELIMITER '\t' " +
                                 @"NULL AS '\000' " +
                                 @"csv quote as '`' " +
                                 @"GZIP";

            using (
                var c =
                    new OdbcCommand(
                        string.Format(query, schemaName, tableName, bucket, fileName,
                            Settings.Settings.Current.S3AwsAccessKeyId,
                            Settings.Settings.Current.S3AwsSecretAccessKey), connection, transaction))
            {
                c.CommandTimeout = 999999999;
                c.ExecuteNonQuery();
            }
        }

        private static string SaveToS3CSV(AmazonS3Client s3Client, string bucket, int? chunkId, int? subChunkId,
            IDataReader reader,
            string tableName)
        {
            var folder = tableName;
            string fileName;
            if (chunkId.HasValue)
            {
                fileName = $@"{chunkId}/{tableName + ".txt.gz." + chunkId + "." + subChunkId}";
            }
            else
                fileName = $@"{folder + ".txt.gz"}";

            AmazonS3Helper.CopyFile(s3Client, bucket, fileName, reader);

            return fileName;
        }

        private void SaveToS3Snappy(string bucket, string tableName, IDataReader reader)
        {
            Console.WriteLine($"{tableName} - Save to S3 started (.snappy)");
            int index = 0;
            foreach (var stream in reader.GetStreamSnappy(50000))
            {
                tableName = tableName.ToUpper();
                var fileName = $"{tableName}/{tableName}.{index}.snappy";
                var putObject = _currentClient.PutObjectAsync(new PutObjectRequest
                {
                    BucketName = bucket,
                    Key = fileName,
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                    StorageClass = S3StorageClass.Standard,
                    InputStream = stream
                });
                putObject.Wait();
                stream.Dispose();
                index++;
            }
        }

        public override void AddChunk(List<ChunkRecord> chunk, int index)
        {
            try
            {
                Write(null, null, new ChunkDataReader(chunk), "_chunks" + index);
            }
            catch (Exception e)
            {
                Logger.WriteError(e);
                Rollback();
            }
        }

        public override void CopyVocabulary()
        {
            // Move data to S3 and then copy to Redshift
            var vocabQueriesPath = Path.Combine(Settings.Settings.Current.Builder.Folder, "Common", "Redshift", "v5.2",
                "Vocabulary");
            Parallel.ForEach(Directory.GetFiles(vocabQueriesPath), filePath =>
            {
                var tableName = Path.GetFileNameWithoutExtension(filePath);

                using (var connection =
                    SqlConnectionHelper.OpenOdbcConnection(
                        Settings.Settings.Current.Building.VocabularyConnectionString))
                {
                    var schemaName = Settings.Settings.Current.Building.VocabularySchemaName;
                    var query = File.ReadAllText(filePath);
                    query = query.Replace("{sc}", schemaName);

                    using (var c = new OdbcCommand(query, connection))
                    {
                        c.CommandTimeout = 0;
                        using (var reader = c.ExecuteReader())
                        {
                            Write(null, null, reader, tableName);
                        }
                    }
                }
            });
        }

       
        public override void Commit()
        {
        }

        public override void Rollback()
        {
        }

        public override void Dispose()
        {
            _currentClient.Dispose();
        }
    }
}