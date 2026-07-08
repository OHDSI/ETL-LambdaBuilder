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
        public int ChunkSize { get; protected set; }

        private const int MaxReadAttempts = 3;


        private readonly string _awsAccessKeyId;
        private readonly string _awsSecretAccessKey;
        private readonly string _bucket;
        private readonly string _cdmFolder;
        private readonly Vendor _vendor;
        private readonly int _buildingId;
        private Dictionary<int, ChunkFile> _chunkFiles; //ChunkId, files
        private Dictionary<int, List<PersonFile>> _personFiles; //ChunkId, files

        private bool _s3InfoRetrieved => _chunkFiles != null && _personFiles != null && Chunks != null && Slices != null;

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
            _chunkFiles = new Dictionary<int, ChunkFile>();
            var chunkFilesRaw = GetS3ChunkObjects();
            foreach (var v in chunkFilesRaw)
            {
                if (_chunkFiles.TryGetValue(v.ChunkId, out ChunkFile? value))
                {
                    // do nothing
                }
                else
                {
                    _chunkFiles.Add(v.ChunkId, v);
                }
            }

            Chunks = _chunkFiles.Select(s => s.Key).Distinct().OrderBy(s => s).ToImmutableList();
            ChunkSize = _chunkFiles.First(s => s.Key == _chunkFiles.Values.Min(a => a.ChunkId)).Value.ReadChunkFile().Count();




            _personFiles = new Dictionary<int, List<PersonFile>>();
            var personFilesRaw = GetPersonFiles();
            foreach (var v in personFilesRaw)
            {
                if (_personFiles.TryGetValue(v.ChunkId, out List<PersonFile>? value))
                {
                    value.Add(v);
                }
                else
                {
                    var list = new List<PersonFile>() { v };
                    _personFiles.Add(v.ChunkId, list);
                }                
            }

            Slices = _personFiles
                .SelectMany(s => s.Value.Select(a => a.SliceId))
                .Distinct()
                .OrderBy(s => s)
                .ToImmutableHashSet();
        }

        public BuildingValidationResult ValidateBuildingId(
            IReadOnlyCollection<int>? chunksToProcess = null,
            int? degreeOfParallelism = null)
        {
            var timer = Stopwatch.StartNew();
            var issues = new ConcurrentBag<ValidationIssue>();
            var chunkResults = new ConcurrentBag<ChunkValidationResult>();

            if (!_s3InfoRetrieved)
                throw new Exception("Lacking information about S3 storage. Run GetS3InfoForValidation first!");

            var chunkFilesSkipped = 0;

            var parallelOptions = new ParallelOptions
            {
                MaxDegreeOfParallelism = degreeOfParallelism.GetValueOrDefault(Math.Max(1, Environment.ProcessorCount - 1))
            };

            Parallel.ForEach(_chunkFiles, parallelOptions, s3ChunkObject =>
            {
                if (chunksToProcess is { Count: > 0 }
                   && !chunksToProcess!.Any(s => s == s3ChunkObject.Value.ChunkId))
                {
                    //skip chunk file if not in chunksToProcess
                }
                else
                {
                    var result = ValidateChunkObject(
                        s3ChunkObject.Value,
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
                _chunkFiles.Count,
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
                throw new Exception("Lacking information about S3 storage. Run GetS3InfoForValidation first!");

            var slices = slicesToProcess is { Count: > 0 }
                ? slicesToProcess.OrderBy(s => s).ToList()
                : Slices.OrderBy(s => s).ToList();

            var relevantS3ChunkObjects = _chunkFiles
                .Where(s => s.Value.ChunkId == chunkId)
                .ToList();

            foreach (var chunkObject in relevantS3ChunkObjects)
            {
                var result = ValidateChunkObject(
                    chunkObject.Value,
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

            var sliceObjects = new List<PersonFile>();

            if (_personFiles.TryGetValue(chunkId, out List<PersonFile>? chunkFiles))
                sliceObjects = chunkFiles
                    .Where(s => s.SliceId == sliceId)
                    .ToList();

            if (!sliceObjects.Any())
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
                var chunkObjects = _chunkFiles
                    .Where(s => s.Value.ChunkId == chunkId)
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

                Person? person = null;
                Dictionary<long, Person> persons = new Dictionary<long, Person>();

                foreach (var chunkObject in chunkObjects)
                {
                    persons = chunkObject.Value
                        .ReadChunkFile()
                        .Select(s => KeyValuePair.Create(s.PersonId, s))
                        .ToDictionary();

                    if (persons.TryGetValue(personId, out Person? value))
                    {
                        person = value;
                    }
                }

                if (person == null || persons.Count == 0)
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

                var objectsBySlice = new List<IGrouping<int, PersonFile>>();

                if (_personFiles.TryGetValue(chunkId, out List<PersonFile>? chunkFiles))
                    objectsBySlice = chunkFiles
                        .Where(s => Slices.Any(a => a == s.SliceId))
                        .GroupBy(s => s.SliceId)
                        .ToList();

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

                foreach (var sliceObjects in objectsBySlice)
                {
                    var sliceResult = ValidateSliceObjects(
                        chunkId,
                        sliceObjects.ToList(),
                        persons);

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
            ChunkFile chunkObject,
            IReadOnlyCollection<int> slicesToProcess)
        {
            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            Dictionary<long, Person> chunkFilePersons;

            try
            {
                chunkFilePersons = chunkObject
                    .ReadChunkFile()
                    .Select(s => KeyValuePair.Create(s.PersonId, s))
                    .ToDictionary();
            }
            catch (Exception exception)
            {

                issues.Add(new ValidationIssue(
                    ValidationIssueType.Exception,
                    _buildingId,
                    chunkObject.ChunkId,
                    null,
                    null,
                    exception.Message));

                timer.Stop();

                return new ChunkValidationResult(
                    _vendor.Name,
                    _buildingId,
                    chunkObject.ChunkId,
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

            var objectsBySlice = new List<IGrouping<int, PersonFile>>();

            if (_personFiles.TryGetValue(chunkId, out List<PersonFile>? chunkFiles))
                objectsBySlice = chunkFiles
                    .Where(s => Slices.Any(a => a == s.SliceId))
                    .GroupBy(s => s.SliceId)
                    .ToList();

            if (!objectsBySlice.Any())
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

            foreach (var sliceObjects in objectsBySlice)
            {
                var sliceResult = ValidateSliceObjects(
                    chunkId,
                    sliceObjects.ToList(),
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
            List<PersonFile> sliceObjects,
            Dictionary<long, Person> chunkFilePersons)
        {
            if (!sliceObjects.Any())
                throw new ArgumentException("sliceObjects is empty!");

            var timer = Stopwatch.StartNew();
            var issues = new List<ValidationIssue>();

            var personRowsRead = 0;
            var metadataRowsRead = 0;
            var unexpectedPersonIds = new HashSet<long>();
            var localCounters = new Dictionary<long, PersonSliceCounters>();

            if (!sliceObjects.Any(s => s.ObjectKind == "PERSON") && !sliceObjects.Any(s => s.ObjectKind == "METADATA_TMP"))
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.SliceObjectsMissing,
                    _buildingId,
                    chunkId,
                    sliceObjects.First().SliceId,
                    null,
                    $"No PERSON or METADATA_TMP objects found for Vendor={_vendor.Name}, BuildingId={_buildingId}, ChunkId={chunkId}, SliceId={sliceObjects.First().SliceId}"));

                timer.Stop();

                return new SliceValidationResult(
                    _vendor.Name,
                    _buildingId,
                    chunkId,
                    sliceObjects.First().SliceId,
                    0,
                    0,
                    0,
                    0,
                    0,
                    issues,
                    timer.Elapsed);
            }

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
                    foreach (var s3Object in sliceObjects)
                    {
                        var personIdsFull = s3Object.ReadPersonIds();

                        foreach (var personIdFull in personIdsFull)
                        {
                            var personId = personIdFull.PersonId;
                            var attritionReason = personIdFull.AttritionReason;

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

                            if (s3Object.ObjectKind == "PERSON")
                            {
                                counters.InPersonFilesCount++;
                                personRowsRead++;
                            }
                            else if (s3Object.ObjectKind == "METADATA_TMP")
                            {
                                if (attritionReason != "Discarded drug count")
                                {
                                    counters.InMetadataFilesCount++;
                                }

                                metadataRowsRead++;
                            }
                            else
                            {
                                throw new NotImplementedException("Unsupported object key: " + s3Object.S3Object.Key);
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
                            sliceObjects.First().SliceId,
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
                person.SliceId ??= sliceObjects.First().SliceId;
                person.InPersonFilesCount += counters.InPersonFilesCount;
                person.InMetadataFilesCount += counters.InMetadataFilesCount;
            }

            foreach (var unexpectedPersonId in unexpectedPersonIds.OrderBy(id => id))
            {
                issues.Add(new ValidationIssue(
                    ValidationIssueType.UnexpectedPersonIdInRawFile,
                    _buildingId,
                    chunkId,
                    sliceObjects.First().SliceId,
                    unexpectedPersonId,
                    $"PersonId={unexpectedPersonId} exists in raw PERSON/METADATA_TMP files but does not exist in _chunks file."));
            }

            timer.Stop();

            return new SliceValidationResult(
                _vendor.Name,
                _buildingId,
                chunkId,
                sliceObjects.First().SliceId,
                sliceObjects.Count(s => s.ObjectKind == "PERSON"),
                sliceObjects.Count(s => s.ObjectKind == "METADATA_TMP"),
                personRowsRead,
                metadataRowsRead,
                unexpectedPersonIds.Count,
                issues,
                timer.Elapsed);
        }

        private List<ChunkFile> GetS3ChunkObjects()
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
                .Select(s => new ChunkFile(s, _awsAccessKeyId, _awsSecretAccessKey, _bucket))
                .OrderBy(s => s.ChunkId)
                .ToList();

            return result;
        }

        private List<PersonFile> GetPersonFiles()
        {
            var files = new List<PersonFile>();

            #region person
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

                foreach (var s3Object in response?.S3Objects ?? new List<S3Object>())
                {
                    files.Add(new PersonFile(s3Object, _awsAccessKeyId, _awsSecretAccessKey, _bucket));
                }

                request.ContinuationToken = response?.NextContinuationToken;
            }
            while (response?.IsTruncated ?? false);
            #endregion

            #region metadata_tmp
            prefix = $"{_vendor.Name}/{_buildingId}/{_cdmFolder}/METADATA_TMP/METADATA_TMP.";
            request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };
            do
            {
                response = client.ListObjectsV2Async(request).GetAwaiter().GetResult();

                foreach (var s3Object in response?.S3Objects ?? new List<S3Object>())
                {
                    files.Add(new PersonFile(s3Object, _awsAccessKeyId, _awsSecretAccessKey, _bucket));
                }

                request.ContinuationToken = response?.NextContinuationToken;
            }
            while (response?.IsTruncated ?? false);
            #endregion

            return files;
        }

        private Dictionary<long, Person> TryReadChunkPersonsByChunkId(
            int chunkId,
            out ValidationIssue? issue)
        {
            issue = null;


            foreach (var chunkObject in _chunkFiles)
            {
                var persons = chunkObject.Value
                    .ReadChunkFile()
                    .Select(s => KeyValuePair.Create(s.PersonId, s))
                    .ToDictionary();

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
    }
}