using Amazon.S3;
using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class DatabricksSaver : Saver
    {
        public override void Write(ChunkData chunk, string table)
        {
            foreach (var reader in CreateDataReader(chunk, table))
            {
                Write(chunk.ChunkId, chunk.SubChunkId, reader, table);
            }
        }

        public override void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName)
        {
            BlobContainerClient blobContainerClient = null;
            IAmazonS3 awsClient = null;

            if(Settings.Settings.Current.UseS3forDatabricks)
                awsClient = CloudStorageHelper.GetAwsStorageClient();
            else
                blobContainerClient = CloudStorageHelper.GetBlobContainerClient();

            var name = "chunks" + chunkId;
            var fileName = $"{Settings.Settings.Current.BuildingPrefix}/{name}.txt.gz";
            
            CloudStorageHelper.UploadFile(awsClient, blobContainerClient, Settings.Settings.Current.CloudStorageName, fileName, reader);
        }
    }
}