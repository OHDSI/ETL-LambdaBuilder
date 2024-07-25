using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Settings
{
    public interface IBuildingSettings
    {
        int? Id { get; set; }

        Vendor Vendor { get; set; }
        List<QueryDefinition> SourceQueryDefinitions { get; }

        int LoadId { get; set; }
    }
}
