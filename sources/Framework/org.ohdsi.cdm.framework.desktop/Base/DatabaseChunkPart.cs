using System;
using System.Collections.Generic;
using System.Diagnostics;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;

namespace org.ohdsi.cdm.framework.desktop.Base
{
    public class DatabaseChunkPart : ChunkPart
    {
        private ChunkData _chunk;
        
        public DatabaseChunkPart(int chunkId, Func<IPersonBuilder> createPersonBuilder, string prefix, int attempt) : base(chunkId, createPersonBuilder, prefix, attempt)
        {
            _chunk = new ChunkData(ChunkId, int.Parse(Prefix));
        }

        public void Reset()
        {
            _chunk = new ChunkData(ChunkId, int.Parse(Prefix));
            PersonBuilders = new Dictionary<long, Lazy<IPersonBuilder>>();
            OffsetManager = new KeyMasterOffsetManager(ChunkId, int.Parse(Prefix), 0);
        }


        public void Load()
        {
            var timer = new Stopwatch();
            timer.Start();

            //Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, new ParallelOptions { MaxDegreeOfParallelism = 1 }, qd =>
            //Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, qd =>
            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                if (qd.Providers != null) continue;
                if (qd.Locations != null) continue;
                if (qd.CareSites != null) continue;

                //var sql = qd.GetSql(Settings.Current.Building.SourceEngine.Database,
                //Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName);

                var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                        qd.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName), Settings.Settings.Current.Building.SourceSchemaName);

                if (string.IsNullOrEmpty(sql)) continue;
                                
                if (Settings.Settings.Current.Building.SourceEngine.Database != Database.Redshift)
                {
                    var q = string.Format(sql, ChunkId);

                    using (var conn = Settings.Settings.Current.Building.SourceEngine.GetConnection(Settings.Settings.Current.Building.SourceConnectionString))
                    using (var cdm = Settings.Settings.Current.Building.SourceEngine.GetCommand(q, conn))
                    using (var reader = Settings.Settings.Current.Building.SourceEngine.ReadChunkData(conn, cdm, qd, ChunkId, Prefix))
                    {
                        while (reader.Read())
                        {
                            PopulateData(qd, reader);
                        }
                    }
                }
                else
                {
                    using (var reader = Settings.Settings.Current.Building.SourceEngine.ReadChunkData(null, null, qd, ChunkId, Prefix))
                    {
                        while (reader.Read())
                        {
                            PopulateData(qd, reader);
                        }
                    }
                }

            }
            timer.Stop();

            Logger.Write(ChunkId, LogMessageTypes.Info,
                     string.Format(Prefix + ") loaded - {0} ms | {1} Mb", timer.ElapsedMilliseconds,
                        (GC.GetTotalMemory(false) / 1024f) / 1024f));
        }

       

     
        public void Build()
        {
            Console.WriteLine($"Building CDM chunkId={ChunkId} ...");
            //Parallel.ForEach(_personBuilders.Values, pb => pb.Value.Build(_chunk, _offsetManager));

            foreach (var pb in PersonBuilders)
            {
                var result = pb.Value.Value.Build(_chunk, OffsetManager);
                //Logger.Write(ChunkId, LogMessageTypes.Info, "Attrition=" + result.ToName());
                _chunk.AddAttrition(pb.Key, result);
            }

            PersonBuilders.Clear();
            PersonBuilders = null;
            Console.WriteLine($"Building CDM chunkId={ChunkId} - complete");
        }

        public void Save()
        {
            Console.WriteLine($"Saving chunkId={ChunkId} ...");
            Console.WriteLine("DestinationConnectionString=" + Settings.Settings.Current.Building.DestinationConnectionString);
            //if (Settings.Settings.Current.Building.Vendor != Vendors.ErasV5 && _chunk.Persons.Count == 0)
            if (_chunk.Persons.Count == 0)
            {
                Logger.Write(ChunkId, LogMessageTypes.Debug, "skipped subChunkId=" + Prefix);
                _chunk.Clean();
                return;
            }

            var saver = Settings.Settings.Current.Building.DestinationEngine.GetSaver();

            var timer = new Stopwatch();
            timer.Start();
            using (saver)
            {
                saver.Create(Settings.Settings.Current.Building.DestinationConnectionString).Save(_chunk);
            }
            timer.Stop();

            Console.WriteLine($"Saving chunkId={ChunkId} - complete");

            Logger.Write(ChunkId, LogMessageTypes.Info,
               "saved to S3 for Redhsift or otherwise to DB subChunkId=" + Prefix + " | " + _chunk.Persons.Count + " | " + timer.ElapsedMilliseconds +
               " ms");

            Console.WriteLine($"Saving chunkId={ChunkId} - complete | subChunkId=" +Prefix + " | " + _chunk.Persons.Count + " | " + timer.ElapsedMilliseconds +
               " ms");
        }

        public void Clean()
        {
            _chunk.Clean();
            _chunk = null;
            Logger.Write(ChunkId, LogMessageTypes.Info, "Cleanup subChunkId=" + Prefix);
        }
    }
}
