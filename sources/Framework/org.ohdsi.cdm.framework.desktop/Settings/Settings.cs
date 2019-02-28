using System;
using System.Configuration;
using System.IO;
using org.ohdsi.cdm.framework.common2.Enums;
using static System.Boolean;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class Settings //: ISettings
    {
        private string _s3AwsAccessKeyId;
        private string _s3AwsSecretAccessKey;

        private string _ec2AwsAccessKeyId;
        private string _ec2AwsSecretAccessKey;
        private string _bucket;

        private string _cdmFolder;
        private bool? _saveOnlyToS3;
        private S3StorageType? _storageType;

        #region Properties
        public static Settings Current { get; set; }
        public BuildingSettings Building { get; set; }
        public BuilderSettings Builder { get; set; }

        static Settings()
        {
            Current = new Settings();
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
            Path.Combine(new[] {
                Builder.Folder,
                "Common",
                Building.DestinationEngine.Database.ToString(),
                "CreateDestination.sql"
            }));

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
        
        public string HixConnectionString
        {
            get
            {
                if (ConfigurationManager.ConnectionStrings["HIX"] != null)
                    return ConfigurationManager.ConnectionStrings["HIX"].ConnectionString;

                return null;
            }
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

        public void Save()
        {
            Current.Building.Save();
            Current.Builder.BuildingId = Current.Building.Id;
            Current.Builder.Save();
        }

        private string GetCdmVersionFolder()
        {
            switch (Building.Cdm)
            {
                case CdmVersions.V5:
                    return "v5";
                case CdmVersions.V501:
                    return "v5.01";
                case CdmVersions.V52:
                    return "v5.2";
                case CdmVersions.V53:
                    return "v5.3";

                default:
                    return "v5.2";
            }
        }

        #endregion
    }
}
