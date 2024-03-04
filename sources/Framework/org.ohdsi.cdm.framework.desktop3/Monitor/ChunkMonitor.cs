using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Timers;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;
using Settings = org.ohdsi.cdm.framework.desktop.Settings.Settings;

namespace org.ohdsi.cdm.framework.desktop3.Monitor
{
    class ChunkMonitor : IDisposable
    {
        private readonly Timer _timer = new();
        private int _ckeckCount = 0;

        public int ChunkId { get; set; }
        public int SlicesNum { get; set; }
        public ChunkState State { get; set; }

        private DateTime _previousLastModified = DateTime.MinValue;
        private int _previousCount = 0;

        private readonly AmazonS3Config _config = new()
        {
            Timeout = TimeSpan.FromMinutes(60),
            RegionEndpoint = Amazon.RegionEndpoint.USEast1,
            BufferSize = 512 * 1024,
            MaxErrorRetry = 20
        };

        public void Start()
        {
            State = ChunkState.RunningLambda;

            _timer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            _timer.Interval = 300 * 1000;
            _timer.Enabled = true;

            Console.WriteLine($">  {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");
        }

        private void OnTimedEvent(object source, ElapsedEventArgs e)
        {
            try
            {
                _ckeckCount++;

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | Checking ChunkId={ChunkId}... (Attempt {_ckeckCount})");

                var lastModified = DateTime.MinValue;

                var count = 0;
                using (var client = new AmazonS3Client(Settings.Current.MessageS3AwsAccessKeyId, Settings.Current.MessageS3AwsSecretAccessKey, _config))
                {
                    var request = new ListObjectsV2Request
                    {
                        BucketName = Settings.Current.MessageBucket,
                        Prefix = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id.Value}.{ChunkId}."
                    };

                    Task<ListObjectsV2Response> task;

                    do
                    {
                        task = client.ListObjectsV2Async(request);
                        task.Wait();

                        count += task.Result.S3Objects.Count;
                        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {ChunkId} - not processed slices {task.Result.S3Objects.Count} | {request.Prefix}");
                        if (task.Result.S3Objects.Count == 0)
                        {
                            _timer.Enabled = false;
                            
                            Validate(false);
                            return;
                        }

                        foreach (var o in task.Result.S3Objects.OrderByDescending(o => o.LastModified))
                        {
                            if (o.LastModified > lastModified)
                                lastModified = o.LastModified;

                            break;
                        }

                        request.ContinuationToken = task.Result.NextContinuationToken;

                    } while (task.Result.IsTruncated);
                }

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} - {count} slices were not processed | PreviouLastModified={_previousLastModified.ToShortTimeString()} LastModified={lastModified.ToShortTimeString()} | {_previousCount} {count}");

                if (_ckeckCount >= 10 || _previousCount == count && _previousLastModified == lastModified)
                {
                    if (_ckeckCount >= 6)
                    {
                        _timer.Enabled = false;
                        State = ChunkState.Timeout;
                        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");
                        return;
                    }
                }

                _previousLastModified = lastModified;
                _previousCount = count;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | OnTimedEvent {ex.Message}");
                State = ChunkState.Error;
            }
        }

        public async Task TryToConvertLocal()
        {
            try
            {
                State = ChunkState.RunningLocal;
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");

                await Task.Run(() =>
                {
                    var removed = new List<string>();
                    foreach (var item in CleanUpS3())
                    {
                        removed.Add(item.Split('.')[3]);
                    }

                    RunLocal(removed);
                    Validate(false);
                });
            }
            catch (Exception e)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | TryToConvertLocal {e.Message}");
                State = ChunkState.Error;
            }
        }

        private void Validate(bool rerun)
        {
            try
            {
                var personsData = new Dictionary<long, List<string>>();

                State = ChunkState.Validating;
                
                var dbSource = new DbSource(Settings.Current.Building.SourceConnectionString, null, Settings.Current.Building.SourceSchemaName);
                foreach (var personId in dbSource.GetPersonIds(ChunkId))
                {
                    personsData.Add(personId, []);
                }

                var validation = new Validation();
                var objects = new List<S3Object>();
                foreach (var o in validation.GetObjects("PERSON", ChunkId, SlicesNum))
                {
                    objects.AddRange(o);
                }

                foreach (var o in validation.GetObjects("METADATA_TMP", ChunkId, SlicesNum))
                {
                    objects.AddRange(o);
                }
                var chunk = new KeyValuePair<int, Dictionary<long, List<string>>>(ChunkId, personsData);
                var wrongPersonIds = validation.ProcessChunk(objects, chunk, SlicesNum, true);

                if (wrongPersonIds.Keys.Count > 0)
                {
                    if (rerun)
                    {
                        State = ChunkState.Ivalid;
                    }
                    else
                    {
                        State = ChunkState.Ivalid;
                    }
                }
                else
                {
                    State = ChunkState.Valid;
                }
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | Validate {ex.Message}");
                State = ChunkState.Error;
            }
        }

        private List<string> CleanUpS3()
        {
            try
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} cleaning s3...");
                var removed = new List<string>();

                using (var client = new AmazonS3Client(Settings.Current.MessageS3AwsAccessKeyId, Settings.Current.MessageS3AwsSecretAccessKey, _config))
                {
                    var request = new ListObjectsV2Request
                    {
                        BucketName = Settings.Current.MessageBucket,
                        Prefix = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id.Value}.{ChunkId}."
                    };

                    Task<ListObjectsV2Response> getList;

                    getList = client.ListObjectsV2Async(request);
                    getList.Wait();

                    foreach (var item in getList.Result.S3Objects)
                    {
                        client.DeleteObjectAsync(new DeleteObjectRequest
                        {
                            BucketName = Settings.Current.MessageBucket,
                            Key = item.Key
                        }).Wait();
                        removed.Add(item.Key);
                    }
                }

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} cleaning s3 ({removed.Count} files removed). DONE.");
                return removed;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | CleanUpS3 {ex.Message}");
                State = ChunkState.Error;
                throw;
            }
        }

        private void RunLocal(List<string> slices)
        {
            try
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} run local. ({slices.Count} slices)");

                foreach (var prefix in slices)
                {
                    Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {Settings.Current.Building.Vendor} {Settings.Current.Building.Id.Value} {ChunkId} {prefix}");
                    ProcessChunkLocally(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, ChunkId, prefix, true);
                }

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} run local. DONE.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | RunLocal {ex.Message}");
                State = ChunkState.Error;
            }
        }

        private static string ProcessChunkLocally(Vendors vendor, int buildingId, int chunkId, string prefix, bool clean)
        {
            try
            {
                var arguments = $"{vendor} {buildingId} {chunkId} {prefix}";
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {Settings.Current.LocalPath} {arguments}");
                var psi = new ProcessStartInfo(Path.Combine(Settings.Current.LocalPath))
                {
                    Arguments = arguments
                };

                using (var p = Process.Start(psi))
                {
                    p.WaitForExit();
                    p.Close();
                }

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={chunkId};Prefix={prefix} - DONE");
                return $"chunkId={chunkId};prefix={prefix}";
            }
            catch (Exception e)
            {
                Console.WriteLine($"{DateTime.Now.ToShortTimeString()} | ChunkId={chunkId};Prefix={prefix} - ERROR | ProcessChunkLocally {e.Message}");

                return null;
            }
        }

        public void Dispose()
        {
            _timer.Dispose();
        }
    }
}