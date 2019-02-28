using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;
using org.ohdsi.cdm.framework.common2.PregnancyAlgorithm;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace org.ohdsi.cdm.presentation.lambdapregnancyepisodes
{
    public class Function
    {
        IAmazonS3 S3Client { get; set; }
        private bool _attemptFileRemoved;

        private string _awsAccessKeyId = "";
        private string _awsSecretAccessKey = "";
        private string _bucket = "";
        private string _cdmFolder = "";
        private string _resultFolder = "";

        /// <summary>
        /// Default constructor. This constructor is used by Lambda to construct the instance. When invoked in a Lambda environment
        /// the AWS credentials will come from the IAM role associated with the function and the AWS region will be set to the
        /// region the Lambda function is executed in.
        /// </summary>
        public Function()
        {
            Console.WriteLine("ctor 1");
            S3Client = new AmazonS3Client();
        }

        /// <summary>
        /// Constructs an instance with a preconfigured S3 client. This can be used for testing the outside of the Lambda environment.
        /// </summary>
        /// <param name="s3Client"></param>
        public Function(IAmazonS3 s3Client)
        {
            Console.WriteLine("ctor 2");
            this.S3Client = s3Client;
        }
        
        /// <summary>
        /// This method is called for every Lambda invocation. This method takes in an S3 event object and can be used 
        /// to respond to S3 notifications.
        /// </summary>
        /// <param name="evnt"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task<string> FunctionHandle(S3Event evnt, ILambdaContext context)
        {
            Console.WriteLine("FunctionHandler");
            var s3Event = evnt.Records?[0].S3;
            if(s3Event == null)
            {
                return null;
            }

            var pr = string.Empty;
            _bucket = Environment.GetEnvironmentVariable("Bucket");
            _awsAccessKeyId = Environment.GetEnvironmentVariable("S3AwsAccessKeyId");
            _awsSecretAccessKey = Environment.GetEnvironmentVariable("S3AwsSecretAccessKey");
            _cdmFolder = Environment.GetEnvironmentVariable("CDMFolder");
            _resultFolder = Environment.GetEnvironmentVariable("ResultFolder");

            _attemptFileRemoved = false;

            try
            {
                var result = new List<EraEntity>();
                var vendor = Enum.Parse<Vendors>(s3Event.Object.Key.Split('.')[0]);
                var buildingId = int.Parse(s3Event.Object.Key.Split('.')[1]);
                var chunkId = int.Parse(s3Event.Object.Key.Split('.')[2]);
                pr = s3Event.Object.Key.Split('.')[3].Trim();

                Console.WriteLine($"vendor={vendor};buildingId={buildingId};chunkId={chunkId};");


                int personCount = 0;

                var prefix = $"{vendor}/{buildingId}/{_cdmFolder}/";
                using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1))
                {
                    var vocab = new Vocabulary2();
                    vocab.Fill(client, _bucket, vendor, buildingId);
                    Console.WriteLine("vocab done");

                    foreach (var key in GetKeys(prefix + "PERSON/PERSON." + chunkId + "." + pr + "."))
                    {
                        var persons = GetPersons(key).ToArray();

                        var observationPeriods = GetObservationPeriods(key).ToArray();
                        var conditionOccurrences = GetConditionOccurrence(key).ToArray();
                        var procedureOccurrences = GetProcedureOccurrences(key).ToArray();
                        var observations = GetObservations(key).ToArray();
                        var measurements = GetMeasurements(key).ToArray();
                        var drugExposures = GetDrugExposures(key).ToArray();

                        foreach (var person in persons)
                        {
                            var pg = new PregnancyAlgorithm();

                            foreach (var r in pg.GetPregnancyEpisodes(vocab, person,
                                observationPeriods.Where(e => e.PersonId == person.PersonId).ToArray(),
                                conditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                                procedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                                observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                                measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                                drugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
                            {
                                result.Add(r);
                            }

                            personCount++;
                        }

                        Console.WriteLine(chunkId + "." + pr + " | Total person:" + personCount + " | pregnancy episodes:" + result.Count);

                    }
                }

                Console.WriteLine("DONE :" + chunkId + "." + pr + " | Total person:" + personCount + " | pregnancy episodes:" + result.Count);

                var fileName = $"CONDITION_ERA/CONDITION_ERA.{chunkId}.{pr}.txt.gz";
                var bucket = $"{_bucket}/{vendor}/{buildingId}/{_resultFolder}";

                var reader = new ConditionEraDataReader2(result.ToList());
                using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1))
                using (var stream = reader.GetStream(S3StorageType.CSV))
                {
                    var putObject = client.PutObjectAsync(new PutObjectRequest
                    {
                        BucketName = bucket,
                        Key = fileName,
                        ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                        StorageClass = S3StorageClass.Standard,
                        InputStream = stream
                    });
                    putObject.Wait();
                }

                GC.Collect();
                Console.WriteLine("SAVED: " + fileName);

                RemoveAttemptFile(s3Event);
                return "Done";

            }
            catch (Exception e)
            {
                context.Logger.LogLine($"Error getting object {s3Event.Object.Key} from bucket {s3Event.Bucket.Name}. Make sure they exist and your bucket is in the same region as this function.");
                context.Logger.LogLine(e.Message);
                context.Logger.LogLine(e.StackTrace);
                throw;
            }
        }

        public class ConditionEraDataReader2 : IDataReader
        {
            private readonly IEnumerator<EraEntity> _conditionEnumerator;

            // A custom DataReader is implemented to prevent the need for the HashSet to be transformed to a DataTable for loading by SqlBulkCopy
            public ConditionEraDataReader2(List<EraEntity> batch)
            {
                _conditionEnumerator = batch.GetEnumerator();
            }

            public bool Read()
            {
                return _conditionEnumerator.MoveNext();
            }

            public int FieldCount
            {
                get { return 6; }
            }

            // is this called only because the datatype specific methods are not implemented?  
            // probably performance to be gained by not passing object back?
            public object GetValue(int i)
            {
                switch (i)
                {
                    case 0:
                        return 0;
                    case 1:
                        return _conditionEnumerator.Current.PersonId;
                    case 2:
                        return _conditionEnumerator.Current.ConceptId;
                    case 3:
                        return _conditionEnumerator.Current.StartDate;
                    case 4:
                        return _conditionEnumerator.Current.EndDate;
                    case 5:
                        return _conditionEnumerator.Current.OccurrenceCount;
                    default:
                        throw new NotImplementedException();
                }
            }

            public string GetName(int i)
            {
                switch (i)
                {
                    case 0:
                        return "Id";
                    case 1:
                        return "PersonId";
                    case 2:
                        return "ConceptId";
                    case 3:
                        return "StartDate";
                    case 4:
                        return "EndDate";
                    case 5:
                        return "OccurrenceCount";
                    default:
                        throw new NotImplementedException();
                }
            }

            #region implementationn not required for SqlBulkCopy
            public bool NextResult()
            {
                throw new NotImplementedException();
            }

            public void Close()
            {
                throw new NotImplementedException();
            }

            public bool IsClosed
            {
                get { throw new NotImplementedException(); }
            }

            public int Depth
            {
                get { throw new NotImplementedException(); }
            }

            public DataTable GetSchemaTable()
            {
                throw new NotImplementedException();
            }

            public int RecordsAffected
            {
                get { throw new NotImplementedException(); }
            }

            public void Dispose()
            {
                throw new NotImplementedException();
            }

            public bool GetBoolean(int i)
            {
                return (bool)GetValue(i);
            }

            public byte GetByte(int i)
            {
                return (byte)GetValue(i);
            }

            public long GetBytes(int i, long fieldOffset, byte[] buffer, int bufferoffset, int length)
            {
                throw new NotImplementedException();
            }

            public char GetChar(int i)
            {
                return (char)GetValue(i);
            }

            public long GetChars(int i, long fieldoffset, char[] buffer, int bufferoffset, int length)
            {
                throw new NotImplementedException();
            }

            public IDataReader GetData(int i)
            {
                throw new NotImplementedException();
            }

            public string GetDataTypeName(int i)
            {
                throw new NotImplementedException();
            }

            public DateTime GetDateTime(int i)
            {
                return (DateTime)GetValue(i);
            }

            public decimal GetDecimal(int i)
            {
                return (decimal)GetValue(i);
            }

            public double GetDouble(int i)
            {
                return Convert.ToDouble(GetValue(i));
            }

            public Type GetFieldType(int i)
            {
                switch (i)
                {
                    case 0:
                        return typeof(long);
                    case 1:
                        return typeof(long);
                    case 2:
                        return typeof(long);
                    case 3:
                        return typeof(DateTime);
                    case 4:
                        return typeof(DateTime);
                    case 5:
                        return typeof(int);
                    default:
                        throw new NotImplementedException();
                }
            }

            public float GetFloat(int i)
            {
                return (float)GetValue(i);
            }

            public Guid GetGuid(int i)
            {
                return (Guid)GetValue(i);
            }

            public short GetInt16(int i)
            {
                return (short)GetValue(i);
            }

            public int GetInt32(int i)
            {
                return (int)GetValue(i);
            }

            public long GetInt64(int i)
            {
                return Convert.ToInt64(GetValue(i));
            }

            public int GetOrdinal(string name)
            {
                throw new NotImplementedException();
            }

            public string GetString(int i)
            {
                return (string)GetValue(i);
            }

            public int GetValues(object[] values)
            {
                throw new NotImplementedException();
            }

            public bool IsDBNull(int i)
            {
                return GetValue(i) == null;
            }

            public object this[string name]
            {
                get { throw new NotImplementedException(); }
            }

            public object this[int i]
            {
                get { throw new NotImplementedException(); }
            }
            #endregion
        }

        private bool RemoveAttemptFile(Amazon.S3.Util.S3EventNotification.S3Entity s3Event)
        {
            if (_attemptFileRemoved)
                return true;

            var attempt = 0;
            var key = s3Event.Object.Key;

            Console.WriteLine(s3Event.Bucket.Name + "." + key);

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

        private IEnumerable<Person> GetPersons(string key)
        {
            using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            using (var responseStream = transferUtility.OpenStream(_bucket, key))
            using (var bufferedStream = new BufferedStream(responseStream))
            using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
            using (var reader = new StreamReader(gzipStream, Encoding.Default))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    if (!string.IsNullOrEmpty(line))
                    {
                        var row = line.Split('\t');
                        var personId = long.Parse(row[0]);
                        var genderConceptId = int.Parse(row[1]);
                        var yearOfBirth = int.Parse(row[2]);

                        yield return new Person(new Entity()) { PersonId = personId, GenderConceptId = genderConceptId, YearOfBirth = yearOfBirth };
                    }
                }
            }
        }

        private IEnumerable<ObservationPeriod> GetObservationPeriods(string key)
        {
            key = key.Replace("PERSON", "OBSERVATION_PERIOD");

            //if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var start = DateTime.Parse(row[2]);
                            var end = DateTime.Parse(row[3]);

                            yield return new ObservationPeriod { PersonId = personId, StartDate = start, EndDate = end };
                        }
                    }
                }
            }
        }

        private IEnumerable<ConditionOccurrence> GetConditionOccurrence(string key)
        {
            key = key.Replace("PERSON", "CONDITION_OCCURRENCE");

            if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var conceptId = int.Parse(row[2]);
                            var start = DateTime.Parse(row[3]);


                            yield return new ConditionOccurrence(new Entity())
                            {
                                PersonId = personId,
                                StartDate = start,
                                ConceptId = conceptId
                            };
                        }
                    }
                }
            }
        }

        private IEnumerable<ProcedureOccurrence> GetProcedureOccurrences(string key)
        {
            key = key.Replace("PERSON", "PROCEDURE_OCCURRENCE");

            if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var conceptId = int.Parse(row[2]);
                            var start = DateTime.Parse(row[3]);


                            yield return new ProcedureOccurrence(new Entity())
                            {
                                PersonId = personId,
                                StartDate = start,
                                ConceptId = conceptId
                            };
                        }
                    }
                }
            }
        }

        private IEnumerable<Observation> GetObservations(string key)
        {
            key = key.Replace("PERSON", "OBSERVATION");

            if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var conceptId = int.Parse(row[2]);
                            var start = DateTime.Parse(row[3]);
                            decimal? valueAsNumber = null;
                            if (decimal.TryParse(row[6], out var num))
                            {
                                valueAsNumber = num;
                            }

                            var valueAsString = row[7];

                            if (valueAsString == "\0")
                                valueAsString = null;

                            yield return new Observation(new Entity())
                            {
                                PersonId = personId,
                                StartDate = start,
                                ConceptId = conceptId,
                                ValueAsNumber = valueAsNumber,
                                ValueAsString = valueAsString
                            };
                        }
                    }
                }
            }
        }

        private IEnumerable<Measurement> GetMeasurements(string key)
        {
            key = key.Replace("PERSON", "MEASUREMENT");

            if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var conceptId = int.Parse(row[2]);
                            var start = DateTime.Parse(row[3]);
                            decimal? valueAsNumber = null;
                            if (decimal.TryParse(row[8], out var num))
                            {
                                valueAsNumber = num;
                            }

                            var valueSourceValue = row[19];

                            if (valueSourceValue == "\0")
                                valueSourceValue = null;

                            yield return new Measurement(new Entity())
                            {
                                PersonId = personId,
                                StartDate = start,
                                ConceptId = conceptId,
                                ValueAsNumber = valueAsNumber,
                                ValueSourceValue = valueSourceValue
                            };
                        }
                    }
                }
            }
        }

        private IEnumerable<DrugExposure> GetDrugExposures(string key)
        {
            key = key.Replace("PERSON", "DRUG_EXPOSURE");

            if (GetKeys(key).Any())
            {
                using (var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                using (var responseStream = transferUtility.OpenStream(_bucket, key))
                using (var bufferedStream = new BufferedStream(responseStream))
                using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                using (var reader = new StreamReader(gzipStream, Encoding.Default))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var row = line.Split('\t');
                            var personId = long.Parse(row[1]);
                            var conceptId = int.Parse(row[2]);
                            var start = DateTime.Parse(row[3]);


                            yield return new DrugExposure(new Entity())
                            {
                                PersonId = personId,
                                StartDate = start,
                                ConceptId = conceptId
                            };
                        }
                    }
                }
            }
        }

        private IEnumerable<string> GetKeys(string prefix)
        {
            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };
                Task<ListObjectsV2Response> task;
                do
                {
                    task = client.ListObjectsV2Async(request);

                    task.Wait();

                    foreach (var o in task.Result.S3Objects)
                    {
                        yield return o.Key;
                    }

                    request.ContinuationToken = task.Result.NextContinuationToken;

                } while (task.Result.IsTruncated);
            }
        }
    }
}
