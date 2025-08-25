using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.etl.Transformation.OptumPanther;
using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Amazon.Lambda.S3Events.S3Event;


// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace org.ohdsi.cdm.presentation.lambdamerge
{
    public class Function
    {
        IAmazonS3 S3Client { get; set; }
        private bool _attemptFileRemoved;

        private Settings _settings;
        private string _table = "";
        private int _subChunkId;
        private int _versionId;

        private double _timeOut;
        private Stopwatch _timer;
        private S3Entity _s3Event;
        private int? _lastSavedChunkId;
        private int? _lastSavedIndex;
        private long? _lastSavedId;
        //private int _rowGroupSize;
        private bool _chunkComplete;
        private const string EtlLibraryPath = "/opt";

        public Function()
        {
            Console.WriteLine("ctor 1");
            S3Client = new AmazonS3Client();
        }

        public Function(IAmazonS3 s3Client)
        {
            Console.WriteLine("ctor 2");
            this.S3Client = s3Client;
        }


        public async Task<string> FunctionHandler(S3Event evnt, ILambdaContext context)
        {
            Console.WriteLine("Start");

            _lastSavedChunkId = null;
            _lastSavedIndex = null;
            _lastSavedId = null;
            _attemptFileRemoved = false;
            _chunkComplete = false;

            _s3Event = evnt.Records?[0].S3;
            if (_s3Event == null)
            {
                return null;
            }

            _timer = new Stopwatch();

            _settings = new Settings
            {
                Bucket = Environment.GetEnvironmentVariable("Bucket"),
                AwsAccessKeyId = Environment.GetEnvironmentVariable("S3AwsAccessKeyId"),
                AwsSecretAccessKey = Environment.GetEnvironmentVariable("S3AwsSecretAccessKey"),
                CdmFolder = Environment.GetEnvironmentVariable("CDMFolder"),
                ResultFolder = Environment.GetEnvironmentVariable("ResultFolder"),
            };

            //var saveSize = int.Parse(Environment.GetEnvironmentVariable("SaveSize"));
            //_rowGroupSize = int.Parse(Environment.GetEnvironmentVariable("RowGroupSize"));

            GetRestorePoint();

            try
            {
                var vendorName = _s3Event.Object.Key.Split('.')[0].Split('/').Last();
                _settings.Vendor = EtlLibrary.CreateVendorInstance(EtlLibraryPath, vendorName);
                _settings.BuildingId = int.Parse(_s3Event.Object.Key.Split('.')[1]);
                _table = _s3Event.Object.Key.Split('.')[2].Trim();
                _subChunkId = int.Parse(_s3Event.Object.Key.Split('.')[3]);
                _versionId = 0;
                if (_s3Event.Object.Key.Split('.').Length > 4)
                {
                    int.TryParse(_s3Event.Object.Key.Split('.')[4], out _versionId);
                }

                _timeOut = context.RemainingTime.TotalSeconds / 2;
                //_timeOut = 300;

                Console.WriteLine(
                    $"_versionId={_versionId};vendor={_settings.Vendor};buildingId={_settings.BuildingId};subChunkId={_subChunkId};cdmFolder={_settings.CdmFolder};resultFolder={_settings.ResultFolder};");
                Console.WriteLine(
                    $"timeOut={_timeOut}s;lastSavedChunkId={_lastSavedChunkId};lastSavedIndex={_lastSavedIndex};_lastSavedId={_lastSavedId};");

                _timer.Start();

                if (_table.Equals("fact_relationship", StringComparison.CurrentCultureIgnoreCase))
                {
                    SaveFactRelationship();
                }
                else if (_table.Equals("metadata", StringComparison.CurrentCultureIgnoreCase))
                {
                    SaveMetadata();
                }
                else if (_table.Equals("cdm_source", StringComparison.CurrentCultureIgnoreCase))
                {
                    SaveCdmSource();
                }
                else if (_table.Equals("_version", StringComparison.CurrentCultureIgnoreCase))
                {
                    SaveVersion();
                }

                RemoveAttemptFile();
                GC.Collect();

                _timer.Stop();

                return "Done";

            }
            catch (Exception e)
            {
                context.Logger.LogLine($"Error getting object {_s3Event.Object.Key} from bucket {_s3Event.Bucket.Name}. Make sure they exist and your bucket is in the same region as this function.");
                context.Logger.LogLine(e.Message);
                context.Logger.LogLine(e.StackTrace);
                throw;
            }
        }

        public async Task<string> FunctionHandler2(S3Event evnt, ILambdaContext context)
        {
            Console.WriteLine("Start");
            _lastSavedChunkId = null;
            _lastSavedIndex = null;
            _attemptFileRemoved = false;
            _chunkComplete = false;

            _timer = new Stopwatch();

            _settings = new Settings
            {
                Bucket = "",
                AwsAccessKeyId = "",
                AwsSecretAccessKey = "",
                CdmFolder = "cdmAPS",
                ResultFolder = "cdmSpectrum",
            };

            //_rowGroupSize = 250000;

            _settings.Vendor = new OptumPantherPersonBuilder.OptumPantherVendor(); //EnumsEtl.OptumPantherFull()
            _settings.BuildingId = 5230;
            _table = "metadata";
            _subChunkId = 0;
            _versionId = 0;

            SaveMetadata();

            return "Done";
        }

        private void SaveCdmSource()
        {
            var cdm = _settings.Vendor.CdmVersion;

            if (cdm == CdmVersions.V54)
            {
                var reader = new CdmSourceDataReader54();
                using var stream = framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
                SaveToS3(stream, 0, _settings.CdmFolder, _table, "gz");
            }
            else
            {
                var reader = new CdmSourceDataReader();
                using var stream = framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
                SaveToS3(stream, 0, _settings.CdmFolder, _table, "gz");
            }
        }

        private void SaveMetadata()
        {
            var mergeMetadata = new MergeMetadata(_settings, _versionId);
            mergeMetadata.Start();
            using var stream = mergeMetadata.GetMetadataCsvStream();
            SaveToS3(stream, 0, _settings.CdmFolder, _table, "gz");
        }

        private void SaveVersion()
        {
            var reader = new VersionDataReader(_versionId);
            using var stream = framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
            SaveToS3(stream, 0, _settings.CdmFolder, _table, "gz");
        }

        private void SaveFactRelationship()
        {
            var mergeFactRelationship = new MergeFactRelationship(_settings);

            using var stream = mergeFactRelationship.GetFactRelationshipCsvStream();
            SaveToS3(stream, 0, _settings.CdmFolder, _table, "gz");
        }

        private void SaveToS3(Stream memoryStream, int index, string folder, string table, string extension)
        {
            if (memoryStream == null)
                return;

            var timer = new Stopwatch();
            timer.Start();

            Console.WriteLine($"{table}.{index} size={memoryStream.Length / 1024f / 1024f}Mb | Saving...");
            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                BufferSize = 512 * 1024,
                MaxErrorRetry = 20
            };

            var fileName = $"{table}/{table}.{_subChunkId}.{index}.{extension}";
            using (var c = new AmazonS3Client(_settings.AwsAccessKeyId,
                _settings.AwsSecretAccessKey,
                config))
            {
                var putObject = c.PutObjectAsync(new PutObjectRequest
                {
                    BucketName = $"{_settings.Bucket}",
                    Key = $"{_settings.Vendor}/{_settings.BuildingId}/{folder}/{fileName}",
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                    StorageClass = S3StorageClass.Standard,
                    InputStream = memoryStream,
                    AutoCloseStream = false
                });
                putObject.Wait();

                var response = putObject.Result;

                if (string.IsNullOrEmpty(response.ETag))
                {
                    Console.WriteLine("!!! PutObject response is empty !!! | " + fileName);
                    throw new Exception("PutObject response.ETag is empty");
                }
            }
            timer.Stop();
            Console.WriteLine($"{table}.{index} SAVED | {timer.ElapsedMilliseconds}ms");
            _lastSavedIndex = index;

            if (_timer.Elapsed.TotalSeconds > _timeOut && _chunkComplete)
            {
                Console.WriteLine("time out, _chunkComplete=" + _chunkComplete);
                RemoveAttemptFile();
                CreateAttemptFile();
            }
        }

        private bool GetRestorePoint()
        {
            var attempt = 0;
            while (true)
            {
                try
                {
                    attempt++;
                    var msg = new StringBuilder();
                    var timer = new Stopwatch();
                    timer.Start();
                    using (var transferUtility = new TransferUtility(this.S3Client))
                    using (var responseStream = transferUtility.OpenStream(_s3Event.Bucket.Name, _s3Event.Object.Key))
                    using (var reader = new StreamReader(responseStream))
                    {
                        string line;
                        while ((line = reader.ReadLine()) != null)
                        {
                            _lastSavedChunkId = int.Parse(line.Split(';')[0]);
                            _lastSavedIndex = int.Parse(line.Split(';')[1]);
                            _lastSavedId = long.Parse(line.Split(';')[2]);

                            msg.Append($"{_lastSavedChunkId};{_lastSavedIndex};{_lastSavedId}");
                        }
                    }

                    timer.Stop();
                    Console.WriteLine("Restore point:" + msg + " | " + timer.ElapsedMilliseconds + "ms");
                    return true;
                }
                catch (Exception e)
                {
                    if (attempt > 5)
                    {
                        Console.WriteLine($"WARN_EXC - GetRestorePoint [{_s3Event.Object.Key}]");
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        throw;
                    }
                }
            }
        }

        private bool CreateAttemptFile()
        {
            if (!_attemptFileRemoved)
                return false;

            var attempt = 0;
            var key = _s3Event.Object.Key;

            while (true)
            {
                try
                {
                    attempt++;

                    using (var memoryStream = new MemoryStream())
                    using (var writer = new StreamWriter(memoryStream))
                    using (var tu = new TransferUtility(this.S3Client))
                    {

                        writer.WriteLine($"{_lastSavedChunkId};{_lastSavedIndex};{_lastSavedId}");
                        writer.Flush();
                        tu.Upload(memoryStream, _s3Event.Bucket.Name, key);
                    }

                    Console.WriteLine($"Attempt file was created - {key} | attempt={attempt} | {_lastSavedChunkId};{_lastSavedIndex};{_lastSavedId}");

                    return true;
                }
                catch (Exception e)
                {
                    if (attempt > 5)
                    {
                        Console.WriteLine($"WARN_EXC - Can't create new attempt [{key}]");
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        return false;
                    }
                }
            }
        }


        private bool RemoveAttemptFile()
        {
            if (_attemptFileRemoved)
                return true;

            var attempt = 0;
            var key = _s3Event.Object.Key;

            Console.WriteLine(_s3Event.Bucket.Name + "." + key);

            while (true)
            {
                try
                {
                    attempt++;
                    var task = this.S3Client.DeleteObjectAsync(new DeleteObjectRequest
                    {
                        BucketName = _s3Event.Bucket.Name,
                        Key = key
                    });
                    task.Wait();

                    Console.WriteLine($"Attempt file was removed - {key} | attempt={attempt}");
                    _attemptFileRemoved = true;
                    return true;
                }
                catch (Exception e)
                {
                    if (attempt > 5)
                    {
                        Console.WriteLine($"WARN_EXC - Can't remove [{key}]");
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        return false;
                    }
                }
            }
        }
    }
}