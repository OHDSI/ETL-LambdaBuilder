using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Savers;
using System.Data;
using System.Data.Odbc;
using System.Data.SqlClient;

namespace org.ohdsi.cdm.framework.desktop.Databases
{
    public class MssqlDatabaseEngine : DatabaseEngine
    {
        public MssqlDatabaseEngine()
        {
            Database = Database.MsSql;
        }

        public override IEnumerable<string> GetAllTables()
        {
            const string query = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";

            using var conn = (SqlConnection)SqlConnectionHelper.OpenMssqlConnection(Settings.Settings.Current.Building.SourceConnectionString);
            using var c = new SqlCommand(query, conn);
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public override IEnumerable<string> GetAllColumns(string tableName)
        {
            var query = $"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{tableName}'";

            using var conn = (SqlConnection)SqlConnectionHelper.OpenMssqlConnection(Settings.Settings.Current.Building.SourceConnectionString);
            using var c = new SqlCommand(query, conn);
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public override ISaver GetSaver()
        {
            return new MsSqlSaver();
        }

        public override IDbCommand GetCommand(string cmdText, IDbConnection connection)
        {
            var c = new OdbcCommand(cmdText, (OdbcConnection)connection);

            return c;
        }

        public override IDataReader ReadChunkData(IDbConnection conn, IDbCommand cmd, QueryDefinition qd, int chunkId, string prefix)
        {
            return cmd.ExecuteReader();
        }
    }
}