using CommandLine;
using CommandLine.Text;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.Common.Utility.Validation;
using Spectre.Console;
using System.Configuration;
using System.Diagnostics;

namespace RunValidation
{
    internal class Program
    {
        internal class Options
        {
            [Option('v', "vendor", Required = true, HelpText = "Vendor name.")]
            public required string Vendor { get; set; }

            [Option('b', "buildingId", Required = true, HelpText = "Building ID.")]
            public required int BuildingId { get; set; }

            [Option('e', "etlLibraryPath", Default = "", HelpText = "(Optional) Path to a folder containing an external ETL .dll")]
            public string EtlLibraryPath { get; set; } = "";

            [Option('c', "chunks", Separator = ',', HelpText = "(Optional) Comma-separated list of chunk IDs to process. All of them, if omitted.")]
            public IEnumerable<int> Chunks { get; set; } = new List<int>();

            [Option('p', "personId", Default = null, HelpText = "(Optional) If specified, the usual check changes to finding SliceId for the given PersonId within the first specified ChunkId.")]
            public long? PersonId { get; set; } = null;

            [Option('s', "singleTreadedMode", Default = 0, HelpText = "(Optional) Set to 1 to only allow a single thread to save memory at cost of processing speed")]
            public int? SingleTreadedMode { get; set; } = null;

            [Usage(ApplicationAlias = "RunValidation")]
            public static IEnumerable<Example> Examples
            {
                get
                {
                    yield return new Example("Process all chunks of a vendor", new Options
                    {
                        Vendor = "VendorName",
                        BuildingId = 123
                    });

                    yield return new Example("Process all vendor's chunks from an external .dll", new Options
                    {
                        Vendor = "ExternalVendorName",
                        BuildingId = 123,
                        EtlLibraryPath = "C:\\PathToExternalDllFolder"
                    });

                    yield return new Example("Process specified chunks of a vendor", new Options
                    {
                        Vendor = "VendorName",
                        BuildingId = 123,
                        Chunks = new List<int> { 1, 2, 3 }
                    });

                    yield return new Example("Get SliceId within the given vendor's chunk containing the given PersonId", new Options
                    {
                        Vendor = "VendorName",
                        BuildingId = 123,
                        Chunks = new List<int> { 1 },
                        PersonId = 123
                    });
                }
            }
        }

        private static string _awsAccessKeyId => ConfigurationManager.AppSettings["awsAccessKeyId"] ?? throw new NullReferenceException("awsAccessKeyId");
        private static string _awsSecretAccessKey => ConfigurationManager.AppSettings["awsSecretAccessKey"] ?? throw new NullReferenceException("awsSecretAccessKey");
        private static string _bucket => ConfigurationManager.AppSettings["bucket"] ?? throw new NullReferenceException("bucket");
        private static string _cdmFolder => ConfigurationManager.AppSettings["cdmFolder"] ?? "cdmCSV";

        static void Main(string[] args)
        {
            Parser.Default.ParseArguments<Options>(args)
                .WithParsed(opts => RunWithOptionsAsync(opts).GetAwaiter().GetResult())
                .WithNotParsed(HandleParseError);

            GC.Collect(GC.MaxGeneration, GCCollectionMode.Aggressive, true, true);
            Console.WriteLine("Press Enter to exit.");
            Console.ReadLine();
        }

