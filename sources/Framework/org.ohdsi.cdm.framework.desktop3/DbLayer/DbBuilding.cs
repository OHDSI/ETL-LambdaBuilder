using org.ohdsi.cdm.framework.desktop.Helpers;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbBuilding(string connectionString)
    {
        private readonly string _connectionString = connectionString;

        public void SetFieldToNowDate(int buildingId, string fieldName)
        {
            using var conn = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            var query = string.Format("UPDATE [Building] SET {1} = '{2}' WHERE [Id] = {0}", buildingId, fieldName, DateTime.Now);
            using var command = SqlConnectionHelper.CreateCommand(query, conn);
            command.ExecuteNonQuery();
        }

        public void SetFieldTo(int buildingId, string fieldName, DateTime? value)
        {
            using var conn = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            var query = string.Format("UPDATE [Building] SET {1} = @time WHERE [Id] = {0}", buildingId, fieldName);
            using var command = SqlConnectionHelper.CreateCommand(query, conn);

            var timePar = command.CreateParameter();
            timePar.ParameterName = "@time";
            timePar.DbType = DbType.DateTime;
            timePar.Value = value ?? (object)DBNull.Value;
            command.Parameters.Add(timePar);

            command.ExecuteNonQuery();
        }

        public IEnumerable<IDataReader> Load(int buildingId)
        {
            const string query = "SELECT * FROM [Building] where Id = {0}";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, buildingId), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader;
            }
        }

        public void Create(int buildingId)
        {
            const string query = "INSERT INTO [Building] ([Id]) VALUES ({0})";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, buildingId), connection);
            cmd.CommandTimeout = 30000;
            cmd.ExecuteScalar();
        }
    }
}