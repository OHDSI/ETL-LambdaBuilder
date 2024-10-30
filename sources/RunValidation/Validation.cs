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
using Spectre.Console;
using System.Collections.Concurrent;

namespace RunValidation
{

    public class Validation(string awsAccessKeyId, string awsSecretAccessKey, string bucket, string tmpFolder, string cdmFolder)
    {
        #region classes

        public class PersonInS3Chunk(long PersonId, int ChunkId, bool IsFromBatch = true)
        {
            public long PersonId { get; set; } = PersonId;
            public int ChunkId { get; set; } = ChunkId;
            public bool IsFromBatch { get; set; } = IsFromBatch;
            public int? SliceId { get; set; }
            public int? InPersonFilesCount { get; set; } = 0;
            public int? InMetadataFilesCount { get; set; } = 0;

            public override int GetHashCode()
            {
                return PersonId.GetHashCode(); //assumming that a single PersonId is never duplicated in a single ChunkId
            }

            public override bool Equals(object? obj)
            {
                if (obj is not PersonInS3Chunk)
                    return false;
                return ((PersonInS3Chunk)obj).GetHashCode() == this.GetHashCode();                
            }

            public override string ToString()
            {
                return $"{ChunkId} - {SliceId?.ToString() ?? "???"} - {PersonId}";
            }
        }

        #endregion

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

        public void ValidateBuildingId(Vendor vendor, int buildingId, List<int> chunks)
        {
            var _wrong = new List<string>();
            var timer = new Stopwatch();
            timer.Start();

            var actualSlices = GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            int chunkCount = 0;
            var personsByChunkId = new Dictionary<int, HashSet<PersonInS3Chunk>>();

            AnsiConsole.Status()
                .Spinner(Spinner.Known.Dots)
                .Start("Getting all chunks...", ctx =>
                {
                    var progress = new Progress<int>(count =>
                    {
                        chunkCount = count;
                        ctx.Status($"Getting all chunks... (Chunks obtained: {chunkCount})");
                    });

                    personsByChunkId = GetPersonsByChunkId(vendor, buildingId, chunks, progress);
                });

            timer.Stop();
            AnsiConsole.MarkupLine($"[green]Getting all {personsByChunkId.Keys.Count} chunks done. It took {timer.ElapsedMilliseconds / 1000}s[/]");
            timer.Restart();

            ProcessChunksWithProgress(vendor, buildingId, chunks, actualSlices, personsByChunkId);

            timer.Stop();
            AnsiConsole.MarkupLine($"[green]Done. Problematic chunks, if any, are described above the chunk progress. Total seconds={timer.ElapsedMilliseconds / 1000}s[/]");
            timer.Restart();
        }




        private Dictionary<int, HashSet<PersonInS3Chunk>> GetPersonsByChunkId(Vendor vendor, int buildingId, List<int> chunks, IProgress<int> progress)
        {            
            var persons = new Dictionary<int, HashSet<PersonInS3Chunk>>();

            var prefix = $"{vendor}/{buildingId}/_chunks";
            int chunkCount = 0;
            int previousChunk = -1;

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
                    using Stream compressedStream = o.Key.EndsWith(".gz")
                        ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                        : new DecompressionStream(bufferedStream) //.zst
                        ;
                    using var reader = new StreamReader(compressedStream, Encoding.Default);
                    string? line = reader.ReadLine();
                    while (!string.IsNullOrEmpty(line))
                    {
                        var splits = line.Split('\t');
                        var chunkId = int.Parse(splits[0]);
                        var personId = long.Parse(splits[1]);

                        if (chunkId != previousChunk)
                        {
                            previousChunk = chunkId;
                            chunkCount++;
                            progress?.Report(chunkCount);
                        }
                        if (chunks.Any() && !chunks.Any(s => s == chunkId))
                            break;

                        if (!persons.ContainsKey(chunkId))
                            persons.Add(chunkId, new HashSet<PersonInS3Chunk>());
                        persons[chunkId].Add(new PersonInS3Chunk(personId, chunkId));

                        line = reader.ReadLine();
                    }
                }
            }

