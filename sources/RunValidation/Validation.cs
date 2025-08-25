using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using Spectre.Console;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.IO.Compression;
using System.Text;
using ZstdSharp;

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

            public override string ToString()
            {
                return $"{Vendor} - {BuildingId} - {ChunkId} - {SliceId?.ToString() ?? "???"} - {PersonId}";
            }
            
            public override bool Equals(object? obj)
            {
                if (obj is not PersonInS3Chunk other || other == null)
                    return false;

                return EqualityComparer<Vendor>.Default.Equals(this.Vendor, other.Vendor)
                    && BuildingId == other.BuildingId
                    && ChunkId == other.ChunkId
                    && PersonId == other.PersonId;
            }

            public override int GetHashCode()
            {
                return HashCode.Combine(Vendor != null ? Vendor.GetHashCode() : 0,
                    BuildingId,
                    ChunkId,
                    PersonId);
            }
        }
        
        class ChunkReport
        {
            public int BuildingId { get; set; }
            public int ChunkId { get; set; }
            public int OnlyInBatchIdsCount { get; set; }
            public List<int> AllSlicesWithOnlyInBatchIds { get; set; } = new List<int>();
            public List<PersonInS3Chunk> PersonsWithCalculatedSlice { get; set; } = new List<PersonInS3Chunk>();
            public List<SliceReport> SliceReports { get; set; } = new List<SliceReport>();
        }

        class SliceReport
        {
            public int BuildingId { get; set; }
            public int ChunkId { get; set; }
            public int SliceId { get; set; }
            public int WrongCount { get; set; }
            public int Duplicates { get; set; }
            public long ExampleWrongPersonId { get; set; }
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
        private readonly List<ChunkReport> _chunkReports = new List<ChunkReport>();

        #endregion

        #region Methods
        public void ValidateBuildingId(Vendor vendor, int buildingId, List<int> chunks)
        {

            var timer = Stopwatch.StartNew();

            var actualSlices = GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            ProcessChunks(vendor, buildingId, chunks, actualSlices);

            foreach (var chunkReport in _chunkReports.OrderBy(c => c.ChunkId))
            {
                var sliceIdPersons = chunkReport.PersonsWithCalculatedSlice.DistinctBy(s => s.SliceId).OrderBy(s => s.SliceId).ToList();
                foreach (var person in sliceIdPersons)
                {
                    var chunkMsg = $"chunkId={chunkReport.ChunkId}" +
                        $" sliceId={person.SliceId}" +
                        $" (personId={person.PersonId})" +
                        $" | {vendor.Name} {buildingId} {chunkReport.ChunkId} {person.SliceId.ToString()!.PadLeft(4, '0')} true" +
                        $" | Info: LostPersonCount={chunkReport.PersonsWithCalculatedSlice.Where(s => s.SliceId == person.SliceId).Count()})";
                    AnsiConsole.MarkupLine($"[red]{chunkMsg}[/]");
                }

                foreach (var sliceReport in chunkReport.SliceReports.OrderBy(s => s.SliceId))
                {
                    if (sliceReport.WrongCount == 0 || sliceIdPersons.Any(s => s.SliceId == sliceReport.SliceId))
                        continue;

                    string sliceMsg = $"chunkId={sliceReport.ChunkId}" +
                        $" sliceId={sliceReport.SliceId}" +
                        $" (personId={sliceReport.ExampleWrongPersonId})" +
                        $" | {vendor.Name} {buildingId} {chunkReport.ChunkId} {sliceReport.SliceId.ToString().PadLeft(4, '0')} true" +
                        $" | Info: Duplicates={sliceReport.Duplicates}";
                    AnsiConsole.MarkupLine($"[red]{sliceMsg}[/]");
                }
            }


            timer.Stop();
            AnsiConsole.MarkupLine($"[green]Done. Total seconds={timer.ElapsedMilliseconds / 1000}s[/]");
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
            var person = new PersonInS3Chunk(personId, vendor, buildingId, chunkId) { IsFromBatch = false };
            GetSlicesFromS3(new HashSet<PersonInS3Chunk>() { person }, vendor.PersonTableName, vendor.PersonIdIndex);
            if (person.SliceId.HasValue)
            {
                AnsiConsole.MarkupLine($"[green]PersonId {person.PersonId} was found in raw SliceId {person.SliceId}![/]");
            }
            else
            {
                AnsiConsole.MarkupLine($"[red]PersonId {person.PersonId} was not found in raw Vendor {vendor.Name} - BuildingId {buildingId} - ChunkId {chunkId}![/]");
            }
        }


        private void ProcessChunks(Vendor vendor, int buildingId, List<int> chunks, List<int> slices)
        {
            var prefix = $"{vendor}/{buildingId}/_chunks";

            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };

                var s3Objects = client
                    .ListObjectsV2Async(request)
                    .GetAwaiter()
                    .GetResult()
                    .S3Objects
                    .OrderBy(s => s.LastModified)
                    .ToList();

                var chunkIds = s3Objects
                    .Select(o => int.Parse(o.Key.Split(new[] { "_chunks", ".txt", ".gz", ".zst" }, StringSplitOptions.RemoveEmptyEntries).Last()))
                    .Distinct()
                    .ToList();

                if (chunks.Any())
                {
                    chunkIds = chunkIds.Where(chunkId => chunks.Contains(chunkId)).ToList();
                }

                var totalChunks = chunkIds.Count;

                AnsiConsole.Progress()
                    .AutoClear(false)
                    .HideCompleted(true)
                    .Columns(
                        new TaskDescriptionColumn(),
                        new ProgressBarColumn(),
                        new PercentageColumn(),
                        new RemainingTimeColumn(),
                        new SpinnerColumn())
                    .Start(ctx =>
                    {
                        var overallTask = ctx.AddTask("Processing chunks...", maxValue: totalChunks);

                        var processingTasks = new List<Task>();
                        int maxDegreeOfParallelism = Environment.ProcessorCount == 1 ? 1 : Environment.ProcessorCount - 1;
                        var semaphore = new SemaphoreSlim(maxDegreeOfParallelism);

                        foreach (var s3obj in s3Objects)
                        {
                            var chunkId = int.Parse(s3obj.Key.Split(new[] { "_chunks", ".txt", ".gz", ".zst" }, StringSplitOptions.RemoveEmptyEntries).Last());

                            if (chunks.Any() && !chunks.Contains(chunkId))
                            {
                                overallTask.Increment(1);
                                continue;
                            }

                            semaphore.Wait();
                            var localChunkId = chunkId;

                            var task = Task.Run(() =>
                            {
                                try
                                {
                                    var chunkPersonIds = new ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>>();

                                    using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                                    using var responseStream = transferUtility.OpenStream(_bucket, s3obj.Key);
                                    using var bufferedStream = new BufferedStream(responseStream);
                                    using Stream compressedStream = s3obj.Key.EndsWith(".gz")
                                        ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                                        : new DecompressionStream(bufferedStream); // .zst
                                    using var reader = new StreamReader(compressedStream, Encoding.Default);
                                    string? line = reader.ReadLine();
                                    while (!string.IsNullOrEmpty(line))
                                    {
                                        var splits = line.Split('\t');
                                        var personId = long.Parse(splits[1]);

                                        var sliceIdDictionary = chunkPersonIds.GetOrAdd(-1, _ => new ConcurrentDictionary<long, PersonInS3Chunk>());
                                        sliceIdDictionary.GetOrAdd(personId, _ => new PersonInS3Chunk(personId, vendor, buildingId, localChunkId));

                                        line = reader.ReadLine();
                                    }

                                    ValidateChunkIdWithProgress(
                                        vendor,
                                        buildingId,
                                        localChunkId,
                                        chunkPersonIds,
                                        slices,
                                        ctx.AddTask($"Chunk {localChunkId}", maxValue: slices.Count));

                                    overallTask.Increment(1);
                                }
                                finally
                                {
                                    semaphore.Release();
                                }
                            });

                            processingTasks.Add(task);
                        }

                        Task.WaitAll(processingTasks.ToArray());
                    });
            }
        }

        private void ValidateChunkIdWithProgress(
            Vendor vendor,
            int buildingId,
            int chunkId,
            ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>> chunkPersonIds,
            List<int> slices,
            ProgressTask task)
        {
            var chunkReport = new ChunkReport
            {
                BuildingId = buildingId,
                ChunkId = chunkId
            };

            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices);

            foreach (var slice in s3ObjectsBySlice)
            {
                ValidateSliceId(chunkPersonIds, vendor, buildingId, chunkId, slice.Key, slice.Value.PersonObjects, slice.Value.MetadataObjects, chunkReport);
                task.Increment(1);
            }

            var personIdsInPersonOrMetadata = chunkPersonIds
                .Where(s => s.Key != -1) // -1 has copies of all the personIds, even without assigned SliceId
                .SelectMany(s => s.Value.Keys)
                .ToHashSet();

            var personsInBatchOnly = chunkPersonIds
                .First(s => s.Key == -1).Value.Values
                .Where(s => !personIdsInPersonOrMetadata.Contains(s.PersonId))
                .ToHashSet();

            if (personsInBatchOnly.Count > 0)
            {
                GetSlicesFromS3(personsInBatchOnly, vendor.PersonTableName, vendor.PersonIdIndex);

                var slicesToCheck = personsInBatchOnly
                    .Where(s => s.SliceId.HasValue)
                    .Select(s => s.SliceId!.Value)
                    .Distinct()
                    .OrderBy(s => s)
                    .ToList();

                chunkReport.OnlyInBatchIdsCount = personsInBatchOnly.Count;
                chunkReport.AllSlicesWithOnlyInBatchIds = slicesToCheck;
                chunkReport.PersonsWithCalculatedSlice = personsInBatchOnly.ToList();
            }

            lock (_chunkReports)
            {
                _chunkReports.Add(chunkReport);
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
        private void ValidateSliceId(
            ConcurrentDictionary<int, ConcurrentDictionary<long, PersonInS3Chunk>> chunkPersonIds,
            Vendor vendor,
            int buildingId,
            int chunkId,
            int sliceId,
            List<S3Object> PersonObjects,
            List<S3Object> MetadataObjects,
            ChunkReport chunkReport)
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

                    var allObjects = PersonObjects.Union(MetadataObjects).ToList();

                    allObjects.ForEach(o =>
                    {
                        using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                        using var responseStream = transferUtility.OpenStream(_bucket, o.Key);
                        using var bufferedStream = new BufferedStream(responseStream);
                        using Stream compressedStream = o.Key.EndsWith(".gz")
                            ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                            : new DecompressionStream(bufferedStream);
                        using var reader = new StreamReader(compressedStream, Encoding.Default);
                        using var csv = org.ohdsi.cdm.framework.common.Helpers.CsvHelper.CreateCsvReader(reader);
                        //using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                        //{
                        //    HasHeaderRecord = false,
                        //    Delimiter = ",",
                        //    Encoding = Encoding.UTF8
                        //});
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

                    if (!chunkPersonIds.TryGetValue(sliceId, out var slicePersonIds))
                        return;

                    var slicePersonIdsDuplicated = slicePersonIds.Values
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount > 1)
                        .ToHashSet();

                    var slicePersonIdsZero = slicePersonIds.Values
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount == 0 || !s.IsFromBatch)
                        .ToHashSet();

                    timer.Stop();

                    if (slicePersonIdsZero.Count > 0)
                    {
                        var sliceReport = new SliceReport
                        {
                            BuildingId = buildingId,
                            ChunkId =  chunkId,
                            SliceId = sliceId,
                            WrongCount = slicePersonIdsZero.Count,
                            Duplicates = slicePersonIdsDuplicated.Count,
                            ExampleWrongPersonId = slicePersonIdsZero.First().PersonId
                        };

                        chunkReport.SliceReports.Add(sliceReport);
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
        private void GetSlicesFromS3(HashSet<PersonInS3Chunk> personsOfSingleChunkId, string table, int personIndex)
        {
            var vendor = personsOfSingleChunkId.First().Vendor;
            var buildingId = personsOfSingleChunkId.First().BuildingId;
            var chunkId = personsOfSingleChunkId.First().ChunkId;

            var prefix = $"{vendor.Name}/{buildingId}/raw/{chunkId}/{table}/{table}";

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
                            if (personsOfSingleChunkId.TryGetValue(new PersonInS3Chunk(personId, vendor, buildingId, chunkId, false), out var personProvided))
                            {
                                var chars = o.Key
                                            .Split('/')
                                            .Last()
                                            .SkipWhile(s => !char.IsDigit(s))
                                            .TakeWhile(s => char.IsDigit(s))
                                            .ToArray();
                                personProvided.SliceId = int.Parse(new string(chars));

                                if (personsOfSingleChunkId.All(s => s.SliceId.HasValue))
                                    return;
                            }
                            line = reader.ReadLine();
                        }
                    }

                }
            }
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