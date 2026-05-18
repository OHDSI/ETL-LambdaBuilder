using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using System.Diagnostics;

namespace org.ohdsi.cdm.framework.desktop.Base
{
    public class DatabaseChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder) : IChunkBuilder
    {
        #region Variables

        private readonly int _chunkId = chunkId;
        private readonly Func<IPersonBuilder> _createPersonBuilder = createPersonBuilder;

        #endregion
        #region Constructors
        #endregion

        #region Methods

        public void Process()
        {
            try
            {
                Console.WriteLine("DatabaseChunkBuilder");
                var dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
                var part = new DatabaseChunkPart(_chunkId, _createPersonBuilder, "0", 0);

                var timer = new Stopwatch();
                timer.Start();

                part.Load();
                //Logger.Write(_chunkId, LogMessageTypes.Info,
                //    $"Loaded - {timer.ElapsedMilliseconds} ms | {(GC.GetTotalMemory(false) / 1024f) / 1024f} Mb");

                Console.WriteLine($"Loaded - {timer.ElapsedMilliseconds} ms | {(GC.GetTotalMemory(false) / 1024f) / 1024f} Mb");

                part.Build();
                part.Save();

                dbChunk.ChunkComplete(_chunkId, Settings.Settings.Current.Building.Id.Value);
                Console.WriteLine($"ChunkId={_chunkId} was complete");
            }
            catch (Exception e)
            {
                //Logger.WriteError(_chunkId, e);
                Console.WriteLine(Logger.CreateExceptionString(e));

                throw;
            }
        }
        #endregion
    }
}
