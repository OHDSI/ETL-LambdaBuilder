using System;
using System.Data.Odbc;
using System.Data.SqlClient;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbDestination
    {
        private readonly string _connectionString;
        private readonly string _schemaName;

        public DbDestination(string connectionString, string schemaName)
        {
            _connectionString = connectionString;
            _schemaName = schemaName;
        }

        public void CreateDatabase(string query)
        {
            var sqlConnectionStringBuilder = new OdbcConnectionStringBuilder(_connectionString);
            var database = sqlConnectionStringBuilder["database"];

            // TMP
            if (_connectionString.ToLower().Contains("amazon redshift"))
                sqlConnectionStringBuilder["database"] = "poc";
            else
                sqlConnectionStringBuilder["database"] = "master";

            using (var connection = SqlConnectionHelper.OpenOdbcConnection(sqlConnectionStringBuilder.ConnectionString))
            {
                query = string.Format(query, database);

                foreach (var subQuery in query.Split(new[] {"\r\nGO", "\nGO"}, StringSplitOptions.None))
                {
                    using (var command = new OdbcCommand(subQuery, connection))
                    {
                        command.CommandTimeout = 30000;
                        command.ExecuteNonQuery();
                    }
                }
            }

            if (_schemaName.ToLower().Trim() != "dbo")
            {
                CreateSchema();
            }
        }

        public void CreateSchema()
        {
            using (var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString))
            {
                var query = $"create schema [{_schemaName}]";

                using (var command = new OdbcCommand(query, connection))
                {
                    command.CommandTimeout = 0;
                    command.ExecuteNonQuery();
                }
            }
        }
        
        public void ExecuteQuery(string query)
        {
            using (var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString))
            {
                query = query.Replace("{sc}", _schemaName);

                using (var command = new OdbcCommand(query, connection))
                {
                    command.CommandTimeout = 0;
                    command.ExecuteNonQuery();
                }
            }
        }

        public void CopyVocabulary(string query, string vocabularyConnectionString)
        {
            if (string.IsNullOrEmpty(query.Trim())) return;

            var vocab = new OdbcConnectionStringBuilder(vocabularyConnectionString);
            using (var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString))
            {
                query = string.Format(query, vocab["server"], vocab["database"]);
                query = query.Replace("{sc}", _schemaName);
                using (var command = new OdbcCommand(query, connection))
                {
                    command.CommandTimeout = 0;
                    command.ExecuteNonQuery();
                }
            }
        }

        public void PopulateMetadata()
        {
            var query = "INSERT INTO {sc}.METADATA " +
                        "(METADATA_CONCEPT_ID  " +
                        ", [NAME] " +
                        ", VALUE_AS_STRING " +
                        ", VALUE_AS_CONCEPT_ID " +
                        ", METADATA_DATE " +
                        ", METADATA_DATETIME) " +
                        "SELECT 0 " +
                        ", [NAME] " +
                        ", count(*) as cnt " +
                        ", 0 " +
                        ", getdate() " +
                        ", CONVERT(varchar, getdate(), 8) " +
                        "FROM ( SELECT DISTINCT PERSON_ID, NAME FROM {sc}.METADATA_TMP) as a GROUP BY [NAME]";

            query = query.Replace("{sc}", _schemaName);

            var odbcConnection = new OdbcConnectionStringBuilder(_connectionString);
            var sqlConnection = new SqlConnectionStringBuilder
            {
                ["Data Source"] = odbcConnection["server"],
                ["Initial Catalog"] = odbcConnection["database"],
                ["User Id"] = odbcConnection["uid"],
                ["Password"] = odbcConnection["pwd"]
            };

            using (var connection = SqlConnectionHelper.OpenMssqlConnection(sqlConnection.ConnectionString))
            {
                using (var command = new SqlCommand(query, connection))
                {
                    command.ExecuteNonQuery();
                }
            }
        }

        public void CreateIndexes(string query)
        {
            if (string.IsNullOrEmpty(query.Trim())) return;

            using (var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString))
            {
                foreach (var subQuery in query.Split(new[] {"\r\nGO", "\nGO"}, StringSplitOptions.None))
                {
                    var q = subQuery.Replace("{sc}", _schemaName);
                    using (var command = new OdbcCommand(q, connection))
                    {
                        command.CommandTimeout = 0;
                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}
