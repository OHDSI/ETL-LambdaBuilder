using Azure.Storage.Queues.Models;
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
    public void Run([QueueTrigger("cdm-test", Connection = "")] QueueMessage message)
    {
        var started = DateTime.Now;
        var name = message.MessageText;
        _logger.LogInformation("START - " + name);

        string instanceId = Environment.GetEnvironmentVariable("WEBSITE_INSTANCE_ID");
        _logger.LogInformation($"Azure Function Instance ID: {instanceId}");

        //string hostName = Environment.GetEnvironmentVariable("WEBSITE_HOSTNAME");
        //_logger.LogInformation($"Function app hostname: {hostName}");

        //string machineName = Environment.MachineName;
        //_logger.LogInformation($"The machine name is: {machineName}");

        //return;

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

            Settings.Current.TimeoutValue = 6000; // TMP

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

            //_logger.LogInformation($"**********************************************************************************************************");
            //_logger.LogInformation($"tenantId={tenantId}");
            //_logger.LogInformation($"clientId={clientId}");
            //_logger.LogInformation($"clientSecret={clientSecret}");
            //_logger.LogInformation($"blobURI={blobURI}");
            //_logger.LogInformation($"blobContainerName={blobContainerName}");
            //_logger.LogInformation($"**********************************************************************************************************");
            //_logger.LogInformation($"vendor={vendor};buildingId={buildingId};chunkId={_chunkId};prefix={_prefix};attempt={attempt}");
            //_logger.LogInformation($"Bucket={Settings.Current.BlobContainerName};CDMFolder={Settings.Current.CDMFolder};");
            //_logger.LogInformation($"TimeoutValue={Settings.Current.TimeoutValue}s;WatchdogValue={Settings.Current.WatchdogValue}ms;MinPersonToBuild={Settings.Current.MinPersonToBuild}; MinPersonToSave={Settings.Current.MinPersonToSave}");

            //return;

            AzureHelper.UploadStream($"{AzureHelper.Path}/running/{_chunkId}.{_prefix}.txt", new MemoryStream());

            Initialize();                     

            var chunkBuilder = new AzureChunkBuilder(CreatePersonBuilder);
            var attempt1 = attempt;

            _lastSavedPersonIdOutput = chunkBuilder.Process(_chunkId, _prefix, _restorePoint, attempt);
            var totalPersonConverted = chunkBuilder.TotalPersonConverted;

            if (_lastSavedPersonIdOutput.HasValue && totalPersonConverted > 0)
            {
                using var streamErrorDetails = new MemoryStream(Encoding.UTF8.GetBytes($"FINISHED by timeout on PersonId={_lastSavedPersonIdOutput.Value}; totalPersonConverted={totalPersonConverted}"));
                AzureHelper.UploadStream($"{AzureHelper.Path}/timeout/{_chunkId}.{_prefix}.txt", streamErrorDetails);
            }
            else
            {
                _logger.LogInformation($"chunkId={_chunkId};prefix={_prefix} - FINISHED, {name} - removed");
            }

            var completed = DateTime.Now;
            using var streamCompleteDetails = new MemoryStream(Encoding.UTF8.GetBytes($"Started={started.ToShortDateString} {started.ToShortTimeString}; Completed={completed.ToShortDateString} {completed.ToShortTimeString}; totalPersonConverted={totalPersonConverted}; Duration={(completed - started).TotalSeconds}s"));
            AzureHelper.UploadStream($"{AzureHelper.Path}/complete/{_chunkId}.{_prefix}.txt", streamCompleteDetails);
        }
        catch (Exception e)
        {
            _logger.LogInformation("error: " + CreateExceptionString(e));
            _restorePoint.Clear();

            using var streamErrorDetails = new MemoryStream(Encoding.UTF8.GetBytes(CreateExceptionString(e)));
            AzureHelper.UploadStream($"{AzureHelper.Path}/error/{_chunkId}.{_prefix}.txt", streamErrorDetails);
        }

        _logger.LogInformation("DONE");
        AzureHelper.DeleteFile($"{AzureHelper.Path}/running/{_chunkId}.{_prefix}.txt");
    }
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
            var key = $"{AzureHelper.Path}/{Settings.Current.CDMFolder}/cdm_source/cdm_source.txt.gz";

            _logger.LogInformation("GetSourceReleaseDate: " + key);

            using var responseStream = AzureHelper.OpenStream(key);
            using var bufferedStream = new BufferedStream(responseStream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            using var csv = framework.common.Helpers.CsvHelper.CreateCsvReader(reader);

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