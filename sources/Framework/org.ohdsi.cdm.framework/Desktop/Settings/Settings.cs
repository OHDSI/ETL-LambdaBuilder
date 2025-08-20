using org.ohdsi.cdm.framework.common.Enums;
using System.Configuration;

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
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropVocabularyTables.sql"));

        public string TruncateWithoutLookupTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateWithoutLookupTables.sql"));

        public string TruncateTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateTables.sql"));

        public string DropTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "DropTables.sql"));

        public string TruncateLookupScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "TruncateLookup.sql"));

        public string CreateCdmTablesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateTables.sql"));

        public string CreateCdmDatabaseScript => File.ReadAllText(
            Path.Combine([
                Folder,
                "Common",
                Building.DestinationEngine.Database.ToString(),
                "CreateDestination.sql"
            ]));

        public string CopyVocabularyScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CopyVocabulary.sql"));

        public string CreateIndexesScript => File.ReadAllText(
            Path.Combine(Folder, "Common", Building.DestinationEngine.Database.ToString(), GetCdmVersionFolder(), "CreateIndexes.sql"));

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
                CdmVersions.V52 => "v5.2",
                CdmVersions.V53 => "v5.3",
                CdmVersions.V6 => "v6.0",
                _ => "v5.2",
            };
        }

        #endregion
    }
}