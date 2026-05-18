using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Timers;

namespace org.ohdsi.cdm.presentation.etl.Monitor
{
    class ChunkStateController : IDisposable
    {
        private readonly Timer _timer = new();
        private int _ckeckCount = 0;

        private int _chunkId;
        //private int _numberOfPartitions;
        

        private DateTime _previousLastModified = DateTime.MinValue;
        private int _previousCount = 0;
        private string _chunksSchema;

        public ChunkState State { get; private set; }

        public ChunkStateController(int chunkId, int numberOfPartitions)
        {
            _chunkId = chunkId;
            //_numberOfPartitions = numberOfPartitions;
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

        public void Dispose()
        {
            _timer.Dispose();
        }
    }
}