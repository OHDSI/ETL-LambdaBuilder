using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;
using System.Data.Odbc;
using System.Reflection;
using System.Text;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbSource(string connectionString, string dbType, string schemaName)
    {
        private readonly string _connectionString = connectionString;
        private readonly string _dbType = dbType;
        private readonly string _schemaName = schemaName;

        private void CreateChunkSchema(string name)
        {
            // TMP
            try
            {
                var query = "CREATE SCHEMA IF NOT EXISTS {sc};";
                query = query.Replace("{sc}", name);
                using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
                using var cmd = new OdbcCommand(query, connection);
                cmd.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                Console.WriteLine("Can't create chunk schema");
            }
        }

        private string GetQuery(string name, string schema)
        {
            string[] resourceNames = Assembly.GetExecutingAssembly().GetManifestResourceNames();
            var resource = resourceNames.First(a => a.EndsWith(name) && a.Contains(_dbType, StringComparison.OrdinalIgnoreCase));
            Console.WriteLine(resource);

            using var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(resource);
            using var reader = new StreamReader(stream, Encoding.Default);
            var query = reader.ReadToEnd();
            query = query.Replace("{sc}", schema);

            return query;
        }

        public void CreateChunkTable(string schemaName)
        {
            CreateChunkSchema(schemaName);
            DropChunkTable(schemaName);

            var query = GetQuery("CreateChunkTable.sql", schemaName);

            Console.WriteLine("CreateChunkTable:" + query);

            using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
            foreach (var q in query.Split(';', StringSplitOptions.RemoveEmptyEntries))
            {
                using var cmd = new OdbcCommand(q, connection);
                cmd.ExecuteNonQuery();
            }
        }

        public void DropChunkTable(string schemaName)
        {
            CreateChunkSchema(schemaName);

            var query = GetQuery("DropChunkTable.sql", schemaName);

            Console.WriteLine("DropChunkTable:" + query);
            using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
            using var cmd = new OdbcCommand(query, connection);
            cmd.ExecuteNonQuery();
        }

        public IEnumerable<long> GetPersonIds(int chunkId, string schemaName)
        {
            var query = $"SELECT person_id FROM {schemaName}._chunks where chunkid={chunkId};";
            using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
            using var c = new OdbcCommand(query, connection) { CommandTimeout = 300 };
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetInt64(0);
            }
        }

        public void CreateIndexesChunkTable(string schemaName)
        {
            var query = GetQuery("CreateIndexesChunkTable.sql", schemaName);

            if (string.IsNullOrEmpty(query.Trim())) 
                return;

            using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
            foreach (var subQuery in query.Split(new[] { "GO" + "\r\n", "GO" + "\n" },
                StringSplitOptions.RemoveEmptyEntries))
            {
                using var command = new OdbcCommand(subQuery, connection);
                command.CommandTimeout = 0;
                command.ExecuteNonQuery();
            }
        }


        public IEnumerable<IDataReader> GetPersonKeys(string batchScript, long batches, int batchSize)
        {
            batchScript = batchScript.Replace("{sc}", _schemaName);
            var sql = batches > 0
                ? string.Format(batchScript, "TOP " + batches * batchSize)
                : string.Format(batchScript, "");
            using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
            using var c = new OdbcCommand(sql, connection) { CommandTimeout = 0 };
            using var reader = c.ExecuteReader();
            while (reader.Read())
            {
                yield return reader;
            }

        }

        public string GetSourceReleaseDate()
        {
            try
            {
                string query = "SELECT version_date version_date FROM " + _schemaName + "._version";
                using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
                using var c = new OdbcCommand(query, connection) { CommandTimeout = 0 };
                using var reader = c.ExecuteReader();

                while (reader.Read())
                {
                    var dateString = reader.GetString("version_date");
                    var date = DateTime.Parse(dateString);

                    return date.ToShortDateString();
                }

            }
            catch (Exception)
            {
                return DateTime.MinValue.ToShortDateString();
            }

            return DateTime.MinValue.ToShortDateString();
        }

        public string GetSourceVersionId()
        {
            try
            {
                string query = "SELECT version_id FROM " + _schemaName + "._version";
                using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
                using var c = new OdbcCommand(query, connection);
                using var reader = c.ExecuteReader();

                while (reader.Read())
                {
                    return reader.GetString("version_id");
                }

            }
            catch (Exception)
            {
                return "unknown";
            }

            return "unknown";
        }
    }
}