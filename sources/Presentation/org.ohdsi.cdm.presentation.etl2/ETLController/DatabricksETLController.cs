using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.IO;
using System.Text;

namespace org.ohdsi.cdm.presentation.etl.ETLController
{
    internal class DatabricksETLController : IETLController
    {

        public void UnloadNative(string chunksSchema, int chunkId, string sourceSchema, QueryDefinition qd)
        {
            var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
                               qd.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName,
                                   chunksSchema), Settings.Current.Building.SourceSchemaName);

            if (string.IsNullOrEmpty(sql))
                return;

            sql = string.Format(sql, chunkId);
            var personIdField = qd.GetPersonIdFieldName();
            var folder = $"{Settings.Current.BuildingPrefix}/raw/{chunkId}/{qd.FileName}/";

            var tableName = $"{chunksSchema}.{sourceSchema.Split('.')[1]}_{qd.FileName}_{chunkId}";

            var unloadQuery =
                //$@"CREATE OR REPLACE TABLE {tableName} " +
                $@"CREATE TABLE {tableName} " +
                $@"USING csv " +
                $@"PARTITIONED BY(PartitionId) " +
                $@"LOCATION '{Settings.Current.GetDatabricksStorage}/{folder}' " +
                $@"OPTIONS(delimiter = '\t', nullValue = '\\N',  compression = 'gzip') " +
                $@"AS({sql});";

            using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);
            try
            {
                using var create = new OdbcCommand(unloadQuery, connection);
                create.CommandTimeout = 60 * 60;
                create.ExecuteNonQuery();
            }
            catch (Exception e)
            {

                Console.WriteLine($"[MoveTableDataToCloudStorage] {e.Message}");
                try
                {
                    DropTable(tableName, connection);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"drop table {tableName} | {e.Message}");
                }

                using var create = new OdbcCommand(unloadQuery, connection);
                create.CommandTimeout = 60 * 60;
                create.ExecuteNonQuery();
            }

            DropTable(tableName, connection);
        }

        public int GetNumberOfPartitions(string chunksSchema, int chunkId)
        {
            using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);
            using var c = new OdbcCommand($"select max(PartitionId) from {chunksSchema}._chunks where chunkid={chunkId};", connection);
            c.CommandTimeout = 900;
            return Convert.ToInt32(c.ExecuteScalar());
        }

        public IEnumerable<string> GetTriggerMessages(string chunksSchema, int chunkId)
        {
            var numberOfPartitions = GetNumberOfPartitions(chunksSchema, chunkId);

            for (int i = 0; i <= numberOfPartitions; i++)
            {
                var slice = $"PartitionId={i}";
                yield return $"{Settings.Current.GetCDMBuildingPrefix}.{chunkId}.{slice}.txt";
            }
        }

        public void StoreMetadataToCloudStorage(QueryDefinition queryDefinition, string query)
        {
            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage start - " + queryDefinition.FileName);
            var fileName = $"{Settings.Current.BuildingPrefix}/raw/metadata/{queryDefinition.FileName + ".txt"}";

            string describeQuery = $"DESCRIBE QUERY {query}";

            using (var conn = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString))
            using (var c = Settings.Current.Building.SourceEngine.GetCommand(describeQuery, conn))
            {
                c.CommandTimeout = 600;
                using var reader = c.ExecuteReader();
                using var source = new MemoryStream();
                using StreamWriter writer = new(source, new UTF8Encoding(false, true));
                using var csv = framework.common.Helpers.CsvHelper.CreateCsvWriter(writer);
                while (reader.Read())
                {
                    var fieldName = reader.GetValue(0);
                    csv.WriteField(fieldName);
                }

                csv.NextRecord();
                writer.Flush();

                var credential = new ClientSecretCredential(Settings.Current.CloudStorageHolder, Settings.Current.CloudStorageKey, Settings.Current.CloudStorageSecret);
                var client = new BlobServiceClient(new Uri(Settings.Current.CloudStorageUri), credential, null);
                var azureClient = client.GetBlobContainerClient(Settings.Current.CloudStorageName);

                source.Position = 0;

                azureClient.GetBlobClient(fileName).Upload(source, overwrite: true);
            }

            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage end - " + queryDefinition.FileName);
        }

        private static void DropTable(string tableName, OdbcConnection connection)
        {
            var drop = new OdbcCommand($"drop table {tableName}", connection);
            drop.ExecuteNonQuery();
        }
    }
}
