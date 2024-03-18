using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using System.Collections.Generic;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.framework.common.Settings
{
    public interface IBuildingSettings
    {
        int? Id { get; set; }

        Vendors Vendor { get; set; }
        List<QueryDefinition> SourceQueryDefinitions { get; }

        int LoadId { get; set; }
    }
}
