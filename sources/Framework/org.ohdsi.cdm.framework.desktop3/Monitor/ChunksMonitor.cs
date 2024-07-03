using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Settings = org.ohdsi.cdm.framework.desktop.Settings.Settings;

namespace org.ohdsi.cdm.framework.desktop3.Monitor
{
    public class ChunksMonitor : IDisposable
    {
        private int? _slicesNum = null;
        private Dictionary<int, ChunkMonitor> _chunks;
        private bool _completeAdding;

        public int InvalidCount { get; private set; }
        public int ValidCount { get; private set; }
        public int TotalCount { get; private set; }
        private Dictionary<int, Task> _local;

        private void Start(int chunkId)
        {
            if (_slicesNum != null)
                return;

            _local = [];

            _chunks = [];
            _slicesNum = GetSlicesNum(chunkId);
        }

        private void TryToRunLocal(ChunkMonitor c)
        {
            if (_local == null)
                return;

            var done = new List<int>();
            foreach (var chunkId in _local.Keys.ToArray())
            {
                if (_chunks[chunkId].State != ChunkState.Timeout && _chunks[chunkId].State != ChunkState.RunningLocal && _chunks[chunkId].State != ChunkState.Validating)
                    done.Add(chunkId);
            }

            foreach (var chunkId in done)
            {
                _local[chunkId].Wait();
                _local[chunkId].Dispose();
                _local.Remove(chunkId);
            }

            if (_local.Keys.Count < 3)
            {
                var local = c;

                var t = Task.Factory.StartNew(async () =>
                 {
                     Console.WriteLine($"*** {DateTime.Now.ToShortTimeString()} | TryToRunLocal | ChunkId {c.ChunkId} - START");
                     await local.TryToConvertLocal();
                     Console.WriteLine($"*** {DateTime.Now.ToShortTimeString()} | TryToRunLocal | ChunkId {c.ChunkId} {local.State} - DONE");
                 });
                _local.Add(c.ChunkId, t);
            }
        }

        public void CompleteAdding()
        {
            _completeAdding = true;

            Console.WriteLine($"*** CompleteAdding");
        }

        public bool TryAddChunk(int chunkId, string chunksSchema)
        {
            Start(chunkId);

            if (_chunks.ContainsKey(chunkId))
                return false;

            var chunk = new ChunkMonitor
            {
                ChunkId = chunkId,
                SlicesNum = _slicesNum.Value
            };
            chunk.Start(chunksSchema);
            _chunks.Add(chunkId, chunk);
            return true;
        }

        public Task Handle()
        {
            return Task.Run(() =>
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
                                case ChunkState.RunningLambda:
                                    runningCnt++;
                                    break;
                                case ChunkState.Timeout:
                                    TryToRunLocal(c);
                                    timeout++;
                                    break;
                                case ChunkState.RunningLocal:
                                    local++;
                                    break;
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
                            if (_local != null && _local.Values.Count > 0)
                                Task.WaitAll([.. _local.Values]);

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

        private static int GetSlicesNum(int chunkId)
        {
            var personDefinition = Settings.Current.Building.SourceQueryDefinitions.
                FirstOrDefault(sq => sq.Persons != null && common.Definitions.QueryDefinition.IsSuitable(sq.Query.Database, Settings.Current.Building.Vendor)) ?? throw new Exception("Error: personDefinition == null");
            var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/raw/{chunkId}/{personDefinition.FileName}/{personDefinition.FileName}";

            Console.WriteLine("Calculating slices num " + Settings.Current.Bucket + "|" + prefix);
            using var client = S3ClientFactory.CreateS3Client();

            var responseTask = client.ListObjectsV2Async(new ListObjectsV2Request
            {
                BucketName = Settings.Current.Bucket,
                Prefix = prefix
            });
            responseTask.Wait();

            Console.WriteLine("slices.Count=" + responseTask.Result.S3Objects.Count);
            return responseTask.Result.S3Objects.Count;
        }

        public void Dispose()
        {
            if (_chunks == null)
                return;

            foreach (var item in _chunks.Values)
            {
                item.Dispose();
            }

            GC.SuppressFinalize(this);
        }
    }
}
