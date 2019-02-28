using System;
using System.Collections.Generic;
using System.Data;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Savers;

namespace org.ohdsi.cdm.framework.desktop.Databases
{
   public interface IDatabaseEngine
   {
      Database Database { get; }
      IEnumerable<string> GetAllTables();
      IEnumerable<string> GetAllColumns(string tableName);
      ISaver GetSaver();

      string GetSql(string tableName, IEnumerable<string> columns, int chunkId, string personIdFieldName);
      IDbConnection GetConnection(string odbcConnectionString);
      IDbCommand GetCommand(string cmdText, IDbConnection connection);

      IDataReader ReadChunkData(IDbConnection conn, IDbCommand cmd, QueryDefinition qd, int chunkId, string prefix);

      IChunkBuilder GetChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder);
   }
}
