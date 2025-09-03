using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class Settings
    {
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

        public string CloudStorageHolder { get; set; }

        public string CloudStorageConnectionString { get; set; }

        public string CloudPrefix { get; set; }

        public string CloudTriggerStorageUri { get; set; }

        public string CloudTriggerStorageHolder { get; set; }

        public string CloudTriggerStorageConnectionString { get; set; }

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
        public string CloudStorageKey { get; set; }

        /// <summary>
        /// AWS s3 - S3AwsSecretAccessKey; Azure Blob - ClientSecret
        /// </summary>
        public string CloudStorageSecret { get; set; }

        /// <summary>
        /// AWS s3 - Bucket; Azure Blob - BlobContainerName
        /// </summary>
        public string CloudStorageName { get; set; }

        /// <summary>
        /// AWS s3 - S3AwsAccessKeyId; Azure Blob - ClientId
        /// </summary>
        public string CloudTriggerStorageKey { get; set; }

        /// <summary>
        /// AWS s3 - S3AwsSecretAccessKey; Azure Blob - ClientSecret
        /// </summary>
        public string CloudTriggerStorageSecret { get; set; }

        /// <summary>
        /// AWS s3 - Bucket; Azure Blob - BlobContainerName
        /// </summary>
        public string CloudTriggerStorageName { get; set; }

        public string CDMFolder { get; set; }
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