        static async Task RunWithOptionsAsync(Options opts)
        {
            var chunks = opts.Chunks.ToList();
            var singleThreadedMode = opts.SingleTreadedMode == 1;

            AnsiConsole.WriteLine("Options:");
            AnsiConsole.WriteLine($"Bucket - folder: {_bucket} - {_cdmFolder}");
            AnsiConsole.WriteLine($"Vendor: {opts.Vendor}");
            AnsiConsole.WriteLine($"Building ID: {opts.BuildingId}");
            AnsiConsole.WriteLine($"Chunks: {string.Join(", ", chunks)}");
            AnsiConsole.WriteLine($"PersonId: {opts.PersonId?.ToString() ?? ""}");
            AnsiConsole.WriteLine($"SingleTreadedMode: {opts.SingleTreadedMode?.ToString() ?? ""}");
            AnsiConsole.WriteLine($"EtlLibraryPath: {opts.EtlLibraryPath}");
            AnsiConsole.WriteLine($"Current directory: {Directory.GetCurrentDirectory()}");
            AnsiConsole.WriteLine();

            Vendor vendor = EtlLibrary.CreateVendorInstance(opts.EtlLibraryPath, opts.Vendor);

            try
            {
                var sw = new Stopwatch();
                sw.Start();

                var validation = new Validation(
                    _awsAccessKeyId,
                    _awsSecretAccessKey,
                    _bucket,
                    _cdmFolder,
                    vendor,
                    opts.BuildingId);

                #region GetS3InfoForValidation
                AnsiConsole.WriteLine($"Getting actual chunks and slices...");
                validation.GetS3InfoForValidation();

                if (chunks is not { Count: > 0 })
                    chunks = validation.Chunks.ToList();

                AnsiConsole.WriteLine($"Done. Chunks count = {validation.Chunks.Count}, Chunk size = {validation.ChunkSize}, slices count = {validation.Slices.Count}. "
                    + $"{Convert.ToInt32(sw.Elapsed.TotalSeconds)}s");
                #endregion

                if (opts.PersonId.HasValue)
                {
                    await ValidatePersonId(validation, chunks, opts.PersonId.Value, singleThreadedMode);
                }
                else
                {
                    await ValidateChunks(validation, chunks, singleThreadedMode);
                }

                sw.Stop();
                AnsiConsole.MarkupLine($"[green]Validation complete! Total time: {Convert.ToInt32(sw.Elapsed.TotalSeconds)}s[/]");
            }
            catch (Exception exception)
            {
                AnsiConsole.MarkupLine("[red]Validation failed.[/]");
                AnsiConsole.WriteException(exception);
            }
        }

        static async Task ValidatePersonId(Validation validation, List<int> chunks, long personId, bool singleThreadedMode)
        {
            AnsiConsole.WriteLine($"\r\nValidation in progress...");

            if (chunks.Count == 0)
            {
                AnsiConsole.MarkupLine("[red]No chunks to process![/]");
                return;
            }

            int maxDegreeOfParallelism = Math.Max(1, Environment.ProcessorCount - 1);

            if (singleThreadedMode)
                maxDegreeOfParallelism = 1;

            var totalTimer = Stopwatch.StartNew();

            var orderedChunks = GetBinaryProbeOrder(chunks.OrderBy(s => s).ToList()).ToList();

            var chunkResult = await FindPersonIdInChunkFiles(
                validation,
                orderedChunks,
                personId,
                maxDegreeOfParallelism);

            if (chunkResult == null)
            {
                AnsiConsole.MarkupLine($"[red]PersonId {personId} was not found in _chunks files.[/]");
                return;
            }

            AnsiConsole.MarkupLine(
                $"[yellow]PersonId {chunkResult.PersonId} was found in _chunks file for ChunkId {chunkResult.ChunkId}. Checking PERSON/METADATA_TMP files...[/]");

            var personFilesCount = validation.GetPersonFilesCountForChunk(
                chunkResult.ChunkId,
                chunkResult.SliceId);

            if (personFilesCount == 0)
            {
                AnsiConsole.MarkupLine(
                    $"[red]No PERSON/METADATA_TMP files found for ChunkId {chunkResult.ChunkId}.[/]");
                return;
            }

            PersonIdValidationResult? finalResult = null;

            using var fileCts = new CancellationTokenSource();

            await AnsiConsole.Progress()
                .AutoClear(false)
                .Columns(
                    new TaskDescriptionColumn(),
                    new ElapsedTimeColumn(),
                    new PercentageColumn(),
                    new SpinnerColumn())
                .StartAsync(async ctx =>
                {
                    var progressTask = ctx.AddTask(
                        $"Phase 2/2. Checked 0/{personFilesCount} PERSON/METADATA_TMP files",
                        maxValue: personFilesCount);

                    var progressLock = new object();

                    finalResult = await Task.Run(() =>
                        validation.ValidatePersonIdInPersonFiles(
                            chunkId: chunkResult.ChunkId,
                            personId: personId,
                            degreeOfParallelism: maxDegreeOfParallelism,
                            sliceIdToSearch: chunkResult.SliceId,
                            progress: (processedFiles, totalFiles) =>
                            {
                                lock (progressLock)
                                {
                                    progressTask.Value = Math.Min(processedFiles, totalFiles);
                                    progressTask.Description =
                                        $"Phase 2/2. Checked {processedFiles}/{totalFiles} PERSON/METADATA_TMP files";
                                }
                            },
                            cancellationToken: fileCts.Token));
                });

            totalTimer.Stop();

            if (finalResult is { Found: true })
            {
                var sliceText = finalResult.SliceId.HasValue
                    ? $", SliceId {finalResult.SliceId.Value}"
                    : "";

                AnsiConsole.MarkupLine(
                    $"[green]PersonId {finalResult.PersonId} was found in ChunkId {finalResult.ChunkId}{sliceText}. {Convert.ToInt32(totalTimer.Elapsed.TotalSeconds)}s[/]");
            }
            else
            {
                AnsiConsole.MarkupLine(
                    $"[red]PersonId {personId} exists in _chunks file for ChunkId {chunkResult.ChunkId}, but was not found in PERSON/METADATA_TMP files.[/]");

                if (finalResult != null)
                {
                    foreach (var issue in finalResult.Issues)
                    {
                        AnsiConsole.WriteLine($"{Markup.Escape(issue.Message)}");
                    }
                }
            }
        }

