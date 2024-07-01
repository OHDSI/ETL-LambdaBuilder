using org.ohdsi.cdm.framework.common.Attributes;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Extensions;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class BuildingSettings
    {
        public int? Id { get; set; }

        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; private set; }
        public List<LookupDefinition> LookupDefinitions { get; private set; }

        public int LoadId { get; set; }


        public void SetVendorSettings(bool fromS3)
        {
            if (fromS3)
            {
                var files = new List<string>();

                var vendorFolder = Path.Combine("Transformation", Vendor.Folder); //here lie files for org.ohdsi.cdm.framework.etl
                var folder = Path.Combine(vendorFolder, "Definitions");
                if (Directory.Exists(folder))
                {
                    files = Directory.GetFiles(folder).ToList();
                }
                else
                {
                    vendorFolder = Path.Combine("Core", "Transformation", Vendor.Folder);
                    folder = Path.Combine(vendorFolder, "Definitions");

                    files = Directory.GetFiles(folder).ToList();
                }


                SourceQueryDefinitions = files.Select(
                    definition =>
                    {
                        var qd = new QueryDefinition().DeserializeFromXml(Helper.S3ReadAllText(definition));
                        var fileInfo = new FileInfo(definition);
                        qd.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");

                        return qd;
                    }).ToList();

                folder = Path.Combine(vendorFolder, "CombinedLookups");
                //if (Directory.Exists(folder))
                {
                    var lookups = Helper.GetFiles(folder).ToArray();
                    if (lookups.Length > 0)
                    {
                        LookupDefinitions = lookups.Select(
                            definition =>
                            {
                                var ld = new LookupDefinition().DeserializeFromXml(Helper.S3ReadAllText(definition));
                                var fileInfo = new FileInfo(definition);
                                ld.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");

                                return ld;
                            }).ToList();
                    }
                }
            }
            else
            {
                var files = new List<string>();

                var vendorFolder = Path.Combine("Transformation", Vendor.Folder); //here lie files for org.ohdsi.cdm.framework.etl
                var folder = Path.Combine(vendorFolder, "Definitions");
                if (Directory.Exists(folder))
                {
                    files = Directory.GetFiles(folder).ToList();
                }
                else
                {
                    vendorFolder = Path.Combine("Core", "Transformation", Vendor.Folder);
                    folder = Path.Combine(vendorFolder, "Definitions");

                    files = Directory.GetFiles(folder).ToList();
                }

                SourceQueryDefinitions?.Clear();

                SourceQueryDefinitions = files.Select(
                    definition =>
                    {
                        var qd = new QueryDefinition().DeserializeFromXml(File.ReadAllText(definition));
                        var fileInfo = new FileInfo(definition);
                        qd.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");
                        qd.ProcessedPersonIds = [];

                        return qd;
                    }).ToList();

                folder = Path.Combine(vendorFolder, "CombinedLookups");

                LookupDefinitions?.Clear();

                if (Directory.Exists(folder))
                {
                    var lookups = Directory.GetFiles(folder).ToArray();
                    if (lookups.Length > 0)
                    {
                        LookupDefinitions = lookups.Select(
                        definition =>
                        {
                            var ld = new LookupDefinition().DeserializeFromXml(File.ReadAllText(definition));

                            var fileInfo = new FileInfo(definition);
                            ld.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");

                            return ld;
                        }).ToList();
                    }
                }
            }
        }
    }
}