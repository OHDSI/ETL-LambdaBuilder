using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbBuilder(string connectionString)
    {
        private readonly string _connectionString = connectionString;

        public BuilderState GetState(int builderId)
        {
            const string query = "SELECT StateId FROM [Builder] WHERE Id = {0}";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, builderId), connection);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                var stateId = reader.GetInt("StateId");
                if (stateId != null) return (BuilderState)stateId.Value;
            }

            return BuilderState.Unknown;
        }

        public void UpdateState(int builderId, BuilderState state)
        {
            const string query = "UPDATE [Builder] SET [StateId] = {1} WHERE Id = {0}";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, builderId, (int)state), connection);
            cmd.CommandTimeout = 30000;
            cmd.ExecuteNonQuery();
        }

        public IEnumerable<IDataReader> Load(string machineName, string version)
        {
            const string query = "SELECT [Id], [StateId] FROM [Builder] WHERE [DSN] = '{0}' AND [Version]  = '{1}'";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, machineName, version), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader;
            }
        }

        public IEnumerable<string> GetOtherBuilderInfo(int builderId, int buildingId)
        {
            const string query = "SELECT [Dsn] + ' - ' + s.Name + CHAR(13) " +
                                 "FROM [Builder] b  " +
                                 "join [BuilderState] s on b.[StateId] = s.Id  " +
                                 "where b.Id != {0} and BuildingId = {1} ";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, builderId, buildingId), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public bool IsLead(int builderId, int buildingId)
        {
            const string query = "SELECT TOP 1 Id FROM [Builder] b WHERE Id != {0} and BuildingId = {1} and StateId = 2";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, builderId, buildingId), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                return false;
            }

            return true;
        }


        public IEnumerable<IDataReader> LoadSettings(string machineName, string version)
        {
            const string query =
               "SELECT [Id], [Folder], [MaxDegreeOfParallelism], [BatchSize], [BuildingId] FROM [Builder] WHERE [DSN] = '{0}' AND [Version]  = '{1}'";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, machineName, version), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader;
            }
        }

        public void Reset(int builderId)
        {
            var query = "UPDATE [Builder] SET [BuildingId] = NULL WHERE Id = " + builderId;
            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);
            cmd.CommandTimeout = 30000;
            cmd.ExecuteScalar();
        }

        public int CreateSettings(string machineName, string folder, int maxDegreeOfParallelism, string version)
        {
            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            var query = "INSERT INTO [Builder] ([Dsn],[Folder],[BatchSize], [MaxDegreeOfParallelism], [Version]) VALUES ('{0}','{1}',{2},{3},'{4}')";

            if (connection is SqlConnection)
                query += ";Select Scope_Identity();";

            query = string.Format(query, machineName, folder, 0, maxDegreeOfParallelism, version);

            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);
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

        public void UpdateSettings(int builderId, string machineName, int buildingId, string folder, int maxDegreeOfParallelism, string version)
        {
            const string query = "UPDATE [Builder] " +
                                 "SET [Folder] = @folder " +
                                 ",[MaxDegreeOfParallelism] = @maxDegreeOfParallelism " +
                                 ",[BuildingId] = @buildingId " +
                                 ",[Version] = @version " +
                                 "WHERE [Id] = @builderId";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);


            var builderIdPar = cmd.CreateParameter();
            builderIdPar.ParameterName = "@builderId";
            builderIdPar.DbType = DbType.Int32;
            builderIdPar.Value = builderId;
            cmd.Parameters.Add(builderIdPar);

            var dsnPar = cmd.CreateParameter();
            dsnPar.ParameterName = "@dsn";
            dsnPar.DbType = DbType.String;
            dsnPar.Value = machineName;
            cmd.Parameters.Add(dsnPar);

            var folderPar = cmd.CreateParameter();
            folderPar.ParameterName = "@folder";
            folderPar.DbType = DbType.String;
            folderPar.Value = folder;
            cmd.Parameters.Add(folderPar);

            var maxDegreeOfParallelismPar = cmd.CreateParameter();
            maxDegreeOfParallelismPar.ParameterName = "@maxDegreeOfParallelism";
            maxDegreeOfParallelismPar.DbType = DbType.Int32;
            maxDegreeOfParallelismPar.Value = maxDegreeOfParallelism;
            cmd.Parameters.Add(maxDegreeOfParallelismPar);

            var buildingIdPar = cmd.CreateParameter();
            buildingIdPar.ParameterName = "@buildingId";
            buildingIdPar.DbType = DbType.Int32;
            buildingIdPar.Value = buildingId;
            cmd.Parameters.Add(buildingIdPar);

            var versionPar = cmd.CreateParameter();
            versionPar.ParameterName = "@version";
            versionPar.DbType = DbType.String;
            versionPar.Value = version;
            cmd.Parameters.Add(versionPar);

            cmd.CommandTimeout = 30000;
            cmd.ExecuteScalar();
        }
    }
}
