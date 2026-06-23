using CommandLine;
using CommandLine.Text;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.Common.Utility.Validation;
using Spectre.Console;
using System.Configuration;
using System.Threading.Channels;

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

        private sealed class ChannelValidationReporter : IValidationReporter
        {
            private readonly ChannelWriter<ValidationProgressEvent> _writer;

            public ChannelValidationReporter(ChannelWriter<ValidationProgressEvent> writer)
            {
                _writer = writer;
            }

            public void Report(ValidationProgressEvent progressEvent)
            {
                _writer.TryWrite(progressEvent);
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
            Console.ReadLine();
        }

        static async Task RunWithOptionsAsync(Options opts)
        {
            var chunks = opts.Chunks.ToList();

            AnsiConsole.WriteLine("Options:");
            AnsiConsole.WriteLine($"Bucket - folder: {_bucket} - {_cdmFolder}");
            AnsiConsole.WriteLine($"Vendor: {opts.Vendor}");
            AnsiConsole.WriteLine($"Building ID: {opts.BuildingId}");
            AnsiConsole.WriteLine($"Chunks: {string.Join(", ", chunks)}");
            AnsiConsole.WriteLine($"EtlLibraryPath: {opts.EtlLibraryPath}");
            AnsiConsole.WriteLine($"Current directory: {Directory.GetCurrentDirectory()}");
            AnsiConsole.WriteLine($"PersonId: {opts.PersonId?.ToString() ?? ""}");
            AnsiConsole.WriteLine();

            Vendor vendor = EtlLibrary.CreateVendorInstance(opts.EtlLibraryPath, opts.Vendor);

            try
            {
                await RunValidationWithProgressAsync(reporter =>
                {
                    var validation = new Validation(
                        _awsAccessKeyId,
                        _awsSecretAccessKey,
                        _bucket,
                        _cdmFolder,
                        reporter);

                    if (opts.PersonId.HasValue)
                    {
                        validation.ValidatePersonIdInSlice(
                            vendor,
                            opts.BuildingId,
                            chunks.FirstOrDefault(),
                            opts.PersonId.Value);
                    }
                    else
                    {
                        validation.ValidateBuildingId(
                            vendor,
                            opts.BuildingId,
                            chunks);
                    }
                });
            }
            catch (Exception exception)
            {
                AnsiConsole.MarkupLine("[red]Validation failed.[/]");
                AnsiConsole.WriteException(exception);
            }
        }

        private static async Task RunValidationWithProgressAsync(Action<IValidationReporter> validationAction)
        {
            var channel = Channel.CreateUnbounded<ValidationProgressEvent>(
                new UnboundedChannelOptions
                {
                    SingleReader = true,
                    SingleWriter = false
                });

            var reporter = new ChannelValidationReporter(channel.Writer);
            var bufferedLogs = new List<ValidationProgressEvent>();

            var workerTask = Task.Run(() =>
            {
                try
                {
                    validationAction(reporter);
                }
                finally
                {
                    channel.Writer.TryComplete();
                }
            });

            try
            {
                await AnsiConsole.Progress()
                    .AutoClear(false)
                    .HideCompleted(true)
                    .Columns(
                        new TaskDescriptionColumn(),
                        new ElapsedTimeColumn(),
                        new ProgressBarColumn(),
                        new PercentageColumn(),
                        new RemainingTimeColumn(),
                        new SpinnerColumn())
                    .StartAsync(async progressContext =>
                    {
                        var progressTasks = new Dictionary<string, ProgressTask>();

                        await foreach (var progressEvent in channel.Reader.ReadAllAsync())
                        {
                            ApplyProgressEvent(
                                progressContext,
                                progressTasks,
                                bufferedLogs,
                                progressEvent);
                        }

                        await workerTask;
                    });
            }
            finally
            {
                PrintBufferedLogs(bufferedLogs);
            }
        }

        private static void ApplyProgressEvent(
            ProgressContext progressContext,
            Dictionary<string, ProgressTask> progressTasks,
            List<ValidationProgressEvent> bufferedLogs,
            ValidationProgressEvent progressEvent)
        {
            switch (progressEvent.Kind)
            {
                case ValidationProgressEventKind.Log:
                    bufferedLogs.Add(progressEvent);
                    break;

                case ValidationProgressEventKind.StartTask:
                    {
                        var maxValue = progressEvent.MaxValue <= 0
                            ? 1
                            : progressEvent.MaxValue;

                        var task = progressContext.AddTask(
                            FormatMarkup(progressEvent.Message, progressEvent.Level),
                            maxValue: maxValue);

                        if (progressEvent.IsIndeterminate)
                        {
                            task.IsIndeterminate();
                        }

                        progressTasks[progressEvent.TaskId] = task;
                        break;
                    }

                case ValidationProgressEventKind.UpdateTask:
                    {
                        if (!progressTasks.TryGetValue(progressEvent.TaskId, out var task))
                        {
                            break;
                        }

                        if (!string.IsNullOrWhiteSpace(progressEvent.Message))
                        {
                            task.Description = FormatMarkup(progressEvent.Message, progressEvent.Level);
                        }

                        if (progressEvent.Value.HasValue)
                        {
                            var value = progressEvent.Value.Value;

                            if (value < 0)
                            {
                                value = 0;
                            }

                            if (value > task.MaxValue)
                            {
                                value = task.MaxValue;
                            }

                            task.Value = value;
                        }

                        break;
                    }

                case ValidationProgressEventKind.IncrementTask:
                    {
                        if (!progressTasks.TryGetValue(progressEvent.TaskId, out var task))
                        {
                            break;
                        }

                        if (!string.IsNullOrWhiteSpace(progressEvent.Message))
                        {
                            task.Description = FormatMarkup(progressEvent.Message, progressEvent.Level);
                        }

                        var nextValue = task.Value + progressEvent.Increment;

                        if (nextValue > task.MaxValue)
                        {
                            task.Value = task.MaxValue;
                        }
                        else
                        {
                            task.Increment(progressEvent.Increment);
                        }

                        break;
                    }

                case ValidationProgressEventKind.CompleteTask:
                    {
                        if (!progressTasks.TryGetValue(progressEvent.TaskId, out var task))
                        {
                            break;
                        }

                        if (!string.IsNullOrWhiteSpace(progressEvent.Message))
                        {
                            task.Description = FormatMarkup(progressEvent.Message, progressEvent.Level);
                        }

                        task.Value = task.MaxValue;
                        task.StopTask();
                        break;
                    }

                case ValidationProgressEventKind.KeepTaskWithMessage:
                    {
                        if (!progressTasks.TryGetValue(progressEvent.TaskId, out var task))
                        {
                            break;
                        }

                        task.Description = FormatMarkup(progressEvent.Message, progressEvent.Level);

                        var value = task.MaxValue - 0.001;

                        if (value < 0)
                        {
                            value = 0;
                        }

                        task.Value = value;
                        break;
                    }

                default:
                    throw new ArgumentOutOfRangeException(
                        nameof(progressEvent.Kind),
                        progressEvent.Kind,
                        "Unknown validation progress event kind.");
            }
        }

        private static string FormatMarkup(string message, ValidationLogLevel level)
        {
            var escaped = Markup.Escape(message);

            return level switch
            {
                ValidationLogLevel.Success => $"[green]{escaped}[/]",
                ValidationLogLevel.Warning => $"[yellow]{escaped}[/]",
                ValidationLogLevel.Error => $"[red]{escaped}[/]",
                _ => escaped
            };
        }

        private static void PrintBufferedLogs(List<ValidationProgressEvent> bufferedLogs)
        {
            foreach (var log in bufferedLogs)
            {
                AnsiConsole.MarkupLine(FormatMarkup(log.Message, log.Level));
            }
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