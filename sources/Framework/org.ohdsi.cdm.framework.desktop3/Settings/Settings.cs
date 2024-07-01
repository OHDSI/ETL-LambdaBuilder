using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Configuration;
using System.IO;
using static System.Boolean;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class Settings
    {
        private string _s3AwsAccessKeyId;
        private string _s3AwsSecretAccessKey;

        private string _ec2AwsAccessKeyId;
        private string _ec2AwsSecretAccessKey;
        private string _bucket;

        private string _cdmFolder;
        private bool? _saveOnlyToS3;
        private S3StorageType? _storageType;

        private string _VendorSettings;


        #region Properties
        public static Settings Current { get; set; }
        public BuildingSettings Building { get; set; }
        public BuilderSettings Builder { get; set; }

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
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropVocabularyTables.sql"));

        public string TruncateWithoutLookupTablesScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateWithoutLookupTables.sql"));

        public string TruncateTablesScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateTables.sql"));

        public string DropTablesScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropTables.sql"));

        public string TruncateLookupScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateLookup.sql"));

        public string CreateCdmTablesScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateTables.sql"));

        public string CreateCdmDatabaseScript => File.ReadAllText(
            Path.Combine([
                Builder.Folder,
                "Common",
                Building.DestinationEngine.Database.ToString(),
                "CreateDestination.sql"
            ]));

        public string CopyVocabularyScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CopyVocabulary.sql"));

        public string CreateIndexesScript => File.ReadAllText(
            Path.Combine(Builder.Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateIndexes.sql"));

        public string S3AwsAccessKeyId
        {
            get
            {
                if (!string.IsNullOrEmpty(_s3AwsAccessKeyId))
                    return _s3AwsAccessKeyId;

                return ConfigurationManager.AppSettings["s3_aws_access_key_id"];
            }
            set => _s3AwsAccessKeyId = value;
        }

        public string S3AwsSecretAccessKey
        {
            get
            {
                if (!string.IsNullOrEmpty(_s3AwsSecretAccessKey))
                    return _s3AwsSecretAccessKey;

                return ConfigurationManager.AppSettings["s3_aws_secret_access_key"];
            }
            set => _s3AwsSecretAccessKey = value;
        }

        public string MessageS3AwsAccessKeyId { get; set; }
        public string MessageS3AwsSecretAccessKey { get; set; }

        public string MessageBucket { get; set; }

        public string Ec2AwsAccessKeyId
        {
            get
            {
                if (!string.IsNullOrEmpty(_ec2AwsAccessKeyId))
                    return _ec2AwsAccessKeyId;

                return ConfigurationManager.AppSettings["ec2_aws_access_key_id"];
            }
            set => _ec2AwsAccessKeyId = value;
        }

        public string Ec2AwsSecretAccessKey
        {
            get
            {
                if (!string.IsNullOrEmpty(_ec2AwsSecretAccessKey))
                    return _ec2AwsSecretAccessKey;

                return ConfigurationManager.AppSettings["ec2_aws_secret_access_key"];
            }
            set => _ec2AwsSecretAccessKey = value;
        }

        public string Bucket
        {
            get
            {
                if (!string.IsNullOrEmpty(_bucket))
                    return _bucket;

                return ConfigurationManager.AppSettings["bucket"];
            }
            set => _bucket = value;
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

        public bool SaveOnlyToS3
        {
            get
            {
                if (_saveOnlyToS3.HasValue)
                    return _saveOnlyToS3.Value;

                return Parse(ConfigurationManager.AppSettings["SaveOnlyToS3"]);
            }
            set => _saveOnlyToS3 = value;
        }

        public S3StorageType StorageType
        {
            get
            {
                if (_storageType.HasValue)
                    return _storageType.Value;

                Enum.TryParse(ConfigurationManager.AppSettings["S3StorageType"], out S3StorageType type);
                return type;
            }
            set => _storageType = value;
        }

        public static string HixConnectionString
        {
            get
            {
                if (ConfigurationManager.ConnectionStrings["HIX"] != null)
                    return ConfigurationManager.ConnectionStrings["HIX"].ConnectionString;

                return null;
            }
        }

        public string VendorSettings
        {
            get => _VendorSettings;
            set => _VendorSettings = value;
        }


        #endregion

        #region Methods
        public static void Initialize(string builderConnectionString, string machineName)
        {
            Current.Building = new BuildingSettings(builderConnectionString);
            Current.Builder = new BuilderSettings(machineName);
            Current.Builder.Load();

            if (Current.Builder.BuildingId.HasValue)
                Current.Building.Load(Current.Builder.BuildingId.Value);
        }

        public static void Save()
        {
            Current.Building.Save();
            Current.Builder.BuildingId = Current.Building.Id;
            Current.Builder.Save();
        }

        private string GetCdmVersionFolder()
        {
            return Building.Cdm switch
            {
                CdmVersions.V52 => "v5.2",
                CdmVersions.V53 => "v5.3",
                CdmVersions.V6 => "v6.0",
                _ => "v5.2",
            };
        }

        #endregion
    }
}