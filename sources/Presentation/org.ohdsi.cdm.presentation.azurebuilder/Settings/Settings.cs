using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class Settings
    {
        #region Properties
        public static Settings Current { get; set; }
        public BuildingSettings Building { get; set; }

        public DateTime Started { get; set; }
        public bool Error { get; set; }

        public double Duration => DateTime.Now.Subtract(Started).TotalSeconds;

        public bool Timeout => Duration > TimeoutValue;

        static Settings()
        {
            Current = new Settings();
        }
                
        public string ServiceUri;
        public string BlobContainerName;

        public string TenantId;
        public string ClientId;
        public string ClientSecret;

        public string CDMFolder { get; set; }

        public double TimeoutValue { get; set; }
        public int WatchdogValue { get; set; }

        public int MinPersonToSave { get; set; }
        public int MinPersonToBuild { get; set; }

        #endregion

        #region Methods

        public static void Initialize(int buildingId, Vendor vendor, string etlLibraryPath)
        {
            Current.Building = new BuildingSettings { Id = buildingId, Vendor = vendor };
            Current.Building.SetVendorSettings(etlLibraryPath);
        }

        #endregion
    }
}