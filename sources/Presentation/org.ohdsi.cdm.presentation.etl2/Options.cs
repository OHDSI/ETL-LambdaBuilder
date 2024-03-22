using CommandLine;

namespace org.ohdsi.cdm.presentation.etl
{
    class Options
    {
        [Option("skip_etl", Required = true)]
        public bool? SkipETL { get; set; }

        [Option("skip_lookup", Required = true)]
        public bool? SkipLookup { get; set; }

        [Option("skip_chunk", Required = true)]
        public bool? SkipChunk { get; set; }

        [Option("resume", Required = true)]
        public bool? ResumeChunk { get; set; }

        [Option("skip_build", Required = true)]
        public bool? SkipBuild { get; set; }

        [Option("skip_cdmsource", Required = true)]
        public bool? CdmSource { get; set; }

        [Option("skip_vocabulary", Required = true)]
        public bool? SkipVocabulary { get; set; }

        [Option("skip_validation", Required = true)]
        public bool? SkipValidation { get; set; }

        [Option("skip_merge", Required = true)]
        public bool? SkipTransformToSpectrum { get; set; }

        [Option("rawcluster")]
        public string SourceCluster { get; set; }

        [Option("rawdb")]
        public string SourceDb { get; set; }

        [Option("rawschema")]
        public string SourceSchema { get; set; }

        [Option("vendor")]
        public string Vendor { get; set; }

        [Option("batch")]
        public int BatchSize { get; set; }

        [Option("vocabularyschema")]
        public string VocabularySchema { get; set; }

        [Option("versionid")]
        public int VersionId { get; set; }

        [Option("new", Required = true)]
        public bool? CreateNewBuildingId { get; set; }

        [Option("etl_ref")]
        public string cdmEtlReference { get; set; }
        
    }
}