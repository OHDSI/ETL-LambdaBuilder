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
        #region ValidationProgressChangedEvent

        public sealed class ValidationProgressChangedEventArgs : EventArgs
        {
            public ValidationProgressChangedEventArgs(
                int lastProcessedChunkId,
                int processedChunksCount,
                int totalChunksCount)
            {
                LastProcessedChunkId = lastProcessedChunkId;
                ProcessedChunksCount = processedChunksCount;
                TotalChunksCount = totalChunksCount;
            }

            public int LastProcessedChunkId { get; }

            public int ProcessedChunksCount { get; }

            public int TotalChunksCount { get; }
        }

        public event EventHandler<ValidationProgressChangedEventArgs>? ProgressChanged;

        private readonly object _progressLock = new object();

        private int _lastProcessedChunkId;
        private int _processedChunksCount;
        private int _totalChunksCount;

        public int LastProcessedChunkId
        {
            get
            {
                lock (_progressLock)
                {
                    return _lastProcessedChunkId;
                }
            }
        }

        public int ProcessedChunksCount
        {
            get
            {
                lock (_progressLock)
                {
                    return _processedChunksCount;
                }
            }
        }

        public int TotalChunksCount
        {
            get
            {
                lock (_progressLock)
                {
                    return _totalChunksCount;
                }
            }
        }

        private void SetTotalChunksCount(int totalChunksCount, bool showProgress = true)
        {
            ValidationProgressChangedEventArgs args;

            lock (_progressLock)
            {
                _totalChunksCount = totalChunksCount;

                args = new ValidationProgressChangedEventArgs(
                    _lastProcessedChunkId,
                    _processedChunksCount,
                    _totalChunksCount);
            }

            if (showProgress)
                ProgressChanged?.Invoke(this, args);
        }

        private void MarkChunkProcessed(int chunkId)
        {
            ValidationProgressChangedEventArgs args;

            lock (_progressLock)
            {
                _lastProcessedChunkId = chunkId;
                _processedChunksCount++;

                args = new ValidationProgressChangedEventArgs(
                    _lastProcessedChunkId,
                    _processedChunksCount,
                    _totalChunksCount);
            }

            ProgressChanged?.Invoke(this, args);
        }

        #endregion

        private const int MaxReadAttempts = 3;

        private static readonly char[] ChunkFileSeparators = new[] { ',', ' ', '\t' };

        private readonly string _awsAccessKeyId;
        private readonly string _awsSecretAccessKey;
        private readonly string _bucket;
        private readonly string _cdmFolder;

        public Validation(
            string awsAccessKeyId,
            string awsSecretAccessKey,
            string bucket,
            string cdmFolder)
        {
            _awsAccessKeyId = awsAccessKeyId;
            _awsSecretAccessKey = awsSecretAccessKey;
            _bucket = bucket;
            _cdmFolder = cdmFolder;
        }

        public BuildingValidationResult ValidateBuildingId(
            Vendor vendor,
            int buildingId,
            IReadOnlyCollection<int>? chunksToProcess = null,
            int? degreeOfParallelism = null)
        {
            var timer = Stopwatch.StartNew();
            var issues = new ConcurrentBag<ValidationIssue>();
            var chunkResults = new ConcurrentBag<ChunkValidationResult>();

            var actualSlices = GetActualSlices(vendor.Name, buildingId)
                .OrderBy(s => s)
                .ToList();

            var s3ChunkObjects = GetS3ChunkObjects(vendor, buildingId);
            SetTotalChunksCount(s3ChunkObjects.Count, false);
            var chunkFilesSkipped = 0;

            var parallelOptions = new ParallelOptions
            {
                MaxDegreeOfParallelism = degreeOfParallelism.GetValueOrDefault(Math.Max(1, Environment.ProcessorCount - 1))
            };

            Parallel.ForEach(s3ChunkObjects, parallelOptions, s3ChunkObject =>
            {
                var result = ValidateChunkObject(
                    vendor,
                    buildingId,
                    s3ChunkObject,
                    actualSlices,
                    chunksToProcess); 

                if (result == null)
                {
                    Interlocked.Increment(ref chunkFilesSkipped); 
                    return;
                }

                chunkResults.Add(result);
            });

            timer.Stop();

            var orderedChunkResults = chunkResults
                .OrderBy(r => r.ChunkId)
                .ToList();

            return new BuildingValidationResult(
                vendor.Name,
                buildingId,
                s3ChunkObjects.Count,
                orderedChunkResults.Count,
                chunkFilesSkipped,
                actualSlices.Count,
                orderedChunkResults,
                issues.OrderBy(i => i.ChunkId).ThenBy(i => i.SliceId).ThenBy(i => i.PersonId).ToList(),
                timer.Elapsed);
        }

        public ChunkValidationResult ValidateChunkId(
            Vendor vendor,
            int buildingId,
            int chunkId,
            IReadOnlyCollection<int>? slicesToProcess = null)
        {
            var timer = Stopwatch.StartNew();

            var slices = slicesToProcess is { Count: > 0 }
                ? slicesToProcess.OrderBy(s => s).ToList()
                : GetActualSlices(vendor.Name, buildingId).OrderBy(s => s).ToList();

            var chunkObjects = GetS3ChunkObjects(vendor, buildingId);

            foreach (var chunkObject in chunkObjects)
            {
                var result = ValidateChunkObject(
                    vendor,
                    buildingId,
                    chunkObject,
                    slices,
                    new HashSet<int> { chunkId });

                if (result != null)
                {
                    timer.Stop();

                    return result with
                    {
                        Elapsed = timer.Elapsed
                    };
                }
            }

            timer.Stop();

            var issue = new ValidationIssue(
                ValidationIssueType.ChunkFileMissing,
                buildingId,
                chunkId,
                null,
                null,
                $"Chunk file was not found for Vendor={vendor.Name}, BuildingId={buildingId}, ChunkId={chunkId}");

            return new ChunkValidationResult(
                vendor.Name,
                buildingId,
                chunkId,
                0,
                0,
                new PersonValidationCounts(0, 0, 0, 0, 0),
                new List<SliceValidationResult>(),
                new List<PersonValidationProblem>(),
                new List<ValidationIssue> { issue },
                timer.Elapsed);
        }

        public SliceValidationResult ValidateSliceId(
            Vendor vendor,
            int buildingId,
            int chunkId,
            int sliceId)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            var chunkPersons = TryReadChunkPersonsByChunkId(
                vendor,
                buildingId,
                chunkId,
                out var chunkFileIssue);

            if (chunkFileIssue != null)
            {
                issues.Add(chunkFileIssue);
            }

            var objectsBySlice = GetS3ObjectsBySlice(
                vendor,
                buildingId,
                chunkId,
                new List<int> { sliceId });

            if (!objectsBySlice.TryGetValue(sliceId, out var sliceObjects))
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    buildingId,
                    chunkId,
                    sliceId,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={vendor.Name}, BuildingId={buildingId}, ChunkId={chunkId}, SliceId={sliceId}"));

                timer.Stop();

                return new SliceValidationResult(
                    vendor.Name,
                    buildingId,
                    chunkId,
                    sliceId,
                    0,
                    0,
                    0,
                    0,
                    0,
                    issues,
                    timer.Elapsed);
            }

            var result = ValidateSliceObjects(
                vendor,
                buildingId,
                chunkId,
                sliceObjects,
                chunkPersons);

            timer.Stop();

            return result with
            {
                Issues = result.Issues.Concat(issues).ToList(),
                Elapsed = timer.Elapsed
            };
        }

        public PersonIdValidationResult ValidatePersonId(
            Vendor vendor,
            int buildingId,
            int chunkId,
            long personId)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();
            var person = new Person(chunkId, personId);

            try
            {
                GetSlicesFromS3(new HashSet<Person> { person }, vendor, buildingId, chunkId);
            }
            catch (Exception exception)
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.Exception,
                    buildingId,
                    chunkId,
                    null,
                    personId,
                    exception.Message));
            }

            timer.Stop();

            return new PersonIdValidationResult(
                vendor.Name,
                buildingId,
                chunkId,
                personId,
                person.SliceId.HasValue,
                person.SliceId,
                issues,
                timer.Elapsed);
        }

        private ChunkValidationResult? ValidateChunkObject(
            Vendor vendor,
            int buildingId,
            S3Object chunkObject,
            IReadOnlyCollection<int> slicesToProcess,
            IReadOnlyCollection<int>? chunksToProcess)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            Dictionary<long, Person> chunkFilePersons;

            try
            {
                chunkFilePersons = ReadChunkFile(chunkObject, chunksToProcess);
            }
            catch (Exception exception)
            {
                var chunkIdFromFileName = TryGetS3ChunksFileNumber(chunkObject.Key)
                    ?? throw new Exception("Failed to extract chunkId from file name!");

                issues.Add(new ValidationIssue(
                    ValidationIssueType.Exception,
                    buildingId,
                    chunkIdFromFileName,
                    null,
                    null,
                    exception.Message));

                timer.Stop();

                return new ChunkValidationResult(
                    vendor.Name,
                    buildingId,
                    chunkIdFromFileName,
                    0,
                    0,
                    new PersonValidationCounts(0, 0, 0, 0, 0),
                    new List<SliceValidationResult>(),
                    new List<PersonValidationProblem>(),
                    issues,
                    timer.Elapsed);
            }

            if (chunkFilePersons.Count == 0)
            {
                return null;
            }

            var chunkId = chunkFilePersons.First().Value.ChunkId;

            var objectsBySlice = GetS3ObjectsBySlice(
                vendor,
                buildingId,
                chunkId,
                slicesToProcess);

            if (objectsBySlice.Count == 0)
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    buildingId,
                    chunkId,
                    null,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={vendor.Name}, BuildingId={buildingId}, ChunkId={chunkId}"));
            }

            var sliceResults = new List<SliceValidationResult>();

            foreach (var sliceObjects in objectsBySlice.Values.OrderBy(s => s.SliceId))
            {
                var sliceResult = ValidateSliceObjects(
                    vendor,
                    buildingId,
                    chunkId,
                    sliceObjects,
                    chunkFilePersons);

                sliceResults.Add(sliceResult);
            }

            var counts = CalculatePersonValidationCounts(chunkFilePersons.Values);
            var personProblems = GetPersonProblems(chunkFilePersons.Values).ToList();

            MarkChunkProcessed(chunkId);

            timer.Stop();

            return new ChunkValidationResult(
                vendor.Name,
                buildingId,
                chunkId,
                chunkFilePersons.Count,
                sliceResults.Count,
                counts,
                sliceResults,
                personProblems,
                issues,
                timer.Elapsed);
        }

        private SliceValidationResult ValidateSliceObjects(
            Vendor vendor,
            int buildingId,
            int chunkId,
            SliceObjects sliceObjects,
            Dictionary<long, Person> chunkFilePersons)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            var personRowsRead = 0;
            var metadataRowsRead = 0;
            var unexpectedPersonIds = new HashSet<long>();
            var localCounters = new Dictionary<long, PersonSliceCounters>();

            if (sliceObjects.PersonObjects.Count == 0 && sliceObjects.MetadataObjects.Count == 0)
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    buildingId,
                    chunkId,
                    sliceObjects.SliceId,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={vendor.Name}, BuildingId={buildingId}, ChunkId={chunkId}, SliceId={sliceObjects.SliceId}"));

                timer.Stop();

                return new SliceValidationResult(
                    vendor.Name,
                    buildingId,
                    chunkId,
                    sliceObjects.SliceId,
                    0,
                    0,
                    0,
                    0,
                    0,
                    issues,
                    timer.Elapsed);
            }

            var allObjects = sliceObjects.PersonObjects
                .Concat(sliceObjects.MetadataObjects)
                .ToList();

            var complete = false;
            var attempt = 0;

            while (!complete)
            {
                attempt++;

                localCounters.Clear();
                unexpectedPersonIds.Clear();
                personRowsRead = 0;
                metadataRowsRead = 0;

                try
                {
                    foreach (var s3Object in allObjects)
                    {
                        var objectKind = DetectObjectKind(s3Object.Key);

                        using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                        using var responseStream = transferUtility.OpenStream(_bucket, s3Object.Key);
                        using var bufferedStream = new BufferedStream(responseStream);
                        using Stream compressedStream = s3Object.Key.EndsWith(".gz")
                            ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                            : new DecompressionStream(bufferedStream);
                        using var reader = new StreamReader(compressedStream, Encoding.Default);
                        using var csv = org.ohdsi.cdm.framework.common.Helpers.CsvHelper.CreateCsvReader(reader);

                        while (csv.Read())
                        {
                            var personId = (long)csv.GetField(typeof(long), 0);

                            if (!chunkFilePersons.ContainsKey(personId))
                            {
                                unexpectedPersonIds.Add(personId);
                                continue;
                            }

                            if (!localCounters.TryGetValue(personId, out var counters))
                            {
                                counters = new PersonSliceCounters();
                                localCounters[personId] = counters;
                            }

                            if (objectKind == "PERSON")
                            {
                                counters.InPersonFilesCount++;
                                personRowsRead++;
                            }
                            else if (objectKind == "METADATA_TMP")
                            {
                                var attrition = csv.GetField(typeof(string), 1) as string;

                                if (attrition != "Discarded drug count")
                                {
                                    counters.InMetadataFilesCount++;
                                }

                                metadataRowsRead++;
                            }
                            else
                            {
                                throw new NotImplementedException("Unsupported object key: " + s3Object.Key);
                            }
                        }
                    }

                    complete = true;
                }
                catch (Exception exception)
                {
                    if (attempt >= MaxReadAttempts)
                    {
                        issues.Add(new ValidationIssue(
                            ValidationIssueType.ObjectReadFailed,
                            buildingId,
                            chunkId,
                            sliceObjects.SliceId,
                            null,
                            $"{exception.Message} | attempt={attempt}"));

                        break;
                    }
                }
            }

            foreach (var pair in localCounters)
            {
                var personId = pair.Key;
                var counters = pair.Value;

                var person = chunkFilePersons[personId];
                person.SliceId ??= sliceObjects.SliceId;
                person.InPersonFilesCount += counters.InPersonFilesCount;
                person.InMetadataFilesCount += counters.InMetadataFilesCount;
            }

            foreach (var unexpectedPersonId in unexpectedPersonIds.OrderBy(id => id))
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.UnexpectedPersonIdInRawFile,
                    buildingId,
                    chunkId,
                    sliceObjects.SliceId,
                    unexpectedPersonId,
                    $"PersonId={unexpectedPersonId} exists in raw PERSON/METADATA_TMP files but does not exist in _chunks file."));
            }

            timer.Stop();

            return new SliceValidationResult(
                vendor.Name,
                buildingId,
                chunkId,
                sliceObjects.SliceId,
                sliceObjects.PersonObjects.Count,
                sliceObjects.MetadataObjects.Count,
                personRowsRead,
                metadataRowsRead,
                unexpectedPersonIds.Count,
                issues,
                timer.Elapsed);
        }

        private List<S3Object> GetS3ChunkObjects(Vendor vendor, int buildingId)
        {
            var prefix = $"{vendor.Name}/{buildingId}/_chunks";

            using var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);

            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };

            var result = new List<S3Object>();
            ListObjectsV2Response response;

            do
            {
                response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                result.AddRange(response.S3Objects);
                request.ContinuationToken = response.NextContinuationToken;
            }
            while (response.IsTruncated ?? false);

            return result
                .OrderBy(s => GetS3ChunksFileNumber(s.Key))
                .ToList();
        }

        private HashSet<int> GetActualSlices(string vendorName, int buildingId)
        {
            var slices = new HashSet<int>();
            var prefix = $"{vendorName}/{buildingId}/{_cdmFolder}/PERSON/PERSON.";

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

                foreach (var s3Object in response.S3Objects)
                {
                    slices.Add(int.Parse(s3Object.Key.Split('.')[1]));
                }

                request.ContinuationToken = response.NextContinuationToken;
            }
            while (response.IsTruncated ?? false);

            return slices;
        }

        private Dictionary<int, SliceObjects> GetS3ObjectsBySlice(
            Vendor vendor,
            int buildingId,
            int chunkId,
            IReadOnlyCollection<int> slices)
        {
            var result = new Dictionary<int, SliceObjects>();
            var orderedSlices = slices.Distinct().OrderBy(s => s).ToList();

            foreach (var sliceId in orderedSlices)
            {
                var personObjects = GetObjects(vendor, buildingId, "PERSON", chunkId, sliceId);
                var metadataObjects = GetObjects(vendor, buildingId, "METADATA_TMP", chunkId, sliceId);

                if (personObjects.Count == 0 && metadataObjects.Count == 0)
                {
                    continue;
                }

                result[sliceId] = new SliceObjects(
                    sliceId,
                    personObjects,
                    metadataObjects);
            }

            return result;
        }

        private List<S3Object> GetObjects(
            Vendor vendor,
            int buildingId,
            string table,
            int chunkId,
            int sliceId)
        {
            var prefix = $"{vendor.Name}/{buildingId}/{_cdmFolder}/{table}/{table}.{sliceId}.{chunkId}.";

            using var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);

            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };

            var result = new List<S3Object>();
            ListObjectsV2Response response;

            do
            {
                response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                
                if (response.S3Objects == null || response.S3Objects.Count == 0)
                    return result;

                result.AddRange(response.S3Objects);
                
                request.ContinuationToken = response.NextContinuationToken;
            }
            while (response.IsTruncated ?? false);

            return result;
        }

        private Dictionary<long, Person> TryReadChunkPersonsByChunkId(
            Vendor vendor,
            int buildingId,
            int chunkId,
            out ValidationIssue? issue)
        {
            issue = null;

            var chunkObjects = GetS3ChunkObjects(vendor, buildingId);

            foreach (var chunkObject in chunkObjects)
            {
                var persons = ReadChunkFile(chunkObject, new HashSet<int> { chunkId });

                if (persons.Count > 0)
                {
                    return persons;
                }
            }

            issue = new ValidationIssue(
                ValidationIssueType.ChunkFileMissing,
                buildingId,
                chunkId,
                null,
                null,
                $"Chunk file was not found for Vendor={vendor.Name}, BuildingId={buildingId}, ChunkId={chunkId}");

            return new Dictionary<long, Person>();
        }

        private Dictionary<long, Person> ReadChunkFile(
            S3Object s3Object,
            IReadOnlyCollection<int>? chunksWhiteList)
        {
            var filePersonIds = new Dictionary<long, Person>();

            using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            using var responseStream = transferUtility.OpenStream(_bucket, s3Object.Key);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = s3Object.Key.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream);
            using var reader = new StreamReader(compressedStream, Encoding.Default);

            string? line = reader.ReadLine();

            while (!string.IsNullOrEmpty(line))
            {
                var splits = line.Split(ChunkFileSeparators, StringSplitOptions.RemoveEmptyEntries);

                if (splits.Length < 3)
                {
                    throw new FormatException($"Invalid _chunks line format. Key={s3Object.Key}, Line={line}");
                }

                var chunkId = int.Parse(splits[0]);
                var personId = long.Parse(splits[1]);
                var personSourceValue = splits[2];

                if (chunksWhiteList is { Count: > 0 } && !chunksWhiteList.Contains(chunkId))
                {
                    return filePersonIds;
                }

                if (!filePersonIds.TryAdd(personId, new Person(chunkId, personId, personSourceValue)))
                {
                    throw new Exception($"Failed to add a new person. ChunkId={chunkId}, PersonId={personId}, PersonSourceValue={personSourceValue}");
                }

                line = reader.ReadLine();
            }

            return filePersonIds;
        }

        private static PersonValidationCounts CalculatePersonValidationCounts(IEnumerable<Person> persons)
        {
            var materialized = persons.ToList();

            var correct = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount == 1 &&
                s.SliceId != null);

            var withoutSliceId = materialized.Count(s =>
                s.SliceId == null);

            var duplicated = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount > 1);

            var missing = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount == 0);

            return new PersonValidationCounts(
                materialized.Count,
                correct,
                withoutSliceId,
                duplicated,
                missing);
        }

        private static IEnumerable<PersonValidationProblem> GetPersonProblems(IEnumerable<Person> persons)
        {
            foreach (var person in persons)
            {
                if (person.SliceId == null)
                {
                    yield return new PersonValidationProblem(
                        person.PersonId,
                        person.SliceId,
                        person.InPersonFilesCount ?? 0,
                        person.InMetadataFilesCount ?? 0,
                        PersonValidationProblemType.WithoutSliceId);
                }

                if (person.InPersonFilesCount + person.InMetadataFilesCount > 1)
                {
                    yield return new PersonValidationProblem(
                        person.PersonId,
                        person.SliceId,
                        person.InPersonFilesCount ?? 0,
                        person.InMetadataFilesCount ?? 0,
                        PersonValidationProblemType.Duplicated);
                }

                if (person.InPersonFilesCount + person.InMetadataFilesCount == 0)
                {
                    yield return new PersonValidationProblem(
                        person.PersonId,
                        person.SliceId,
                        person.InPersonFilesCount ?? 0,
                        person.InMetadataFilesCount ?? 0,
                        PersonValidationProblemType.Missing);
                }
            }
        }

        private static string DetectObjectKind(string key)
        {
            if (key.Contains("/PERSON/") || key.Contains("PERSON."))
            {
                return "PERSON";
            }

            if (key.Contains("/METADATA_TMP/") || key.Contains("METADATA_TMP."))
            {
                return "METADATA_TMP";
            }

            throw new NotImplementedException("Unsupported object key: " + key);
        }

        private static int GetS3ChunksFileNumber(string filename)
        {
            return int.Parse(new string(filename.Split('/')
                .Last()
                .Where(char.IsDigit)
                .ToArray()));
        }

        private static int? TryGetS3ChunksFileNumber(string filename)
        {
            var digits = new string(filename.Split('/')
                .Last()
                .Where(char.IsDigit)
                .ToArray());

            if (int.TryParse(digits, out var result))
            {
                return result;
            }

            return null;
        }

        private void GetSlicesFromS3(
            HashSet<Person> personsOfSingleChunkId,
            Vendor vendor,
            int buildingId,
            int chunkId)
        {
            var prefix = $"{vendor.Name}/{buildingId}/raw/{chunkId}/{vendor.PersonTableName}/{vendor.PersonTableName}";

            using var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);

            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };

            var response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();

            foreach (var s3Object in response.S3Objects)
            {
                using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                using var responseStream = transferUtility.OpenStream(_bucket, s3Object.Key);
                using var bufferedStream = new BufferedStream(responseStream);
                using Stream compressedStream = s3Object.Key.EndsWith(".gz")
                    ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                    : new DecompressionStream(bufferedStream);
                using var reader = new StreamReader(compressedStream, Encoding.Default);

                string? line = reader.ReadLine();

                while (!string.IsNullOrEmpty(line))
                {
                    var personId = long.Parse(line.Split('\t')[vendor.PersonIdIndex]);

                    if (personsOfSingleChunkId.TryGetValue(new Person(chunkId, personId), out var personProvided))
                    {
                        var chars = s3Object.Key
                            .Split('/')
                            .Last()
                            .SkipWhile(s => !char.IsDigit(s))
                            .TakeWhile(s => char.IsDigit(s))
                            .ToArray();

                        personProvided.SliceId = int.Parse(new string(chars));

                        if (personsOfSingleChunkId.All(s => s.SliceId.HasValue))
                        {
                            return;
                        }
                    }

                    line = reader.ReadLine();
                }
            }
        }
    }
}