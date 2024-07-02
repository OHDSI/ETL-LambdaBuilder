using Amazon.S3;
using Amazon.S3.Model;
using System;
using System.Configuration;
using System.IO;
using org.ohdsi.cdm.framework.common.Enums;
using Function = org.ohdsi.cdm.presentation.lambdabuilder.Function;
using Amazon.Runtime;
using Amazon;
using Amazon.SecurityToken;
using Amazon.SecurityToken.Model;

namespace RunLocal
{
    class Program
    {
        private static string _awsAccessKeyId;
        private static string _awsSecretAccessKey;
        private static string _bucket;
        private static string _cdmFolder;
        private static string _roleArn;
        private static string _roleSessionName;


        static void Main(string[] args)
        {
            _awsAccessKeyId = ConfigurationManager.AppSettings["awsAccessKeyId"];
            _awsSecretAccessKey = ConfigurationManager.AppSettings["awsSecretAccessKey"];
            _bucket = ConfigurationManager.AppSettings["bucket"];
            _cdmFolder = ConfigurationManager.AppSettings["cdmFolder"];
            _roleArn = ConfigurationManager.AppSettings["roleArn"];
            _roleSessionName = ConfigurationManager.AppSettings["roleSessionName"];

            Console.WriteLine($"Settings: {_awsAccessKeyId}; {_awsSecretAccessKey}");
            Console.WriteLine($"Settings: {_roleArn}; {_roleSessionName}");
            Console.WriteLine($"Settings: {_bucket}; {_cdmFolder}");

            Console.WriteLine($"{Directory.GetCurrentDirectory()}");

            //Process(Vendors.OptumPantherFull, 19140, 178, "0087", true);
            bool arg4 = false; 
            Process(Vendor.CreateVendorInstanceByName(args[0]), int.Parse(args[1]), int.Parse(args[2]), args[3], bool.TryParse(args[4], out arg4));

            //int[] slicesNum = [24, 40, 48, 96, 192];

            //var localTmpPath = "C:\\_tmp";
            //var validation = new Validation(_awsAccessKeyId, _awsSecretAccessKey, _bucket, localTmpPath);
            //validation.Start((Vendor)Enum.Parse(typeof(Vendor), args[0]), int.Parse(args[1]), slicesNum[0], _cdmFolder);

            Console.WriteLine("DONE");
            Console.ReadLine();
        }

        private static string Process(Vendor vendor, int buildingId, int chunkId, string prefix, bool clean)
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

                var client = CreateS3Client();

                var func = new Function(client);
                var t = func.FunctionHandler2(_awsAccessKeyId, _awsSecretAccessKey, _bucket, _cdmFolder, vendor, buildingId, chunkId, prefix, 0);
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

                    using (var client = CreateS3Client())                        
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

        static AmazonS3Client CreateS3Client(AmazonS3Config amazonS3Config = null)
        {
            var config = amazonS3Config ?? new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20,
            };

            //try using IAM role
            if (!string.IsNullOrEmpty(_roleArn) && !string.IsNullOrEmpty(_roleSessionName))
                try
                {
                    var client = CreateS3ClientViaIamRole(config);
                    Console.WriteLine("Managed to login to AWS using the specified IAM role!");
                    return client;
                }
                catch (AmazonSecurityTokenServiceException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    Console.WriteLine("Trying to login to AWS using access keys!");
                }
                catch (AmazonAccountIdException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    Console.WriteLine("Trying to login to AWS using access keys!");
                }
                catch (Exception e)
                {
                    Console.WriteLine("Unexpected error while logging in to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    throw;
                }

            //go here if no IAM role credentials specified or failed to use them to login
            //try using access keys
            if (!string.IsNullOrEmpty(_awsAccessKeyId) && !string.IsNullOrEmpty(_awsSecretAccessKey))
                try
                {
                    var client = CreateS3ClientViaAccessKeys(config);
                    Console.WriteLine("Managed to login to AWS using the specified access keys!");
                    return client;
                }
                catch (AmazonSecurityTokenServiceException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified access keys!");
                    Console.WriteLine(e.Message);
                    throw;
                }
                catch (AmazonAccountIdException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified access keys!");
                    Console.WriteLine(e.Message);
                    throw;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Unexpected error while logging in to AWS using the specified access keys!");
                    Console.WriteLine(e.Message);
                    throw;
                }

            else
            {
                throw new AmazonAccountIdException("AWS credentials are not configured properly.");
            }
        }

        static AmazonS3Client CreateS3ClientViaIamRole(AmazonS3Config config)
        {
            var stsClient = new AmazonSecurityTokenServiceClient();
            var assumeRoleRequest = new AssumeRoleRequest
            {
                RoleArn = _roleArn,
                RoleSessionName = _roleSessionName
            };
            var assumeRoleResponse = stsClient.AssumeRoleAsync(assumeRoleRequest).GetAwaiter().GetResult();
            var credentials = assumeRoleResponse.Credentials ?? throw new AmazonAccountIdException("Failed to assume IAM role!");
            var sessionCredentials = new SessionAWSCredentials(
                credentials.AccessKeyId,
                credentials.SecretAccessKey,
                credentials.SessionToken
            );
            var client = new AmazonS3Client(sessionCredentials, config);
            return client;
        }

        static AmazonS3Client CreateS3ClientViaAccessKeys(AmazonS3Config config)
        {
            var credentials = new BasicAWSCredentials(_awsAccessKeyId, _awsSecretAccessKey);
            var client = new AmazonS3Client(credentials, config);
            return client;
        }
    }
}