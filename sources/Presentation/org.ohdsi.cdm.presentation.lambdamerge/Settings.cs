using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.lambdamerge
{
    public class Settings
    {
        public string AwsAccessKeyId { get; set; } = "";

        public string AwsSecretAccessKey { get; set; } = "";

        public string Bucket { get; set; } = "";

        public string CdmFolder { get; set; } = "";

        public string ResultFolder { get; set; } = "";

        public Vendor Vendor { get; set; }

        public int BuildingId { get; set; }
    }
}