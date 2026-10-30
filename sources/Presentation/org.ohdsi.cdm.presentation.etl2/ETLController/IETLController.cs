using org.ohdsi.cdm.framework.common.Definitions;
using System.Collections.Generic;

namespace org.ohdsi.cdm.presentation.etl.ETLController
{
    public interface IETLController
    {
        void UnloadNative(string chunksSchema, int chunkId, string sourceSchema, QueryDefinition qd);
        int GetNumberOfPartitions(string chunksSchema, int chunkId);
        IEnumerable<string> GetTriggerMessages(string chunksSchema, int chunkId);
        void StoreMetadataToCloudStorage(QueryDefinition queryDefinition, string query);
    }
}
