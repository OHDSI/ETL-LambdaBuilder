using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Enums;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.IO.Compression;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{

    public class Validation
    {

        public Validation(
            string awsAccessKeyId,
            string awsSecretAccessKey,
            string bucket,
            string cdmFolder,
            IValidationReporter? reporter = null)
        {
            _awsAccessKeyId = awsAccessKeyId;
            _awsSecretAccessKey = awsSecretAccessKey;
            _bucket = bucket;
            _cdmFolder = cdmFolder;
            _reporter = reporter ?? NullValidationReporter.Instance;            
        }

        #region Fields 

        private readonly string _awsAccessKeyId;
        private readonly string _awsSecretAccessKey;
        private readonly string _bucket;
        private readonly string _cdmFolder;
        private readonly IValidationReporter _reporter;

        #endregion

        #region Methods

        public void ValidateBuildingId(Vendor vendor, int buildingId, List<int> chunksToProcess)
        {
            var timer = Stopwatch.StartNew();

            var actualSlices = GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            Process(vendor, buildingId, chunksToProcess, actualSlices);

            timer.Stop();

            Report(ValidationProgressEvent.Log(
                $"Done. Total seconds={timer.ElapsedMilliseconds / 1000}s",
                ValidationLogLevel.Success));
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
                Report(ValidationProgressEvent.Log(
                    $"PersonId {person.PersonId} was found in raw SliceId {person.SliceId}!",
                    ValidationLogLevel.Success));
            }
            else
            {
                Report(ValidationProgressEvent.Log(
                    $"PersonId {person.PersonId} was not found in raw Vendor {vendor.Name} - BuildingId {buildingId} - ChunkId {chunkId}!",
                    ValidationLogLevel.Error));
            }
        }

        private void Report(ValidationProgressEvent progressEvent)
        {
            _reporter.Report(progressEvent);
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
                List<S3Object> s3ChunkObjects = new List<S3Object>();

                const string s3ChunksTaskId = "s3-chunks";
                var s3ChunksTaskDescription = "Getting S3 _chunks objects.";

                Report(ValidationProgressEvent.StartTask(
                    s3ChunksTaskId,
                    s3ChunksTaskDescription,
                    1,
                    isIndeterminate: true));

                do
                {
                    response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                    s3ChunkObjects.AddRange(response.S3Objects);

                    Report(ValidationProgressEvent.UpdateTask(
                        s3ChunksTaskId,
                        s3ChunksTaskDescription + " | Files=" + s3ChunkObjects.Count));

                    request.ContinuationToken = response.NextContinuationToken;
                }
                while (response.IsTruncated ?? false);

                s3ChunkObjects = s3ChunkObjects
                    .OrderBy(s => GetS3ChunksFileNumber(s.Key))
                    .ToList();

                Report(ValidationProgressEvent.CompleteTask(
                    s3ChunksTaskId,
                    s3ChunksTaskDescription + " | Files=" + s3ChunkObjects.Count));

                Report(ValidationProgressEvent.Log("Error messages are in this format:"));
                Report(ValidationProgressEvent.Log(
                    "{vendor.Name} {buildingId} {chunkId} {sliceId} true"
                    + "\r\n| {example personId for debug}"
                    + "\r\n| C={correct person ids} N={no sliceId} D={duplicated personId} M={missing personId}"));

                int totalPersonsCount = 0;
                int chunkErrorsCount = 0;
                int actuallyProcessed = 0;
                int overallFilesDone = 0;

                var statsLock = new object();

                const string errorTaskId = "validation-errors";
                const string overallTaskId = "overall-chunks";

                Report(ValidationProgressEvent.StartTask(
                    errorTaskId,
                    "No errors yet",
                    100,
                    isIndeterminate: true));

                var overallTaskInitMsg = $"Processing _chunks objects. (0/{s3ChunkObjects.Count})";

                Report(ValidationProgressEvent.StartTask(
                    overallTaskId,
                    overallTaskInitMsg,
                    Math.Max(1, s3ChunkObjects.Count)));

                var degreeParallel = Math.Max(1, Environment.ProcessorCount - 1);
                int lastExclusive = s3ChunkObjects.Count;
                int nextFileId = -1;

                var workers = new List<Task>(degreeParallel);

                for (int w = 0; w < degreeParallel; w++)
                {
                    workers.Add(Task.Run(() =>
                    {
                        while (true)
                        {
                            int chunkFileId = Interlocked.Increment(ref nextFileId);

                            if (chunkFileId >= lastExclusive)
                            {
                                break;
                            }

                            int chunkFilePersonIdsCount = 0;
                            int? chunkId = null;
                            bool chunkHadErrors = false;

                            var chunkTaskId = $"chunk-file-{chunkFileId}";
                            var chunkTaskDescription = "Chunk ???";
                            var chunkErrorMessages = new ConcurrentQueue<string>();

                            Report(ValidationProgressEvent.StartTask(
                                chunkTaskId,
                                chunkTaskDescription,
                                Math.Max(1, slicesToProcess.Count)));

                            try
                            {
                                var chunkFilePersonIds = ReadChunkFile(
                                    s3ChunkObjects[chunkFileId],
                                    vendor,
                                    buildingId,
                                    chunksToProcess);

                                chunkFilePersonIdsCount = chunkFilePersonIds.Count;

                                if (chunkFilePersonIdsCount == 0)
                                {
                                    Report(ValidationProgressEvent.CompleteTask(
                                        chunkTaskId,
                                        "Chunk skipped"));

                                    var done = Interlocked.Increment(ref overallFilesDone);

                                    Report(ValidationProgressEvent.IncrementTask(
                                        overallTaskId,
                                        1,
                                        $"Processing _chunks objects. ({done}/{s3ChunkObjects.Count})"));

                                    continue;
                                }

                                chunkId = chunkFilePersonIds.First().Value.ChunkId;
                                chunkTaskDescription = $"Chunk {chunkId.Value}";

                                Report(ValidationProgressEvent.UpdateTask(
                                    chunkTaskId,
                                    chunkTaskDescription));

                                ValidateChunkFile(
                                    vendor,
                                    buildingId,
                                    chunkId.Value,
                                    chunkFilePersonIds,
                                    slicesToProcess,
                                    chunkErrorMessages,
                                    chunkTaskId);

                                Interlocked.Increment(ref actuallyProcessed);

                                var processed = Interlocked.Increment(ref overallFilesDone);

                                Report(ValidationProgressEvent.IncrementTask(
                                    overallTaskId,
                                    1,
                                    $"Processing _chunks objects. ({processed}/{s3ChunkObjects.Count})"));
                            }
                            catch (Exception ex)
                            {
                                chunkHadErrors = true;

                                Report(ValidationProgressEvent.KeepTaskWithMessage(
                                    chunkTaskId,
                                    $"Chunk {chunkId?.ToString() ?? "unknown"} failed: {ex.Message}", ValidationLogLevel.Error));

                                throw;
                            }
                            finally
                            {
                                lock (statsLock)
                                {
                                    totalPersonsCount += chunkFilePersonIdsCount;

                                    while (chunkErrorMessages.TryDequeue(out var msg))
                                    {
                                        chunkHadErrors = true;
                                        chunkErrorsCount++;

                                        Report(ValidationProgressEvent.CompleteTask(
                                            errorTaskId,
                                            "Errors were found"));

                                        Report(ValidationProgressEvent.KeepTaskWithMessage(
                                            chunkTaskId,
                                            msg, ValidationLogLevel.Error));
                                    }
                                }

                                if (!chunkHadErrors && chunkFilePersonIdsCount > 0)
                                {
                                    Report(ValidationProgressEvent.CompleteTask(
                                        chunkTaskId,
                                        chunkTaskDescription));
                                }
                            }
                        }
                    }));
                }

                Task.WaitAll(workers.ToArray());

                var finalOverallValue = s3ChunkObjects.Count > 0
                    ? s3ChunkObjects.Count - 0.1
                    : 1;

                Report(ValidationProgressEvent.UpdateTask(
                    overallTaskId,
                    $"Processing _chunks objects. ({overallFilesDone}/{s3ChunkObjects.Count})",
                    finalOverallValue));

                Report(ValidationProgressEvent.Log(
                    "\r\nProcessed " + actuallyProcessed + " out of total " + s3ChunkObjects.Count + " files or " + totalPersonsCount + " persons. "
                    + chunkErrorsCount + " Chunks with errors are written above in red."));
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
            var separator = new[] { ',', ' ', '\t', '	' };
            while (!string.IsNullOrEmpty(line))
            {
                var splits = line.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                var chunkId = int.Parse(splits[0]);
                var personId = long.Parse(splits[1]);
                var personSourceValue = splits[2];

                if (chunksWhiteList != null && chunksWhiteList.Any() && !chunksWhiteList.Any(s => s == chunkId))
                    return filePersonIds; // each file seem only to contain a single chunkId

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
            string chunkTaskId)
        {
            var s3ObjectsBySlice = GetS3ObjectsBySlice(vendor, buildingId, chunkId, slices, errorMessages);

            foreach (var slice in s3ObjectsBySlice)
            {
                ValidateSliceId(
                    chunkFilePersons,
                    vendor,
                    buildingId,
                    chunkId,
                    slice.Key,
                    slice.Value.PersonObjects,
                    slice.Value.MetadataObjects,
                    errorMessages);

                Report(ValidationProgressEvent.IncrementTask(
                    chunkTaskId,
                    1,
                    $"Chunk {chunkId} | Slice {slice.Key}"));
            }

            //keeping hashsets requires more memory, but allows a better debug

            var personsCorrect = chunkFilePersons.Values
                .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount == 1
                         && s.SliceId != null)
                .ToHashSet();

            var personsWithoutSliceId = chunkFilePersons.Values
                .Where(s => s.SliceId == null)
                .ToHashSet();

            var personsDuplicated = chunkFilePersons.Values
                .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount > 1)
                .ToHashSet();

            var personsZero = chunkFilePersons.Values
                .Where(s => s.InPersonFilesCount + s.InMetadataFilesCount == 0)
                .ToHashSet();

            var personsBadAll = personsWithoutSliceId
                .Union(personsDuplicated)
                .Union(personsZero)
                .ToHashSet();

            if (personsBadAll.Count > 0)
            {
                var sliceId = personsBadAll.FirstOrDefault(s => s.SliceId != null)?.SliceId.ToString() ?? "null";
                var personId = personsBadAll.First().PersonId;

                string sliceMsg =
                    $"{vendor.Name} {buildingId} {chunkId} {sliceId.PadLeft(4, '0')} true" +
                    $" | {personId}" +
                    $" | C={personsCorrect.Count}, N={personsWithoutSliceId.Count}, D={personsDuplicated.Count}, M={personsZero.Count}";

                errorMessages.Enqueue(sliceMsg);
            }
        }



        private HashSet<int> GetActualSlices(string vendorName, int buildingId)
        {
            var slices = new HashSet<int>();
            var prefix = $"{vendorName}/{buildingId}/{_cdmFolder}/PERSON/PERSON.";

            const string taskId = "actual-slices";
            string taskDescription = "Calculating slices";

            Report(ValidationProgressEvent.StartTask(
                taskId,
                taskDescription,
                1,
                isIndeterminate: true));

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
                    response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();

                    foreach (var o in response.S3Objects)
                    {
                        slices.Add(int.Parse(o.Key.Split('.')[1]));
                    }

                    Report(ValidationProgressEvent.UpdateTask(
                        taskId,
                        taskDescription + ": " + slices.Count));

                    request.ContinuationToken = response.NextContinuationToken;
                }
                while (response.IsTruncated ?? false);
            }

            Report(ValidationProgressEvent.KeepTaskWithMessage(
                taskId,
                taskDescription + ": " + slices.Count, ValidationLogLevel.Success));

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

                if(PersonObjects != null)
                    s3ObjectsBySlice[sliceId].PersonObjects.AddRange(PersonObjects);
            }

            foreach (var tuple in GetObjects(vendor, buildingId, "METADATA_TMP", chunkId, slices2process))
            {
                int sliceId = tuple.Item1;
                List<S3Object> MetadataObjects = tuple.Item2;

                if (!s3ObjectsBySlice.ContainsKey(sliceId))
                    s3ObjectsBySlice[sliceId] = (new List<S3Object>(), new List<S3Object>());

                if (MetadataObjects != null)
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
                while (response.IsTruncated ?? false);
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

                            var person = chunkFilePersons[personId];
                            person.SliceId ??= sliceId;

                            if (o.Key.Contains("PERSON"))
                                person.InPersonFilesCount++;
                            else if (o.Key.Contains("METADATA_TMP"))
                            {
                                var attrition = csv.GetField(typeof(string), 1) as string;

                                if (attrition != "Discarded drug count")
                                    person.InMetadataFilesCount++;
                            }
                            else
                                throw new NotImplementedException("o.Key=" + o.Key);
                        }
                    });

                    timer.Stop();
                    complete = true;
                }
                catch (Exception ex)
                {
                    var msg = $"{ex.Message} | ProcessChunk Exception | new attempt | attempt={attempt}";
                    Report(ValidationProgressEvent.Log(
                        msg,
                        ValidationLogLevel.Error));
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