using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;
using System.Data.Odbc;
using System.Data.SqlClient;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbBuildingSettings(string connectionString)
    {
        private readonly string _connectionString = connectionString;

        public int? GetBuildingId(string sourceConnectionString, string vocabularyConnectionString, Vendor vendor)
        {
            const string query = "SELECT [BuildingId] FROM [BuildingSettings] where [SourceConnectionString] = '{0}' and [VocabularyConnectionString] = '{1}' and [Vendor] = '{2}' ORDER BY [BuildingId] desc ";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, sourceConnectionString, vocabularyConnectionString, vendor), connection);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                return reader.GetInt("BuildingId");
            }

            return null;
        }

        public int? GetBuildingId(string sourceConnectionString, string destinationConnectionString, string vocabularyConnectionString, Vendor vendor)
        {
            const string query = "SELECT [BuildingId] FROM [BuildingSettings] where [SourceConnectionString] = '{0}' and [DestinationConnectionString] = '{1}' and [VocabularyConnectionString] = '{2}' and [Vendor] = '{3}'";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, sourceConnectionString, destinationConnectionString, vocabularyConnectionString, vendor), connection);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                return reader.GetInt("BuildingId");
            }

            return null;
        }

        public int Create(string sourceConnectionString, string destinationConnectionString, string vocabularyConnectionString, Vendor vendor, int batchSize)
        {
            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            string query = "INSERT INTO [BuildingSettings] " +
                                 "([SourceConnectionString] " +
                                 ",[DestinationConnectionString] " +
                                 ",[VocabularyConnectionString] " +
                                 ",[Vendor] " +
                                 ",[BatchSize]) " +
                                 "VALUES " +
                                 "(@sourceConnectionString " +
                                 ",@destinationConnectionString " +
                                 ",@vocabularyConnectionString " +
                                 ",@vendor " +
                                 ",@batchSize);";

            if (connection is SqlConnection)
                query += ";Select Scope_Identity();";

            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);

            var sourceConnectionStringPar = cmd.CreateParameter();
            sourceConnectionStringPar.ParameterName = "@sourceConnectionString";
            sourceConnectionStringPar.DbType = DbType.String;
            sourceConnectionStringPar.Value = sourceConnectionString;
            cmd.Parameters.Add(sourceConnectionStringPar);

            var destinationConnectionStringPar = cmd.CreateParameter();
            destinationConnectionStringPar.ParameterName = "@destinationConnectionString";
            destinationConnectionStringPar.DbType = DbType.String;
            destinationConnectionStringPar.Value = destinationConnectionString;
            cmd.Parameters.Add(destinationConnectionStringPar);

            var vocabularyConnectionStringPar = cmd.CreateParameter();
            vocabularyConnectionStringPar.ParameterName = "@vocabularyConnectionString";
            vocabularyConnectionStringPar.DbType = DbType.String;
            vocabularyConnectionStringPar.Value = vocabularyConnectionString;
            cmd.Parameters.Add(vocabularyConnectionStringPar);

            var vendorPar = cmd.CreateParameter();
            vendorPar.ParameterName = "@vendor";
            vendorPar.DbType = DbType.String;
            vendorPar.Value = vendor.ToString();
            cmd.Parameters.Add(vendorPar);

            var batchSizePar = cmd.CreateParameter();
            batchSizePar.ParameterName = "@batchSize";
            batchSizePar.DbType = DbType.Int32;
            batchSizePar.Value = batchSize;
            cmd.Parameters.Add(batchSizePar);

            cmd.CommandTimeout = 30000;
            if (connection is SqlConnection)
            {
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
            else
            {
                cmd.ExecuteScalar();
                using var cmd2 = SqlConnectionHelper.CreateCommand("SELECT last_insert_rowid()", connection);
                return Convert.ToInt32(cmd2.ExecuteScalar());
            }
        }

        public void Update(int buildingId, string sourceConnectionString, string destinationConnectionString, string vocabularyConnectionString, Vendor vendor, int batchSize)
        {
            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            const string query = "UPDATE [BuildingSettings] " +
                                 "SET [SourceConnectionString] = @sourceConnectionString " +
                                 ",[DestinationConnectionString] = @destinationConnectionString " +
                                 ",[VocabularyConnectionString] = @vocabularyConnectionString " +
                                 ",[Vendor] = @vendor " +
                                 ",[BatchSize] = @batchSize " +
                                 "WHERE BuildingId = @buildingId";

            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);
            var buildingIdPar = cmd.CreateParameter();
            buildingIdPar.ParameterName = "@buildingId";
            buildingIdPar.DbType = DbType.Int32;
            buildingIdPar.Value = buildingId;
            cmd.Parameters.Add(buildingIdPar);

            var sourceConnectionStringPar = cmd.CreateParameter();
            sourceConnectionStringPar.ParameterName = "@sourceConnectionString";
            sourceConnectionStringPar.DbType = DbType.String;
            sourceConnectionStringPar.Value = sourceConnectionString;
            cmd.Parameters.Add(sourceConnectionStringPar);

            var destinationConnectionStringPar = cmd.CreateParameter();
            destinationConnectionStringPar.ParameterName = "@destinationConnectionString";
            destinationConnectionStringPar.DbType = DbType.String;
            destinationConnectionStringPar.Value = destinationConnectionString;
            cmd.Parameters.Add(destinationConnectionStringPar);

            var vocabularyConnectionStringPar = cmd.CreateParameter();
            vocabularyConnectionStringPar.ParameterName = "@vocabularyConnectionString";
            vocabularyConnectionStringPar.DbType = DbType.String;
            vocabularyConnectionStringPar.Value = vocabularyConnectionString;
            cmd.Parameters.Add(vocabularyConnectionStringPar);

            var vendorPar = cmd.CreateParameter();
            vendorPar.ParameterName = "@vendor";
            vendorPar.DbType = DbType.String;
            vendorPar.Value = vendor.ToString();
            cmd.Parameters.Add(vendorPar);

            var batchSizePar = cmd.CreateParameter();
            batchSizePar.ParameterName = "@batchSize";
            batchSizePar.DbType = DbType.Int32;
            batchSizePar.Value = batchSize;
            cmd.Parameters.Add(batchSizePar);

            cmd.CommandTimeout = 30000;
            cmd.ExecuteScalar();
        }

        public void Reset()
        {
            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            const string query = "delete from [BuildingSettings]";

            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);
            cmd.ExecuteScalar();
        }

        public IEnumerable<IDataReader> GetList()
        {
            const string query = "SELECT [BuildingId] " +
                                 ",[SourceConnectionString] " +
                                 ",[DestinationConnectionString] " +
                                 ",[Vendor] " +
                                 ",[BatchSize] " +
                                 "FROM [BuildingSettings] ORDER BY BuildingId DESC";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader; ;
            }
        }

        public IEnumerable<IDataReader> Load(int buildingId)
        {
            const string query = "SELECT [BuildingId] " +
                                 ",[SourceConnectionString] " +
                                 ",[DestinationConnectionString] " +
                                 ",[VocabularyConnectionString] " +
                                 ",[Vendor] " +
                                 ",[BatchSize] " +
                                 "FROM [BuildingSettings] where BuildingId = {0}";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, buildingId), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader;
            }
        }

        public static string GetVocabularyVersion(string vocabularyConnectionString, string schema)
        {
            string query = $"select vocabulary_version from {schema}.vocabulary where vocabulary_id = 'None'";

            try
            {
                using var connection = SqlConnectionHelper.OpenOdbcConnection(vocabularyConnectionString);
                using var cmd = new OdbcCommand(query, connection);
                using var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    return reader.GetString(0);
                }
            }
            catch (Exception)
            {
                return null;
            }


            return null;
        }
    }
}