        static async Task<PersonIdValidationResult?> FindPersonIdInChunkFiles(
            Validation validation,
            List<int> chunks,
            long personId,
            int maxDegreeOfParallelism)
        {
            using var cts = new CancellationTokenSource();

            PersonIdValidationResult? foundResult = null;

            int nextChunkIndex = -1;
            int processedChunks = 0;
            int foundFlag = 0;

            await AnsiConsole.Progress()
                .AutoClear(false)
                .Columns(
                    new TaskDescriptionColumn(),
                    new ElapsedTimeColumn(),
                    new PercentageColumn(),
                    new SpinnerColumn())
                .StartAsync(async ctx =>
                {
                    var progressTask = ctx.AddTask(
                        $"Phase 1/2. Checked 0/{chunks.Count} chunk files",
                        maxValue: chunks.Count);

                    var progressLock = new object();

                    var workers = Enumerable
                        .Range(0, maxDegreeOfParallelism)
                        .Select(_ => Task.Run(() =>
                        {
                            while (!cts.Token.IsCancellationRequested)
                            {
                                var chunkIndex = Interlocked.Increment(ref nextChunkIndex);

                                if (chunkIndex >= chunks.Count)
                                    break;

                                var chunkId = chunks[chunkIndex];

                                PersonIdValidationResult result;

                                try
                                {
                                    result = validation.CheckPersonIdInChunkFile(
                                        chunkId,
                                        personId,
                                        cts.Token);
                                }
                                catch (OperationCanceledException)
                                {
                                    break;
                                }

                                var currentProcessedChunks = Interlocked.Increment(ref processedChunks);

                                lock (progressLock)
                                {
                                    progressTask.Value = currentProcessedChunks;
                                    progressTask.Description =
                                        $"Phase 1/2. Checked {currentProcessedChunks}/{chunks.Count} chunk files";
                                }

                                if (!result.Found)
                                    continue;

                                if (Interlocked.CompareExchange(ref foundFlag, 1, 0) == 0)
                                {
                                    foundResult = result;
                                    cts.Cancel();
                                }

                                break;
                            }
                        }))
                        .ToList();

                    try
                    {
                        await Task.WhenAll(workers);
                    }
                    catch (OperationCanceledException)
                    {
                    }
                });

            return foundResult;
        }

        static IEnumerable<int> GetBinaryProbeOrder(IReadOnlyList<int> chunks)
        {
            if (chunks.Count == 0)
                yield break;

            var ranges = new Queue<(int Left, int Right)>();
            ranges.Enqueue((0, chunks.Count - 1));

            while (ranges.Count > 0)
            {
                var (left, right) = ranges.Dequeue();

                if (left > right)
                    continue;

                int middle = left + (right - left) / 2;

                yield return chunks[middle];

                ranges.Enqueue((left, middle - 1));
                ranges.Enqueue((middle + 1, right));
            }
        }

