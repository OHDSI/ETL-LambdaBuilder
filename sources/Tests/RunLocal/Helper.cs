using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper.Configuration;
using CsvHelper;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO.Compression;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using org.ohdsi.cdm.framework.common.Enums;

namespace RunLocal
{
    internal class Helper
    {
        internal static void CheckChunk(string localTmpPath, List<S3Object> objects, string awsAccessKeyId, string awsSecretAccessKey, string bucket,
      KeyValuePair<int, Dictionary<long, List<string>>> chunk)
        {

            var missed = 0;
            var dups = 0;

            var attempt = 0;
            var complete = false;

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                BufferSize = 1512 * 1024,
                MaxErrorRetry = 120
            };

            while (!complete)
            {
                try
                {
                    attempt++;

                    var timer = new Stopwatch();
                    timer.Start();

                    var cnt = 0;
                    var attempt1 = attempt;

                    Parallel.ForEach(objects, new ParallelOptions() { MaxDegreeOfParallelism = 10 }, o =>
                    {
                        var loadAttempt = 0;
                        var loaded = false;
                        while (!loaded)
                        {
                            try
                            {
                                loadAttempt++;
                                using (var client = new AmazonS3Client(awsAccessKeyId, awsSecretAccessKey, config))
                                using (var transferUtility = new TransferUtility(client))
                                {
                                    transferUtility.Download($@"{localTmpPath}\{o.Key}", bucket, o.Key);
                                }
                                loaded = true;
                            }
                            catch (Exception)
                            {
                                if (loadAttempt <= 11)
                                {
                                    Console.WriteLine(o.Key + " | " + loadAttempt);
                                }
                                else
                                {
                                    throw;
                                }
                            }
                        }


                        using (var responseStream = File.Open($@"{localTmpPath}\{o.Key}", FileMode.Open))
                        using (var bufferedStream = new BufferedStream(responseStream))
                        using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                        using (var reader = new StreamReader(gzipStream, Encoding.Default))
                        {
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

                            Console.Write(
                                $"\rchunkId={chunk.Key} | {cnt} from {objects.Count} | attempt={attempt1}");
                        }

                        File.Delete($@"{localTmpPath}\{o.Key}");

                    });


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
                    }

                    timer.Stop();
                    Console.WriteLine($" | DONE | missed={missed}; dups={dups} | total={timer.ElapsedMilliseconds}ms");

                    complete = true;
                }
                catch (Exception)
                {
                    Console.Write(" | Exception");
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
        }

        internal static IEnumerable<List<S3Object>> GetObjectsFromS3(Vendor vendor, int buildingId, string awsAccessKeyId, string awsSecretAccessKey,
            string bucket, string cdmFolder, string table, int chunkId, int slicesNum)
        {
            for (int i = 0; i < slicesNum; i++)
            {
                var prefix = $"{vendor}/{buildingId}/{cdmFolder}/{table}/{table}.{i}.{chunkId}.";

                using var client = new AmazonS3Client(awsAccessKeyId, awsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1);
                var request = new ListObjectsV2Request
                {
                    BucketName = bucket,
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

        internal static List<string> FindSlicesByPersonIds(string awsAccessKeyId, string awsSecretAccessKey, string bucket, Vendor vendor, int buildingId, int chunkId, string table, Dictionary<long, bool> personIds, int personIndex)
        {
            var prefix = $"{vendor}/{buildingId}/raw/{chunkId}/{table}/{table}";

            var input = new ConcurrentDictionary<long, bool>();

            foreach (var pId in personIds.Keys)
            {
                input.TryAdd(pId, false);
            }

            var result = new ConcurrentDictionary<string, bool>();
            using (var client = new AmazonS3Client(awsAccessKeyId, awsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = bucket,
                    Prefix = prefix
                };

                var r = client.ListObjectsV2Async(request);
                r.Wait();
                var response = r.Result;
                var rows = new List<string>();

                Parallel.ForEach(response.S3Objects, o =>
                {
                    using var transferUtility = new TransferUtility(awsAccessKeyId, awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var responseStream = transferUtility.OpenStream(bucket, o.Key);
                    using var bufferedStream = new BufferedStream(responseStream);
                    using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                    using var reader = new StreamReader(gzipStream, Encoding.Default);
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (input.IsEmpty)
                            break;

                        if (!string.IsNullOrEmpty(line))
                        {
                            long personId = long.Parse(line.Split('\t')[personIndex]);
                            if (personIds.ContainsKey(personId))
                            {
                                result.TryAdd(o.Key, false);
                                input.TryRemove(personId, out var res);
                                break;
                            }
                        }
                    }
                });
            }

            return [.. result.Keys];
        }

        internal static IEnumerable<KeyValuePair<int, Dictionary<long, List<string>>>> GetChunksFromS3(string localTmpPath, Vendor vendor, int buildingId,
            string awsAccessKeyId, string awsSecretAccessKey,
            string bucket)
        {
            var currentChunkId = 0;
            var result = new KeyValuePair<int, Dictionary<long, List<string>>>(0, []);
            var prefix = $"{vendor}/{buildingId}/_chunks";
            using (var client = new AmazonS3Client(awsAccessKeyId, awsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = bucket,
                    Prefix = prefix
                };

                var response = client.ListObjectsV2Async(request);
                response.Wait();

                foreach (var o in response.Result.S3Objects.OrderBy(o => o.LastModified))
                {
                    var loadAttempt = 0;
                    var loaded = false;
                    while (!loaded)
                    {
                        try
                        {
                            loadAttempt++;
                            using (var transferUtility = new TransferUtility(client))
                            {
                                transferUtility.Download($@"{localTmpPath}\{o.Key}", bucket, o.Key);
                            }
                            loaded = true;
                        }
                        catch (Exception)
                        {
                            if (loadAttempt <= 11)
                            {
                                Console.WriteLine(o.Key + " | " + loadAttempt);
                            }
                            else
                            {
                                throw;
                            }
                        }
                    }

                    using (var responseStream = File.Open($@"{localTmpPath}\{o.Key}", FileMode.Open))
                    using (var bufferedStream = new BufferedStream(responseStream))
                    using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                    using (var reader = new StreamReader(gzipStream, Encoding.Default))
                    {
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

                    File.Delete($@"{localTmpPath}\{o.Key}");
                }
            }

            if (result.Value.Count > 0)
                yield return result;
        }
    }
}
