using Amazon.S3;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;


namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class RedshiftSaver : Saver
    {
        public override void Write(ChunkData chunk, string table)
        {
            var attempt = 0;
            var copied = false;
            while (!copied)
            {
                try
                {
                    attempt++;
                    foreach (var reader in CreateDataReader(chunk, table))
                    {
                        Write(chunk.ChunkId, chunk.SubChunkId, reader, table);
                    }
                    copied = true;
                }
                catch (Exception e)
                {
                    if (attempt <= 5)
                    {
                        Console.WriteLine("MoveToS3 attempt=" + attempt + ") | " + table + " | " + Logger.CreateExceptionString(e));
                    }
                    else
                    {
                        throw;
                    }
                }
            }
        }

        public override void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName)
        {
            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20,
            };

            using var currentClient = new AmazonS3Client(Settings.Settings.Current.CloudStorageKey,
                Settings.Settings.Current.CloudStorageSecret,
                config);

            var name = "_chunks" + chunkId;
            var fileName = $"{Settings.Settings.Current.BuildingPrefix}/{name}.txt.gz";
            
            CloudStorageHelper.UploadFile(currentClient, null, Settings.Settings.Current.CloudStorageName, fileName, reader);
        }               
    }
}