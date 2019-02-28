using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common2.Attributes;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.Databases;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class BuildingSettings
    {
        #region Variables
        private readonly DbBuildingSettings _dbBuildingSettings;
        private IDatabaseEngine _sourceEngine;
        private IDatabaseEngine _destinationEngine;
        private string _cdmSourceScript;

        #endregion

        #region Properties
        public int? Id { get; private set; }

        public Vendors Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; private set; } 

        public string RawSourceConnectionString { get; set; }
        public string RawDestinationConnectionString { get; set; }
        public string RawVocabularyConnectionString { get; set; }

        public string BuilderConnectionString { get; private set; }
        public string VocabularyVersion { get; private set; }
        public string SourceReleaseDate { get; private set; }

        public int Batches { get; set; }
        public int BatchSize { get; set; }
        public SaveType SaveType { get; set; }

        public string BatchScript { get; private set; }
        public string CohortDefinitionScript { get; private set; }

        public int LoadId
        {
            get
            {
                if (DestinationSchemaName.StartsWith("cdm_"))
                {
                    var loadIdValue = DestinationSchemaName.Replace("cdm_", "");
                    int loadId;
                    if (int.TryParse(loadIdValue, out loadId))
                        return loadId;
                }
                else if (DestinationSchemaName.StartsWith("cdm_v"))
                {
                    var loadIdValue = DestinationSchemaName.Replace("cdm_v", "");
                    int loadId;
                    if (int.TryParse(loadIdValue, out loadId))
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
            private set { _cdmSourceScript = value; }
        }

        public CdmVersions Cdm
        {
            get
            {
                return Vendor.GetAttribute<CdmVersionAttribute>().Value;
            }
        }

        public IDatabaseEngine SourceEngine
        {
            get
            {
                return _sourceEngine ?? (_sourceEngine = DatabaseEngine.GetEngine(RawSourceConnectionString));
            }
        }

        public IDatabaseEngine DestinationEngine
        {
            get
            {
                return _destinationEngine ??
                       (_destinationEngine = DatabaseEngine.GetEngine(RawDestinationConnectionString));
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

        #region Constructor
        public BuildingSettings(string builderConnectionString)
        {
            _dbBuildingSettings = new DbBuildingSettings(builderConnectionString);
            BuilderConnectionString = builderConnectionString;
        }
        #endregion

        #region Methods
        private void SetFrom(IDataReader reader)
        {
            RawVocabularyConnectionString = reader.GetString("VocabularyConnectionString");
            RawSourceConnectionString = reader.GetString("SourceConnectionString");
            RawDestinationConnectionString = reader.GetString("DestinationConnectionString");
            BatchSize = reader.GetInt("BatchSize") ?? 1000;
            
            Vendor = (Vendors)Enum.Parse(typeof(Vendors), reader.GetString("Vendor"));
            Logger.Write(null, LogMessageTypes.Debug, "Vendor=" + reader.GetString("Vendor"));

            SetVendorSettings();
            SetVocabularyVersion();
            SetSourceReleaseDate();
        }

        private void SetVocabularyVersion()
        {
            VocabularyVersion = _dbBuildingSettings.GetVocabularyVersion(VocabularyConnectionString);
        }

        private void SetSourceReleaseDate()
        {
            var dbSource = new DbSource(SourceConnectionString, null, SourceSchemaName);
            SourceReleaseDate = dbSource.GetSourceReleaseDate();
        }

        private void SetVendorSettings()
        {
            var vendorFolder = Vendor.GetAttribute<FolderAttribute>().Value;
            vendorFolder = Path.Combine("Core", "Transformation", vendorFolder);

            var batch = Vendor.GetAttribute<BatchFileAttribute>() == null
                              ? "Batch.sql"
                              : Vendor.GetAttribute<BatchFileAttribute>().Value;

            var cdmSource = Vendor.GetAttribute<CdmSourceAttribute>() == null
            ? "CdmSource.sql"
            : Vendor.GetAttribute<CdmSourceAttribute>().Value;

            Logger.Write(null, LogMessageTypes.Debug, vendorFolder + ";" + batch + ";" + Vendor.ToString());


            if (File.Exists(Path.Combine(vendorFolder, batch)))
            {
                BatchScript = File.ReadAllText(Path.Combine(vendorFolder, batch));
            }

            if (File.Exists(Path.Combine(vendorFolder, cdmSource)))
            {
                CdmSourceScript = File.ReadAllText(Path.Combine(vendorFolder, cdmSource));
            }

            if (File.Exists(Path.Combine(vendorFolder, "CohortDefinition.sql")))
            {
                CohortDefinitionScript = File.ReadAllText(Path.Combine(vendorFolder, "CohortDefinition.sql"));
            }

            var folder = Path.Combine(vendorFolder, "Definitions");
            SourceQueryDefinitions = Directory.GetFiles(folder).Select(
               definition =>
               {
                   var qd = new QueryDefinition().DeserializeFromXml(File.ReadAllText(definition));
                   var fileInfo = new FileInfo(definition);
                   qd.FileName = fileInfo.Name.Replace(fileInfo.Extension, "");

                   return qd;
               }).ToList();

            //folder = Path.Combine(Directory.GetParent(vendorFolder).FullName, Path.Combine("Common", "Definitions"));
            //CommonQueryDefinitions = Directory.GetFiles(folder).Select(
            //    definition => new QueryDefinition().DeserializeFromXml(File.ReadAllText(definition))).ToList();

            //folder = Path.Combine(vendorFolder, "CDMDefinitions");
            //if (Directory.Exists(folder))
            //{
            //    DestinationQueryDefinitions = Directory.GetFiles(folder).Select(
            //     definition => new QueryDefinition().DeserializeFromXml(File.ReadAllText(definition))).ToList();
            //}
        }

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
        #endregion
    }
}
