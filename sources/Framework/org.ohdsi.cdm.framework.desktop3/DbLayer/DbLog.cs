using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbLog(string connectionString)
    {
        private readonly string _connectionString = connectionString;

        public IEnumerable<string> GetErrors(int buildingId)
        {
            const string query =
               "SELECT  'Builder: ' + b.Dsn + CHAR(13) + " +
               "'Time: ' + cast([Time] as nvarchar) + CHAR(13) + " +
               "'Error: ' + [Message] + CHAR(13) + CHAR(13) " +
               "FROM [Log] l " +
               "join [Builder] b on l.BuilderId = b.Id " +
               "where l.[BuildingId] = {0} and [Type] = 'Error' " +
               "order by time desc ";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, buildingId), connection);
            cmd.CommandTimeout = 30000;
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return reader.GetString(0);
            }
        }

        public void Reset(int buildingId)
        {
            const string query =
               "delete [Log] FROM [Log] l " +
               "join [Builder] b on l.BuilderId = b.Id " +
               "where l.[BuildingId] = {0} and l.[Type] = 'Error'";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(string.Format(query, buildingId), connection);
            cmd.ExecuteNonQuery();
        }

        public void Add(int? builderId, int? buildingId, int? chunkId, LogMessageTypes type, string message)
        {
            const string query =
                "INSERT INTO [Log] ([ChunkId],[BuilderId],[BuildingId],[Type],[Time],[Message]) VALUES (@chunkId, @builderId, @buildingId, @type, @time, @message)";

            using var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString);
            using var cmd = SqlConnectionHelper.CreateCommand(query, connection);

            var chunkIdPar = cmd.CreateParameter();
            chunkIdPar.ParameterName = "@chunkId";
            chunkIdPar.DbType = DbType.Int32;
            chunkIdPar.Value = chunkId.HasValue ? chunkId : (object)DBNull.Value;
            cmd.Parameters.Add(chunkIdPar);

            var builderIdPar = cmd.CreateParameter();
            builderIdPar.ParameterName = "@builderId";
            builderIdPar.DbType = DbType.Int32;
            builderIdPar.Value = builderId.HasValue ? builderId : (object)DBNull.Value;
            cmd.Parameters.Add(builderIdPar);


            var buildingIdPar = cmd.CreateParameter();
            buildingIdPar.ParameterName = "@buildingId";
            buildingIdPar.DbType = DbType.Int32;
            buildingIdPar.Value = buildingId.HasValue ? buildingId : (object)DBNull.Value;
            cmd.Parameters.Add(buildingIdPar);

            var typePar = cmd.CreateParameter();
            typePar.ParameterName = "@type";
            typePar.DbType = DbType.String;
            typePar.Value = type.ToString();
            cmd.Parameters.Add(typePar);

            var timePar = cmd.CreateParameter();
            timePar.ParameterName = "@time";
            timePar.DbType = DbType.DateTime;
            timePar.Value = DateTime.Now;
            cmd.Parameters.Add(timePar);

            var messagePar = cmd.CreateParameter();
            messagePar.ParameterName = "@message";
            messagePar.DbType = DbType.String;
            messagePar.Value = message;
            cmd.Parameters.Add(messagePar);

            cmd.ExecuteNonQuery();
        }
    }
}