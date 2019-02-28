using System.Collections.Generic;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Enums;

namespace org.ohdsi.cdm.framework.common2.Settings
{
    public interface IBuildingSettings
    {
        int? Id { get; set; }

        Vendors Vendor { get; set; }
        List<QueryDefinition> SourceQueryDefinitions { get; }

        int LoadId { get; set; }
    }
}
