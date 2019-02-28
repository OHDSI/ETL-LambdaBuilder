using System;
using System.Configuration;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Settings;
using static System.Boolean;

namespace org.ohdsi.cdm.presentation.chunker
{
  
    class Program
    {
        //private class Options
        //{

        //    [Option('b', "builderconnectionstring", HelpText = "Connection string to Builder database", Required = false)]
        //    public string BuilderConnectionString { get; set; }

        //    [Option('s', "sourceconnectionstring", HelpText = "Connection string to Native database", Required = false)]
        //    public string SourceConnectionString { get; set; }

        //    [Option('d', "destinationconnectionstring", HelpText = "Connection string to CDM database", Required = false)]
        //    public string DestinationConnectionString { get; set; }

        //    [Option('v', "vocabularyconnectionstring", HelpText = "Connection string to CDM Vocabulary database", Required = false)]
        //    public string VocabularyConnectionString { get; set; }

        //    [Option('r', "vendor", HelpText = "Native dataset Vendor (Vendor Schema Id from HIX database)", Required = false)]
        //    public Vendors Vendor { get; set; }

        //    [Option('c', "chunksize", HelpText = "CDM Build Batch size", Required = false)]
        //    public int ChunkSize { get; set; }

        //    [Option('a', "s3awsaccesskeyid", HelpText = "S3 AWS Access Key Id", Required = false)]
        //    public string S3AwsAccessKeyId { get; set; }

        //    [Option('e', "s3awssecretaccesskey", HelpText = "S3 AWS Secret Access Key", Required = false)]
        //    public string S3AwsSecretAccessKey { get; set; }

        //    [Option('l', "loadid", HelpText = "CDM Build Load Id (from HIX database)", Required = false)]
        //    public int LoadId { get; set; }

        //    [Option("nativeSchema", HelpText = "Native database schema name", Required = false)]
        //    public string NativeSchema { get; set; }

        //    [Option("cdmSchema", HelpText = "CDM database schema name", Required = false)]
        //    public string CdmSchema { get; set; }
        //}
        static void Main(string[] inputArgs)
        {
            Console.WriteLine("Chunks creation in progress, please do not close the window...");

            try
            {
                bool restart = false;
                if (inputArgs.Length > 0)
                {

                    var args = string.Join(" ", inputArgs);
                    var builderConnectionString = Regex.Match(args, @"(?s)(?<=\<cs\>).*?(?=\<\/cs\>)", RegexOptions.IgnoreCase).Value;
                    var s3awsAccessKeyId = Regex.Match(args, @"(?s)(?<=\<s3keyid\>).*?(?=\<\/s3keyid\>)", RegexOptions.IgnoreCase).Value;
                    var s3awsSecretAccessKey = Regex.Match(args, @"(?s)(?<=\<s3accesskey\>).*?(?=\<\/s3accesskey\>)", RegexOptions.IgnoreCase).Value;
                    var ec2awsAccessKeyId = Regex.Match(args, @"(?s)(?<=\<ec2keyid\>).*?(?=\<\/ec2keyid\>)", RegexOptions.IgnoreCase).Value;
                    var ec2awsSecretAccessKey = Regex.Match(args, @"(?s)(?<=\<ec2accesskey\>).*?(?=\<\/ec2accesskey\>)", RegexOptions.IgnoreCase).Value;
                    var bucket = Regex.Match(args, @"(?s)(?<=\<bucket\>).*?(?=\<\/bucket\>)", RegexOptions.IgnoreCase).Value;
                    restart = Parse(Regex.Match(args, @"(?s)(?<=\<restart\>).*?(?=\<\/restart\>)", RegexOptions.IgnoreCase).Value);

                    var cdmFolder = Regex.Match(args, @"(?s)(?<=\<cdmFolder\>).*?(?=\<\/cdmFolder\>)", RegexOptions.IgnoreCase).Value;
                    var saveOnlyToS3 = Regex.Match(args, @"(?s)(?<=\<saveOnlyToS3\>).*?(?=\<\/saveOnlyToS3\>)", RegexOptions.IgnoreCase).Value;
                    var storageType = Regex.Match(args, @"(?s)(?<=\<storageType\>).*?(?=\<\/storageType\>)", RegexOptions.IgnoreCase).Value;


                    Settings.Initialize(builderConnectionString, Environment.MachineName);
                    Settings.Current.S3AwsAccessKeyId = s3awsAccessKeyId;
                    Settings.Current.S3AwsSecretAccessKey = s3awsSecretAccessKey;
                    Settings.Current.Ec2AwsAccessKeyId = ec2awsAccessKeyId;
                    Settings.Current.Ec2AwsSecretAccessKey = ec2awsSecretAccessKey;
                    Settings.Current.Bucket = bucket;

                    Settings.Current.CDMFolder = cdmFolder;
                    Settings.Current.SaveOnlyToS3 = Parse(saveOnlyToS3);
                    if (Enum.TryParse(storageType, out S3StorageType type))
                        Settings.Current.StorageType = type;

                    Console.WriteLine($"Bucket ={Settings.Current.Bucket};CDMFolder={Settings.Current.CDMFolder}");
                    Console.WriteLine($"SaveOnlyToS3={Settings.Current.SaveOnlyToS3}; StorageType={Settings.Current.StorageType};");
                }
                else
                {
                    Settings.Initialize(ConfigurationManager.ConnectionStrings["Builder"].ConnectionString, Environment.MachineName);
                }

                Console.WriteLine("Settings initialized");

                Console.WriteLine($"Vendor={Settings.Current.Building.Vendor}; restart={restart}");
                Console.WriteLine($"BuildingId={Settings.Current.Building.Id}; Chunk size={Settings.Current.Building.BatchSize}");

                var chunkController = new ChunkController();
                chunkController.CreateChunks(restart);

                if (Settings.Current.Building.SourceEngine.Database == Database.Redshift)
                {
                    Console.WriteLine("Saving vocabulary to S3...");
                    var vocabulary = new Vocabulary();
                    vocabulary.SaveToS3(); 
                    Console.WriteLine("Vocabulary was saved to S3");
                }
                
                Console.WriteLine("DONE.");
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                Console.ReadLine();
            }
        }
    }
}
