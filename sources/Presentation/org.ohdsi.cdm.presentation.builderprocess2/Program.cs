using System;
using System.Configuration;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common2.Base;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Cerner;
using org.ohdsi.cdm.framework.common2.Core.Transformation.CPRD;
using org.ohdsi.cdm.framework.common2.Core.Transformation.HCUP;
using org.ohdsi.cdm.framework.common2.Core.Transformation.JMDC;
using org.ohdsi.cdm.framework.common2.Core.Transformation.nhanes;
using org.ohdsi.cdm.framework.common2.Core.Transformation.OptumExtended;
using org.ohdsi.cdm.framework.common2.Core.Transformation.OptumOncology;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Premier;
using org.ohdsi.cdm.framework.common2.Core.Transformation.SEER;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Truven;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Settings;
using static System.Boolean;

namespace org.ohdsi.cdm.presentation.builderprocess2
{
    class Program
    {
        static void Main(string[] inputArgs)
        {
            Console.WriteLine("Process has started, please do not close the window...");
            if (inputArgs.Length > 0)
            {

                var args = string.Join(" ", inputArgs);
                var builderConnectionString = Regex.Match(args, @"(?s)(?<=\<cs\>).*?(?=\<\/cs\>)", RegexOptions.IgnoreCase).Value;
                var s3awsAccessKeyId = Regex.Match(args, @"(?s)(?<=\<s3keyid\>).*?(?=\<\/s3keyid\>)", RegexOptions.IgnoreCase).Value;
                var s3awsSecretAccessKey = Regex.Match(args, @"(?s)(?<=\<s3accesskey\>).*?(?=\<\/s3accesskey\>)", RegexOptions.IgnoreCase).Value;
                var ec2awsAccessKeyId = Regex.Match(args, @"(?s)(?<=\<ec2keyid\>).*?(?=\<\/ec2keyid\>)", RegexOptions.IgnoreCase).Value;
                var ec2awsSecretAccessKey = Regex.Match(args, @"(?s)(?<=\<ec2accesskey\>).*?(?=\<\/ec2accesskey\>)", RegexOptions.IgnoreCase).Value;
                var bucket = Regex.Match(args, @"(?s)(?<=\<bucket\>).*?(?=\<\/bucket\>)", RegexOptions.IgnoreCase).Value;

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
            
            Console.WriteLine($"MachineName={Environment.MachineName}; Vendor={Settings.Current.Building.Vendor}");
            var builderController = new BuilderController();
            try
            {
                Console.WriteLine("Loading vocabulary...");
                var vocabulary = new Vocabulary();
                vocabulary.Fill(false);
                Console.WriteLine("Vocabulary was loaded");
                Build(builderController);
            }
            catch (Exception e)
            {
                Logger.WriteError(e);

                builderController.UpdateState(BuilderState.Error);
            }
        }

        private static bool GetRandomBoolean()
        {
            return new Random().Next(100) % 2 == 0;
        }

        private static void Build(BuilderController builderController)
        {
            var dbChunk = new DbChunk(Settings.Current.Building.BuilderConnectionString);
            int? chunkId = null;

            while (true)
            {
                try
                {
                    builderController.RefreshState();
                    if (builderController.Builder.State == BuilderState.Stopping)
                        break;

                    if (builderController.Builder.State == BuilderState.Stopped)
                        break;

                    if (builderController.Builder.State == BuilderState.Error)
                        break;

                    if (builderController.Builder.State == BuilderState.Unknown ||
                        builderController.Builder.State == BuilderState.Idle)
                        continue;

                    chunkId = dbChunk.TakeChunk(Settings.Current.Building.Id.Value, Settings.Current.Builder.Id.Value, GetRandomBoolean());
                    if (!chunkId.HasValue) break;

                    Console.WriteLine($"ChunkId={chunkId} in progress...");

                    var attempt = 0;
                    var processing = false;
                    var chunk = Settings.Current.Building.SourceEngine.GetChunkBuilder(chunkId.Value, CreatePersonBuilder);
                    while (!processing)
                    {

                        try
                        {
                            attempt++;
                            chunk.Process();
                            processing = true;
                        }
                        catch (Exception ex)
                        {
                            if (attempt <= 3)
                            {
                                Logger.Write(chunkId, LogMessageTypes.Warning, "chunk.Process attempt=" + attempt + ") " + Logger.CreateExceptionString(ex));
                                chunk = Settings.Current.Building.SourceEngine.GetChunkBuilder(chunkId.Value, CreatePersonBuilder);
                            }
                            else
                            {
                                throw;
                            }
                        }
                    }
                    chunkId = null;
                }
                catch (Exception e)
                {
                    if (chunkId.HasValue)
                    {
                        Logger.WriteError(chunkId, e);
                        dbChunk.ChunkFailed(chunkId.Value, Settings.Current.Building.Id.Value);
                    }
                    else
                        Logger.Write(null, Settings.Current.Building.Id.Value, null, LogMessageTypes.Error,
                           Logger.CreateExceptionString(e));


                    builderController.UpdateState(BuilderState.Error);
                }
            }
        }

        private static IPersonBuilder CreatePersonBuilder()
        {
            switch (Settings.Current.Building.Vendor)
            {
                case Vendors.Truven_CCAE:
                case Vendors.Truven_MDCR:
                case Vendors.Truven_MDCD:
                    return new TruvenPersonBuilder();

                    case Vendors.OptumExtendedSES:
                    case Vendors.OptumExtendedDOD:
                        return new OptumExtendedPersonBuilder();

                    case Vendors.PremierV5:
                        return new PremierPersonBuilder();


                    case Vendors.Cerner:
                        return new CernerPersonBuilder();

                    case Vendors.HCUPv5:
                        return new HcupPersonBuilder();

                    case Vendors.JMDCv5:
                        return new JmdcPersonBuilder();

                    case Vendors.SEER:
                        return new SeerPersonBuilder();

                    case Vendors.OptumOncology:
                        return new OptumOncologyPersonBuilder();

                case Vendors.CprdV5:
                    return new CprdPersonBuilder();

                case Vendors.NHANES:
                    return new NhanesPersonBuilder();


                    //    case Vendors.ErasV5:
                    //        return new ErasV5PersonBuilder();

                    //    case Vendors.OptumIntegrated:
                    //        return new OptumIntegratedPersonBuilder();
            }

            return new PersonBuilder();

        }
        
    }
}
