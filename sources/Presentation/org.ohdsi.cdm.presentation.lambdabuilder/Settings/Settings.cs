using System;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Settings
    {
        #region Properties
        public static Settings Current { get; set; }
        public BuildingSettings Building { get; set; }

        public DateTime Started { get; set; }
        public bool Error { get; set; }

        //public bool WatchdogTimeout { get; set; }

        //public bool ReadIdle { get; set; }

        public double Duration => DateTime.Now.Subtract(Started).TotalSeconds;

        public bool Timeout => Duration > TimeoutValue;

        static Settings()
        {
            Current = new Settings();
        }

        public string S3AwsAccessKeyId { get; set; }

        public string S3AwsSecretAccessKey { get; set; }

        public string Ec2AwsAccessKeyId { get; set; }

        public string Ec2AwsSecretAccessKey { get; set; }


        public string Bucket { get; set; }

        public string CDMFolder { get; set; }

        //public S3StorageType StorageType { get; set; }
        public double TimeoutValue { get; set; }
        public int WatchdogValue { get; set; }

        public int MinPersonToSave { get; set; }
        public int MinPersonToBuild { get; set; }

        #endregion

        #region Methods
        public static void Initialize(int buildingId, Vendor vendor, bool readFromS3)
        {
            Current.Building = new BuildingSettings { Id = buildingId, Vendor = vendor };
            Current.Building.SetVendorSettings(readFromS3);
        }

        public static void Initialize(int buildingId, Vendor vendor)
        {
            Initialize(buildingId, vendor, false);
        }

        #endregion
    }
}
