using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Base
{
    public interface IVendorSettings
    {
        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; set; }
        public List<LookupDefinition> CombinedLookupDefinitions { get; set; }

        public string BatchScript { get; set; }
    }
}
