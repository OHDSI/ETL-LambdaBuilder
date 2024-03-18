using CommandLine;

namespace RunETL
{
    class Options
    {
        [Option("chunkscnt", Required = true)]
        public int? ChunksCnt { get; set; }

        [Option("slicescnt", Required = true)]
        public int? SlicesCnt { get; set; }

        [Option("buildingid", Required = true)]
        public int? Buildingid { get; set; }

        [Option("vendor")]
        public string Vendor { get; set; }
    }
}
