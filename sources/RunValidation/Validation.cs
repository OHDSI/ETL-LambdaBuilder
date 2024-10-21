using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper.Configuration;
using CsvHelper;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Numerics;
using System.Runtime.InteropServices;
using System.Text;
using ZstdSharp;

namespace RunValidation
{

    public class Validation(string awsAccessKeyId, string awsSecretAccessKey, string bucket, string tmpFolder, string cdmFolder)
    {
        #region Fields 

        private readonly string _awsAccessKeyId = awsAccessKeyId;
        private readonly string _awsSecretAccessKey = awsSecretAccessKey;
        private readonly string _bucket = bucket;
        private readonly string _tmpFolder = tmpFolder;
        private readonly string _cdmFolder = cdmFolder;
        private readonly LambdaUtility _lambdaUtility = 
            new LambdaUtility(awsAccessKeyId, awsSecretAccessKey, awsAccessKeyId, awsSecretAccessKey, bucket, bucket, bucket, cdmFolder);

        #endregion

        #region Methods

        public void ValidateBuildingId(Vendor vendor, int buildingIdToCheck, IEnumerable<int> chunkIdsToCheck, IEnumerable<int> slicesToCheck)
        {
            var wrong = new List<string>();
            var timer = new Stopwatch();
            timer.Start();

            foreach (var chunk in GetChunks(vendor, buildingIdToCheck))
            {
                var chunkId = chunk.Key;
                if (chunkIdsToCheck != null && chunkIdsToCheck.Any() && !chunkIdsToCheck.Any(s => s == chunkId))
                {
                    Console.WriteLine("Skip chunkId " + chunkId);
                    continue;
                }

                var actualSlices = GetActualSlices(vendor.Name, buildingIdToCheck);

                var slices2process = (slicesToCheck == null || !slicesToCheck.Any())
                    ? actualSlices
                        .OrderBy(s => s)
                        .ToList()
                    : slicesToCheck
                        .Distinct()
                        .Where(s => actualSlices.Any(a => a == s))
                        .OrderBy(s => s)
                        .ToList()
                    ;

                var objects = new List<S3Object>();
                foreach (var o in GetObjects(vendor, buildingIdToCheck, "PERSON", chunkId, slices2process))
                {
                    objects.AddRange(o);
                }

                foreach (var o in GetObjects(vendor, buildingIdToCheck, "METADATA_TMP", chunkId, slices2process))
                {
                    objects.AddRange(o);
                }

                if (objects.Count == 0)
                {
                    wrong.Add($"chunkId={chunkId} - MISSED");
                }

                ProcessChunk(vendor, buildingIdToCheck, objects, chunk, slices2process, true);

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

        private HashSet<int> GetActualSlices(string vendorName, int buildingId)
        {
            var slices = new HashSet<int>();
            var prefix = $"{vendorName}/{buildingId}/{_cdmFolder}/PERSON/PERSON.";
            Console.WriteLine("Calculating slices " + _bucket + "|" + prefix);
            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))

            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
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
                        slices.Add(int.Parse(o.Key.Split('.')[1]));
                    }

