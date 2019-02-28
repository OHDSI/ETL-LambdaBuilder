using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading.Tasks;

using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Cerner;
using org.ohdsi.cdm.framework.common2.Core.Transformation.CPRD;
using org.ohdsi.cdm.framework.common2.Core.Transformation.HCUP;
using org.ohdsi.cdm.framework.common2.Core.Transformation.JMDC;
using org.ohdsi.cdm.framework.common2.Core.Transformation.nhanes;
using org.ohdsi.cdm.framework.common2.Core.Transformation.OptumExtended;
using org.ohdsi.cdm.framework.common2.Core.Transformation.OptumOncology;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Premier;
using org.ohdsi.cdm.framework.common2.Core.Transformation.SEER;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Truven;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.presentation.lambdabuilder.Base;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Function
    {
        IAmazonS3 S3Client { get; set; }
        private Vocabulary _vocabulary;
        //private bool _initialized = false;
        private bool _attemptFileRemoved;
        private long? _lastSavedPersonIdOutput;
        private Dictionary<string, long> _restorePoint = new Dictionary<string, long>();

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
            Settings.Current.WatchdogTimeout = false;
            _attemptFileRemoved = false;
            _lastSavedPersonIdOutput = null;
            _restorePoint.Clear();

            if (_vocabulary != null && _vocabulary.Vendor == Settings.Current.Building.Vendor) return;

            try
            {
                var timer = new Stopwatch();
                timer.Start();
                _vocabulary = new Vocabulary(Settings.Current.Building.Vendor);
                _vocabulary.Fill(false);
                timer.Stop();

                Console.WriteLine("Vocabulary initialized for " + Settings.Current.Building.Vendor + " | " +
                                  timer.ElapsedMilliseconds + "ms");
            }
            catch (Exception e)
            {
                _vocabulary = null;
                throw;
            }
        }

        public async Task<string> FunctionHandler2(Vendors vendor, int buildingId, int chunkId, string prefix,
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

                    Settings.Initialize(buildingId, vendor);
                    Settings.Current.S3AwsAccessKeyId = "";
                    Settings.Current.S3AwsSecretAccessKey = "";
                    Settings.Current.Bucket = "";
                    Settings.Current.StorageType = S3StorageType.Parquet;
                    Settings.Current.CDMFolder = "cdm";
                    Settings.Current.TimeoutValue = 18000;
                    Settings.Current.WatchdogValue = 100000 * 1000;
                    Settings.Current.MinPersonToBuild = 100;
                    Settings.Current.MinPersonToSave = 100;

                    Console.WriteLine(
                        $"vendor={vendor};buildingId={buildingId};chunkId={chunkId};prefix={prefix};attempt={attempt}");

                    Initialize();

                    if (restorePoint != null)
                    {
                        _restorePoint = restorePoint;
                    }

                    _vocabulary.Attach();

                    var chunkBuilder = new LambdaChunkBuilder(CreatePersonBuilder);
                    _lastSavedPersonIdOutput = chunkBuilder.Process(chunkId, prefix, _restorePoint, attempt);
                    Console.WriteLine("DONE");
                    return "done";
                }
                catch (Exception e)
                {
                    attempt++;
                    Console.WriteLine();
                    Console.WriteLine("Attempt: " + attempt);
                    Console.WriteLine();
                    restorePoint = new Dictionary<string, long>(_restorePoint);
                }
            }
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

            int chunkId = 0;
            int buildingId = 0;
            string prefix = String.Empty;
            int attempt = 0;
            Vendors vendor;

            try
            {
                // 0         1        2       3      4      5
                //vendor.buildingId.chunkId.prefix.attempt.txt

                vendor = Enum.Parse<Vendors>(s3Event.Object.Key.Split('.')[0]);
                buildingId = int.Parse(s3Event.Object.Key.Split('.')[1]);
                chunkId = int.Parse(s3Event.Object.Key.Split('.')[2]);
                prefix = s3Event.Object.Key.Split('.')[3].Trim();

                if (s3Event.Object.Key.Split('.').Length == 6)
                {
                    attempt = int.Parse(s3Event.Object.Key.Split('.')[4]);
                }

                Settings.Initialize(buildingId, vendor);

                Settings.Current.TimeoutValue = 180;
                Settings.Current.WatchdogValue = 10 * 1000;
                Settings.Current.MinPersonToBuild = 100;
                Settings.Current.MinPersonToSave = 100;

                Settings.Current.S3AwsAccessKeyId = Environment.GetEnvironmentVariable("S3AwsAccessKeyId");
                Settings.Current.S3AwsSecretAccessKey = Environment.GetEnvironmentVariable("S3AwsSecretAccessKey");
                Settings.Current.Bucket = Environment.GetEnvironmentVariable("Bucket");
                Settings.Current.CDMFolder = Environment.GetEnvironmentVariable("CDMFolder");
                Settings.Current.StorageType = Enum.TryParse(Environment.GetEnvironmentVariable("StorageType"), true,
                    out S3StorageType storageType) ? storageType : S3StorageType.CSV;

                //TODO different behavior(num of subChunks 256, 31...)
                if (attempt > 55)
                {
                    //Console.WriteLine($"*** too many attempt || chunkId={chunkId};prefix={prefix};attempt={attempt} - STARTED from PersonId={lastSavedPersonIdInput}");
                    return null;
                }

                Console.WriteLine($"vendor={vendor};buildingId={buildingId};chunkId={chunkId};prefix={prefix};attempt={attempt}");
                Console.WriteLine($"Bucket={Settings.Current.Bucket};CDMFolder={Settings.Current.CDMFolder};StorageType={Settings.Current.StorageType};");
                Console.WriteLine($"TimeoutValue={Settings.Current.TimeoutValue}s;WatchdogValue={Settings.Current.WatchdogValue}ms;MinPersonToBuild={Settings.Current.MinPersonToBuild}; MinPersonToSave={Settings.Current.MinPersonToSave}");

                Initialize();

                GetRestorePoint(s3Event);

                _vocabulary.Attach();

                var chunkBuilder = new LambdaChunkBuilder(CreatePersonBuilder);
                var attempt1 = attempt;
                _lastSavedPersonIdOutput = chunkBuilder.Process(chunkId, prefix, _restorePoint, attempt1);

                RemoveAttemptFile(s3Event);

                if (_lastSavedPersonIdOutput.HasValue || (Settings.Current.WatchdogTimeout && chunkBuilder.TotalPersonConverted == 0))
                {
                    attempt++;
                    CreateAttemptFile(s3Event, chunkId, prefix, attempt);

                    Console.WriteLine($"chunkId={chunkId};prefix={prefix} - FINISHED by timeout on PersonId={_lastSavedPersonIdOutput.Value}");
                    return "done";
                }

                Console.WriteLine($"chunkId={chunkId};prefix={prefix} - FINISHED, {s3Event.Object.Key} - removed");

                return "done";
            }
            catch (Exception e)
            {
                Console.WriteLine($"WARN_EXC - FunctionHandler");
                Console.WriteLine($"getting object {s3Event.Object.Key} from bucket {s3Event.Bucket.Name}. Make sure they exist and your bucket is in the same region as this function.");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);

                if (RemoveAttemptFile(s3Event))
                {
                    attempt++;
                    if (!CreateAttemptFile(s3Event, chunkId, prefix, attempt))
                    {
                        Console.WriteLine($"Can't convert chunkId={chunkId} prefix={prefix} | CreateAttemptFile");
                    }
                }
                else
                {
                    Console.WriteLine($"Can't convert chunkId={chunkId} prefix={prefix} | RemoveAttemptFile");
                }

                return "interrupted";
            }
        }

        private bool GetRestorePoint(Amazon.S3.Util.S3EventNotification.S3Entity s3Event)
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
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        throw;
                    }
                }
            }
        }

        private bool RemoveAttemptFile(Amazon.S3.Util.S3EventNotification.S3Entity s3Event)
        {
            if (_attemptFileRemoved)
                return true;

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
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        return false;
                    }
                }
            }
        }

        private bool CreateAttemptFile(Amazon.S3.Util.S3EventNotification.S3Entity s3Event, int chunkId, string prefix, int processAttempt)
        {
            if (!_attemptFileRemoved)
                return false;

            var attempt = 0;
            var key = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id}.{chunkId}.{prefix}.{processAttempt}.txt";

            //if (_lastSavedPersonIdOutput.HasValue)
            //    key = $"{chunkId}.{prefix}.{_lastSavedPersonIdOutput.Value}.{processAttempt}.txt";


            while (true)
            {
                try
                {
                    attempt++;


                    using (var memoryStream = new MemoryStream())
                    using (var writer = new StreamWriter(memoryStream))
                    using (var tu = new TransferUtility(this.S3Client))
                    {
                        foreach (var rp in _restorePoint)
                        {
                            writer.WriteLine($"{rp.Key}:{rp.Value}");
                        }

                        writer.Flush();

                        tu.Upload(memoryStream, s3Event.Bucket.Name, key);
                    }

                    Console.WriteLine($"Attempt file was created - {key} | attempt={attempt}");

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

        private static IPersonBuilder CreatePersonBuilder()
        {
            switch (Settings.Current.Building.Vendor)
            {
                case Vendors.Truven_CCAE:
                case Vendors.Truven_MDCR:
                case Vendors.Truven_MDCD:
                    return new TruvenPersonBuilder();

                case Vendors.OptumExtendedSES:
                case Vendors.OptumExtendedDOD:
                    return new OptumExtendedPersonBuilder();

                case Vendors.PremierV5:
                    return new PremierPersonBuilder();

                case Vendors.Cerner:
                    return new CernerPersonBuilder();

                case Vendors.HCUPv5:
                    return new HcupPersonBuilder();

                case Vendors.JMDCv5:
                    return new JmdcPersonBuilder();

                case Vendors.SEER:
                    return new SeerPersonBuilder();

                case Vendors.OptumOncology:
                    return new OptumOncologyPersonBuilder();

                case Vendors.CprdV5:
                    return new CprdPersonBuilder();

                case Vendors.NHANES:
                    return new NhanesPersonBuilder();

                    //    case Vendors.ErasV5:
                    //        return new ErasV5PersonBuilder();

                    //    case Vendors.OptumIntegrated:
                    //        return new OptumIntegratedPersonBuilder();


            }

            return new PersonBuilder();

        }
    }
}
