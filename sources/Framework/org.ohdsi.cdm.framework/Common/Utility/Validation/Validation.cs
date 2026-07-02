using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Enums;
using System.Collections.Concurrent;
using System.Collections.Immutable;
using System.Diagnostics;
using System.IO.Compression;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public class Validation
    {
        public ImmutableHashSet<int> Slices { get; protected set; }
        public ImmutableList<int> Chunks { get; protected set; }

        private const int MaxReadAttempts = 3;

        private static readonly char[] ChunkFileSeparators = new[] { ',', ' ', '\t' };

        private readonly string _awsAccessKeyId;
        private readonly string _awsSecretAccessKey;
        private readonly string _bucket;
        private readonly string _cdmFolder;
        private readonly Vendor _vendor;
        private readonly int _buildingId;
        private List<(int ChunkId, S3Object S3Object)> _s3ChunkObjects;

        private bool _s3InfoRetrieved => _s3ChunkObjects != null && Chunks != null && Slices != null;

        public Validation(
            string awsAccessKeyId,
            string awsSecretAccessKey,
            string bucket,
            string cdmFolder,
            Vendor vendor,
            int buildingId)
        {
            _awsAccessKeyId = awsAccessKeyId;
            _awsSecretAccessKey = awsSecretAccessKey;
            _bucket = bucket;
            _cdmFolder = cdmFolder;
            _vendor = vendor;
            _buildingId = buildingId;
        }


        public void GetS3InfoForValidation()
        {
            _s3ChunkObjects = GetS3ChunkObjects();
            Chunks = _s3ChunkObjects.Select(s => s.ChunkId).Distinct().OrderBy(s => s).ToImmutableList();

            Slices = GetActualSlices().ToImmutableHashSet();
        }

        public BuildingValidationResult ValidateBuildingId(
            IReadOnlyCollection<int>? chunksToProcess = null,
            int? degreeOfParallelism = null)
        {
            var timer = Stopwatch.StartNew();
            var issues = new ConcurrentBag<ValidationIssue>();
            var chunkResults = new ConcurrentBag<ChunkValidationResult>();

            if (!_s3InfoRetrieved)
                GetS3InfoForValidation();

            var chunkFilesSkipped = 0;

            var parallelOptions = new ParallelOptions
            {
                MaxDegreeOfParallelism = degreeOfParallelism.GetValueOrDefault(Math.Max(1, Environment.ProcessorCount - 1))
            };

            Parallel.ForEach(_s3ChunkObjects, parallelOptions, s3ChunkObject =>
            {
                if (chunksToProcess is { Count: > 0 }
                   && !chunksToProcess!.Any(s => s == s3ChunkObject.ChunkId))
                {
                    //skip chunk file if not in chunksToProcess
                }
                else
                {
                    var result = ValidateChunkObject(
                        s3ChunkObject.S3Object,
                        Slices);

                    if (result == null)
                    {
                        Interlocked.Increment(ref chunkFilesSkipped);
                        return;
                    }

                    chunkResults.Add(result);
                }
            });

            timer.Stop();

            var orderedChunkResults = chunkResults
                .OrderBy(r => r.ChunkId)
                .ToList();

            return new BuildingValidationResult(
                _vendor.Name,
                _buildingId,
                _s3ChunkObjects.Count,
                orderedChunkResults.Count,
                chunkFilesSkipped,
                Slices.Count,
                orderedChunkResults,
                issues.OrderBy(i => i.ChunkId).ThenBy(i => i.SliceId).ThenBy(i => i.PersonId).ToList(),
                timer.Elapsed);
        }

        public ChunkValidationResult ValidateChunkId(
            int chunkId,
            IReadOnlyCollection<int>? slicesToProcess = null)
        {
            var timer = Stopwatch.StartNew();

            if (!_s3InfoRetrieved)
                GetS3InfoForValidation();

            var slices = slicesToProcess is { Count: > 0 }
                ? slicesToProcess.OrderBy(s => s).ToList()
                : Slices.OrderBy(s => s).ToList();

            var relevantS3ChunkObjects = _s3ChunkObjects
                .Where(s => s.ChunkId == chunkId)
                .ToList();

            foreach (var chunkObject in relevantS3ChunkObjects)
            {
                var result = ValidateChunkObject(
                    chunkObject.S3Object,
                    slices);

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
                _buildingId,
                chunkId,
                null,
                null,
                $"Chunk file was not found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}");

            return new ChunkValidationResult(
                _vendor.Name,
                _buildingId,
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
            int chunkId,
            int sliceId)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            if (!_s3InfoRetrieved)
                GetS3InfoForValidation();

            var chunkPersons = TryReadChunkPersonsByChunkId(
                chunkId,
                out var chunkFileIssue);

            if (chunkFileIssue != null)
            {
                issues.Add(chunkFileIssue);
            }

            var objectsBySlice = GetS3ObjectsBySlice(
                chunkId,
                new List<int> { sliceId });

            if (!objectsBySlice.TryGetValue(sliceId, out var sliceObjects))
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    _buildingId,
                    chunkId,
                    sliceId,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}, SliceId={sliceId}"));

                timer.Stop();

                return new SliceValidationResult(
                    _vendor.Name,
                    _buildingId,
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

        public PersonIdValidationResult ValidatePersonId(int chunkId, long personId)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            int? foundSliceId = null;

            try
            {
                var chunkObjects = _s3ChunkObjects
                    .Where(s => s.ChunkId == chunkId)
                    .Select(s => s.S3Object)
                    .ToList();

                if (chunkObjects.Count == 0)
                {
                    issues.Add(new ValidationIssue(
                        ValidationIssueType.ChunkFileMissing,
                        _buildingId,
                        chunkId,
                        null,
                        personId,
                        $"Chunk file was not found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}"));

                    timer.Stop();

                    return new PersonIdValidationResult(
                        _vendor.Name,
                        _buildingId,
                        chunkId,
                        personId,
                        false,
                        null,
                        issues,
                        timer.Elapsed);
                }

                Dictionary<long, Person>? chunkFilePersons = null;
                Person? person = null;

                foreach (var chunkObject in chunkObjects)
                {
                    var personsFromChunkFile = ReadChunkFile(chunkObject);
                    if (personsFromChunkFile.Count == 0)
                        continue;

                    if (personsFromChunkFile.TryGetValue(personId, out var foundPerson))
                    {
                        chunkFilePersons = personsFromChunkFile;
                        person = foundPerson;
                        break;
                    }
                }

                if (chunkFilePersons == null || person == null)
                {
                    issues.Add(new ValidationIssue(
                        ValidationIssueType.MissingPersonId,
                        _buildingId,
                        chunkId,
                        null,
                        personId,
                        $"PersonId={personId} was not found in _chunks file for ChunkId={chunkId}."));

                    timer.Stop();

                    return new PersonIdValidationResult(
                        _vendor.Name,
                        _buildingId,
                        chunkId,
                        personId,
                        false,
                        null,
                        issues,
                        timer.Elapsed);
                }

                var objectsBySlice = GetS3ObjectsBySlice(
                    chunkId,
                    Slices);

                if (objectsBySlice.Count == 0)
                {
                    issues.Add(new ValidationIssue(
                        ValidationIssueType.SliceObjectsMissing,
                        _buildingId,
                        chunkId,
                        null,
                        personId,
                        $"No PERSON or METADATA_TMP objects found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}."));

                    timer.Stop();

                    return new PersonIdValidationResult(
                        _vendor.Name,
                        _buildingId,
                        chunkId,
                        personId,
                        false,
                        null,
                        issues,
                        timer.Elapsed);
                }

                foreach (var sliceObjects in objectsBySlice.Values.OrderBy(s => s.SliceId))
                {
                    var sliceResult = ValidateSliceObjects(
                        chunkId,
                        sliceObjects,
                        chunkFilePersons);

                    foreach (var issue in sliceResult.Issues)
                    {
                        if (issue.PersonId == personId || issue.PersonId == null)
                        {
                            issues.Add(issue);
                        }
                    }

                    if (person.SliceId.HasValue)
                    {
                        foundSliceId = person.SliceId.Value;
                        break;
                    }
                }

                if (!foundSliceId.HasValue)
                {
                    issues.Add(new ValidationIssue(
                        ValidationIssueType.MissingPersonId,
                        _buildingId,
                        chunkId,
                        null,
                        personId,
                        $"PersonId={personId} exists in _chunks file for ChunkId={chunkId}, but was not found in PERSON/METADATA_TMP files."));
                }
            }
            catch (Exception exception)
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.Exception,
                    _buildingId,
                    chunkId,
                    null,
                    personId,
                    exception.Message));
            }

            timer.Stop();

            return new PersonIdValidationResult(
                _vendor.Name,
                _buildingId,
                chunkId,
                personId,
                foundSliceId.HasValue,
                foundSliceId,
                issues,
                timer.Elapsed);
        }

        private ChunkValidationResult? ValidateChunkObject(
            S3Object chunkObject,
            IReadOnlyCollection<int> slicesToProcess)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            Dictionary<long, Person> chunkFilePersons;

            try
            {
                chunkFilePersons = ReadChunkFile(chunkObject);
            }
            catch (Exception exception)
            {
                var chunkIdFromFileName = TryGetS3ChunksFileNumber(chunkObject.Key)
                    ?? throw new Exception("Failed to extract chunkId from file name!");

                issues.Add(new ValidationIssue(
                    ValidationIssueType.Exception,
                    _buildingId,
                    chunkIdFromFileName,
                    null,
                    null,
                    exception.Message));

                timer.Stop();

                return new ChunkValidationResult(
                    _vendor.Name,
                    _buildingId,
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
                chunkId,
                slicesToProcess);

            if (objectsBySlice.Count == 0)
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    _buildingId,
                    chunkId,
                    null,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}"));
            }

            var sliceResults = new List<SliceValidationResult>();

            foreach (var sliceObjects in objectsBySlice.Values.OrderBy(s => s.SliceId))
            {
                var sliceResult = ValidateSliceObjects(
                    chunkId,
                    sliceObjects,
                    chunkFilePersons);

                sliceResults.Add(sliceResult);
            }

            var counts = CalculatePersonValidationCounts(chunkFilePersons.Values);
            var personProblems = GetPersonProblems(chunkFilePersons.Values).ToList();

            timer.Stop();

            return new ChunkValidationResult(
                _vendor.Name,
                _buildingId,
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
                    _buildingId,
                    chunkId,
                    sliceObjects.SliceId,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}, SliceId={sliceObjects.SliceId}"));

                timer.Stop();

                return new SliceValidationResult(
                    _vendor.Name,
                    _buildingId,
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
                            _buildingId,
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
                    _buildingId,
                    chunkId,
                    sliceObjects.SliceId,
                    unexpectedPersonId,
                    $"PersonId={unexpectedPersonId} exists in raw PERSON/METADATA_TMP files but does not exist in _chunks file."));
            }

            timer.Stop();

            return new SliceValidationResult(
                _vendor.Name,
                _buildingId,
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

        private List<(int ChunkId, S3Object S3Object)> GetS3ChunkObjects()
        {
            var prefix = $"{_vendor.Name}/{_buildingId}/chunks";

            using var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);

            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };

            var s3ObjectsTotal = new List<S3Object>();
            ListObjectsV2Response response;

            bool tryAnotherChunksPath = false;

            do
            {                
                response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                var s3objects = response?.S3Objects ?? new List<S3Object>();

                if (s3objects.Count == 0 && tryAnotherChunksPath)
                    break;

                if (s3objects.Count == 0 && !tryAnotherChunksPath)
                {
                    prefix = prefix.Replace("chunks", "_chunks");
                    request.Prefix = prefix;
                    response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();
                    s3objects = response?.S3Objects ?? new List<S3Object>();
                    tryAnotherChunksPath = true;
                }

                s3ObjectsTotal.AddRange(s3objects);
                request.ContinuationToken = response?.NextContinuationToken;
            }
            while (response?.IsTruncated ?? false);

            var result = s3ObjectsTotal
                .Select(s => (ReadChunkFile(s, true).Values.First().ChunkId, s))
                .OrderBy(s => s.ChunkId)
                .ToList();

            return result;
        }

        private HashSet<int> GetActualSlices()
        {
            var slices = new HashSet<int>();
            var prefix = $"{_vendor.Name}/{_buildingId}/{_cdmFolder}/PERSON/PERSON.";

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
            int chunkId,
            IReadOnlyCollection<int> slices)
        {
            var result = new Dictionary<int, SliceObjects>();
            var orderedSlices = slices.Distinct().OrderBy(s => s).ToList();

            foreach (var sliceId in orderedSlices)
            {
                var personObjects = GetObjects("PERSON", chunkId, sliceId);
                var metadataObjects = GetObjects("METADATA_TMP", chunkId, sliceId);

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
            string table,
            int chunkId,
            int sliceId)
        {
            var prefix = $"{_vendor.Name}/{_buildingId}/{_cdmFolder}/{table}/{table}.{sliceId}.{chunkId}.";

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
            int chunkId,
            out ValidationIssue? issue)
        {
            issue = null;


            foreach (var chunkObject in _s3ChunkObjects)
            {
                var persons = ReadChunkFile(chunkObject.S3Object);

                if (persons.Count > 0)
                {
                    return persons;
                }
            }

            issue = new ValidationIssue(
                ValidationIssueType.ChunkFileMissing,
                _buildingId,
                chunkId,
                null,
                null,
                $"Chunk file was not found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}");

            return new Dictionary<long, Person>();
        }

        private Dictionary<long, Person> ReadChunkFile(
            S3Object s3Object,
            bool returnChunkIdOnly = false)
        {
            var filePersonIds = new Dictionary<long, Person>();

            using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            using var responseStream = transferUtility.OpenStream(_bucket, s3Object.Key);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = s3Object.Key.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream);
            using var reader = new StreamReader(compressedStream, Encoding.Default);

            var line = reader.ReadLine();
            while (!string.IsNullOrEmpty(line))
            {
                var splits = line.Split(ChunkFileSeparators, StringSplitOptions.RemoveEmptyEntries);

                var person = splits.Length switch
                {
                    3 => new Person(ChunkId: int.Parse(splits[0]),
                                    PersonId: long.Parse(splits[1]),
                                    PersonSourceValue: splits[2]),

                    4 => new Person(ChunkId: int.Parse(splits[0]),
                                    //PartitionId: int.Parse(splits[1]),
                                    PersonId: long.Parse(splits[2]),
                                    PersonSourceValue: splits[3]),

                    _ => throw new FormatException($"Invalid _chunks line format. Key={s3Object.Key}, Line={line}")
                };

                filePersonIds.TryAdd(person.PersonId, person);

                if (returnChunkIdOnly)
                    return filePersonIds;

                line = reader.ReadLine();
            }

            return filePersonIds;
        }

        private static PersonValidationCounts CalculatePersonValidationCounts(IEnumerable<Person> persons)
        {
            var materialized = persons.ToList();

            var correct = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount == 1 
                && s.SliceId != null);

            var duplicated = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount > 1);

            var missing = materialized.Count(s =>
                s.InPersonFilesCount + s.InMetadataFilesCount == 0);

            var withoutSliceId = materialized.Count(s =>
                s.SliceId == null);

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
                if (person.SliceId == null 
                    //avoid single personId display for 2 error categories
                    && !(person.InPersonFilesCount + person.InMetadataFilesCount == 0))
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
    }
}