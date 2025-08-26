using Azure.Identity;
using Azure.Storage.Blobs;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.presentation.azurebuilder.Base;
using System.Diagnostics;
using System.IO.Compression;
using System.Net;
using System.Reflection;
using System.Text;

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

        EtlLibraryPath = Path.Combine(Environment.CurrentDirectory, "EtlLibrary");

        _logger.LogInformation(EtlLibraryPath);

        _chunkId = 0;
        _prefix = string.Empty;
        int buildingId = 0;
        int attempt = 0;
        var getRestorePointDone = false;
        Vendor vendor;

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

            // 0         1        2       3      4      5
            //vendor.buildingId.chunkId.prefix.attempt.txt

            var vendorName = name.Split('.')[0].Split('/').Last();
            vendor = EtlLibrary.CreateVendorInstance(EtlLibraryPath, vendorName);

            buildingId = int.Parse(name.Split('.')[1]);
            _chunkId = int.Parse(name.Split('.')[2]);
            _prefix = name.Split('.')[3].Trim();

            if (name.Split('.').Length == 6)
            {
                attempt = int.Parse(name.Split('.')[4]);
            }

            Settings.Initialize(buildingId, vendor, EtlLibraryPath, _logger);

            Settings.Current.TimeoutValue = 600; // TMP

            Settings.Current.WatchdogValue = 30 * 1000;
            Settings.Current.MinPersonToBuild = 100;
            Settings.Current.MinPersonToSave = 100;

            Settings.Current.TenantId = tenantId;
            Settings.Current.ClientId = clientId;
            Settings.Current.ClientSecret = clientSecret;
            Settings.Current.ServiceUri = blobURI;
            Settings.Current.BlobContainerName = blobContainerName;
            Settings.Current.Prefix = prefix;

            Settings.Current.CDMFolder = Environment.GetEnvironmentVariable("cdmFolder");

            ServicePointManager.DefaultConnectionLimit = Int32.MaxValue;

            if (attempt > 15) // TMP was 10
            {
                return;
            }

            _logger.LogInformation($"vendor={vendor};buildingId={buildingId};chunkId={_chunkId};prefix={_prefix};attempt={attempt}");
            _logger.LogInformation($"Bucket={Settings.Current.BlobContainerName};CDMFolder={Settings.Current.CDMFolder};");
            _logger.LogInformation($"TimeoutValue={Settings.Current.TimeoutValue}s;WatchdogValue={Settings.Current.WatchdogValue}ms;MinPersonToBuild={Settings.Current.MinPersonToBuild}; MinPersonToSave={Settings.Current.MinPersonToSave}");

            Initialize();

            getRestorePointDone = GetRestorePoint(stream, name);

            if (!getRestorePointDone)
                throw new Exception("GetRestorePoint error");

            var chunkBuilder = new AzureChunkBuilder(CreatePersonBuilder);
            var attempt1 = attempt;

            _lastSavedPersonIdOutput = chunkBuilder.Process(_chunkId, _prefix, _restorePoint, attempt);
            var totalPersonConverted = chunkBuilder.TotalPersonConverted;

            RemoveAttemptFile(name);

            if (_lastSavedPersonIdOutput.HasValue && totalPersonConverted > 0)
            {
                attempt++;
                CreateAttemptFile(_chunkId, _prefix, attempt);

                _logger.LogInformation($"chunkId={_chunkId};prefix={_prefix} - FINISHED by timeout on PersonId={_lastSavedPersonIdOutput.Value}");
                return;
            }

            _logger.LogInformation($"chunkId={_chunkId};prefix={_prefix} - FINISHED, {name} - removed");
        }
        catch (Exception e)
        {
            _logger.LogInformation("error: " + CreateExceptionString(e));
            _restorePoint.Clear();
        }

        _logger.LogInformation("DONE");
    }

    private bool CreateAttemptFile(int chunkId, string prefix, int processAttempt)
    {
        if (!_attemptFileRemoved)
            return false;

        var attempt = 0;
        var key = $"{Settings.Current.Building.Vendor}.{Settings.Current.Building.Id}.{chunkId}.{prefix}.{processAttempt}.txt";

        attempt++;

        var restore = new List<string>();
        foreach (var rp in _restorePoint)
        {
            restore.Add($"{rp.Key}:{rp.Value}");
        }

        _logger.LogInformation("restore.Count=" + restore.Count);

        var credential = new ClientSecretCredential(Settings.Current.TenantId, Settings.Current.ClientId, Settings.Current.ClientSecret);
        var client = new BlobServiceClient(new Uri(Settings.Current.ServiceUri), credential, null);
        var bcc = client.GetBlobContainerClient(Settings.Current.BlobContainerName);

        using var stream = new MemoryStream(Encoding.UTF8.GetBytes(string.Join(Environment.NewLine, restore)));
        bcc.UploadBlob(key, stream);

        _logger.LogInformation($"Attempt file was created - {key} | attempt={attempt}");

        return true;
    }

    private void RemoveAttemptFile(string name)
    {
        _logger.LogInformation("removing attempt file...");

        var bc = new BlobClient(Environment.GetEnvironmentVariable("AzureWebJobsStorage"), "cdm-etl-msg", name);
        bc.DeleteIfExists();

        _logger.LogInformation($"Attempt file was removed - {name}");
        _attemptFileRemoved = true;
    }

    //[Function(nameof(FunctionCdmEtl))]
    //public async Task Run(
    //    [BlobTrigger("cdm-etl-msg/{name}", Connection = "", Source = BlobTriggerSource.LogsAndContainerScan)] Stream stream,
    //    string name)
    //{
    //    _logger.LogInformation("START - " + name);

    //    try
    //    {
    //        var tenantId = Environment.GetEnvironmentVariable("tenantId");
    //        var clientId = Environment.GetEnvironmentVariable("clientId");
    //        var clientSecret = Environment.GetEnvironmentVariable("clientSecret");

    //        var blobURI = Environment.GetEnvironmentVariable("blobURI");
    //        var blobContainerName = Environment.GetEnvironmentVariable("containerName");
    //        var prefix = Environment.GetEnvironmentVariable("prefix");

    //        var credential = new ClientSecretCredential(tenantId, clientId, clientSecret);
    //        var client = new BlobServiceClient(new Uri(blobURI), credential, null);
    //        var bcc = client.GetBlobContainerClient(blobContainerName);

    //        foreach (var blob in bcc.GetBlobs(BlobTraits.None, BlobStates.None, prefix))
    //        {
    //            _logger.LogInformation(blob.Name);
    //        }

    //        var bc = new BlobClient(Environment.GetEnvironmentVariable("AzureWebJobsStorage"), "cdm-etl-msg", name);
    //        bc.DeleteIfExists();
    //    }
    //    catch (Exception ex)
    //    {
    //        _logger.LogInformation(ex.Message);

    //        throw;
    //    }

    //    _logger.LogInformation("DONE");
    //}

    private static PersonBuilder CreatePersonBuilder()
    {
        if (_personBuilderConstructor == null)
            _personBuilderConstructor = EtlLibrary.GetBuilderConstructor(EtlLibraryPath, Settings.Current.Building.Vendor);

        var handle = (PersonBuilder)_personBuilderConstructor.Invoke([Settings.Current.Building.Vendor]);
        return handle;
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
            _vocabulary.Fill(false);
            _vocabulary.Attach();
            timer.Stop();

            _logger.LogInformation("Vocabulary initialized for " + Settings.Current.Building.Vendor + " | " +
                              timer.ElapsedMilliseconds + "ms");
        }
        catch (Exception)
        {
            _vocabulary = null;
            throw;
        }
    }

    private DateTime? GetSourceReleaseDate()
    {
        try
        {
            var key = $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}/CDM_SOURCE/CDM_SOURCE.0.0.gz";

            _logger.LogInformation("GetSourceReleaseDate: " + key);

            using var responseStream = AzureHelper.OpenStream(key);
            using var bufferedStream = new BufferedStream(responseStream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            using var csv = framework.common.Helpers.CsvHelper.CreateCsvReader(reader);
            //using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            //{
            //    HasHeaderRecord = false,
            //    Delimiter = ",",
            //    Encoding = Encoding.UTF8,
            //    BadDataFound = null
            //});

            while (csv.Read())
            {
                var dateString = csv.GetField(6);
                _logger.LogInformation("GetSourceReleaseDate: " + dateString);
                return DateTime.Parse(dateString);
            }
        }
        catch (Exception ex)
        {
            _logger.LogInformation("GetSourceReleaseDate: " + ex.Message);
            return null;
        }

        return null;
    }

    private bool GetRestorePoint(Stream stream, string name)
    {
        var attempt = 0;
        while (true)
        {
            try
            {
                attempt++;
                var msg = new StringBuilder();
                var timer = new Stopwatch();
                timer.Start();
                using (var reader = new StreamReader(stream))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        var fileName = line.Split(':')[0];
                        var rowIndex = long.Parse(line.Split(':')[1]);
                        _restorePoint.Add(fileName, rowIndex);
                        msg.Append($"{fileName}:{rowIndex};");
                    }
                }

                timer.Stop();
                _logger.LogInformation("Restore point:" + msg + " | " + timer.ElapsedMilliseconds + "ms");
                return true;
            }
            catch (Exception e)
            {
                if (attempt > 5)
                {
                    _logger.LogInformation($"WARN_EXC - GetRestorePoint [{name}]");
                    _logger.LogInformation(CreateExceptionString(e));
                    return false;
                }
            }
        }
    }

    public static string CreateExceptionString(Exception e)
    {
        var sb = new StringBuilder();
        CreateExceptionString(sb, e, string.Empty);

        return sb.ToString();
    }

    private static void CreateExceptionString(StringBuilder sb, Exception e, string indent)
    {
        if (indent == null)
        {
            indent = string.Empty;
        }
        else if (indent.Length > 0)
        {
            sb.AppendFormat("{0}Inner ", indent);
        }

        sb.AppendFormat("Exception Found:\n{0}Type: {1}", indent, e.GetType().FullName);
        sb.AppendFormat("\n{0}Message: {1}", indent, e.Message);
        sb.AppendFormat("\n{0}Source: {1}", indent, e.Source);
        sb.AppendFormat("\n{0}Stacktrace: {1}", indent, e.StackTrace);

        if (e.InnerException != null)
        {
            sb.Append('\n');
            CreateExceptionString(sb, e.InnerException, indent + "  ");
        }
    }
}