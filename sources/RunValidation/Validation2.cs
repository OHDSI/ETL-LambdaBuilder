using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System.Diagnostics;
using System.Globalization;
using System.IO.Compression;
using System.Text;

namespace RunValidation
{
    [Obsolete] //it's here for a reference; //todo delete //copy from Presentation
    public class Validation2
    {
        private string _cdmFolder = "cdmCSV";
        private LambdaUtility _lambdaUtility;

        public void Start(LambdaUtility utility, string cdmCsvFolder)
        {
            var wrong = new List<string>();
            var timer = new Stopwatch();
            timer.Start();
            _cdmFolder = cdmCsvFolder;

            var slicesNum = GetSlicesNum();
            _lambdaUtility = utility;

            foreach (var chunk in GetChunk())
            {
                var chunkId = chunk.Key;
                var objects = new List<S3Object>();
                foreach (var o in GetObjects("PERSON", chunkId, slicesNum))
                {
                    objects.AddRange(o);
                }

                foreach (var o in GetObjects("METADATA_TMP", chunkId, slicesNum))
                {
                    objects.AddRange(o);
                }

                if (objects.Count == 0)
                {
                    wrong.Add($"chunkId={chunkId} - MISSED");
                }

                ProcessChunk(objects, chunk, slicesNum, false);

                foreach (var c in chunk.Value)
                {
                    if (c.Value.Count != 1)
                        wrong.Add($"chunkId={chunkId};person_id={c.Key};files={string.Join(',', [.. c.Value])}");
                }
            }

            Console.WriteLine();
            timer.Stop();
            Console.WriteLine($"Total={timer.ElapsedMilliseconds}ms");
            timer.Restart();
        }

        private int GetSlicesNum()
        {
            var slices = new HashSet<string>();
            var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/{_cdmFolder}/PERSON/PERSON.";
            Console.WriteLine("Calculating slices num " + Settings.Current.Bucket + "|" + prefix);
            using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))

            {
                var request = new ListObjectsV2Request
                {
                    BucketName = Settings.Current.Bucket,
                    Prefix = prefix
                };
                ListObjectsV2Response response;

                do
                {
                    var responseTask = client.ListObjectsV2Async(request);
                    responseTask.Wait();
                    response = responseTask.Result;

                    foreach (var o in response.S3Objects)
                    {
                        slices.Add(o.Key.Split('.')[1]);
                    }

                    request.ContinuationToken = response.NextContinuationToken;
                } while (response.IsTruncated);
            }

            Console.WriteLine("slices.Count=" + slices.Count);