            return persons;
        }



        private void ProcessChunksWithProgress(Vendor vendor, int buildingId, List<int> chunks, List<int> actualSlices, Dictionary<int, HashSet<PersonInS3Chunk>> personsByChunkId)
        {
            AnsiConsole.MarkupLine("\n");

            AnsiConsole.Progress()
                .AutoClear(false)
                .HideCompleted(false)
                .Columns(
                    new TaskDescriptionColumn(),
                    new ProgressBarColumn(),
                    new PercentageColumn(),
                    new RemainingTimeColumn(),
                    new SpinnerColumn())
                .Start(ctx =>
                {
                    var tasks = new ConcurrentDictionary<int, ProgressTask>();

                    foreach (var awsChunkId in personsByChunkId.Keys)
                    {
                        if (chunks.Any() && !chunks.Contains(awsChunkId))
                        {
                            continue;
                        }

                        var task = ctx.AddTask($"Chunk {awsChunkId}", maxValue: actualSlices.Count);
                        tasks[awsChunkId] = task;
                    }

                    Parallel.ForEach(personsByChunkId.Keys.OrderBy(s => s)
                        , new ParallelOptions {MaxDegreeOfParallelism = Environment.ProcessorCount == 1 ? 1 : Environment.ProcessorCount - 1 } // leave 1 core for UI and OS
                        , awsChunkId =>
                    {
                        var awsChunkPersonIds = personsByChunkId[awsChunkId];

                        if (tasks.TryGetValue(awsChunkId, out var task))
                        {
                            ValidateChunkIdWithProgress(vendor, buildingId, awsChunkPersonIds, actualSlices, task);
                        }

                        personsByChunkId[awsChunkId].Clear();
                        awsChunkPersonIds = null;
                        GC.Collect();
                    });
                    GC.KeepAlive(personsByChunkId);
                });
        }



        private void  ValidateChunkIdWithProgress(Vendor vendor, int buildingId, HashSet<PersonInS3Chunk> chunkPersonIds, List<int> slices, ProgressTask task)
        {
            var chunkId = chunkPersonIds.First().ChunkId;

            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices);

            foreach (var slice in s3ObjectsBySlice)
            {
                var slicePersonIds = ValidateSliceId(chunkPersonIds, vendor, buildingId, chunkId, slice.Key, slice.Value.personObjects, slice.Value.metadataObjects);    
                task.Increment(1);
            }

            var inBatchOnlyPersonIds = chunkPersonIds
                .Where(s => s.InMetadataFilesCount + s.InPersonFilesCount == 0)
                .ToHashSet();
            

            if (inBatchOnlyPersonIds.Count > 0)
            {
                var msg = $"[red]BuildingId={buildingId} ChunkId={chunkId} | InBatchOnlyPersonIdsCount={inBatchOnlyPersonIds.Count} | Id Example={inBatchOnlyPersonIds.First().PersonId}[/]";
                AnsiConsole.MarkupLine(msg);
            }

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

        /// <summary>
        /// This method alters members of chunkPersonIds collection
        /// </summary>
        /// <param name="chunkPersonIds"></param>
        /// <param name="vendor"></param>
        /// <param name="buildingId"></param>
        /// <param name="chunkId"></param>
        /// <param name="sliceId"></param>
        /// <param name="personObjects"></param>
        /// <param name="metadataObjects"></param>
        /// <returns>Subset of chunkPersonIds for the specified sliceId</returns>
        private HashSet<PersonInS3Chunk> ValidateSliceId(HashSet<PersonInS3Chunk> chunkPersonIds, Vendor vendor, int buildingId, int chunkId, int sliceId, 
            List<S3Object> personObjects, List<S3Object> metadataObjects)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;
                    var timer = new Stopwatch();
                    timer.Start();

                    #region chunkPersonIds -> set counts

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
                            lock (chunkPersonIds)
                            {
                                var localPersonInS3 = new PersonInS3Chunk(personId, chunkId, false);
                                if (chunkPersonIds.TryGetValue(localPersonInS3, out var actual))                                
                                    localPersonInS3 = actual;                                
                                else
                                    chunkPersonIds.Add(localPersonInS3);

                                localPersonInS3.SliceId ??= sliceId;

                                if (o.Key.Contains("PERSON"))
                                    localPersonInS3.InPersonFilesCount++;
                                else if (o.Key.Contains("METADATA_TMP"))
                                    localPersonInS3.InMetadataFilesCount++;
                            }
                        }
                        Interlocked.Increment(ref cnt);
                    });

                    #endregion

                    var slicePersonIds = chunkPersonIds
                        .Where(s => s.SliceId == sliceId)
                        .ToHashSet();

                    var slicePersonIdsDuplicated = slicePersonIds
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount > 1)
                        .ToHashSet();

                    var slicePersonIdsWrongCount = slicePersonIds
                        .Where(s => s.InPersonFilesCount != 1 || s.InMetadataFilesCount != 0 || !s.IsFromBatch)
                        .ToHashSet();

                    timer.Stop();

                    if (slicePersonIdsWrongCount.Count > 0)
                    {
                        var msg = $"[red]BuildingId={buildingId} ChunkId={chunkId} SliceId={sliceId} " +
                            $"| WrongCount={slicePersonIdsWrongCount.Count}; Duplicates={slicePersonIdsDuplicated.Count} " +
                            $"| Wrong Person Id Example={slicePersonIdsWrongCount.First().PersonId}[/]";
                        AnsiConsole.MarkupLine(msg);
                    }

                    complete = true;
                    return slicePersonIds;
                }
                catch (Exception ex)
                {
                    var msg = $"[red]{ex.Message} | ProcessChunk Exception | new attempt | attempt={attempt}[/]";
                    AnsiConsole.MarkupLine(msg);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
            return new HashSet<PersonInS3Chunk>();
        }

        #endregion

    }
}