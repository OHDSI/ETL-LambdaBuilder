using Microsoft.Extensions.Configuration;
using org.ohdsi.cdm.framework.common.Attributes;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.IO;
using System.Linq;

namespace org.ohdsi.cdm.presentation.etl
{
    class SettingsLoader
    {
        public static void LoadVendorettings(IConfigurationRoot config)
        {
            Console.WriteLine();
            Console.WriteLine("loading vendor settings from S3...");
            var vendorFolder = Settings.Current.Building.Vendor.Folder;

            Settings.Current.Vendorettings = config.GetSection("AppSettings")["vendor_settings"];
            vendorFolder = Path.Combine(Settings.Current.Vendorettings, "Core", "Transformation",
                vendorFolder);

            var batch = "Batch.sql";
            /*= Settings.Current.Building.Vendor.GetAttribute<BatchFileAttribute>() == null
            ? "Batch.sql"
            : Settings.Current.Building.Vendor.GetAttribute<BatchFileAttribute>().Value;
            */

            var cdmSource = Settings.Current.Building.Vendor.CdmSource;

            Settings.Current.Building.BatchScript = Helper.S3ReadAllText(Path.Combine(vendorFolder, batch));
            Settings.Current.Building.CdmSourceScript = Helper.S3ReadAllText(Path.Combine(vendorFolder, cdmSource));
            Settings.Current.Building.CohortDefinitionScript =
                Helper.S3ReadAllText(Path.Combine(vendorFolder, "CohortDefinition.sql"));

            var folder = Path.Combine(vendorFolder, "Definitions");
            Settings.Current.Building.SourceQueryDefinitions = Helper.GetFiles(folder).ToArray().Select(
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
                    Settings.Current.Building.LookupDefinitions = lookups.Select(
                        definition =>
                        {
                            var ld = new LookupDefinition().DeserializeFromXml(Helper.S3ReadAllText(definition));

                            var fileInfo = new FileInfo(definition);
                            ld.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");

                            return ld;
                        }).ToList();
                }
            }

            Console.WriteLine("vendor settings - loaded successfully");
        }
    }
}
