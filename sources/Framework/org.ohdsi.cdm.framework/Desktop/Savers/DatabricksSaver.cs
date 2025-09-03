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
            var currentClient = CloudStorageHelper.GetBlobContainerClient();

            var name = "chunks" + chunkId;
            var fileName = $"{Settings.Settings.Current.BuildingPrefix}/{name}.txt.gz";
            
            CloudStorageHelper.UploadFile(null, currentClient, Settings.Settings.Current.CloudStorageName, fileName, reader);
        }
    }
}