        static async Task ValidateChunks(Validation validation, List<int> chunks, bool singleThreadedMode)
        {
            #region validation
            AnsiConsole.WriteLine($"\r\nChunks validation in progress...");

            int maxDegreeOfParallelism = Math.Max(1, Environment.ProcessorCount - 1);

            if (singleThreadedMode)
                maxDegreeOfParallelism = 1;

            var orderedChunks = chunks
                .Distinct()
                .OrderBy(s => s)
                .ToList();

            var results = new List<ChunkValidationResult>();
            int errorChunks = 0;

            foreach (var chunkId in orderedChunks)
            {
                ChunkValidationResult? result = null;

                await AnsiConsole.Progress()
                    .AutoClear(false)
                    .Columns(
                        new TaskDescriptionColumn(),
                        new ElapsedTimeColumn(),
                        new PercentageColumn(),
                        new SpinnerColumn())
                    .StartAsync(async ctx =>
                    {
                        var progressTask = ctx.AddTask(
                            $"ChunkId {chunkId}. Slices checked: 0/{validation.Slices.Count}",
                            maxValue: Math.Max(1, validation.Slices.Count));

                        var progressLock = new object();

                        result = await Task.Run(() =>
                            validation.ValidateChunkIdBySlicesParallel(
                                chunkId,
                                maxDegreeOfParallelism,
                                (processedSlices, totalSlices, elapsed) =>
                                {
                                    lock (progressLock)
                                    {
                                        progressTask.MaxValue = Math.Max(1, totalSlices);
                                        progressTask.Value = Math.Min(processedSlices, totalSlices);
                                        progressTask.Description =
                                            $"ChunkId {chunkId}. Slices checked: {processedSlices}/{totalSlices}";
                                    }
                                }));

                        lock (progressLock)
                        {
                            if (!result.IsValid)
                                errorChunks++;

                            progressTask.MaxValue = Math.Max(1, progressTask.MaxValue);
                            progressTask.Value = progressTask.MaxValue;
                            progressTask.Description = BuildFinishedChunkTaskDescription(result);
                            progressTask.StopTask();
                        }
                    });

                if (result != null)
                    results.Add(result);
            }
            #endregion

            if (errorChunks > 0)
                AnsiConsole.MarkupLine($"[red]\r\n{errorChunks} chunks with errors![/]");
            else
                AnsiConsole.MarkupLine($"[green]\r\n{errorChunks} chunks with errors![/]");
        }

        static string BuildFinishedChunkTaskDescription(ChunkValidationResult result)
        {
            var badSlicesCount = GetBadSlicesCount(result);
            var badExample = GetBadExampleId(result);

            if (result.IsValid)
            {
                return
                    $"[green]{result.ChunkId} - OK.  " +
                    $"InChunkFile: {result.PersonsInChunkFile}. " + "[/]";
            }

            return
                $"[red]{result.ChunkId} - BAD. " +
                $"Dups: {result.Counts.Duplicated}. " +
                $"Missing: {result.Counts.Missing}. " +
                $"Example PersonId: {badExample}[/]";
        }

        static int GetBadSlicesCount(ChunkValidationResult result)
        {
            var badSliceIds = new HashSet<int>();

            foreach (var problem in result.PersonProblems)
            {
                if (problem.SliceId.HasValue)
                    badSliceIds.Add(problem.SliceId.Value);
            }

            foreach (var issue in result.Issues)
            {
                if (issue.SliceId.HasValue)
                    badSliceIds.Add(issue.SliceId.Value);
            }

            return badSliceIds.Count;
        }

        static long GetBadExampleId(ChunkValidationResult result)
        {
            var firstProblem = result.PersonProblems.FirstOrDefault();

            if (firstProblem != null)
            {
                return firstProblem.PersonId;
            }

            var firstIssueWithPerson = result.Issues
                .FirstOrDefault(s => s.PersonId.HasValue);

            if (firstIssueWithPerson != null)
            {
                var personId = firstIssueWithPerson.PersonId.HasValue
                    ? firstIssueWithPerson.PersonId.Value
                    : -1;

                return personId;
            }

            return -1;
        }

        static void HandleParseError(IEnumerable<Error> errs)
        {
            AnsiConsole.WriteLine("Failed to parse command-line arguments.");

            foreach (var error in errs)
            {
                AnsiConsole.WriteLine(error.ToString());
            }
        }
    }
}