using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;

namespace org.ohdsi.cdm.presentation.etl.ETLController
{
    public class RedshiftETLController : IETLController
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

            var tableName = "#" + qd.FileName + "_" + chunkId;

            var unloadQuery =
            $"create table {tableName} sortkey ({personIdField}) distkey ({personIdField}) as {sql}; " +
            $@"UNLOAD ('select * from {tableName} order by {personIdField}') to 's3://{Settings.Current.CloudStorageName}/{folder}{qd.FileName}' " +
            $@"DELIMITER AS '\t' " +
            $@"NULL AS '\\N' " +
            $@"credentials 'aws_access_key_id={Settings.Current.CloudStorageKey};aws_secret_access_key={Settings.Current.CloudStorageSecret}' " +
            $@"ZSTD ALLOWOVERWRITE PARALLEL ON";

            using var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString);

            using var create = new OdbcCommand(unloadQuery, connection);
            create.CommandTimeout = 60 * 60;
            create.ExecuteNonQuery();
        }

        public int GetNumberOfPartitions(string chunksSchema, int chunkId)
        {
            return CloudStorageHelper.GetSlices(chunkId).Max();
        }

        public IEnumerable<string> GetTriggerMessages(string chunksSchema, int chunkId)
        {
            var numberOfPartitions = GetNumberOfPartitions(chunksSchema, chunkId);

            for (int i = 0; i <= numberOfPartitions; i++)
            {
                var slice = i.ToString("D4");

                yield return $"{Settings.Current.GetCDMBuildingPrefix}.{chunkId}.{slice}.txt";
            }
        }

        public void StoreMetadataToCloudStorage(QueryDefinition queryDefinition, string query)
        {
            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage start - " + queryDefinition.FileName);
            var fileName = $"{Settings.Current.BuildingPrefix}/raw/metadata/{queryDefinition.FileName + ".txt"}";
            
            using (var conn = SqlConnectionHelper.OpenOdbcConnection(Settings.Current.Building.SourceConnectionString))
            using (var c = Settings.Current.Building.SourceEngine.GetCommand(query, conn))
            {
                c.CommandTimeout = 3600;
                using var reader = c.ExecuteReader(CommandBehavior.SchemaOnly);
                CloudStorageHelper.UploadFile(fileName, reader, false, true);
            }

            Console.WriteLine("[Moving raw data] StoreMetadataToCloudStorage end - " + queryDefinition.FileName);
        }
    }
}
