using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class DatabricksSaver : Saver
    {
        private BlobContainerClient _currentClient;
        private string _connectionString;

        public override ISaver Create(string connectionString)
        {
            var credential = new ClientSecretCredential(
                Settings.Settings.Current.CloudStorageHolder, 
                Settings.Settings.Current.CloudStorageKey, 
                Settings.Settings.Current.CloudStorageSecret);
            var client = new BlobServiceClient(new Uri(Settings.Settings.Current.CloudStorageUri), credential, null);
            _currentClient = client.GetBlobContainerClient(Settings.Settings.Current.CloudStorageName);

            _connectionString = connectionString;

            return this;
        }

        public override void Write(ChunkData chunk, string table)
        {
            foreach (var reader in CreateDataReader(chunk, table))
            {
                Write(chunk.ChunkId, chunk.SubChunkId, reader, table);
            }
        }

        public override void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName)
        {
            throw new NotImplementedException();
        }

        public override void AddChunk(List<ChunkRecord> chunk, int index, string schemaName)
        {
            try
            {
                var tableName = "chunks" + index;
                var fileName = $"{Settings.Settings.Current.BuildingPrefix}/{tableName}.txt.gz";
                FileTransferHelper.UploadFile(null, _currentClient, Settings.Settings.Current.CloudStorageName, fileName, new ChunkDataReader(chunk), "\t", '`', "\0");

                var storage = Settings.Settings.Current.CloudStorageUri.Split("//")[1];
                string query = $@"COPY INTO {schemaName}._chunks BY POSITION " +
                    $@"FROM 'abfss://{storage}/{Settings.Settings.Current.CloudStorageName}/{Settings.Settings.Current.CloudPrefix}' " +
                    @"FILEFORMAT = CSV " +
                    @"PATTERN = 'chunks[0-9]{1,4}.txt.gz' " +
                    @"FORMAT_OPTIONS( " +
                    @"'recursiveFileLookup' = 'true', " +
                    @"'header' = 'false', " +
                    @"'delimiter' = '\t', " +
                    @"'quote' = '`', " +
                    @"'nullValue' = '\\0', " +
                    @"'unescapedQuoteHandling' = 'RAISE_ERROR', " +
                    @"'mode' = 'FAILFAST', " +
                    @"'multiLine' = 'true' " +
                    @"'compression' = 'gzip');";

                using var connection = SqlConnectionHelper.OpenOdbcConnection(_connectionString);
                using var c = new OdbcCommand(query, connection);
                c.CommandTimeout = 900;
                c.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                Console.WriteLine(Logger.CreateExceptionString(e));
                throw;
            }
        }

        private void SaveToS3Csv(string bucket, string folder, string tableName, IDataReader reader)
        {
            //Console.WriteLine($"{tableName} - Save to S3 started (csv)");

            //tableName = tableName.ToUpper();

            //var table = tableName;
            //var file = tableName;

            //if (tableName.Split('.').Length > 0)
            //{
            //    table = tableName.Split('.')[0];
            //}

            //using var stream = reader.GetStreamCsv();
            //var fileName = $"{folder}/{table}/{file}.txt.gz";

            //Console.WriteLine("BucketName=" + bucket);
            //Console.WriteLine("Key=" + fileName);

            //var request = new PutObjectRequest
            //{
            //    BucketName = bucket,
            //    Key = fileName,
            //    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
            //    StorageClass = S3StorageClass.Standard,
            //    InputStream = stream
            //};

            //using var putObject = _currentClient.PutObjectAsync(request);
            //putObject.Wait();
        }

        

        //public void SaveEntityLookup(List<Location> location, int index, string cdmFolder, CdmVersions cdm)
        //{
        //    if (location != null && location.Count > 0)
        //    {
        //        var tableName = "LOCATION." + index;

        //        var folder =
        //            $"{Settings.Settings.Current.Building.Vendor}/" +
        //            $"{Settings.Settings.Current.Building.Id}/";

        //        if (cdm == CdmVersions.V54)
        //        {
        //            SaveToS3Csv(Settings.Settings.Current.CloudStorageName, folder + cdmFolder, tableName, new LocationDataReader54(location));
        //        }
        //        else
        //        {
        //            SaveToS3Csv(Settings.Settings.Current.CloudStorageName, folder + cdmFolder, tableName, new LocationDataReader(location));
        //        }
        //    }
        //}

        //public void SaveEntityLookup(List<CareSite> careSite, int index, string cdmFolder)
        //{
        //    if (careSite != null && careSite.Count > 0)
        //    {
        //        var tableName = "CARE_SITE." + index;
        //        var folder =
        //            $"{Settings.Settings.Current.Building.Vendor}/" +
        //            $"{Settings.Settings.Current.Building.Id}/";

        //        SaveToS3Csv(Settings.Settings.Current.CloudStorageName, folder + cdmFolder, tableName, new CareSiteDataReader(careSite));
        //    }
        //}

        //public void SaveEntityLookup(List<Provider> provider, int index, string cdmFolder)
        //{
        //    if (provider != null && provider.Count > 0)
        //    {
        //        var tableName = "PROVIDER." + index;

        //        var folder =
        //            $"{Settings.Settings.Current.Building.Vendor}/" +
        //            $"{Settings.Settings.Current.Building.Id}/";

        //        SaveToS3Csv(Settings.Settings.Current.CloudStorageName, folder + cdmFolder, tableName, new ProviderDataReader(provider));
        //    }
        //}
    }
}