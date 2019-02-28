using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.Helpers;

namespace org.ohdsi.cdm.framework.desktop.DbLayer
{
    public class DbChunk
    {
        private readonly string _connectionString;

        public DbChunk(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void AddChunk(int chunkId, int buildingId)
        {
            const string query =
               "INSERT INTO Chunk (Id, BuildingId) VALUES (@chunkId, @buildingId);";
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                cmd.Parameters.Add("@chunkId", SqlDbType.Int);
                cmd.Parameters["@chunkId"].Value = chunkId;

                cmd.Parameters.Add("@buildingId", SqlDbType.Int);
                cmd.Parameters["@buildingId"].Value = buildingId;

                cmd.ExecuteScalar();
            }
        }

        public int GetChunksCount(int buildingId)
        {
            var query =
                $"SELECT Count(*) FROM Chunk WHERE BuildingId = {buildingId}";

            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public int GetCompleteChunksCount(int buildingId)
        {
            var query =
                $"SELECT Count(*) FROM Chunk WHERE BuildingId = {buildingId} AND Ended is not null";

            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public void ResetNotFinishedChunks(int buildingId)
        {
            var query =
                $"UPDATE [dbo].[Chunk] SET [Started] = NULL WHERE [Ended] is NULL and [BuildingId] = {buildingId}";
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                cmd.ExecuteNonQuery();
            }
        }

        public void ResetChunks(int buildingId)
        {
            var query =
                $"UPDATE [dbo].[Chunk] SET [Created] = NULL, [Started] = NULL,  [Ended] = NULL, [Failed] = NULL WHERE [BuildingId] = {buildingId}";
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                cmd.ExecuteNonQuery();
            }

            //query = $"DELETE FROM [dbo].[AvailableOnS3] WHERE [BuildingId] = {buildingId}";
            //using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            //using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            //{
            //   cmd.ExecuteNonQuery();
            //}
        }

        public bool AllChunksStarted(int buildingId)
        {
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var transaction = connection.BeginTransaction())
            {
                var query =
                    $"SELECT TOP 1 Id FROM Chunk WHERE BuildingId = {buildingId} AND Started is null";
                using (var cmd = new SqlCommand(query, connection, transaction) { CommandTimeout = 0 })
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            return false;
                        }
                    }
                }
            }

            return true;
        }

        public bool AllChunksComplete(int buildingId)
        {
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var transaction = connection.BeginTransaction())
            {
                var query =
                    $"SELECT TOP 1 Id FROM Chunk WHERE BuildingId = {buildingId} AND Ended is null";
                using (var cmd = new SqlCommand(query, connection, transaction) { CommandTimeout = 0 })
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            return false;
                        }
                    }
                }
            }

            return true;
        }

        public void ChunkFailed(int chunkId, int buildingId)
        {
            var query = string.Format("UPDATE Chunk SET Failed = '{2}' WHERE Id = {0} and BuildingId = {1}", chunkId, buildingId, DateTime.Now);
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                cmd.ExecuteNonQuery();
            }
        }

        public void ChunkComplete(int chunkId, int buildingId)
        {
           var query = string.Format("UPDATE Chunk SET Ended = '{2}' WHERE Id = {0} and BuildingId = {1}", chunkId, buildingId, DateTime.Now);
           using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
           using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
           {
              cmd.ExecuteNonQuery();
           }
        }

        public IEnumerable<int> GetNotMovedToS3Chunks(int buildingId)
        {
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            {
                using (var cmd = new SqlCommand(
                    $"SELECT Id FROM Chunk WHERE BuildingId = {buildingId} AND Created IS NULL", connection))
                {
                    cmd.CommandTimeout = 30000;
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            yield return reader.GetInt("Id").Value;
                        }
                    }
                }
            }
        }
       
        public void ChunkCreated(int chunkId, int buildingId)
        {
           var query = string.Format("UPDATE Chunk SET Created = '{2}' WHERE Id = {0} and BuildingId = {1}", chunkId, buildingId, DateTime.Now);
           using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
           using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
           {
              cmd.ExecuteNonQuery();
           }
        }

      
        public void MarkUncompletedChunks(int buildingId, int builderId)
        {
           var query = string.Format("UPDATE Chunk SET Failed = '{2}' WHERE BuildingId = {0} AND BuilderId = {1} AND Started is not NULL and Ended is NULL", buildingId, builderId, DateTime.Now);
           using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
           using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
           {
              cmd.ExecuteNonQuery();
           }
        }


        public int? TakeChunk(int buildingId, int builderId, bool orderByDesc)
        {
            int? chunkId = null;
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var transaction = connection.BeginTransaction())
            {
                var orderBy = orderByDesc ? " ORDER BY 1 DESC" : "";
                var query =
                    $"SELECT TOP 1 Id FROM Chunk with (updlock) WHERE BuildingId = {buildingId} AND Started is null{orderBy}";

                using (var cmd = new SqlCommand(query, connection, transaction) { CommandTimeout = 0 })
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            chunkId = reader.GetInt("Id").Value;
                        }
                    }
                }

                if (chunkId.HasValue)
                {
                    query = string.Format("UPDATE Chunk SET Started = '{1}', BuilderId = {2}  WHERE Id = {0}", chunkId,
                                          DateTime.Now, builderId);
                    using (var cmd = new SqlCommand(query, connection, transaction) { CommandTimeout = 0 })
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
                transaction.Commit();
            }

            return chunkId;
        }

        public void ClearChunks(int buildingId)
        {
            var query = $"DELETE FROM Chunk WHERE BuildingId = {buildingId} ";
            using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            {
                cmd.ExecuteNonQuery();
            }

            //query = $"DELETE FROM AvailableOnS3 WHERE BuildingId = {buildingId} ";
            //using (var connection = SqlConnectionHelper.OpenMssqlConnection(_connectionString))
            //using (var cmd = new SqlCommand(query, connection) { CommandTimeout = 0 })
            //{
            //   cmd.ExecuteNonQuery();
            //}
        }
    }
}
