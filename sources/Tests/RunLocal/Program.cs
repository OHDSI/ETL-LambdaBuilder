using Amazon.S3;
using Amazon.S3.Model;
using System;
using System.Configuration;
using System.IO;
using org.ohdsi.cdm.framework.common.Enums;
using Function = org.ohdsi.cdm.presentation.lambdabuilder.Function;
using org.ohdsi.cdm.framework.common.Utility;

namespace RunLocal
{
    class Program
    {
        private static string _awsAccessKeyId;
        private static string _awsSecretAccessKey;
        private static string _bucket;
        private static string _cdmFolder;

        static void Main(string[] args)
        {
            _awsAccessKeyId = ConfigurationManager.AppSettings["awsAccessKeyId"];
            _awsSecretAccessKey = ConfigurationManager.AppSettings["awsSecretAccessKey"];
            _bucket = ConfigurationManager.AppSettings["bucket"];
            _cdmFolder = ConfigurationManager.AppSettings["cdmFolder"];
            Console.WriteLine($"Settings: {_awsAccessKeyId}; {_awsSecretAccessKey}");
            Console.WriteLine($"Settings: {_bucket}; {_cdmFolder}");

            Console.WriteLine($"{Directory.GetCurrentDirectory()}");

            var vendor = EtlLibrary.CreateVendorInstance(args[5], args[0]);
            Process(vendor, int.Parse(args[1]), int.Parse(args[2]), args[3], bool.Parse(args[4]), args[5]);

            //int[] slicesNum = [24, 40, 48, 96, 192];

            //var localTmpPath = "C:\\_tmp";
            //var validation = new Validation(_awsAccessKeyId, _awsSecretAccessKey, _bucket, localTmpPath);
            //validation.Start((Vendor)Enum.Parse(typeof(Vendor), args[0]), int.Parse(args[1]), slicesNum[0], _cdmFolder);

            Console.WriteLine("DONE");
            Console.ReadLine();
        }

        private static string Process(Vendor vendor, int buildingId, int chunkId, string prefix, bool clean, string etlLibraryFolderPath)
        {
            try
            {
                var config = new AmazonS3Config
                {
                    Timeout = TimeSpan.FromMinutes(60),
                    RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                    MaxErrorRetry = 20,
                };

                var tables = new[]
                {
                    "PERSON",
                    "OBSERVATION_PERIOD",
                    "PAYER_PLAN_PERIOD",
                    "DEATH",
                    "DRUG_EXPOSURE",
                    "OBSERVATION",
                    "VISIT_OCCURRENCE",
                    "VISIT_DETAIL",
                    "PROCEDURE_OCCURRENCE",
                    "DRUG_ERA",
                    "CONDITION_ERA",
                    "DEVICE_EXPOSURE",
                    "MEASUREMENT",
                    "COHORT",
                    "CONDITION_OCCURRENCE",
                    "COST",
                    "NOTE",
                    "METADATA_TMP",
                    "FACT_RELATIONSHIP"
                };

                if (clean)
                {
                    foreach (var table in tables)
                    {
                        Clean(vendor, buildingId, chunkId, table, int.Parse(prefix));
                    }
                    Console.WriteLine($"chunkId={chunkId};prefix={prefix} - CLEANED");
                }

                var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey, config);

                var func = new Function(client);
                var t = func.FunctionHandler2(_awsAccessKeyId, _awsSecretAccessKey, _bucket, _cdmFolder, vendor, buildingId, chunkId, prefix, 0, etlLibraryFolderPath);
                t.Wait();

                Console.WriteLine($"chunkId={chunkId};prefix={prefix} - DONE");

                return $"chunkId={chunkId};prefix={prefix}";
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                Console.WriteLine($"chunkId={chunkId};prefix={prefix} - ERROR");
                return null;
            }
        }

        public static void Clean(Vendor vendor, int buildingId, int chunkId, string table, int slice)
        {
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;

                    var perfix = $"{vendor}/{buildingId}/{_cdmFolder}/{table}/{table}.{slice}.{chunkId}.";

                    using (var client = new AmazonS3Client(_awsAccessKeyId, _awsSecretAccessKey,
                        Amazon.RegionEndpoint.USEast1))
                    {
                        var request = new ListObjectsV2Request
                        {
                            BucketName = _bucket,
                            Prefix = perfix
                        };
                        ListObjectsV2Response response;
                        do
                        {
                            using var getListObjects = client.ListObjectsV2Async(request);
                            getListObjects.Wait();
                            response = getListObjects.Result;

                            var multiObjectDeleteRequest = new DeleteObjectsRequest
                            {
                                BucketName = _bucket
                            };

                            foreach (var o in response.S3Objects)
                            {
                                multiObjectDeleteRequest.AddKey(o.Key, null);
                            }

                            if (response.S3Objects.Count > 0)
                            {
                                using var deleteObjects = client.DeleteObjectsAsync(multiObjectDeleteRequest);
                                deleteObjects.Wait();
                            }

                            request.ContinuationToken = response.NextContinuationToken;
                        } while (response.IsTruncated == true);
                    }

                    complete = true;
                }
                catch (Exception ex)
                {
                    Console.Write(" | [Clean] Exception | new attempt | " + attempt);
                    Console.WriteLine(ex.Message);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
        }
    }
}