using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.Diagnostics;
using System.Text;

namespace org.ohdsi.cdm.framework.desktop.Base
{
    public class DatabaseChunkPart : ChunkPart
    {
        public ChunkData ChunkData { get; private set; }

        public DatabaseChunkPart(int chunkId, Func<IPersonBuilder> createPersonBuilder, string prefix, int attempt) : base(chunkId, createPersonBuilder, prefix, attempt)
        {
            ChunkData = new ChunkData(ChunkId, int.Parse(Prefix));
            PersonBuilders = [];
            OffsetManager = new KeyMasterOffsetManager(ChunkId, int.Parse(Prefix), 0);
        }

        public void Reset()
        {
            ChunkData = new ChunkData(ChunkId, int.Parse(Prefix));
            PersonBuilders = [];
            OffsetManager = new KeyMasterOffsetManager(ChunkId, int.Parse(Prefix), 0);
        }

        public KeyValuePair<string, Exception> Load2(OdbcConnection connection)
        {
            var fileName = string.Empty;
            var query = string.Empty;
            var connectionString = string.Empty;
            var sourceEngine = string.Empty;

            try
            {
                var timer = new Stopwatch();
                timer.Start();
                foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
                {
                    if (qd.Providers != null) continue;
                    if (qd.Locations != null) continue;
                    if (qd.CareSites != null) continue;

                    fileName = qd.FileName;

                    var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                        qd.GetSql(Settings.Settings.Current.Building.Vendor,
                            Settings.Settings.Current.Building.SourceSchemaName, Settings.Settings.Current.Building.SourceSchemaName),
                        Settings.Settings.Current.Building.SourceSchemaName);

                    if (string.IsNullOrEmpty(sql))
                        continue;

                    var q = string.Format(sql, ChunkId);

                    using var cdm = Settings.Settings.Current.Building.SourceEngine.GetCommand(q, connection);
                    using var reader =
                        Settings.Settings.Current.Building.SourceEngine.ReadChunkData(connection, cdm, qd, ChunkId,
                            Prefix);
                    while (reader.Read())
                    {
                        PopulateData(qd, reader);
                    }
                }

                timer.Stop();
            }
            catch (Exception e)
            {
                var info = new StringBuilder();
                info.AppendLine("SourceEngine=" + sourceEngine);
                info.AppendLine("SourceConnectionString=" + connectionString);
                info.AppendLine("File name=" + fileName);
                info.AppendLine("Query:");
                info.AppendLine(query);

                return new KeyValuePair<string, Exception>(info.ToString(), e);
            }


            return new KeyValuePair<string, Exception>(null, null);
        }


        public KeyValuePair<string, Exception> Load()
        {
            var query = "";
            var connectionString = "";
            var sourceEngine = "";

            try
            {
                var timer = new Stopwatch();
                timer.Start();
                foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
                {
                    if (qd.Providers != null) continue;
                    if (qd.Locations != null) continue;
                    if (qd.CareSites != null) continue;

                    var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                            qd.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName, Settings.Settings.Current.Building.SourceSchemaName), Settings.Settings.Current.Building.SourceSchemaName);

                    if (string.IsNullOrEmpty(sql)) continue;

                    if (Settings.Settings.Current.Building.SourceEngine.Database != Database.Redshift)
                    {
                        var q = string.Format(sql, ChunkId);
                        query = q;
                        connectionString = Settings.Settings.Current.Building.SourceConnectionString;
                        sourceEngine = Settings.Settings.Current.Building.SourceEngine.Database.ToString();

                        using var conn = Settings.Settings.Current.Building.SourceEngine.GetConnection(Settings.Settings.Current.Building.SourceConnectionString);
                        using var cdm = Settings.Settings.Current.Building.SourceEngine.GetCommand(q, conn);
                        using var reader = Settings.Settings.Current.Building.SourceEngine.ReadChunkData(conn, cdm, qd, ChunkId, Prefix);
                        while (reader.Read())
                        {
                            PopulateData(qd, reader);
                        }
                    }
                    else
                    {
                        using var reader = Settings.Settings.Current.Building.SourceEngine.ReadChunkData(null, null, qd, ChunkId, Prefix);
                        while (reader.Read())
                        {
                            PopulateData(qd, reader);
                        }
                    }

                }
                timer.Stop();
            }
            catch (Exception e)
            {
                var info = new StringBuilder();
                info.AppendLine("SourceEngine=" + sourceEngine);
                info.AppendLine("SourceConnectionString=" + connectionString);
                info.AppendLine("Query:");
                info.AppendLine(query);

                return new KeyValuePair<string, Exception>(info.ToString(), e);
            }


            return new KeyValuePair<string, Exception>(null, null);
        }

        public void Build()
        {
            Console.WriteLine($"Building CDM chunkId={ChunkId} ...");

            foreach (var pb in PersonBuilders)
            {
                var result = pb.Value.Value.Build(ChunkData, OffsetManager);
                ChunkData.AddAttrition(pb.Key, result);
            }

            PersonBuilders.Clear();
            PersonBuilders = null;
            Console.WriteLine($"Building CDM chunkId={ChunkId} - complete");
        }

        public void Save()
        {
            Console.WriteLine($"Saving chunkId={ChunkId} ...");
            Console.WriteLine("DestinationConnectionString=" + Settings.Settings.Current.Building.DestinationConnectionString);

            if (Settings.Settings.Current.Building.Vendor is not etl.Transformation.Era.EraPersonBuilder.EraVendor &&
                Settings.Settings.Current.Building.Vendor is not etl.Transformation.PA.PregnancyAlgorithmPersonBuilder.PregnancyAlgorithmVendor &&
                ChunkData.Persons.Count == 0)
            {
                ChunkData.Clean();
                return;
            }

            var saver = Settings.Settings.Current.Building.DestinationEngine.GetSaver();

            var timer = new Stopwatch();
            timer.Start();
            using (saver)
            {
                saver.Create(Settings.Settings.Current.Building.DestinationConnectionString).Save(ChunkData, OffsetManager);
            }
            timer.Stop();

            Console.WriteLine($"Saving chunkId={ChunkId} - complete");

            ChunkData.Clean();
            GC.Collect();
        }

        public void Clean()
        {
            ChunkData.Clean();
            ChunkData = null;
        }
    }
}
