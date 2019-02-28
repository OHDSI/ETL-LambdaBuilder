using System.Collections.Generic;
using System.IO;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Attributes;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class BuildingSettings
    {
        public int? Id { get; set; }

        public Vendors Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; private set; }

        public int LoadId { get; set; }

  
        public void SetVendorSettings()
        {
            var vendorFolder = Path.Combine("Core", "Transformation", Vendor.GetAttribute<FolderAttribute>().Value);

            var folder = Path.Combine(vendorFolder, "Definitions");

            SourceQueryDefinitions?.Clear();

            SourceQueryDefinitions = Directory.GetFiles(folder).Select(
                definition =>
                {
                    var qd = new QueryDefinition().DeserializeFromXml(File.ReadAllText(definition));
                    var fileInfo = new FileInfo(definition);
                    qd.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");
                    qd.ProcessedPersonIds = new Dictionary<long, long>();

                    return qd;
                }).ToList();
        }
    }
}
