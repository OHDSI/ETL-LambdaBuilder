using System;
using System.Linq;
using System.Data.Odbc;
using System.Collections.Generic;
using System.Configuration;
using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.common2.Definitions;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Omop;
using org.ohdsi.cdm.framework.desktop;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using static System.Boolean;


namespace org.ohdsi.cdm.presentation.lookup
{
    public class Program
    {
        private static void Main(string[] inputArgs)
        {
            Console.WriteLine("Lookup creation in progress, please do not close the window...");
            try
            {
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
                    if(Enum.TryParse(storageType, out S3StorageType type))
                        Settings.Current.StorageType = type;

                    Console.WriteLine($"Bucket ={Settings.Current.Bucket};CDMFolder={Settings.Current.CDMFolder}");
                    Console.WriteLine($"SaveOnlyToS3={Settings.Current.SaveOnlyToS3}; StorageType={Settings.Current.StorageType};");
                }
                else
                {
                    Settings.Initialize(ConfigurationManager.ConnectionStrings["Builder"].ConnectionString, Environment.MachineName);
                }

                Console.WriteLine("Settings initialized");
                Console.WriteLine($"Vendor={Settings.Current.Building.Vendor}");
                
                Console.WriteLine("Loading vocabulary...");
                var vocabulary = new Vocabulary();
                vocabulary.Fill(true);
                Console.WriteLine("Vocabulary was loaded");

                var locationConcepts = new List<Location>();
                var careSiteConcepts = new List<CareSite>();
                var providerConcepts = new List<Provider>();

                Console.WriteLine("Loading locations...");
                var location = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd => qd.Locations != null && qd.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));
                if (location != null)
                {
                    FillList<Location>(locationConcepts, location, location.Locations[0]);
                }

                if (locationConcepts.Count == 0)
                    locationConcepts.Add(new Location { Id = Entity.GetId(null) });
                Console.WriteLine("Locations was loaded");

                Console.WriteLine("Loading care sites...");
                var careSite = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd => qd.CareSites != null && qd.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));
                if (careSite != null)
                {
                    FillList<CareSite>(careSiteConcepts, careSite, careSite.CareSites[0]);
                }

                if (careSiteConcepts.Count == 0)
                    careSiteConcepts.Add(new CareSite { Id = 0, LocationId = 0, OrganizationId = 0, PlaceOfSvcSourceValue = null });
                Console.WriteLine("Care sites was loaded");

                Console.WriteLine("Loading providers...");
                var provider = Settings.Current.Building.SourceQueryDefinitions.FirstOrDefault(qd => qd.Providers != null && qd.IsSuitable(qd.Query.Database, Settings.Current.Building.Vendor));
                if (provider != null)
                {
                    FillList<Provider>(providerConcepts, provider, provider.Providers[0]);
                }
                Console.WriteLine("Providers was loaded");

                Console.WriteLine("Saving lookups...");
                var saver = Settings.Current.Building.DestinationEngine.GetSaver();
                using (saver.Create(Settings.Current.Building.DestinationConnectionString))
                {
                    saver.SaveEntityLookup(locationConcepts, careSiteConcepts, providerConcepts);
                }

                Console.WriteLine("Lookups was saved " + Settings.Current.Building.DestinationEngine.Database);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                Console.ReadLine();
            }
        }

        private static void FillList<T>(ICollection<T> list, QueryDefinition qd, EntityDefinition ed) where T : IEntity
        {
            var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
              qd.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName), Settings.Current.Building.SourceSchemaName);
            
            if (string.IsNullOrEmpty(sql)) return;


            using (var connection = new OdbcConnection(Settings.Current.Building.SourceConnectionString))
            {
                connection.Open();
                using (var c = new OdbcCommand(sql, connection))
                {
                    c.CommandTimeout = 30000;
                    using (var reader = c.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Concept conceptDef = null;
                            if (ed.Concepts != null && ed.Concepts.Any())
                                conceptDef = ed.Concepts[0];

                            var concept = (T)ed.GetConcepts(conceptDef, reader, null).ToList()[0];

                            var key = concept.GetKey();
                            if (key == null) continue;

                            list.Add(concept);
                        }
                    }
                }
            }
        }
        
    }
}
