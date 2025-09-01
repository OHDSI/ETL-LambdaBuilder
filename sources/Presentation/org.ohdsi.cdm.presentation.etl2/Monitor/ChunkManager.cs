using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.etl.Monitor
{
    public class ChunkManager : IDisposable
    {
        public int InvalidCount { get; private set; }
        public int ValidCount { get; private set; }
        public int TotalCount { get; private set; }

        private Task _trackDownStates;
        private string _chunksSchema;
        private int _numberOfPartitions;
        private Dictionary<int, ChunkStateController> _chunks = new Dictionary<int, ChunkStateController>();
        private bool _completeAdding;

        public ChunkManager(string chunksSchema, int numberOfPartitions)
        {
            _chunksSchema = chunksSchema;
            _numberOfPartitions = numberOfPartitions;
        }

        public void CompleteAdding()
        {
            _completeAdding = true;

            Console.WriteLine($"*** CompleteAdding");
        }

        public void AddChunk(int chunkId)
        {
            if (_chunks.ContainsKey(chunkId))
                return;

            var chunk = new ChunkStateController(chunkId, _numberOfPartitions);
            chunk.Start(_chunksSchema);
            _chunks.Add(chunkId, chunk);

            if (_trackDownStates == null)
                TrackDownStates();
        }

        private void TrackDownStates()
        {
            _trackDownStates = Task.Run(() =>
            {
                try
                {
                    while (true)
                    {
                        var validCnt = 0;
                        var invalidCnt = 0;
                        var validatingCnt = 0;
                        var runningCnt = 0;
                        var error = 0;
                        var timeout = 0;
                        var local = 0;

                        foreach (var c in _chunks.Values.ToList())
                        {
                            switch (c.State)
                            {
                                case ChunkState.Running:
                                    runningCnt++;
                                    break;
                                case ChunkState.Timeout:
                                    //TryToRunLocal(c);
                                    timeout++;
                                    break;
                                //case ChunkState.RunningLocal:
                                //    local++;
                                //    break;
                                case ChunkState.Validating:
                                    validatingCnt++;
                                    break;
                                case ChunkState.Valid:
                                    validCnt++;
                                    break;
                                case ChunkState.Ivalid:
                                    invalidCnt++;
                                    break;
                                case ChunkState.Error:
                                    error++;
                                    break;
                                default:
                                    break;
                            }
                        }

                        Console.WriteLine($"*** {DateTime.Now.ToShortTimeString()} | Running: lambda {runningCnt} local {local}; Validating {validatingCnt}; Valid {validCnt}; Timeout {timeout}; Invalid {invalidCnt}; Error {error}; Total {_chunks.Values.Count}");

                        ValidCount = validCnt;
                        InvalidCount = invalidCnt;
                        TotalCount = _chunks.Values.Count;

                        if (_completeAdding && error + validCnt + invalidCnt == _chunks.Values.Count)
                        {
                            Console.WriteLine($"*** {DateTime.Now.ToShortTimeString()} | ChunksMonitor - DONE");
                            return;
                        }

                        Thread.Sleep(TimeSpan.FromMinutes(1));
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    throw;
                }

            });
        }

        public void AwaitingCompletion()
        {
            _trackDownStates.Wait();
        }

        public void Dispose()
        {
            foreach (var item in _chunks.Values)
            {
                item.Dispose();
            }

            _trackDownStates.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}