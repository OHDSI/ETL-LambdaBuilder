using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Databases;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common.Utility;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class BuildingSettings(string builderConnectionString)
    {
        #region Variables
        private readonly DbBuildingSettings _dbBuildingSettings = new(builderConnectionString);
        private IDatabaseEngine _sourceEngine;
        private IDatabaseEngine _destinationEngine;
        private string _cdmSourceScript;

        #endregion

        #region Properties
        public int? Id { get; private set; }

        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; set; }
        public List<LookupDefinition> LookupDefinitions { get; set; }

        public string RawSourceConnectionString { get; set; }
        public string RawDestinationConnectionString { get; set; }
        public string RawVocabularyConnectionString { get; set; }

        public string BuilderConnectionString { get; private set; } = builderConnectionString;
        public string VocabularyVersion { get; private set; }
        public string SourceReleaseDate { get; private set; }

        public string PersonIdFieldName { get; set; }
        public string PersonFileName { get; set; }
        public int PersonIdFieldIndex { get; set; }

        public int Batches { get; set; }
        public int BatchSize { get; set; }
        public SaveType SaveType { get; set; }

        public string BatchScript { get; set; }
        public string CohortDefinitionScript { get; set; }

        public int LoadId
        {
            get
            {
                if (DestinationSchemaName.StartsWith("cdm_v"))
                {
                    var loadIdValue = DestinationSchemaName.Replace("cdm_v", "");
                    if (int.TryParse(loadIdValue, out int loadId))
                        return loadId;
                }
                else if (DestinationSchemaName.StartsWith("cdm_"))
                {
                    var loadIdValue = DestinationSchemaName.Replace("cdm_", "");
                    if (int.TryParse(loadIdValue, out int loadId))
                        return loadId;
                }

                if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["loadId"]))
                    return 0;

                return int.Parse(ConfigurationManager.AppSettings["loadId"]);
            }
        }

        public string SourceConnectionString
        {
            get
            {
                return Regex.Replace(RawSourceConnectionString, "sc=" + SourceSchemaName + ";", "", RegexOptions.IgnoreCase);
            }
        }

        public string DestinationConnectionString
        {
            get
            {
                return Regex.Replace(RawDestinationConnectionString, "sc=" + DestinationSchemaName + ";", "", RegexOptions.IgnoreCase);
            }
        }

        public string VocabularyConnectionString
        {
            get
            {
                return Regex.Replace(RawVocabularyConnectionString, "sc=" + VocabularySchemaName + ";", "", RegexOptions.IgnoreCase);
            }
        }

        public string CdmSourceScript
        {
            get
            {
                if (_cdmSourceScript == null || SourceReleaseDate == null || VocabularyVersion == null)
                    return null;

                _cdmSourceScript = _cdmSourceScript.Replace("{0}", SourceReleaseDate);
                _cdmSourceScript = _cdmSourceScript.Replace("{1}", VocabularyVersion);
                _cdmSourceScript = _cdmSourceScript.Replace("{3}", DateTime.Now.ToShortDateString());

                return _cdmSourceScript;
            }
            set { _cdmSourceScript = value; }
        }

        public CdmVersions Cdm
        {
            get
            {
                return Vendor.CdmVersion;
            }
        }

        public IDatabaseEngine SourceEngine
        {
            get
            {
                return _sourceEngine ??= DatabaseEngine.GetEngine(RawSourceConnectionString);
            }
        }

        public IDatabaseEngine DestinationEngine
        {
            get
            {
                return _destinationEngine ??= DatabaseEngine.GetEngine(RawDestinationConnectionString);
            }
        }

        public string SourceSchemaName
        {
            get
            {
                if (string.IsNullOrEmpty(RawSourceConnectionString))
                    return "dbo";

                var match = Regex.Match(RawSourceConnectionString, "(?s)(?<=sc=).*?(?=;)", RegexOptions.IgnoreCase);
                if (match.Success)
                {
                    return match.Value.Trim().ToLower();
                }

                return "dbo";
            }
        }

        public string DestinationSchemaName
        {
            get
            {
                if (string.IsNullOrEmpty(RawDestinationConnectionString))
                    return "dbo";

                var match = Regex.Match(RawDestinationConnectionString, "(?s)(?<=sc=).*?(?=;)", RegexOptions.IgnoreCase);
                if (match.Success)
                {
                    return match.Value.Trim().ToLower();
                }

                return "dbo";
            }
        }

        public string VocabularySchemaName
        {
            get
            {
                if (string.IsNullOrEmpty(RawVocabularyConnectionString))
                    return "dbo";

                var match = Regex.Match(RawVocabularyConnectionString, "(?s)(?<=sc=).*?(?=;)", RegexOptions.IgnoreCase);
                if (match.Success)
                {
                    return match.Value.Trim().ToLower();
                }

                return "dbo";
            }
        }

        #endregion
        
        #region Constructors
        #endregion

        #region Methods

        public bool Load(int buildingId)
        {
            Id = null;
            foreach (var dataReader in _dbBuildingSettings.Load(buildingId))
            {
                Id = buildingId;
                SetFrom(dataReader);
            }

            return Id.HasValue;
        }

        public void Save()
        {
            var id = _dbBuildingSettings.GetBuildingId(RawSourceConnectionString, RawDestinationConnectionString,
               RawVocabularyConnectionString, Vendor);

            if (id.HasValue)
            {
                Id = id;
                _dbBuildingSettings.Update(Id.Value, RawSourceConnectionString, RawDestinationConnectionString,
                   RawVocabularyConnectionString, Vendor, BatchSize);
            }
            else
            {
                Id = _dbBuildingSettings.Create(RawSourceConnectionString, RawDestinationConnectionString,
                   RawVocabularyConnectionString, Vendor, BatchSize);
            }

            SetVendorSettings();
        }

        private void SetFrom(IDataReader reader)
        {
            RawVocabularyConnectionString = reader.GetString("VocabularyConnectionString");
            RawSourceConnectionString = reader.GetString("SourceConnectionString");
            RawDestinationConnectionString = reader.GetString("DestinationConnectionString");
            BatchSize = reader.GetInt("BatchSize") ?? 1000;

            this.Vendor = Vendor.CreateVendorInstanceByName(reader.GetString("Vendor"));
            Logger.Write(null, LogMessageTypes.Debug, "Vendor=" + reader.GetString("Vendor"));

            SetVendorSettings();
            SetVocabularyVersion();
            SetSourceReleaseDate();
        }

        private void SetVocabularyVersion()
        {
            VocabularyVersion = DbBuildingSettings.GetVocabularyVersion(VocabularyConnectionString, VocabularySchemaName);
        }

        private void SetSourceReleaseDate()
        {
            var dbSource = new DbSource(SourceConnectionString, null, SourceSchemaName);
            SourceReleaseDate = dbSource.GetSourceReleaseDate();
        }

        private void SetVendorSettings()
        {
            var loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies()
                  .Where(s => !s.FullName.Contains("System."))
                  .Where(s => !s.FullName.Contains("Microsoft."))
                  .Where(s => !s.FullName.Contains("netstandard"));

            var vendorFolder = Vendor.Folder;

            var batch = "Batch.sql";
            var cdmSource = Vendor.CdmSource ?? "CdmSource.sql";
            var cohortDefinition = "CohortDefinition.sql";

            Logger.Write(null, LogMessageTypes.Debug, vendorFolder + ";" + batch + ";" + Vendor.ToString());

            SourceQueryDefinitions = new List<QueryDefinition>();
            LookupDefinitions = new List<LookupDefinition>();
            foreach (var assembly in loadedAssemblies)
            {
                BatchScript ??= ReadResources.TryReadResource(assembly, vendorFolder + "." + batch);
                CdmSourceScript ??= ReadResources.TryReadResource(assembly, vendorFolder + "." + cdmSource);
                CohortDefinitionScript ??= ReadResources.TryReadResource(assembly, vendorFolder + "." + cohortDefinition);

                var folder = vendorFolder + ".Definitions.";
                Console.WriteLine(folder);
                var definitionResources = assembly.GetManifestResourceNames()
                    .Where(s => s.Contains(this.Vendor.Folder))
                    .Where(s => s.Contains(folder))
                    .ToList();

                foreach (var resource in definitionResources)
                {
                    var txt = ReadResources.TryReadResource(assembly, resource);
                    if (!string.IsNullOrWhiteSpace(txt))
                    {
                        var qd = new QueryDefinition().DeserializeFromXml(txt);
                        qd.FileName = resource.Split(new[] { "." }, StringSplitOptions.None).SkipLast(1).Last();
                        SourceQueryDefinitions.Add(qd);
                    }
                }


                folder = vendorFolder + ".CombinedLookups.";
                Console.WriteLine(folder);
                var lookupResources = assembly.GetManifestResourceNames()
                    .Where(s => s.Contains(this.Vendor.Folder))
                    .Where(s => s.Contains(folder))
                    .ToList();

                foreach (var resource in lookupResources)
                {
                    var txt = ReadResources.TryReadResource(assembly, resource);
                    if (!string.IsNullOrWhiteSpace(txt))
                    {
                        var ld = new LookupDefinition().DeserializeFromXml(txt);
                        ld.FileName = resource.Split(new[] { "." }, StringSplitOptions.None).SkipLast(1).Last();
                        LookupDefinitions.Add(ld);
                    }
                }
            }
        }

        #endregion
    }
}
