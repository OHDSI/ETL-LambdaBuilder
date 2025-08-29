using org.ohdsi.cdm.framework.common.Enums;
using System.Configuration;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class Settings
    {
        private string _cloudStorageKey;
        private string _cloudStorageSecret;
        private string _cloudStorageName;

        private string _cloudTriggerStorageKey;
        private string _cloudTriggerStorageSecret;
        private string _cloudTriggerStorageName;
        private string _cdmFolder;


        #region Properties
        public static Settings Current { get; set; }
        public BuildingSettings Building { get; set; }
        public string Folder { get; set; }

        public int ParallelQueries { get; set; }
        public int ParallelChunks { get; set; }

        public string LocalPath { get; set; }

        static Settings()
        {
            Current = new Settings
            {
                ParallelQueries = 1,
                ParallelChunks = 1
            };
        }

        public string DropVocabularyTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropVocabularyTables.sql"));

        public string TruncateWithoutLookupTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateWithoutLookupTables.sql"));

        public string TruncateTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateTables.sql"));

        public string DropTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropTables.sql"));

        public string TruncateLookupScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateLookup.sql"));

        public string CreateCdmTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateTables.sql"));

        public string CreateCdmDatabaseScript => File.ReadAllText(
            Path.Combine([
                Folder,
                "Common",
                "Queries",
                Building.DestinationEngine.Database.ToString(),
                "CreateDestination.sql"
            ]));

        public string CopyVocabularyScript => File.ReadAllText(
            Path.Combine(Folder, "Common",  "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CopyVocabulary.sql"));

        public string CreateIndexesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", "Queries", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateIndexes.sql"));

        /// <summary>
        /// AWS s3 - None; Azure Blob - ServiceUri
        /// </summary>
        public string CloudStorageUri { get; set; }

        public string CloudStorageUriDfs
        {
            get
            {
                return CloudStorageUri.Split("//")[1].Replace(".blob.", ".dfs.");
            }
        }


        /// <summary>
        /// AWS s3 - None; Azure Blob - TenantId
        /// </summary>
        public string CloudStorageHolder { get; set; }

        public string CloudPrefix { get; set; }

        /// <summary>
        /// AWS s3 - None; Azure Blob - ServiceUri
        /// </summary>
        public string CloudTriggerStorageUri { get; set; }

        /// <summary>
        /// AWS s3 - None; Azure Blob - TenantId
        /// </summary>
        public string CloudTriggerStorageHolder { get; set; }

        public string CloudTriggerPrefix { get; set; }

        public string BuildingPrefix
        {
            get
            {
                if (string.IsNullOrEmpty(Settings.Current.CloudPrefix))
                    return $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";

                return $"{Settings.Current.CloudPrefix}/{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";
            }
        }
        public string BuildingTriggerPrefix
        {
            get
            {
                if (string.IsNullOrEmpty(Settings.Current.CloudTriggerPrefix))
                    return $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";

                return $"{Settings.Current.CloudTriggerPrefix}/{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}";
            }
        }

        /// <summary>
        /// AWS s3 - S3AwsAccessKeyId; Azure Blob - ClientId
        /// </summary>
        public string CloudStorageKey
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudStorageKey))
                    return _cloudStorageKey;

                return ConfigurationManager.AppSettings["cloudStorageKey"];
            }
            set => _cloudStorageKey = value;
        }

        /// <summary>
        /// AWS s3 - S3AwsSecretAccessKey; Azure Blob - ClientSecret
        /// </summary>
        public string CloudStorageSecret
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudStorageSecret))
                    return _cloudStorageSecret;

                return ConfigurationManager.AppSettings["cloudStorageSecret"];
            }
            set => _cloudStorageSecret = value;
        }

        /// <summary>
        /// AWS s3 - Bucket; Azure Blob - BlobContainerName
        /// </summary>
        public string CloudStorageName
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudStorageName))
                    return _cloudStorageName;

                return ConfigurationManager.AppSettings["cloudStorageName"];
            }
            set => _cloudStorageName = value;
        }


        /// <summary>
        /// AWS s3 - S3AwsAccessKeyId; Azure Blob - ClientId
        /// </summary>
        public string CloudTriggerStorageKey
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudTriggerStorageKey))
                    return _cloudTriggerStorageKey;

                return ConfigurationManager.AppSettings["cloudTriggerStorageKey"];
            }
            set => _cloudTriggerStorageKey = value;
        }

        /// <summary>
        /// AWS s3 - S3AwsSecretAccessKey; Azure Blob - ClientSecret
        /// </summary>
        public string CloudTriggerStorageSecret
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudTriggerStorageSecret))
                    return _cloudTriggerStorageSecret;

                return ConfigurationManager.AppSettings["cloudTriggerStorageSecret"];
            }
            set => _cloudTriggerStorageSecret = value;
        }

        /// <summary>
        /// AWS s3 - Bucket; Azure Blob - BlobContainerName
        /// </summary>
        public string CloudTriggerStorageName
        {
            get
            {
                if (!string.IsNullOrEmpty(_cloudTriggerStorageName))
                    return _cloudTriggerStorageName;

                return ConfigurationManager.AppSettings["cloudTriggerStorageName"];
            }
            set => _cloudTriggerStorageName = value;
        }

        public string CDMFolder
        {
            get
            {
                if (!string.IsNullOrEmpty(_cdmFolder))
                    return _cdmFolder;

                return ConfigurationManager.AppSettings["CDMFolder"];
            }
            set => _cdmFolder = value;
        }
        #endregion

        #region Methods
        public static void Initialize(string builderConnectionString, string machineName)
        {
            Current.Building = new BuildingSettings(builderConnectionString);
        }

        private string GetCdmVersionFolder()
        {
            return Building.Cdm switch
            {
                CdmVersions.V54 => "v5.4",
            };
        }

        #endregion
    }
}