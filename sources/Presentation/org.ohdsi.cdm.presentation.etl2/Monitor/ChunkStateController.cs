using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Linq;
using System.Timers;

namespace org.ohdsi.cdm.presentation.etl.Monitor
{
    class ChunkStateController : IDisposable
    {
        private readonly Timer _timer = new();
        private int _ckeckCount = 0;

        private int _chunkId;
        private int _numberOfPartitions;
        

        private DateTime _previousLastModified = DateTime.MinValue;
        private int _previousCount = 0;
        private string _chunksSchema;

        public ChunkState State { get; private set; }

        public ChunkStateController(int chunkId, int numberOfPartitions)
        {
            _chunkId = chunkId;
            _numberOfPartitions = numberOfPartitions;
        }

        public void Start(string chunksSchema)
        {
            State = ChunkState.Running;

            _timer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            _timer.Interval = 300 * 1000;
            _timer.Enabled = true;

            Console.WriteLine($">  {DateTime.Now.ToShortTimeString()} | ChunkId={_chunkId} {State}");
            _chunksSchema = chunksSchema;
        }

        private void OnTimedEvent(object source, ElapsedEventArgs e)
        {
            try
            {
                _ckeckCount++;

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | Checking ChunkId={_chunkId}... (Attempt {_ckeckCount})");
                var lastModified = DateTime.MinValue;

                var prefix = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id.Value}.{_chunkId}.";
                // TODO: add message storage
                
                var client = CloudStorageHelper.GetTriggerBlobContainerClient();
                var info = CloudStorageHelper.GetObjectInfo(null, client, Settings.Current.CloudTriggerStorageName, prefix);

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {_chunkId} - not processed slices {info.Count()} | {prefix}");
                if (!info.Any())
                {
                    _timer.Enabled = false;

                    // TMP
                    State = ChunkState.Valid;
                    //Validate(false);
                    return;
                }

                lastModified = info.Select(i => i.Item2).Max();

                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={_chunkId} - {info.Count()} slices were not processed | PreviouLastModified={_previousLastModified.ToShortTimeString()} LastModified={lastModified.ToShortTimeString()} | {_previousCount} {info.Count()}");

                if (_ckeckCount >= 10 || _previousCount == info.Count() && _previousLastModified == lastModified)
                {
                    if (_ckeckCount >= 6)
                    {
                        _timer.Enabled = false;
                        State = ChunkState.Timeout;
                        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={_chunkId} {State}");
                        return;
                    }
                }

                _previousLastModified = lastModified;
                _previousCount = info.Count();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={_chunkId} ERROR | OnTimedEvent {ex.Message}");
                State = ChunkState.Error;
            }
        }

        //public async Task TryToConvertLocal()
        //{
        //    try
        //    {
        //        State = ChunkState.RunningLocal;
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");

        //        await Task.Run(() =>
        //        {
        //            var removed = new List<string>();
        //            foreach (var item in CleanUpS3())
        //            {
        //                removed.Add(item.Split('.')[3]);
        //            }

        //            RunLocal(removed);
        //            Validate(false);
        //        });
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | TryToConvertLocal {e.Message}");
        //        State = ChunkState.Error;
        //    }
        //}

        //private void Validate(bool rerun)
        //{
        //    try
        //    {
        //        var personsData = new Dictionary<long, List<string>>();

        //        State = ChunkState.Validating;

        //        var dbSource = new DbSource(Settings.Current.Building.SourceConnectionString, null, Settings.Current.Building.SourceSchemaName);
        //        foreach (var personId in dbSource.GetPersonIds(ChunkId, _chunksSchema))
        //        {
        //            personsData.Add(personId, []);
        //        }

        //        var validation = new Validation();
        //        var objects = new List<S3Object>();
        //        foreach (var o in validation.GetObjects("PERSON", ChunkId, SlicesNum))
        //        {
        //            objects.AddRange(o);
        //        }

        //        foreach (var o in validation.GetObjects("METADATA_TMP", ChunkId, SlicesNum))
        //        {
        //            objects.AddRange(o);
        //        }
        //        var chunk = new KeyValuePair<int, Dictionary<long, List<string>>>(ChunkId, personsData);
        //        var wrongPersonIds = validation.ProcessChunk(objects, chunk, SlicesNum, true);

        //        if (wrongPersonIds.Keys.Count > 0)
        //        {
        //            if (rerun)
        //            {
        //                State = ChunkState.Ivalid;
        //            }
        //            else
        //            {
        //                State = ChunkState.Ivalid;
        //            }
        //        }
        //        else
        //        {
        //            State = ChunkState.Valid;
        //        }
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} {State}");
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | Validate {ex.Message}");
        //        State = ChunkState.Error;
        //    }
        //}

        //private List<string> CleanUpS3()
        //{
        //    try
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} cleaning s3...");
        //        var removed = new List<string>();

        //        using (var client = new AmazonS3Client(Settings.Current.CloudStorageKey, Settings.Current.CloudStorageSecret, _config))
        //        {
        //            var request = new ListObjectsV2Request
        //            {
        //                BucketName = Settings.Current.CloudStorageName,
        //                Prefix = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id.Value}.{ChunkId}."
        //            };

        //            Task<ListObjectsV2Response> getList;

        //            getList = client.ListObjectsV2Async(request);
        //            getList.Wait();

        //            foreach (var item in getList.Result.S3Objects)
        //            {
        //                client.DeleteObjectAsync(new DeleteObjectRequest
        //                {
        //                    BucketName = Settings.Current.CloudStorageName,
        //                    Key = item.Key
        //                }).Wait();
        //                removed.Add(item.Key);
        //            }
        //        }

        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} cleaning s3 ({removed.Count} files removed). DONE.");
        //        return removed;
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | CleanUpS3 {ex.Message}");
        //        State = ChunkState.Error;
        //        throw;
        //    }
        //}

        //private void RunLocal(List<string> slices)
        //{
        //    try
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} run local. ({slices.Count} slices)");

        //        foreach (var prefix in slices)
        //        {
        //            Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {Settings.Current.Building.Vendor} {Settings.Current.Building.Id.Value} {ChunkId} {prefix}");
        //            ProcessChunkLocally(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, ChunkId, prefix, true);
        //        }

        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} run local. DONE.");
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={ChunkId} ERROR | RunLocal {ex.Message}");
        //        State = ChunkState.Error;
        //    }
        //}

        //private static string ProcessChunkLocally(Vendor vendor, int buildingId, int chunkId, string prefix, bool clean)
        //{
        //    try
        //    {
        //        var arguments = $"{vendor} {buildingId} {chunkId} {prefix}";
        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | {Settings.Current.LocalPath} {arguments}");
        //        var psi = new ProcessStartInfo(Path.Combine(Settings.Current.LocalPath))
        //        {
        //            Arguments = arguments
        //        };

        //        using (var p = Process.Start(psi))
        //        {
        //            p.WaitForExit();
        //            p.Close();
        //        }

        //        Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={chunkId};Prefix={prefix} - DONE");
        //        return $"chunkId={chunkId};prefix={prefix}";
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine($"{DateTime.Now.ToShortTimeString()} | ChunkId={chunkId};Prefix={prefix} - ERROR | ProcessChunkLocally {e.Message}");

        //        return null;
        //    }
        //}

        public void Dispose()
        {
            _timer.Dispose();
        }
    }
}