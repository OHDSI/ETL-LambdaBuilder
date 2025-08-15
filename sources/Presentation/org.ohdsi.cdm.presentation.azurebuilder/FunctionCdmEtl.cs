using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using CsvHelper;
using CsvHelper.Configuration;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.azurebuilder;

public class FunctionCdmEtl
{
    private readonly ILogger<FunctionCdmEtl> _logger;

    private Vocabulary _vocabulary;
    private bool _attemptFileRemoved;
    private long? _lastSavedPersonIdOutput;
    private Dictionary<string, long> _restorePoint = [];
    private int _chunkId;
    private string _prefix;

    private static ConstructorInfo _personBuilderConstructor;

    public static string EtlLibraryPath { get; set; }

    public FunctionCdmEtl(ILogger<FunctionCdmEtl> logger)
    {
        _logger = logger;
    }

    [Function(nameof(FunctionCdmEtl))]
    public async Task Run(
        [BlobTrigger("cdm-etl-msg/{name}", Connection = "", Source = BlobTriggerSource.LogsAndContainerScan)] Stream stream,
        string name)
    {
        _logger.LogInformation("START - " + name);

        try
        {
            var tenantId = Environment.GetEnvironmentVariable("tenantId");
            var clientId = Environment.GetEnvironmentVariable("clientId");
            var clientSecret = Environment.GetEnvironmentVariable("clientSecret");

            var blobURI = Environment.GetEnvironmentVariable("blobURI");
            var blobContainerName = Environment.GetEnvironmentVariable("containerName");
            var prefix = Environment.GetEnvironmentVariable("prefix");

            var credential = new ClientSecretCredential(tenantId, clientId, clientSecret);
            var client = new BlobServiceClient(new Uri(blobURI), credential, null);
            var bcc = client.GetBlobContainerClient(blobContainerName);

            foreach (var blob in bcc.GetBlobs(BlobTraits.None, BlobStates.None, prefix))
            {
                _logger.LogInformation(blob.Name);
            }

            var bc = new BlobClient(Environment.GetEnvironmentVariable("AzureWebJobsStorage"), "cdm-etl-msg", name);
            bc.DeleteIfExists();
        }
        catch (Exception ex)
        {
            _logger.LogInformation(ex.Message);

            throw;
        }

        _logger.LogInformation("DONE");
    }

    public void Initialize()
    {
        Settings.Current.Started = DateTime.Now;
        Settings.Current.Error = false;
        _personBuilderConstructor = null;

        _attemptFileRemoved = false;
        _lastSavedPersonIdOutput = null;
        _restorePoint.Clear();

        Settings.Current.Building.Vendor.SourceReleaseDate = GetSourceReleaseDate();

        if (_vocabulary != null && _vocabulary.Vendor == Settings.Current.Building.Vendor) return;
        try
        {
            var timer = new Stopwatch();
            timer.Start();
            _vocabulary = new Vocabulary(Settings.Current.Building.Vendor);
            _vocabulary.Fill(false, false);
            timer.Stop();

            Console.WriteLine("Vocabulary initialized for " + Settings.Current.Building.Vendor + " | " +
                              timer.ElapsedMilliseconds + "ms");
        }
        catch (Exception)
        {
            _vocabulary = null;
            throw;
        }
    }

    private static DateTime? GetSourceReleaseDate()
    {
        try
        {
            var key = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}/CDM_SOURCE/CDM_SOURCE.0.0.gz";

            Console.WriteLine("GetSourceReleaseDate: " + key);

            using var responseStream = AzureHelper.OpenStream(key);
            using var bufferedStream = new BufferedStream(responseStream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = false,
                Delimiter = ",",
                Encoding = Encoding.UTF8,
                BadDataFound = null
            });

            while (csv.Read())
            {
                var dateString = csv.GetField(6);
                Console.WriteLine("GetSourceReleaseDate: " + dateString);
                return DateTime.Parse(dateString);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("GetSourceReleaseDate: " + ex.Message);
            return null;
        }

        return null;
    }
}