using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.Databases;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common.Utility;
using org.ohdsi.cdm.framework.Common.Base;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class BuildingSettings(string builderConnectionString) : IVendorSettings
    {
        #region Variables
        private readonly DbBuildingSettings _dbBuildingSettings = new(builderConnectionString);
        private IDatabaseEngine _sourceEngine;
        private IDatabaseEngine _destinationEngine;
        #endregion

        #region Properties
        public int? Id { get; private set; }

        public Vendor Vendor { get; set; }
        public List<QueryDefinition> SourceQueryDefinitions { get; set; }
        public List<LookupDefinition> CombinedLookupDefinitions { get; set; }

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

        public string BatchScript { get; set; }
        public string EtlLibraryPath { get; set; }

        public string Param1 { get; set; }

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

        #region Methods

        public bool Load(int buildingId)
        {
            Id = null;
            Console.WriteLine("buildingId:" + buildingId);
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

            Console.WriteLine("Vendor: " + reader.GetString("Vendor"));
            Console.WriteLine("EtlLibraryPath: " + EtlLibraryPath);

            this.Vendor = EtlLibrary.CreateVendorInstance(EtlLibraryPath, reader.GetString("Vendor"));

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
            Console.WriteLine("etlLibraryPath: " + EtlLibraryPath);
            EtlLibrary.LoadVendorSettings(EtlLibraryPath, this); 
        }

        #endregion
    }
}
