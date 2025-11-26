using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using CsvHelper.Configuration;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using RunValidation.Domain;
using Spectre.Console;
using System.Collections.Concurrent;
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
        private readonly List<ChunkReport> _chunkReports = new List<ChunkReport>();

        #endregion

        #region Methods
        public void ValidateBuildingId(Vendor vendor, int buildingId, List<int> chunksToProcess)
        {

            var timer = Stopwatch.StartNew();

            var actualSlices = GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            Process(vendor, buildingId, chunksToProcess, actualSlices);

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
            var person = new Person(chunkId, personId);
            GetSlicesFromS3(new HashSet<Person>() { person }, vendor, buildingId, chunkId);
            if (person.SliceId.HasValue)
            {
                AnsiConsole.MarkupLine($"[green]PersonId {person.PersonId} was found in raw SliceId {person.SliceId}![/]");
            }
            else
            {
                AnsiConsole.MarkupLine($"[red]PersonId {person.PersonId} was not found in raw Vendor {vendor.Name} - BuildingId {buildingId} - ChunkId {chunkId}![/]");
            }
        }


        private void Process(Vendor vendor, int buildingId, List<int> chunksToProcess, List<int> slicesToProcess)
        {
            var prefix = $"{vendor}/{buildingId}/_chunks";

            using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                var request = new ListObjectsV2Request
                {
                    BucketName = _bucket,
                    Prefix = prefix
                };
                ListObjectsV2Response response;
                Task<ListObjectsV2Response> responseTask;

                List<S3Object> s3ChunkObjects = new List<S3Object>();

                AnsiConsole.Progress()
                    .AutoClear(false)
                    .HideCompleted(false)
                    .Columns(
                        new TaskDescriptionColumn(),
                        new ElapsedTimeColumn(),
                        new SpinnerColumn())
                    .Start(ctx =>
                    {
                        var taskDescription = "Getting S3 _chunks objects.";
                        var task = ctx.AddTask(taskDescription);
                        do
                        {
                            responseTask = client.ListObjectsV2Async(request);
                            responseTask.Wait();
                            response = responseTask.Result;
                            s3ChunkObjects.AddRange(response.S3Objects);

                            task.Description = taskDescription + " | Files=" + s3ChunkObjects.Count;
                            request.ContinuationToken = response.NextContinuationToken;
                        } while (response.IsTruncated);
                        
                        s3ChunkObjects = s3ChunkObjects
                            .OrderBy(s => GetS3ChunksFileNumber(s.Key))
                            .ToList();
                    });

                var errorMessages = new ConcurrentQueue<string>();
                var consoleLock = new object();

                AnsiConsole.Progress()
                    .AutoClear(false)
                    .HideCompleted(true)
                    .Columns(
                        new TaskDescriptionColumn(),
                        new ElapsedTimeColumn(),
                        new ProgressBarColumn(),
                        new PercentageColumn(),
                        new RemainingTimeColumn(),
                        new SpinnerColumn())
                    .Start(ctx =>
                    {
                        var overallTask = ctx.AddTask("Processing S3 _chunks objects...", maxValue: s3ChunkObjects.Count);

                        var processingTasks = new List<Task>();
                        int maxDegreeOfParallelism = Environment.ProcessorCount == 1 ? 1 : Environment.ProcessorCount - 1;
                        var semaphore = new SemaphoreSlim(maxDegreeOfParallelism);

                        foreach (var s3obj in s3ChunkObjects)
                        {
                            var task = Task.Run(() =>
                            {
                                try
                                {
                                    var chunkFilePersonIds = ReadChunkFile(s3obj, vendor, buildingId, chunksToProcess);
                                    var chunkId = chunkFilePersonIds.First().Value.ChunkId;

                                    ValidateChunkFile(
                                        vendor,
                                        buildingId,
                                        chunkId,
                                        chunkFilePersonIds,
                                        slicesToProcess,
                                        errorMessages,
                                        ctx.AddTask($"Chunk {chunkId}", maxValue: slicesToProcess.Count));

                                    overallTask.Increment(1);
                                }
                                finally
                                {
                                    lock (consoleLock)
                                    {
                                        while (errorMessages.TryDequeue(out var msg))
                                        {
                                            AnsiConsole.MarkupLine(msg); //not threadsafe
                                        }
                                    }
                                    semaphore.Release();
                                }
                            });

                            processingTasks.Add(task);
                        }

                        Task.WaitAll(processingTasks.ToArray());
                    });
            }
        }

        private int GetS3ChunksFileNumber(string filename)
            =>
            int.Parse(new string(filename.Split('/')
                .Last()
                .Where(a => Char.IsDigit(a))
                .ToArray()));

        /// <summary>
        /// 
        /// </summary>
        /// <param name="s3obj"></param>
        /// <param name="vendor"></param>
        /// <param name="buildingId"></param>
        /// <param name="chunksWhiteList"></param>
        /// <returns>person.personId, person</returns>
        /// <exception cref="Exception"></exception>
        private ConcurrentDictionary<long, Person> ReadChunkFile(S3Object s3obj, Vendor vendor, int buildingId, List<int> chunksWhiteList)
        {
            var filePersonIds = new ConcurrentDictionary<long, Person>();

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
                var chunkId = int.Parse(splits[0]);
                var personId = long.Parse(splits[1]);
                var personSourceValue = splits[2];

                if (!chunksWhiteList.Any() || chunksWhiteList.Any(s => s == chunkId))
                    if (!filePersonIds.TryAdd(personId, new Person(chunkId, personId, personSourceValue)))
                        throw new Exception($"Failed to add a new person! ChunkId={chunkId}, PersonId={personId}, PersonSourceValue={personSourceValue}");

                line = reader.ReadLine();
            }

            return filePersonIds;
        }

        private void ValidateChunkFile(
            Vendor vendor,
            int buildingId,
            int chunkId,
            ConcurrentDictionary<long, Person> chunkFilePersons,
            List<int> slices,
            ConcurrentQueue<string> errorMessages,
            ProgressTask task)
        {
            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices, errorMessages);

            foreach (var slice in s3ObjectsBySlice)
            {
                ValidateSliceId(chunkFilePersons, vendor, buildingId, chunkId, slice.Key, slice.Value.PersonObjects, slice.Value.MetadataObjects, errorMessages);
                task.Increment(1);
            }
        }



        private HashSet<int> GetActualSlices(string vendorName, int buildingId)
        {
            var slices = new HashSet<int>();
            var prefix = $"{vendorName}/{buildingId}/{_cdmFolder}/PERSON/PERSON.";

            AnsiConsole.Progress()
               .AutoClear(false)
               .HideCompleted(false)
               .Columns(
                   new TaskDescriptionColumn(),
                   new ElapsedTimeColumn(),
                   new SpinnerColumn())
               .Start(ctx =>
               {
                   string taskDescription = "Calculating slices " + _bucket + "|" + prefix;
                   var task = ctx.AddTask(taskDescription);

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

                           task.Description = taskDescription + " | Count=" + slices.Count;
                           request.ContinuationToken = response.NextContinuationToken;
                       } while (response.IsTruncated);
                   }
               });

            AnsiConsole.WriteLine();

            return slices;
        }

        private Dictionary<int, (List<S3Object> PersonObjects, List<S3Object> MetadataObjects)> GetS3ObjectsBySlice(Vendor vendor, 
            int buildingId, int chunkId, List<int> slices2process, ConcurrentQueue<string> errorMessages)
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
                errorMessages.Enqueue(msg);
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
        /// <param name="chunkFilePersons"></param>
        /// <param name="vendor"></param>
        /// <param name="buildingId"></param>
        /// <param name="chunkId"></param>
        /// <param name="sliceId"></param>
        /// <param name="PersonObjects"></param>
        /// <param name="MetadataObjects"></param>
        /// <returns></returns>
        private void ValidateSliceId(
            ConcurrentDictionary<long, Person> chunkFilePersons,
            Vendor vendor,
            int buildingId,
            int chunkId,
            int sliceId,
            List<S3Object> PersonObjects,
            List<S3Object> MetadataObjects,
            ConcurrentQueue<string> errorMessages)
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
                        using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                        {
                            HasHeaderRecord = false,
                            Delimiter = ",",
                            Encoding = Encoding.UTF8
                        });
                        while (csv.Read())
                        {
                            var personId = (long)csv.GetField(typeof(long), 0);

                            var person = chunkFilePersons[personId];
                            person.SliceId ??= sliceId;

                            if (o.Key.Contains("PERSON"))
                                person.InPersonFilesCount++;
                            else if (o.Key.Contains("METADATA_TMP"))
                                person.InMetadataFilesCount++;
                            else
                                throw new NotImplementedException("o.Key=" + o.Key);
                        }
                    });

                    var slicePersonsDuplicated = chunkFilePersons.Values
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount > 1)
                        .ToHashSet();

                    var slicePersonsZero = chunkFilePersons.Values
                        .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount == 0 || s.PersonSourceValue == null)
                        .ToHashSet();

                    timer.Stop();

                    if (slicePersonsZero.Count > 0)
                    {
                        string sliceMsg = $"chunkId={chunkId}" +
                        $" sliceId={sliceId}" +
                        $" (personId={slicePersonsZero.First().PersonId})" +
                        $" | {vendor.Name} {buildingId} {chunkId} {sliceId.ToString().PadLeft(4, '0')} true" +
                        $" | Info: Duplicates={slicePersonsDuplicated.Count}";

                        errorMessages.Enqueue(sliceMsg);
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
        /// <param name="person"></param>
        /// <param name="table"></param>
        /// <returns></returns>
        private void GetSlicesFromS3(HashSet<Person> personsOfSingleChunkId, Vendor vendor, int buildingId, int chunkId)
        {
            var prefix = $"{vendor.Name}/{buildingId}/raw/{chunkId}/{vendor.PersonTableName}/{vendor.PersonTableName}";

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
                            var personId = long.Parse(line.Split('\t')[vendor.PersonIdIndex]);                            
                            if (personsOfSingleChunkId.TryGetValue(new Person(chunkId, personId), out var personProvided))
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

        #endregion

    }
}