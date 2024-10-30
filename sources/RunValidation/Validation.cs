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
using System.IO;
using System.Diagnostics.Eventing.Reader;

namespace RunValidation
{

    public class Validation(string awsAccessKeyId, string awsSecretAccessKey, string bucket, string tmpFolder, string cdmFolder)
    {
        #region classes

        class PersonInS3Chunk(long PersonId, Vendor Vendor, int BuildingId, int ChunkId, bool IsFromBatch = true)
        {
            public long PersonId { get; set; } = PersonId;
            public Vendor Vendor { get; set; } = Vendor;
            public int BuildingId { get; set; } = BuildingId;
            public int ChunkId { get; set; } = ChunkId;
            public bool IsFromBatch { get; set; } = IsFromBatch;
            public int? SliceId { get; set; }
            public int? InPersonFilesCount { get; set; } = 0;
            public int? InMetadataFilesCount { get; set; } = 0;

            public override int GetHashCode()
            {
                return Vendor.GetHashCode() ^ BuildingId.GetHashCode() ^ ChunkId.GetHashCode() ^ PersonId.GetHashCode(); //assumming that a single PersonId is never duplicated in a single ChunkId
            }

            public override bool Equals(object? obj)
            {
                if (obj is not PersonInS3Chunk)
                    return false;
                return ((PersonInS3Chunk)obj).GetHashCode() == this.GetHashCode();                
            }

            public override string ToString()
            {
                return $"{Vendor} - {BuildingId} - {ChunkId} - {SliceId?.ToString() ?? "???"} - {PersonId}";
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

        /// <summary>
        /// <ChunkId, <SliceId, <PersonId, Person>>>
        /// </summary>
        private ConcurrentDictionary<int, ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>> _personsBySliceIdByChunkId; 


        #endregion

        #region Methods

        public void ValidateBuildingId(Vendor vendor, int buildingId, List<int> chunks)
        {
            _personsBySliceIdByChunkId = new ConcurrentDictionary<int, ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>>();

            var _wrong = new List<string>();
            var timer = new Stopwatch();
            timer.Start();

            var actualSlices = GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            int chunkCount = 0;

            AnsiConsole.Status()
                .Spinner(Spinner.Known.Dots)
                .Start("Getting all chunks...", ctx =>
                {
                    var progress = new Progress<int>(count =>
                    {
                        chunkCount = count;
                        ctx.Status($"Getting all chunks... (Chunks obtained: {chunkCount})");
                    });

                    GetPersonsByChunkId(vendor, buildingId, chunks, progress);
                });

            timer.Stop();
            AnsiConsole.MarkupLine($"[green]Getting all {_personsBySliceIdByChunkId.Keys.Count} chunks done. It took {timer.ElapsedMilliseconds / 1000}s[/]");
            timer.Restart();

            ProcessChunksWithProgress(vendor, buildingId, chunks, actualSlices);

            timer.Stop();
            AnsiConsole.MarkupLine($"[green]Done. Problematic chunks, if any, are described above the chunk progress. Total seconds={timer.ElapsedMilliseconds / 1000}s[/]");
            timer.Restart();
        }

        /// <summary>
        /// Short version to quickly get sliceId for a given personId
        /// </summary>
        /// <param name="vendor"></param>
        /// <param name="buildingId"></param>
        /// <param name="chunkId"></param>
        /// <param name="personId"></param>
        public void ValidatePersonIdInSlice(Vendor vendor, int buildingId, int chunkId, long personId)
        {
            _personsBySliceIdByChunkId = new ConcurrentDictionary<int, ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>>();
            var person = new PersonInS3Chunk(personId, vendor, buildingId, chunkId) { IsFromBatch = false };
            person.SliceId = FindSlice(person, vendor.PersonTableName, vendor.PersonIdIndex);
            if (person.SliceId.HasValue)
            {
                AnsiConsole.MarkupLine($"[green]PersonId {person.PersonId} was found in raw SliceId {person.SliceId}![/]");
            }
            else
            {
                AnsiConsole.MarkupLine($"[red]PersonId {person.PersonId} was not found in raw Vendor {vendor.Name} - BuildingId {buildingId} - ChunkId {chunkId}![/]");
            }
        }


        private void GetPersonsByChunkId(Vendor vendor, int buildingId, List<int> chunks, IProgress<int> progress)
        {
            _personsBySliceIdByChunkId = new ConcurrentDictionary<int, ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>>(); 



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

                        var chunkIdDictionary = _personsBySliceIdByChunkId.GetOrAdd(chunkId, new ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>());
                        var sliceIdDictionary = chunkIdDictionary.GetOrAdd(-1, new ConcurrentDictionary<long, PersonInS3Chunk>());
                        var person = sliceIdDictionary.GetOrAdd(personId, new PersonInS3Chunk(personId, vendor, buildingId, chunkId));

                        line = reader.ReadLine();
                    }
                }
            }
        }



