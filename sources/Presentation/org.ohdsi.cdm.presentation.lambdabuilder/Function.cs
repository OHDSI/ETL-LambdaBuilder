using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.etl.Transformation.CDM;
using org.ohdsi.cdm.framework.etl.Transformation.CPRD;
using org.ohdsi.cdm.framework.etl.Transformation.CprdAurum;
using org.ohdsi.cdm.framework.etl.Transformation.CprdHES;
using org.ohdsi.cdm.framework.etl.Transformation.Era;
using org.ohdsi.cdm.framework.etl.Transformation.HealthVerity;
using org.ohdsi.cdm.framework.etl.Transformation.JMDC;
using org.ohdsi.cdm.framework.etl.Transformation.OptumExtended;
using org.ohdsi.cdm.framework.etl.Transformation.OptumPanther;
using org.ohdsi.cdm.framework.etl.Transformation.PA;
using org.ohdsi.cdm.framework.etl.Transformation.Premier;
using org.ohdsi.cdm.framework.etl.Transformation.Truven;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.presentation.lambdabuilder.Base;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using static Amazon.Lambda.S3Events.S3Event;
using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Function
    {
        IAmazonS3 S3Client { get; set; }
        private Vocabulary _vocabulary;
        private bool _attemptFileRemoved;
        private long? _lastSavedPersonIdOutput;
        private Dictionary<string, long> _restorePoint = [];
        private int _chunkId;
        private string _prefix;
        private static string _tmpFolder = null;

        public static string TmpFolder
        {
            get
            {
                if (string.IsNullOrEmpty(_tmpFolder))
                    return "/tmp";

                return $"/tmp/{_tmpFolder}";
            }
        }

        /// <summary>
        /// Default constructor. This constructor is used by Lambda to construct the instance. When invoked in a Lambda environment
        /// the AWS credentials will come from the IAM role associated with the function and the AWS region will be set to the
        /// region the Lambda function is executed in.
        /// </summary>
        public Function()
        {
            S3Client = new AmazonS3Client();
            Console.WriteLine("ctor 1");
        }

        /// <summary>
        /// Constructs an instance with a preconfigured S3 client. This can be used for testing the outside of the Lambda environment.
        /// </summary>
        /// <param name="s3Client"></param>
        public Function(IAmazonS3 s3Client)
        {
            this.S3Client = s3Client;
            Console.WriteLine("ctor 2");
        }

        public void Initialize()
        {
            Settings.Current.Started = DateTime.Now;
            Settings.Current.Error = false;

            _attemptFileRemoved = false;
            _lastSavedPersonIdOutput = null;
            _restorePoint.Clear();

            Settings.Current.Building.Vendor.SourceReleaseDate = GetSourceReleaseDate();

            if (_vocabulary != null && _vocabulary.Vendor == Settings.Current.Building.Vendor) return;
            try
            {
                var timer = new Stopwatch();
                timer.Start();
                _vocabulary = new Vocabulary(Settings.Current.Building.Vendor);
                _vocabulary.Fill(false, false);
                timer.Stop();

                Console.WriteLine("Vocabulary initialized for " + Settings.Current.Building.Vendor + " | " +
                                  timer.ElapsedMilliseconds + "ms");
            }
            catch (Exception)
            {
                _vocabulary = null;
                throw;
            }
        }

        public async Task<string> FunctionHandler2(string s3AwsAccessKeyId, string s3AwsSecretAccessKey, string bucket, string folder, Vendor vendor, int buildingId, int chunkId, string prefix,
            int attempt)
        {
            Dictionary<string, long> restorePoint = null;

            while (true)
            {
                try
                {

                    if (attempt > 55)
                    {
                        Console.WriteLine("Too many attempts");
                        return null;
                    }

                    Settings.Current.S3AwsAccessKeyId = s3AwsAccessKeyId;
                    Settings.Current.S3AwsSecretAccessKey = s3AwsSecretAccessKey;
                    Settings.Current.Bucket = bucket;
                    Settings.Current.CDMFolder = folder;

                    Settings.Initialize(buildingId, vendor, false);

                    Settings.Current.TimeoutValue = 180000;
                    Settings.Current.WatchdogValue = 100000 * 1000;
                    Settings.Current.MinPersonToBuild = 100;
                    Settings.Current.MinPersonToSave = 100;

                    _prefix = prefix;
                    _chunkId = chunkId;

                    _tmpFolder = buildingId + "_" + _chunkId + "_" + _prefix;

                    Console.WriteLine(
                        $"s3AwsAccessKeyId={s3AwsAccessKeyId};S3AwsSecretAccessKey={s3AwsSecretAccessKey};bucket={bucket};folder={folder};");
                    Console.WriteLine(
                        $"vendor={vendor};buildingId={buildingId};chunkId={chunkId};prefix={prefix};attempt={attempt}");
                    Console.WriteLine(
                        $"tmpFolder={_tmpFolder}");

                    Initialize();

                    if (restorePoint != null)
                    {
                        _restorePoint = restorePoint;
                    }

                    _vocabulary.Attach(_vocabulary);

                    CleanupTmp();
                    var chunkBuilder = new LambdaChunkBuilder(CreatePersonBuilder, _tmpFolder);
                    _lastSavedPersonIdOutput = chunkBuilder.Process(chunkId, prefix, _restorePoint, attempt);

                    _vocabulary.Attach(null);
                    chunkBuilder = null;
                    _vocabulary = null;
                    if (this.S3Client != null)
                    {
                        this.S3Client.Dispose();
                        this.S3Client = null;
                    }

                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                    GC.Collect();

                    MoveToS3(0);
                    Console.WriteLine("DONE");
                    return "done";
                }
                catch (Exception e)
                {
                    MoveToS3(0);
                    attempt++;
                    Console.WriteLine();
                    Console.WriteLine(e.Message);
                    Console.WriteLine("Attempt: " + attempt);
                    Console.WriteLine();
                    restorePoint = new Dictionary<string, long>(_restorePoint);
                }
            }
        }

        private static DateTime? GetSourceReleaseDate()
        {
            try
            {
                var key = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}/CDM_SOURCE/CDM_SOURCE.0.0.gz";
                
                Console.Write("GetSourceReleaseDate: " + key);

                using var transferUtility = new TransferUtility(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1);
                using var responseStream = transferUtility.OpenStream(Settings.Current.Bucket, key);
                using var bufferedStream = new BufferedStream(responseStream);
                using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                using var reader = new StreamReader(gzipStream, Encoding.Default);
                using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    HasHeaderRecord = false,
                    Delimiter = ",",
                    Encoding = Encoding.UTF8,
                    BadDataFound = null
                });

                while (csv.Read())
                {
                    var dateString = csv.GetField(6);
                    Console.Write("GetSourceReleaseDate: " + dateString);
                    return DateTime.Parse(dateString);
                }
            }
            catch (Exception ex)
            {
                Console.Write("GetSourceReleaseDate: " + ex.Message);
                return null;
            }

            return null;
        }

        /// <summary>
        /// This method is called for every Lambda invocation. This method takes in an S3 event object and can be used 
        /// to respond to S3 notifications.
        /// </summary>
        /// <param name="evnt"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task<string> FunctionHandler(S3Event evnt, ILambdaContext context)
        {
            //return null;
            var s3Event = evnt.Records?[0].S3;
            if (s3Event == null)
            {
                return null;
            }

            _chunkId = 0;
            _prefix = string.Empty;
            int buildingId = 0;
            int attempt = 0;
            var getRestorePointDone = false;
            Vendor vendor;

            try
            {
                // 0         1        2       3      4      5
                //vendor.buildingId.chunkId.prefix.attempt.txt
                
                var vendorName = s3Event.Object.Key.Split('.')[0].Split('/').Last();
                vendor = Vendor.CreateVendorInstanceByName(vendorName);

                buildingId = int.Parse(s3Event.Object.Key.Split('.')[1]);
                _chunkId = int.Parse(s3Event.Object.Key.Split('.')[2]);
                _prefix = s3Event.Object.Key.Split('.')[3].Trim();

                if (s3Event.Object.Key.Split('.').Length == 6)
                {
                    attempt = int.Parse(s3Event.Object.Key.Split('.')[4]);
                }

                Settings.Initialize(buildingId, vendor);

                //Settings.Current.TimeoutValue = 150; // TMP
                Settings.Current.TimeoutValue = 600; // TMP

                //if (context.RemainingTime.TotalSeconds >= 500)
                //    Settings.Current.TimeoutValue = context.RemainingTime.TotalSeconds - 120;
                //else if (context.RemainingTime.TotalSeconds >= 300)
                //    Settings.Current.TimeoutValue = context.RemainingTime.TotalSeconds - 100;
                //else
                //    Settings.Current.TimeoutValue =
                //        context.RemainingTime.TotalSeconds - context.RemainingTime.TotalSeconds / 100 * 30;

                Settings.Current.WatchdogValue = 30 * 1000;
                Settings.Current.MinPersonToBuild = 100;
                Settings.Current.MinPersonToSave = 100;

                Settings.Current.S3AwsAccessKeyId = Environment.GetEnvironmentVariable("S3AwsAccessKeyId");
                Settings.Current.S3AwsSecretAccessKey = Environment.GetEnvironmentVariable("S3AwsSecretAccessKey");
                Settings.Current.Bucket = Environment.GetEnvironmentVariable("Bucket");
                Settings.Current.CDMFolder = Environment.GetEnvironmentVariable("CDMFolder");

                ServicePointManager.DefaultConnectionLimit = Int32.MaxValue;

                //TODO different behavior(num of subChunks 256, 31...)
                if (attempt > 15) // TMP was 10
                {
                    return null;
                }

                Console.WriteLine($"vendor={vendor};buildingId={buildingId};chunkId={_chunkId};prefix={_prefix};attempt={attempt}");
                Console.WriteLine($"Bucket={Settings.Current.Bucket};CDMFolder={Settings.Current.CDMFolder};");
                Console.WriteLine($"RemainingTime={context.RemainingTime.TotalSeconds}s;TimeoutValue={Settings.Current.TimeoutValue}s;WatchdogValue={Settings.Current.WatchdogValue}ms;MinPersonToBuild={Settings.Current.MinPersonToBuild}; MinPersonToSave={Settings.Current.MinPersonToSave}");

                Initialize();

                getRestorePointDone = GetRestorePoint(s3Event);

                if (!getRestorePointDone)
                    throw new Exception("GetRestorePoint error");

                _vocabulary.Attach(_vocabulary);

                CleanupTmp();

                var chunkBuilder = new LambdaChunkBuilder(CreatePersonBuilder, _tmpFolder);
                var attempt1 = attempt;

                _lastSavedPersonIdOutput = chunkBuilder.Process(s3Event.Object.Key, _restorePoint);

                var totalPersonConverted = chunkBuilder.TotalPersonConverted;
                try
                {
                    if (Settings.Current.Building.Vendor is OptumPantherPersonBuilder.OptumPantherVendor ||
                        Settings.Current.Building.Vendor is OptumExtendedPersonBuilder.OptumExtendedDODVendor ||
                        Settings.Current.Building.Vendor is OptumExtendedPersonBuilder.OptumExtendedSESVendor)
                    {
                        _vocabulary.Attach(null);
                        chunkBuilder = null;
                        _vocabulary = null;

                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                        GC.Collect();
                    }

                    MoveToS3(attempt);
                }
                catch (Exception e)
                {
                    Console.WriteLine("error: " + CreateExceptionString(e));
                    _restorePoint.Clear();
                    return "failed";
                }

                RemoveAttemptFile(s3Event);

                if (_lastSavedPersonIdOutput.HasValue && totalPersonConverted > 0)
                {
                    attempt++;
                    CreateAttemptFile(s3Event, _chunkId, _prefix, attempt);

                    Console.WriteLine(
                        $"chunkId={_chunkId};prefix={_prefix} - FINISHED by timeout on PersonId={_lastSavedPersonIdOutput.Value}");
                    return "done";
                }

                Console.WriteLine($"chunkId={_chunkId};prefix={_prefix} - FINISHED, {s3Event.Object.Key} - removed");

                return "done";
            }
            catch (Exception e)
            {
                Console.WriteLine("error: " + CreateExceptionString(e));
                _restorePoint.Clear();
                return "failed";
            }
        }

        private static void CleanupTmp()
        {
            var cnt = 0;
            var timer = new Stopwatch();
            timer.Start();

            if (Directory.Exists($@"{TmpFolder}/raw/"))
            {
                foreach (var file in Directory.GetFiles($@"{TmpFolder}/", "*.txt.gz"))
                {
                    File.Delete(file);
                    cnt++;
                }

                foreach (var file in Directory.GetFiles($@"{TmpFolder}/raw/", "*.gz"))
                {
                    File.Delete(file);
                }

                foreach (var file in Directory.GetFiles($@"{TmpFolder}/raw/", "*.parquet"))
                {
                    File.Delete(file);
                }
            }

            timer.Stop();
            Console.WriteLine($"{cnt} tmp files were deleted | {timer.ElapsedMilliseconds}ms");
        }

        private void MoveToS3(int conversionAttempt)
        {
            //// Only for EHR
            //return;
            Console.WriteLine("Moving to s3...");

            if (Directory.Exists($@"{TmpFolder}/raw/"))
            {
                System.GC.Collect();
                System.GC.WaitForPendingFinalizers();
                foreach (var file in Directory.GetFiles($@"{TmpFolder}/raw/", "*.gz"))
                {
                    File.Delete(file);
                }
            }
            Console.WriteLine("raw tmp was cleaned");

            var files = GetFiles();

            var timer = new Stopwatch();
            foreach (var table in files.Keys)
            {
                if (table.Contains("person", StringComparison.CurrentCultureIgnoreCase))
                    continue;

                MoveTableToS3(timer, files, table, conversionAttempt);
            }

            foreach (var table in files.Keys)
            {
                if (!table.Contains("person", StringComparison.CurrentCultureIgnoreCase))
                    continue;

                MoveTableToS3(timer, files, table, conversionAttempt);
            }

            timer.Stop();
            Console.WriteLine($"merged and saved to S3 | {timer.ElapsedMilliseconds}ms");
        }

        private static void MoveTableToS3(Stopwatch timer, Dictionary<string, List<string>> files, string table, int conversionAttempt)
        {
            GC.Collect();

            timer.Restart();
            var index = 0;
            foreach (var tuple in GetStream(files, table))
            {
                var processedFiles = tuple.Item1;
                using (var outputStream = tuple.Item2)
                {
                    var fileName = GenerateFileName(table, processedFiles, index, conversionAttempt);

                    var attempt = 0;
                    while (true)
                    {
                        try
                        {
                            attempt++;

                            outputStream.Position = 0;
                            SaveToS3(outputStream, fileName);
                            timer.Stop();
                            Console.WriteLine(
                                $"{fileName} - was saved to S3, {timer.ElapsedMilliseconds}ms | {processedFiles.Count} files were merged");
                            index++;

                            break;
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine("MoveToS3 attempt=" + attempt);
                            if (attempt > 3)
                            {
                                Console.WriteLine("WARN_EXC - MoveToS3 - throw");
                                Console.WriteLine(CreateExceptionString(e));
                                throw;
                            }
                        }
                    }
                }

                GC.Collect();
            }

            int cnt = 0;
            if (Directory.Exists(@$"{TmpFolder}/"))
            {
                foreach (var file in Directory.GetFiles(@$"{TmpFolder}/", "*.gz"))
                {
                    if (!file.Contains($"/{table}."))
                        continue;

                    File.Delete(file);
                    cnt++;
                }
            }

            Console.WriteLine($"{TmpFolder}/raw/{table}/ - {cnt} - tmp files were removed");
        }

        public static string CreateExceptionString(Exception e)
        {
            var sb = new StringBuilder();
            CreateExceptionString(sb, e, string.Empty);

            return sb.ToString();
        }

        private static void CreateExceptionString(StringBuilder sb, Exception e, string indent)
        {
            if (indent == null)
            {
                indent = string.Empty;
            }
            else if (indent.Length > 0)
            {
                sb.AppendFormat("{0}Inner ", indent);
            }

            sb.AppendFormat("Exception Found:\n{0}Type: {1}", indent, e.GetType().FullName);
            sb.AppendFormat("\n{0}Message: {1}", indent, e.Message);
            sb.AppendFormat("\n{0}Source: {1}", indent, e.Source);
            sb.AppendFormat("\n{0}Stacktrace: {1}", indent, e.StackTrace);

            if (e.InnerException != null)
            {
                sb.Append('\n');
                CreateExceptionString(sb, e.InnerException, indent + "  ");
            }
        }

        private Dictionary<string, List<string>> GetFiles()
        {
            var files = new Dictionary<string, List<string>>();
            var pId = int.Parse(_prefix);
            var filteredFiles = Directory.GetFiles($@"{TmpFolder}/", "*.*")
                .Where(file => file.ToLower().EndsWith("txt.gz") || file.ToLower().EndsWith("parquet")).ToList();

            foreach (var file in filteredFiles)
            {
                var parts = file.Split('.');
                var tableName = parts[0].Replace($"{TmpFolder}/", "");
                var chunkId = int.Parse(parts[1]);
                var prefix = int.Parse(parts[2]);

                if (chunkId != _chunkId || prefix != pId)
                {
                    Console.WriteLine("skipped, file=" + file);
                    continue;
                }

                if (!files.ContainsKey(tableName))
                    files.Add(tableName, []);

                files[tableName].Add(file);
            }

            return files;
        }

        private static IEnumerable<Tuple<List<string>, MemoryStream>> GetStream(Dictionary<string, List<string>> files, string table)
        {
            var outputStream = new MemoryStream();
            long length = 0;
            var processedFiles = new List<string>();
            foreach (var file in files[table])
            {
                using (var fs = File.OpenRead(file))
                {
                    length += fs.Length;
                    processedFiles.Add(file);
                    using var gz = new GZipStream(fs, CompressionMode.Decompress);
                    gz.CopyTo(outputStream);
                }

                if (length / 1024 >= 12 * 1000)
                {
                    Console.WriteLine($"length={length / 1024};processedFiles={processedFiles.Count}");
                    yield return new Tuple<List<string>, MemoryStream>(processedFiles, outputStream);
                    length = 0;
                    outputStream = new MemoryStream();
                    processedFiles.Clear();
                }
            }

            if (length > 0)
            {
                yield return new Tuple<List<string>, MemoryStream>(processedFiles, outputStream);
            }
        }


        private static void SaveToS3(Stream outputStream, string fileName)
        {
            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                BufferSize = 512 * 1024,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                Settings.Current.S3AwsSecretAccessKey, config);
            using var compressed = Compress(outputStream);
            var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}";
            var putObject = client.PutObjectAsync(new PutObjectRequest
            {
                BucketName = Settings.Current.Bucket,
                Key = prefix + "/" + fileName,
                ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                StorageClass = S3StorageClass.Standard,
                InputStream = compressed
            });
            putObject.Wait();

            var response = putObject.Result;

            if (string.IsNullOrEmpty(response.ETag))
            {
                Console.WriteLine("!!! PutObject response is empty !!! | " + fileName);
                throw new Exception("PutObject response.ETag is empty");
            }

        }

        private static string GenerateFileName(string table, IEnumerable<string> processedFiles, int index, int attempt)
        {
            var chunkId = "x";
            var prefix = "x";
            var personIds = new SortedSet<long>();
            var rowCount = 0L;
            foreach (var file in processedFiles)
            {
                var parts = file.Split('.');
                chunkId = parts[1];
                prefix = parts[2];
                var pIds = parts[3].Split('_');
                rowCount += int.Parse(parts[4]);

                personIds.Add(long.Parse(pIds[0]));
                personIds.Add(long.Parse(pIds[1]));
            }

            var tableName = table;
            if (table.Equals("fact_relationship", StringComparison.CurrentCultureIgnoreCase))
                tableName = "FACT_RELATIONSHIP" + "_TMP";

            var fileName =
               $"{tableName}/{tableName}.{prefix}.{chunkId}.{attempt}.{index}.txt.gz";

            return fileName;
        }

        private static MemoryStream Compress(Stream inputStream)
        {
            inputStream.Position = 0;
            var outputStream = new MemoryStream();
            using (var gz = new BufferedStream(new GZipStream(outputStream, CompressionLevel.Optimal, true)))
            {
                inputStream.CopyTo(gz);
            }

            outputStream.Position = 0;

            return outputStream;
        }

        private bool GetRestorePoint(S3Entity s3Event)
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
                    using (var responseStream = transferUtility.OpenStream(s3Event.Bucket.Name, s3Event.Object.Key))
                    using (var reader = new StreamReader(responseStream))
                    {
                        string line;
                        while ((line = reader.ReadLine()) != null)
                        {
                            var fileName = line.Split(':')[0];
                            var rowIndex = long.Parse(line.Split(':')[1]);
                            _restorePoint.Add(fileName, rowIndex);
                            msg.Append($"{fileName}:{rowIndex};");
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
                        Console.WriteLine($"WARN_EXC - GetRestorePoint [{s3Event.Object.Key}]");
                        Console.WriteLine(CreateExceptionString(e));
                        return false;
                    }
                }
            }
        }

        private bool RemoveAttemptFile(S3Entity s3Event)
        {
            if (_attemptFileRemoved)
                return true;

            Console.WriteLine("removing attempt file...");

            var attempt = 0;
            var key = s3Event.Object.Key;

            while (true)
            {
                try
                {
                    attempt++;
                    var task = this.S3Client.DeleteObjectAsync(new DeleteObjectRequest
                    {
                        BucketName = s3Event.Bucket.Name,
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
                        Console.WriteLine(CreateExceptionString(e));
                        return false;
                    }
                }
            }
        }

        private bool CreateAttemptFile(S3Entity s3Event, int chunkId, string prefix, int processAttempt)
        {
            if (!_attemptFileRemoved)
                return false;

            var attempt = 0;
            var key = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id}.{chunkId}.{prefix}.{processAttempt}.txt";

            while (true)
            {
                try
                {
                    attempt++;

                    var restore = new List<string>();
                    foreach (var rp in _restorePoint)
                    {
                        restore.Add($"{rp.Key}:{rp.Value}");
                    }

                    Console.WriteLine("restore.Count=" + restore.Count);
                    File.WriteAllLines($"{TmpFolder}/{key}", restore);

                    using (var tu = new TransferUtility(this.S3Client))
                    {
                        tu.Upload($"{TmpFolder}/{key}", s3Event.Bucket.Name, key);
                    }
                    Console.WriteLine($"{key} - moved to S3");
                    File.Delete($"{TmpFolder}/{key}");
                    Console.WriteLine($"{key} - removed from tmp");
                    Console.WriteLine($"Attempt file was created - {key} | attempt={attempt}");

                    return true;
                }
                catch (Exception e)
                {
                    if (attempt > 5)
                    {
                        Console.WriteLine($"WARN_EXC - Can't create new attempt [{key}]");
                        Console.WriteLine(CreateExceptionString(e));
                        return false;
                    }
                }
            }
        }

        private static PersonBuilder CreatePersonBuilder()
        {
            return PersonBuilder.CreateBuilder(Settings.Current.Building.Vendor);
        }
    }
}