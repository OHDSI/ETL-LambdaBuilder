using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Base;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Savers;
using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop.Databases
{
    public class RedshiftDatabaseEngine : DatabaseEngine
    {
        public RedshiftDatabaseEngine()
        {
            Database = Database.Redshift;
        }

        public override IEnumerable<string> GetAllTables()
        {
            const string query = "select distinct(tablename) from pg_table_def where schemaname = 'public'";

            using var conn = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString);
            using var c = new OdbcCommand(query, conn);
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public override IEnumerable<string> GetAllColumns(string tableName)
        {
            var query = $@"select ""column"" from pg_table_def where tablename = '{tableName}'";

            using var conn = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString);
            using var c = new OdbcCommand(query, conn);
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public override ISaver GetSaver()
        {
            return new RedshiftSaver();
        }

        public override IDbCommand GetCommand(string cmdText, IDbConnection connection)
        {
            return new OdbcCommand(cmdText, (OdbcConnection)connection);
        }

        public override IDataReader ReadChunkData(IDbConnection conn, IDbCommand cmd, QueryDefinition qd, int chunkId, string prefix)
        {
            var folder = $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw";

            return new S3DataReader(Settings.Settings.Current.CloudStorageName, folder, Settings.Settings.Current.CloudStorageKey,
               Settings.Settings.Current.CloudStorageSecret, chunkId, qd.FileName, qd.FieldHeaders, prefix);
        }

        public override IChunkBuilder GetChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder)
        {
            return new RedshiftChunkBuilder(chunkId, createPersonBuilder);
        }
    }
}