                    request.ContinuationToken = response.NextContinuationToken;
                } while (response.IsTruncated);
            }

            Console.WriteLine("slices.Count=" + slices.Count);

            return slices;
        }

        private IEnumerable<KeyValuePair<int, Dictionary<long, List<string>>>> GetChunks(Vendor vendor, int buildingId)
        {
            var currentChunkId = 0;
            var result = new KeyValuePair<int, Dictionary<long, List<string>>>(0, []);
            var prefix = $"{vendor}/{buildingId}/_chunks";
            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };

                var response = client.ListObjectsV2Async(request);
                response.Wait();

                foreach (var o in response.Result.S3Objects.OrderBy(o => o.LastModified))
                {
                    using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var responseStream = transferUtility.OpenStream(_bucket, o.Key);
                    using var bufferedStream = new BufferedStream(responseStream);
                    using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
                    using var reader = new StreamReader(gzipStream, Encoding.Default);
                    string? line = reader.ReadLine();
                    while (!string.IsNullOrEmpty(line))
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

                        line = reader.ReadLine();
                    }
                }
            }

            if (result.Value.Count > 0)
                yield return result;
        }

        private IEnumerable<List<S3Object>> GetObjects(Vendor vendor, int buildingId, string table, int chunkId, List<int> slices)
        {
            var orderedSlices = slices.Distinct().OrderBy(s => s).ToList();
            for (int i = 0; i < orderedSlices.Count; i++)
            {
                var prefix = $"{vendor}/{buildingId}/{_cdmFolder}/{table}/{table}.{orderedSlices[i]}.{chunkId}.";
                using var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };
                ListObjectsV2Response response;
                do
                {
                    response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                    yield return response.S3Objects;
                    request.ContinuationToken = response.NextContinuationToken;
                } 
                while (response.IsTruncated);
            }
        }

        private Dictionary<long, bool> ProcessChunk(Vendor vendor, int buildingId, List<S3Object> objects, KeyValuePair<int, 
            Dictionary<long, List<string>>> chunk, List<int> slices, bool onlyCheck = true)
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
                        using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                        using var responseStream = transferUtility.OpenStream(_bucket, o.Key);
                        using var bufferedStream = new BufferedStream(responseStream);
                        using Stream compressedStream = o.Key.EndsWith(".gz")
                            ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                            : new DecompressionStream(bufferedStream) //.zst
                            ;
                        using var reader = new StreamReader(compressedStream, Encoding.Default);
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
                            Cleanup(vendor, buildingId, chunk.Key, slices);
                            var tasks = _lambdaUtility.TriggerBuildFunction(vendor, buildingId, chunk.Key, false);
                            Task.WaitAll([.. tasks]);

                            var checkCreation = Task.Run(() => _lambdaUtility.AllChunksWereDone(vendor, buildingId, _lambdaUtility.BuildMessageBucket));

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

        private void Cleanup(Vendor vendor, int buildingId, int chunkId, List<int> slices)
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

                for (var i = 0; i < slices.Count; i++)
                {
                    Clean(vendor, buildingId, chunkId, table, slices[i]);
                }
            }

            Console.WriteLine($"chunkId={chunkId} was cleaned");
        }

        private IEnumerable<string> GetLines(Stream stream, string filePath)
        {
            using var bufferedStream = new BufferedStream(stream);
            using Stream compressedStream = filePath.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream) //.zst
                ;
            using var reader = new StreamReader(compressedStream, Encoding.Default);
            string? line;
            while ((line = reader.ReadLine()) != null)
            {
                if (!string.IsNullOrEmpty(line))
                {
                    yield return line;
                }
            }
        }

        private List<string> FindSlice(Vendor vendor, int buildingId, int chunkId, string table, Dictionary<long, bool> personIds, int personIndex)
        {
            var prefix = $"{vendor}/{buildingId}/raw/{chunkId}/{table}/{table}";

            var result = new HashSet<string>();
            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };

                var r = client.ListObjectsV2Async(request);
                r.Wait();
                var response = r.Result;
                var rows = new List<string>();
                foreach (var o in response.S3Objects)
                {
                    using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var responseStream = transferUtility.OpenStream(_bucket, o.Key);
                    {
                        foreach (var line in GetLines(responseStream, o.Key))
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

        private void Clean(Vendor vendor, int buildingId, int chunkId, string table, int slice)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;

                    var perfix = $"{vendor}/{buildingId}/{_cdmFolder}/{table}/{table}.{slice}.{chunkId}.";

                    using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
                    {
                        var request = new ListObjectsV2Request
                        {
                            BucketName = _bucket,
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
                                BucketName = _bucket
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

        #endregion

    }
}