        private void ProcessChunksWithProgress(Vendor vendor, int buildingId, List<int> chunks, List<int> actualSlices)
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

                    foreach (var awsChunkId in _personsBySliceIdByChunkId.Keys)
                    {
                        if (chunks.Any() && !chunks.Contains(awsChunkId))
                        {
                            continue;
                        }

                        var task = ctx.AddTask($"Chunk {awsChunkId}", maxValue: actualSlices.Count);
                        tasks[awsChunkId] = task;
                    }

                    Parallel.ForEach(_personsBySliceIdByChunkId.Keys.OrderBy(s => s)
                        , new ParallelOptions {MaxDegreeOfParallelism = Environment.ProcessorCount == 1 ? 1 : Environment.ProcessorCount - 1 } // leave 1 core for UI and OS
                        , awsChunkId =>
                    {
                        var awsChunkPersonIds = _personsBySliceIdByChunkId[awsChunkId];

                        if (tasks.TryGetValue(awsChunkId, out var task))
                        {
                            ValidateChunkIdWithProgress(vendor, buildingId, awsChunkId, awsChunkPersonIds, actualSlices, task);
                        }

                        _personsBySliceIdByChunkId[awsChunkId].Clear();
                        awsChunkPersonIds = null;
                        GC.Collect();
                    });
                    GC.KeepAlive(_personsBySliceIdByChunkId);
                });
        }



        private void  ValidateChunkIdWithProgress(Vendor vendor, int buildingId, int chunkId, ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>> chunkPersonIds, List<int> slices, ProgressTask task)
        {
            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices);

            foreach (var slice in s3ObjectsBySlice)
            {
                ValidateSliceId(chunkPersonIds, vendor, buildingId, chunkId, slice.Key, slice.Value.PersonObjects, slice.Value.MetadataObjects);                
                task.Increment(1);
            }

            var personIdsInPersonOrMetadata = chunkPersonIds
                .Where(s => s.Key != -1) // Sliceid -1 contains copies from all other SliceId HashSets
                .SelectMany(s => s.Value.Keys)
                .ToHashSet();

            var personsInBatchOnly = chunkPersonIds
                .First(s => s.Key == -1).Value.Values // Sliceid -1 contains copies from all other SliceId HashSets 
                .Where(s => !personIdsInPersonOrMetadata.TryGetValue(s.PersonId, out long matchedPersonId))
                .ToHashSet();
            
            if (personsInBatchOnly.Count > 0)
            {
                var inBatchOnlyExample = personsInBatchOnly.First();
                inBatchOnlyExample.SliceId = FindSlice(inBatchOnlyExample, vendor.PersonTableName, vendor.PersonIdIndex);

                var msg = $"[red]BuildingId={buildingId} ChunkId={chunkId} | InBatchOnlyPersonIdsCount={personsInBatchOnly.Count} " +
                    $"| Example PersonId = {inBatchOnlyExample.PersonId}, SliceId = {inBatchOnlyExample.SliceId.ToString() ?? "???"}[/]";
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

        private Dictionary<int, (List<S3Object> PersonObjects, List<S3Object> MetadataObjects)> GetS3ObjectsBySlice(Vendor vendor, 
            int buildingId, int chunkId, List<int> slices2process)
        {
            var s3ObjectsBySlice = new Dictionary<int, (List<S3Object> PersonObjects, List<S3Object> MetadataObjects)>();

            foreach (var tuple in GetObjects(vendor, buildingId, "PERSON", chunkId, slices2process))
            {
                int sliceId = tuple.Item1;
                List<S3Object> PersonObjects = tuple.Item2;

                if (!s3ObjectsBySlice.ContainsKey(sliceId))
                    s3ObjectsBySlice[sliceId] = (new List<S3Object>(), new List<S3Object>());

                s3ObjectsBySlice[sliceId].PersonObjects.AddRange(PersonObjects);
            }

            foreach (var tuple in GetObjects(vendor, buildingId, "METADATA_TMP", chunkId, slices2process))
            {
                int sliceId = tuple.Item1;
                List<S3Object> MetadataObjects = tuple.Item2;

                if (!s3ObjectsBySlice.ContainsKey(sliceId))
                    s3ObjectsBySlice[sliceId] = (new List<S3Object>(), new List<S3Object>());

                s3ObjectsBySlice[sliceId].MetadataObjects.AddRange(MetadataObjects);
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
        /// <param name="PersonObjects"></param>
        /// <param name="MetadataObjects"></param>
        /// <returns>Subset of chunkPersonIds for the specified sliceId</returns>
        private void ValidateSliceId(ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>> chunkPersonIds, Vendor vendor, int buildingId, int chunkId, int sliceId, 
            List<S3Object> PersonObjects, List<S3Object> MetadataObjects)
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

                    #region chunkPersonIds -> set counts. After this chunkPersonIds will have a HashSet for each SliceId and all of them are also in Sliceid -1.

                    var attempt1 = attempt;

                    var allObjects = PersonObjects.Union(MetadataObjects).ToList();
                                        

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

                            var sliceIdDictionary = chunkPersonIds.GetOrAdd(sliceId, new ConcurrentDictionary<long, PersonInS3Chunk>());                             
                            var personToProcess = sliceIdDictionary.GetOrAdd(personId, chunkPersonIds[-1][personId]);
                            personToProcess.SliceId ??= sliceId;

                            if (o.Key.Contains("PERSON"))
                            {
                                personToProcess.InPersonFilesCount++;
                            }
                            else if (o.Key.Contains("METADATA_TMP"))
                            {
                                personToProcess.InMetadataFilesCount++;
                            }
                            else
                                throw new NotImplementedException("o.Key=" + o.Key);
                        }

                    });

                    #endregion

                    if (!chunkPersonIds.TryGetValue(sliceId, out var slicePersonIds))
                        return;

                    var slicePersonIdsDuplicated = slicePersonIds.Values
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount > 1)
                        .ToHashSet();

                    var slicePersonIdsWrongCount = slicePersonIds.Values
                        .Where(s => s.InPersonFilesCount != 1 || s.InMetadataFilesCount != 0 || !s.IsFromBatch)
                        .ToHashSet();

                    timer.Stop();

                    if (slicePersonIdsWrongCount.Count > 0)
                    {
                        var msg = $"[red]BuildingId={buildingId} ChunkId={chunkId} SliceId={sliceId} " +
                            $"| WrongCount={slicePersonIdsWrongCount.Count}; Duplicates={slicePersonIdsDuplicated.Count} " +
                            $"| Example Wrong Person Id = {slicePersonIdsWrongCount.First().PersonId}[/]";
                        AnsiConsole.MarkupLine(msg);
                    }

                    complete = true;
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
        }

        /// <summary>
        /// Try to get sliceId which contains given PersonId and other parameters
        /// </summary>
        /// <param name="person">This should have Vendor, BuildingId, ChunkId, and PersonId information</param>
        /// <param name="table"></param>
        /// <returns></returns>
        private int? FindSlice(PersonInS3Chunk person, string table, int personIndex)
        {            
            var prefix = $"{person.Vendor.Name}/{person.BuildingId}/raw/{person.ChunkId}/{table}/{table}";

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
                        using var bufferedStream = new BufferedStream(responseStream);
                        using Stream compressedStream = o.Key.EndsWith(".gz")
                            ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                            : new DecompressionStream(bufferedStream) //.zst
                            ;
                        using var reader = new StreamReader(compressedStream, Encoding.Default);
                        string? line = reader.ReadLine();
                        while (!string.IsNullOrEmpty(line))
                        {
                            var personId = long.Parse(line.Split('\t')[personIndex]);
                            if (person.PersonId == personId)
                            {
                                var chars = o.Key
                                            .Split('/')
                                            .Last()
                                            .SkipWhile(s => !char.IsDigit(s))
                                            .TakeWhile(s => char.IsDigit(s))
                                            .ToArray();
                                var sliceId = int.Parse(new string(chars));
                                return sliceId;
                            }
                            line = reader.ReadLine();
                        }
                    }
                }
            }

            return null;
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