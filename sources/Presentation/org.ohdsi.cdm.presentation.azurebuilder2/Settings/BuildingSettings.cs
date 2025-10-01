using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Utility;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class BuildingSettings : IVendorSettings
    {
        public int? Id { get; set; }

        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; set; }
        public List<LookupDefinition> CombinedLookupDefinitions { get; set; }

        public int LoadId { get; set; }

        public string BatchScript { get; set; }

        public void SetVendorSettings(string etlLibraryPath)
        {
            EtlLibrary.LoadVendorSettings(etlLibraryPath, this);
        }
    }
}