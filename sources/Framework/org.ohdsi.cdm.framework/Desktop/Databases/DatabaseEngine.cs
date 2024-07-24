using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.desktop.Base;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Savers;
using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop.Databases
{
    public class DatabaseEngine : IDatabaseEngine
    {
        public Database Database { get; protected set; }

        public virtual IEnumerable<string> GetAllTables()
        {
            throw new NotImplementedException();
        }

        public virtual IEnumerable<string> GetAllColumns(string tableName)
        {
            throw new NotImplementedException();
        }

        public virtual ISaver GetSaver()
        {
            throw new NotImplementedException();
        }

        public virtual string GetSql(string tableName, IEnumerable<string> columns, int chunkId,
            string personIdFieldName)
        {
            return
                $"select {string.Join(",", columns)} from {tableName} JOIN _chunks ch ON ch.ChunkId = {chunkId} AND {personIdFieldName} = ch.PERSON_ID";
        }

        public virtual IDbConnection GetConnection(string odbcConnectionString)
        {
            return SqlConnectionHelper.OpenConnection(odbcConnectionString, Database);
        }

        public virtual IDbCommand GetCommand(string cmdText, IDbConnection connection)
        {
            throw new NotImplementedException();
        }

        public virtual IDataReader ReadChunkData(IDbConnection conn, IDbCommand cmd, QueryDefinition qd, int chunkId,
            string prefix)
        {
            throw new NotImplementedException();
        }

        public virtual IChunkBuilder GetChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder)
        {
            return new DatabaseChunkBuilder(chunkId, createPersonBuilder);
        }

        public static IDatabaseEngine GetEngine(OdbcConnection cn)
        {
            return GetDbType(cn) switch
            {
                Database.MsSql => new MssqlDatabaseEngine(),
                Database.Redshift => new RedshiftDatabaseEngine(),
                _ => throw new Exception("Unsupported database engine"),
            };
        }

        public static IDatabaseEngine GetEngine(string connectionString)
        {
            if (connectionString.Contains("amazon redshift", StringComparison.CurrentCultureIgnoreCase))
                return new RedshiftDatabaseEngine();

            if (connectionString.Contains("postgre", StringComparison.CurrentCultureIgnoreCase))
                return new PostgreDatabaseEngine();

            if (connectionString.Contains("mysql", StringComparison.CurrentCultureIgnoreCase))
                return new MySqlDatabaseEngine();

            return new MssqlDatabaseEngine();
        }

        public static Database GetDbType(string connectionString)
        {
            return connectionString.Contains("amazon redshift", StringComparison.CurrentCultureIgnoreCase) ? Database.Redshift : Database.MsSql;
        }

        public static Database GetDbType(OdbcConnection cn)
        {
            var t = Database.Unsupported;
            try
            {
                if (cn.State != ConnectionState.Open)
                    cn.Open();


                var cmd = cn.CreateCommand();
                var outstring = "";
                cmd.CommandText = "SELECT * FROM v$version";
                try
                {
                    var reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        outstring = $"{reader.GetString(0)}";

                    }
                }
                catch (Exception)
                {
                    cmd = cn.CreateCommand();
                    cmd.CommandText = "SELECT @@version, @@version_comment FROM dual";
                    try
                    {
                        var reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();
                            outstring = $"{reader.GetString(0)} {reader.GetString(1)}";

                        }
                    }
                    catch (Exception)
                    {
                        cmd = cn.CreateCommand();
                        cmd.CommandText = "SELECT @@version";
                        try
                        {
                            var reader = cmd.ExecuteReader();
                            if (reader.HasRows)
                            {
                                reader.Read();
                                outstring = $"{reader.GetString(0)}";

                            }
                        }
                        catch (Exception)
                        {
                            cmd = cn.CreateCommand();
                            cmd.CommandText = "SELECT version()";
                            try
                            {
                                var reader = cmd.ExecuteReader();
                                if (reader.HasRows)
                                {
                                    reader.Read();
                                    outstring = $"{reader.GetString(0)}";

                                }
                            }
                            catch (Exception)
                            {
                            }
                        }
                    }
                }

                outstring = outstring.ToUpper();

                if (outstring.Contains("SQL SERVER"))
                {
                    t = Database.MsSql;
                }
                else if (outstring.Contains("REDSHIFT"))
                {
                    t = Database.Redshift;
                }
            }
            catch (Exception)
            {

            }

            return t;

        }
    }
}