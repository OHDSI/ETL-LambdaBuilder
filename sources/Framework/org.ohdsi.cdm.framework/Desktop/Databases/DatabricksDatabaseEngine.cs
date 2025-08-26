using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Savers;
using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop.Databases
{
    public class DatabricksDatabaseEngine : DatabaseEngine
    {
        public DatabricksDatabaseEngine()
        {
            Database = Database.Databricks;
        }

        public override IEnumerable<string> GetAllTables()
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<string> GetAllColumns(string tableName)
        {
            throw new NotImplementedException();
        }

        public override ISaver GetSaver()
        {
            return new DatabricksSaver();
        }

        public override IDbCommand GetCommand(string cmdText, IDbConnection connection)
        {
            return new OdbcCommand(cmdText, (OdbcConnection)connection);
        }

        public override IDataReader ReadChunkData(IDbConnection conn, IDbCommand cmd, QueryDefinition qd, int chunkId, string prefix)
        {
            throw new NotImplementedException();
        }

        public override IChunkBuilder GetChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder)
        {
            throw new NotImplementedException();
        }
    }
}