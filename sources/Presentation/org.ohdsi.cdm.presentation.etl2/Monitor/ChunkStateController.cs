using org.ohdsi.cdm.framework.Common.Utility.Validation;
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
        private readonly int _chunkId;
        private DateTime _previousLastModified = DateTime.MinValue;
        private int _previousCount = 0;

        public ChunkState State { get; private set; }

        public ChunkStateController(int chunkId)
        {
            _chunkId = chunkId;
        }

        public void Start()
        {
            State = ChunkState.Running;

            _timer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            _timer.Interval = 300 * 1000;
            _timer.Enabled = true;

            Console.WriteLine($">  {DateTime.Now:t} | ChunkId={_chunkId} {State}");
        }

        private void OnTimedEvent(object source, ElapsedEventArgs e)
        {
            try
            {
                _ckeckCount++;

                Console.WriteLine($"> {DateTime.Now:t} | Checking ChunkId={_chunkId}... (Attempt {_ckeckCount})");
                var lastModified = DateTime.MinValue;

                var prefix = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id.Value}.{_chunkId}.";
                
                var info = CloudStorageHelper.GetTriggerFilesInfo(prefix);
                if (info == null || !info.Any())
                {
                    _timer.Enabled = false;
                    
                    Validate();
                    return;
                }

                Console.WriteLine($"> {DateTime.Now:t} | {_chunkId} - not processed slices {info.Count()} | {prefix}");

                lastModified = info.Select(i => i.Item2).Max();

                Console.WriteLine($"> {DateTime.Now:t} | ChunkId={_chunkId} - {info.Count()} slices were not processed | PreviouLastModified={_previousLastModified:t} LastModified={lastModified:t} | {_previousCount} {info.Count()}");

                if (_ckeckCount >= 10 || _previousCount == info.Count() && _previousLastModified == lastModified)
                {
                    if (_ckeckCount >= 6)
                    {
                        _timer.Enabled = false;
                        State = ChunkState.Timeout;
                        Console.WriteLine($"> {DateTime.Now:t} | ChunkId={_chunkId} {State}");
                        return;
                    }
                }

                _previousLastModified = lastModified;
                _previousCount = info.Count();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now:t} | ChunkId={_chunkId} ERROR | OnTimedEvent {ex.Message}");
                State = ChunkState.Error;
            }
        }
        private void Validate()
        {
            State = ChunkState.Validating;
            try
            {
                var validation = new Validation(Settings.Current.CloudStorageKey,
                    Settings.Current.CloudStorageSecret,
                    Settings.Current.CloudStorageName,
                    Settings.Current.CDMFolder);

                var result = validation.ValidateBuildingId(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, [_chunkId]);

                if (result.ChunkResults[0].IsValid)
                {
                    State = ChunkState.Invalid;
                }
                else
                {
                    State = ChunkState.Valid;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"> {DateTime.Now.ToShortTimeString()} | ChunkId={_chunkId} ERROR | Validate {ex.Message}");
                State = ChunkState.Error;
            }
        }

        public void Dispose()
        {
            _timer.Dispose();
        }
    }
}