            return slices.Count;
        }

        private static IEnumerable<KeyValuePair<int, Dictionary<long, List<string>>>> GetChunk()
        {
            var currentChunkId = 0;
            var result = new KeyValuePair<int, Dictionary<long, List<string>>>(0, []);
            var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/_chunks";
            using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = Settings.Current.Bucket,
                    Prefix = prefix
                };

                var response = client.ListObjectsV2Async(request);
                response.Wait();

                foreach (var o in response.Result.S3Objects.OrderBy(o => o.LastModified))
                {
                    using var transferUtility = new TransferUtility(Settings.Current.S3AwsAccessKeyId,
                        Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var responseStream = transferUtility.OpenStream(Settings.Current.Bucket, o.Key);
                    using var bufferedStream = new BufferedStream(responseStream);
                    using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                    using var reader = new StreamReader(gzipStream, Encoding.Default);
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (!string.IsNullOrEmpty(line))
                        {
                            var chunkId = int.Parse(line.Split('\t')[0]);

                            if (currentChunkId != chunkId)
                            {
                                if (result.Value.Count > 0)
                                    yield return result;

                                result = new KeyValuePair<int, Dictionary<long, List<string>>>(chunkId,
                                    []);
                                currentChunkId = chunkId;
                            }

                            var personId = long.Parse(line.Split('\t')[1]);
                            result.Value.Add(personId, []);
                        }
                    }
                }
            }

            if (result.Value.Count > 0)
                yield return result;
        }

        public IEnumerable<List<S3Object>> GetObjects(string table, int chunkId, int slicesNum)
        {
            for (int i = 0; i < slicesNum; i++)
            {
                var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/{_cdmFolder}/{table}/{table}.{i}.{chunkId}.";
                using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1);
                var request = new ListObjectsV2Request
                {
                    BucketName = Settings.Current.Bucket,
                    Prefix = prefix
                };
                ListObjectsV2Response response;
                do
                {
                    var responseTask = client.ListObjectsV2Async(request);
                    responseTask.Wait();
                    response = responseTask.Result;

                    yield return response.S3Objects;

                    request.ContinuationToken = response.NextContinuationToken;
                } while (response.IsTruncated);
            }

        }

        public Dictionary<long, bool> ProcessChunk(List<S3Object> objects, KeyValuePair<int, Dictionary<long, List<string>>> chunk, int slicesNum, bool onlyCheck)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;
                    var missed = 0;
                    var dups = 0;

                    foreach (var ci in chunk.Value)
                    {
                        ci.Value.Clear();
                    }

                    var timer = new Stopwatch();
                    timer.Start();

                    var cnt = 0;
                    var attempt1 = attempt;

                    Parallel.ForEach(objects, o =>
                    {
                        using var transferUtility = new TransferUtility(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                            Amazon.RegionEndpoint.USEast1);
                        using var responseStream = transferUtility.OpenStream(Settings.Current.Bucket, o.Key);
                        using var bufferedStream = new BufferedStream(responseStream);
                        using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                        using var reader = new StreamReader(gzipStream, Encoding.Default);
                        using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                        {
                            HasHeaderRecord = false,
                            Delimiter = ",",
                            Encoding = Encoding.UTF8
                        });
                        while (csv.Read())
                        {
                            var personId = (long)csv.GetField(typeof(long), 0);

                            chunk.Value[personId].Add(o.Key);
                        }
                        Interlocked.Increment(ref cnt);
                    });

                    int wrngCnt = 0;
                    var wrongPersonIds = new Dictionary<long, bool>();
                    foreach (var ci in chunk.Value)
                    {
                        if (ci.Value.Count == 0)
                        {
                            missed++;
                        }
                        else if (ci.Value.Count > 1)
                        {
                            dups++;
                        }

                        if (ci.Value.Count != 1)
                        {
                            wrngCnt++;

                            if (wrngCnt == 1 || wrngCnt % 500 == 0)
                                wrongPersonIds.Add(ci.Key, false);
                        }
                    }

                    timer.Stop();

                    if (missed > 0 || dups > 0)
                    {
                        Console.WriteLine($"XXX ChunkId={chunk.Key} | missed={missed}; dups={dups} | {wrongPersonIds.Keys.Count}");
                        if (!onlyCheck)
                        {
                            Cleanup(chunk.Key, slicesNum);
                            var tasks = _lambdaUtility.TriggerBuildFunction(Settings.Current.Building.Vendor, Settings.Current.Building.Id.Value, chunk.Key, false);
                            Task.WaitAll([.. tasks]);

                            var checkCreation = Task.Run(() => _lambdaUtility.AllChunksWereDone(Settings.Current.Building.Vendor,
                                Settings.Current.Building.Id.Value, _lambdaUtility.BuildMessageBucket));

                            checkCreation.Wait();

                            foreach (var personId in chunk.Value.Keys)
                            {
                                chunk.Value[personId].Clear();
                            }

                            throw new Exception("restart");
                        }
                    }

                    complete = true;
                    return wrongPersonIds;
                }
                catch (Exception ex)
                {
                    Console.Write(ex.Message + " | [ProcessChunk] Exception | new attempt | attempt=" + attempt);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
            return null;
        }

        private void Cleanup(int chunkId, int slicesNum)
        {
            var tables = new[]
            {
                "PERSON",
                "OBSERVATION_PERIOD",
                "PAYER_PLAN_PERIOD",
                "DEATH",
                "DRUG_EXPOSURE",
                "OBSERVATION",
                "VISIT_OCCURRENCE",
                "VISIT_DETAIL",
                "PROCEDURE_OCCURRENCE",
                "DRUG_ERA",
                "CONDITION_ERA",
                "DEVICE_EXPOSURE",
                "MEASUREMENT",
                "COHORT",
                "CONDITION_OCCURRENCE",
                "COST",
                "NOTE",
                "METADATA_TMP",
                "FACT_RELATIONSHIP"
            };

            Console.WriteLine("Cleaning chunkId=" + chunkId);

            foreach (var table in tables)
            {
                Console.WriteLine("Cleaning table=" + table);

                for (var i = 0; i < slicesNum; i++)
                {
                    Clean(chunkId, table, i);
                }
            }

            Console.WriteLine($"chunkId={chunkId} was cleaned");
        }

        private static IEnumerable<string> GetLines(Stream stream)
        {
            using var bufferedStream = new BufferedStream(stream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                if (!string.IsNullOrEmpty(line))
                {
                    yield return line;
                }
            }
        }

        public static List<string> FindSlice(int chunkId, string table, Dictionary<long, bool> personIds, int personIndex)
        {
            var prefix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/raw/{chunkId}/{table}/{table}";

            var result = new HashSet<string>();
            using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = Settings.Current.Bucket,
                    Prefix = prefix
                };

                var r = client.ListObjectsV2Async(request);
                r.Wait();
                var response = r.Result;
                var rows = new List<string>();
                foreach (var o in response.S3Objects)
                {
                    using var transferUtility = new TransferUtility(Settings.Current.S3AwsAccessKeyId,
                        Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var responseStream = transferUtility.OpenStream(Settings.Current.Bucket, o.Key);
                    {
                        foreach (var line in GetLines(responseStream))
                        {
                            long personId = long.Parse(line.Split('\t')[personIndex]);
                            if (personIds.ContainsKey(personId))
                            {
                                result.Add(o.Key);
                                break;
                            }
                        }
                    }
                }
            }

            return [.. result];
        }

        public void Clean(int chunkId, string table, int slice)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;

                    var perfix = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/{_cdmFolder}/{table}/{table}.{slice}.{chunkId}.";

                    using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey,
                        Amazon.RegionEndpoint.USEast1))
                    {
                        var request = new ListObjectsV2Request
                        {
                            BucketName = Settings.Current.Bucket,
                            Prefix = perfix
                        };
                        ListObjectsV2Response response;
                        do
                        {
                            using var getListObjects = client.ListObjectsV2Async(request);
                            getListObjects.Wait();
                            response = getListObjects.Result;

                            var multiObjectDeleteRequest = new DeleteObjectsRequest
                            {
                                BucketName = Settings.Current.Bucket
                            };

                            foreach (var o in response.S3Objects)
                            {
                                multiObjectDeleteRequest.AddKey(o.Key, null);
                            }

                            if (response.S3Objects.Count > 0)
                            {
                                using var deleteObjects = client.DeleteObjectsAsync(multiObjectDeleteRequest);
                                deleteObjects.Wait();

                                //Console.WriteLine(response.S3Objects.Count + " files deleted");
                            }

                            request.ContinuationToken = response.NextContinuationToken;
                        } while (response.IsTruncated == true);
                    }

                    complete = true;
                }
                catch (Exception ex)
                {
                    Console.Write(" | [Clean] Exception | new attempt | " + attempt);
                    Console.WriteLine(ex.Message);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
        }
    }
}