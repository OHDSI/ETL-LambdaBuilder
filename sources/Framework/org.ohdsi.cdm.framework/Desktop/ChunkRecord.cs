namespace org.ohdsi.cdm.framework.desktop
{
    public struct ChunkRecord
    {
        public int Id { get; set; }
        public int PartitionId { get; set; }
        public Int64 PersonId { get; set; }
        public string PersonSource { get; set; }
    }
}