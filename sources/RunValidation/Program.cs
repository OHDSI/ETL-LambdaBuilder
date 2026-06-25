using CommandLine;
using CommandLine.Text;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.Common.Utility.Validation;
using Spectre.Console;
using System.Configuration;

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
                AnsiConsole.WriteLine($"Validation in progress...");

                var validation = new Validation(
                    _awsAccessKeyId,
                    _awsSecretAccessKey,
                    _bucket,
                    _cdmFolder);

                var result = validation.ValidateBuildingId(
                    vendor,
                    opts.BuildingId,
                    chunks);

                AnsiConsole.WriteLine("\r\n\r\n");

                AnsiConsole.WriteLine($"BuildingId: {result.BuildingId}");
                AnsiConsole.WriteLine($"IsValid: {result.IsValid}");
                AnsiConsole.WriteLine($"Chunks found: {result.TotalChunkFilesFound}");
                AnsiConsole.WriteLine($"Chunks validated: {result.ChunkFilesValidated}");
                AnsiConsole.WriteLine($"Chunks skipped: {result.ChunkFilesSkipped}");
                AnsiConsole.WriteLine($"Chunks with errors: {result.ChunksWithErrors}");
                AnsiConsole.WriteLine($"Persons: {result.TotalPersons}");
                AnsiConsole.WriteLine($"Elapsed: {result.Elapsed}");

                foreach (var chunkResult in result.ChunkResults.Where(c => !c.IsValid))
                {
                    AnsiConsole.MarkupLine($"[red]Chunk {chunkResult.ChunkId} is invalid[/]");
                    AnsiConsole.WriteLine($"Persons in chunk file: {chunkResult.PersonsInChunkFile}");
                    AnsiConsole.WriteLine($"Correct: {chunkResult.Counts.Correct}");
                    AnsiConsole.WriteLine($"Without sliceId: {chunkResult.Counts.WithoutSliceId}");
                    AnsiConsole.WriteLine($"Duplicated: {chunkResult.Counts.Duplicated}");
                    AnsiConsole.WriteLine($"Missing: {chunkResult.Counts.Missing}");

                    foreach (var issue in chunkResult.Issues)
                    {
                        AnsiConsole.MarkupLine($"[red]{Markup.Escape(issue.Message)}[/]");
                    }

                    foreach (var problem in chunkResult.PersonProblems.Take(10))
                    {
                        AnsiConsole.MarkupLine(
                            $"[red]PersonId={problem.PersonId}, SliceId={problem.SliceId}, InPerson={problem.InPersonFilesCount}, InMetadata={problem.InMetadataFilesCount}, Type={problem.Type}[/]");
                    }
                }

                AnsiConsole.WriteLine($"\r\nValidation complete!");
            }
            catch (Exception exception)
            {
                AnsiConsole.MarkupLine("[red]Validation failed.[/]");
                AnsiConsole.WriteException(exception);
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