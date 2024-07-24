using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Extensions;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using org.ohdsi.cdm.framework.common.Utility;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class BuildingSettings
    {
        public int? Id { get; set; }

        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; private set; }
        public List<LookupDefinition> CombinedLookupDefinitions { get; private set; }

        public int LoadId { get; set; }


        public void SetVendorSettings()
        {
            LoadReferencedAssemblies.DoIfNotLoadedAlready();
            SourceQueryDefinitions = ReadSourceQueryDefinitions();
            CombinedLookupDefinitions = ReadSourceQueryCombinedLookups();
        }

        List<QueryDefinition> ReadSourceQueryDefinitions()
        {
            var loadedAssembly = AppDomain.CurrentDomain.GetAssemblies()
                  .Where(s => !s.FullName.Contains("System."))
                  .Where(s => !s.FullName.Contains("Microsoft."))
                  .Where(s => !s.FullName.Contains("netstandard"))
                  .First(s => s.FullName.Contains("etl"));

            var resources = loadedAssembly.GetManifestResourceNames()
                .Where(s => s.Contains(this.Vendor.Folder))
                .Where(s => s.Contains(".Definitions."))
                .ToList();

            var sourceQueryDefinitions = new List<QueryDefinition>();
            foreach (var resource in resources)
            {
                var txt = ReadResources.TryReadResource(loadedAssembly, resource);
                if (!string.IsNullOrWhiteSpace(txt))
                {
                    var qd = new QueryDefinition().DeserializeFromXml(txt);
                    qd.FileName = resource.Split(new[] { "." }, StringSplitOptions.None).SkipLast(1).Last();
                    qd.ProcessedPersonIds = [];

                    sourceQueryDefinitions.Add(qd);
                }
            }

            if (sourceQueryDefinitions.Count > 0)
                return sourceQueryDefinitions;
            else
                throw new FileNotFoundException("Resources for SourceQueryDefinitions not found!");
        }

        List<LookupDefinition> ReadSourceQueryCombinedLookups()
        {
            var loadedAssembly = AppDomain.CurrentDomain.GetAssemblies()
                  .Where(s => !s.FullName.Contains("System."))
                  .Where(s => !s.FullName.Contains("Microsoft."))
                  .Where(s => !s.FullName.Contains("netstandard"))
                  .First(s => s.FullName.Contains("etl"));

            var resources = loadedAssembly.GetManifestResourceNames()
                .Where(s => s.Contains(this.Vendor.Folder))
                .Where(s => s.Contains(".CombinedLookups."))
                .ToList();
            //folder = Path.Combine(vendorFolder, "CombinedLookups");

            if (resources.Count == 0)
                return new List<LookupDefinition>();

            var lookupDefinitions = new List<LookupDefinition>();
            foreach (var resource in resources)
            {
                var txt = ReadResources.TryReadResource(loadedAssembly, resource);
                if (!string.IsNullOrWhiteSpace(txt))
                {
                    var ld = new LookupDefinition().DeserializeFromXml(txt);
                    ld.FileName = resource.Split(new[] { "." }, StringSplitOptions.None).SkipLast(1).Last();

                    lookupDefinitions.Add(ld);
                }
            }

            if (lookupDefinitions.Count > 0)
                return lookupDefinitions;
            else
                throw new FileNotFoundException("Resources for lookupDefinitions not found!");
        }
    }
}