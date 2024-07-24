using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data.Odbc;
using System.Data.SqlClient;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class MsSqlSaver : Saver
    {
        private SqlConnection _connection;
        private SqlTransaction _transaction;
        private SqlBulkCopy _bulkCopy;

        public override ISaver Create(string connectionString)
        {
            var odbcConnection = new OdbcConnectionStringBuilder(connectionString);
            var sqlConnection = new SqlConnectionStringBuilder
            {
                ["Data Source"] = odbcConnection["server"],
                ["Initial Catalog"] = odbcConnection["database"],
                ["User Id"] = odbcConnection["uid"],
                ["Password"] = odbcConnection["pwd"]
            };

            _connection = (SqlConnection)SqlConnectionHelper.OpenMssqlConnection(sqlConnection.ConnectionString);
            _transaction = _connection.BeginTransaction();
            _bulkCopy = new SqlBulkCopy(_connection, SqlBulkCopyOptions.TableLock, _transaction) { BulkCopyTimeout = 600 };

            return this;
        }

        public override void Write(int? chunkId, int? subChunkId, System.Data.IDataReader reader, string tableName)
        {
            if (tableName.StartsWith("_chunks", System.StringComparison.CurrentCultureIgnoreCase))
            {
                tableName = Settings.Settings.Current.Building.SourceSchemaName + "." + tableName;
            }
            else
            {
                tableName = Settings.Settings.Current.Building.DestinationSchemaName + "." + tableName;
            }

            _bulkCopy.DestinationTableName = tableName;
            _bulkCopy.WriteToServer(reader);
        }

        public override void Commit()
        {
            _transaction.Commit();
            _bulkCopy.Close();
        }

        public override void Rollback()
        {
            _transaction.Rollback();
        }

        public override void Dispose()
        {
            _transaction.Dispose();
            _connection.Dispose();
        }

        public override void CopyVocabulary()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString, Settings.Settings.Current.Building.DestinationSchemaName);
            dbDestination.CopyVocabulary(Settings.Settings.Current.CopyVocabularyScript, Settings.Settings.Current.Building.VocabularyConnectionString);
        }
    }
}