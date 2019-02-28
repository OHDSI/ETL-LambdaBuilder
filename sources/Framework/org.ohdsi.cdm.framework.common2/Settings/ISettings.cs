using System;

namespace org.ohdsi.cdm.framework.common2.Settings
{
    public interface ISettings
    {
        ISettings Current { get; set; }

        IBuildingSettings Building { get; set; }

        DateTime Started { get; set; }
        bool Error { get; set; }

        bool ReadIdle { get; set; }

        double Duration { get; }
        
        bool Timeout { get; }
        
        string S3AwsAccessKeyId { get; set; }
        
        string S3AwsSecretAccessKey { get; set; }
        
        string Ec2AwsAccessKeyId { get; set; }
        
        string Ec2AwsSecretAccessKey { get; set; }

        string Bucket { get; set; }

        //void Initialize();
    }
}
