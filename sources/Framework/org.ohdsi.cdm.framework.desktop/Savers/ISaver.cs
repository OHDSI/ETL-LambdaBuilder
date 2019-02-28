using System;
using System.Collections.Generic;
using System.Data;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public interface ISaver : IDisposable
    {
        ISaver Create(string connectionString);
        void Save(ChunkData chunk);
        void SaveEntityLookup(List<Location> location, List<CareSite> careSite, List<Provider> provider);
        void AddChunk(List<ChunkRecord> chunk, int index);
        void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName);
        void Write(ChunkData chunk, string table);
        void Commit();
        void Rollback();
        void CopyVocabulary();

    }
}
