using Amazon.Runtime;
using Amazon.S3;
using Amazon.SecurityToken;
using Amazon.SecurityToken.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.framework.common.Utility
{
    public static class S3ClientFactory
    {
        private static string _awsAccessKeyId;
        private static string _awsSecretAccessKey;

        private static string _awsMessageAccessKeyId;
        private static string _awsMessageSecretAccessKey;

        private static string _roleArn;
        private static string _roleSessionName;

        private static bool _IAM_role_authentication_failed = false;

        /// <summary>
        /// This only needs to be executed once to keep info from App.config
        /// </summary>
        /// <param name="awsAccessKeyId"></param>
        /// <param name="awsSecretAccessKey"></param>
        /// <param name="roleArn"></param>
        /// <param name="roleSessionName"></param>
        public static void SetAppSettings(string awsAccessKeyId, string awsSecretAccessKey, 
            string awsMessageAccesssKeyId, string awsMessageSecretAccessKey,
            string roleArn, string roleSessionName)
        {
            _awsAccessKeyId = awsAccessKeyId;
            _awsSecretAccessKey = awsSecretAccessKey;
            _awsMessageAccessKeyId = awsMessageAccesssKeyId;
            _awsMessageSecretAccessKey = awsMessageSecretAccessKey;
            _roleArn = roleArn;
            _roleSessionName = roleSessionName;            
        }

        /// <summary>
        /// Create an Amazon S3 client. Try to use IAM role first. In case of an error use access keys. Default values for config are used if amazonS3Config is omitted.
        /// </summary>
        /// <param name="amazonS3Config">Default config is Timeout = TimeSpan.FromMinutes(60), RegionEndpoint = Amazon.RegionEndpoint.USEast1, MaxErrorRetry = 20, </param>
        /// <param name="useMessageKeys">False means AWS keys are used for keys authentication. True means AWS Message keys are used</param>
        /// <returns></returns>
        /// <exception cref="AmazonAccountIdException"></exception>
        public static AmazonS3Client CreateS3Client(AmazonS3Config amazonS3Config = null, bool useMessageKeys = false)
        {
            var config = amazonS3Config ?? new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20,
            };

            //try using IAM role
            if (!_IAM_role_authentication_failed && !string.IsNullOrEmpty(_roleArn) && !string.IsNullOrEmpty(_roleSessionName))
                try
                {
                    Console.WriteLine("Trying to login to AWS using IAM role!");
                    var client = CreateS3ClientViaIamRole(config);
                    Console.WriteLine("Managed to login to AWS using the specified IAM role!");
                    return client;
                }
                catch (AmazonSecurityTokenServiceException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    _IAM_role_authentication_failed = true;
                }
                catch (AmazonAccountIdException e)
                {
                    Console.WriteLine("Failed to login to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    _IAM_role_authentication_failed = true;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Unexpected error while logging in to AWS using the specified IAM role!");
                    Console.WriteLine(e.Message);
                    _IAM_role_authentication_failed = true;
                    throw;
                }

            //go here if no IAM role credentials specified or failed to use them to login
            //try using access keys
            if (!string.IsNullOrEmpty(_awsAccessKeyId) && !string.IsNullOrEmpty(_awsSecretAccessKey))
                try
                {
                    Console.WriteLine("Trying to login to AWS using access keys!");
                    var client = CreateS3ClientViaAccessKeys(config, useMessageKeys);
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

        static AmazonS3Client CreateS3ClientViaAccessKeys(AmazonS3Config config, bool useMessageKeys = false)
        {
            if (useMessageKeys)
            {
                var credentials = new BasicAWSCredentials(_awsMessageAccessKeyId, _awsMessageSecretAccessKey);
                var client = new AmazonS3Client(credentials, config);
                return client;
            }
            else
            {
                var credentials = new BasicAWSCredentials(_awsAccessKeyId, _awsSecretAccessKey);
                var client = new AmazonS3Client(credentials, config);
                return client;
            }
        }
    }
}
