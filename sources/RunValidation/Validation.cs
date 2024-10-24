using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper.Configuration;
using CsvHelper;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using System.Diagnostics;
using System.Globalization;
using System.IO.Compression;
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

        public void ValidateBuildingId(Vendor vendor, int buildingId, List<(int ChunkId, int? SliceId)> chunkSlicePairs)
        {
            var _wrong = new List<string>();
            var timer = new Stopwatch();
            timer.Start();

            var actualSlices = GetActualSlices(vendor.Name, buildingId);

            foreach (var awsChunk in GetChunks(vendor, buildingId))
            {
                var awsChunkId = awsChunk.Key;

                if (chunkSlicePairs.Any() && !chunkSlicePairs.Any(s => s.ChunkId == awsChunkId))
                {
                    Console.WriteLine();
                    Console.WriteLine($"BuildingId {buildingId} ChunkId {awsChunkId} skipped");
                    continue;
                }
                Console.WriteLine();
                Console.WriteLine($"BuildingId {buildingId} ChunkId {awsChunkId} validation start");

                var slices = chunkSlicePairs
                    .Where(s => s.ChunkId == awsChunkId)
                    .Where(s => s.SliceId != null)
                    .Select(s => s.SliceId ?? -1) //change type int? to int
                    .ToList();

                var slices2process = (!slices.Any())
                    ? actualSlices
                        .OrderBy(s => s)
                        .ToList()
                    : slices
                        .Distinct()
                        .Where(s => actualSlices.Any(a => a == s))
                        .OrderBy(s => s)
                        .ToList()
                    ;

                ValidateChunkId(vendor, buildingId, awsChunkId, slices2process);

                Console.WriteLine($"BuildingId {buildingId} ChunkId {awsChunkId} is validated");
            }

            Console.WriteLine();
            timer.Stop();
            Console.WriteLine($"Done. Total seconds={timer.ElapsedMilliseconds/1000}s");
            timer.Restart();
        }

        private void ValidateChunkId(Vendor vendor, int buildingId, int chunkId, List<int> slices)
        {

            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices);

            Parallel.ForEach(s3ObjectsBySlice, slice =>
            {
                ValidateSliceId(vendor, buildingId, chunkId, slice.Key, slice.Value.personObjects, slice.Value.metadataObjects);
            });
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
            Console.WriteLine();

            return slices;
        }

        private Dictionary<int, (List<S3Object> personObjects, List<S3Object> metadataObjects)> GetS3ObjectsBySlice(Vendor vendor, 
            int buildingId, int chunkId, List<int> slices2process)
        {
            var s3ObjectsBySlice = new Dictionary<int, (List<S3Object> PersonObjects, List<S3Object> MetadataObjects)>();

            foreach (var tuple in GetObjects(vendor, buildingId, "PERSON", chunkId, slices2process))
            {
                int sliceId = tuple.Item1;
                List<S3Object> personObjects = tuple.Item2;

                if (!s3ObjectsBySlice.ContainsKey(sliceId))
                    s3ObjectsBySlice[sliceId] = (new List<S3Object>(), new List<S3Object>());

                s3ObjectsBySlice[sliceId].PersonObjects.AddRange(personObjects);
            }

            foreach (var tuple in GetObjects(vendor, buildingId, "METADATA_TMP", chunkId, slices2process))
            {
                int sliceId = tuple.Item1;
                List<S3Object> metadataObjects = tuple.Item2;

                if (!s3ObjectsBySlice.ContainsKey(sliceId))
                    s3ObjectsBySlice[sliceId] = (new List<S3Object>(), new List<S3Object>());

                s3ObjectsBySlice[sliceId].MetadataObjects.AddRange(metadataObjects);
            }

            if (s3ObjectsBySlice.Count == 0)
            {
                var msg = $"chunkId={chunkId} - MISSED";
                Console.WriteLine(msg);
            }

            return s3ObjectsBySlice;
        }

        private IEnumerable<Tuple<int, List<S3Object>>> GetObjects(Vendor vendor, int buildingId, string table, int chunkId, List<int> slices)
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
                    yield return Tuple.Create(orderedSlices[i], response.S3Objects);
                    request.ContinuationToken = response.NextContinuationToken;
                } 
                while (response.IsTruncated);
            }
        }

        private HashSet<long> ValidateSliceId(Vendor vendor, int buildingId, int chunkId, int sliceId, 
            List<S3Object> personObjects, List<S3Object> metadataObjects)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;
                    var appearenceStatsByPersonId = new Dictionary<long, (int InPersonCount, int InMetadataCount)>();

                    var timer = new Stopwatch();
                    timer.Start();

                    #region get appearenceStatsByPersonId

                    var cnt = 0;
                    var attempt1 = attempt;

                    var allObjects = personObjects.Union(metadataObjects).ToList();

                    Parallel.ForEach(allObjects, o =>
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
                            lock (appearenceStatsByPersonId)
                            {
                                if (!appearenceStatsByPersonId.ContainsKey(personId))
                                    appearenceStatsByPersonId[personId] = (0, 0);

                                var tuple = appearenceStatsByPersonId[personId];

                                if (o.Key.Contains("PERSON"))
                                    tuple.InPersonCount++;
                                else if (o.Key.Contains("METADATA_TMP"))
                                    tuple.InMetadataCount++;

                                appearenceStatsByPersonId[personId] = tuple;
                            }
                        }
                        Interlocked.Increment(ref cnt);
                    });

                    #endregion

                    int wrongCount = 0;
                    var dups = 0;
                    var wrongPersonIds = new HashSet<long>();

                    foreach (var kvp in appearenceStatsByPersonId)
                    {
                        var personId = kvp.Key;
                        var stats = kvp.Value;

                        //check InPersonCount just in case, InMetadataCount should actually suffice
                        if (stats.InPersonCount > 1 || stats.InMetadataCount > 0)
                        {
                            wrongCount++;
                                                        
                            if (stats.InPersonCount > 1 || stats.InMetadataCount > 1)
                                dups++;

                            if(!wrongPersonIds.Contains(personId))
                                wrongPersonIds.Add(personId);
                        }
                    }

                    timer.Stop();

                    if (wrongCount > 0)
                    {
                        var msg = $"--BuildingId={buildingId} ChunkId={chunkId} SliceId={sliceId} | WrongCount={wrongCount}; Duplicates={dups} | Wrong Person Id Example={wrongPersonIds.First()}";
                        Console.WriteLine(msg);
                    }

                    complete = true;
                    return wrongPersonIds;
                }
                catch (Exception ex)
                {
                    Console.Write("--" + ex.Message + " | [ProcessChunk] Exception | new attempt | attempt=" + attempt);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
            return null;
        }

        #endregion

    }
}