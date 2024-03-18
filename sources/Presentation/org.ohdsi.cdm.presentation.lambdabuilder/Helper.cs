using Amazon.S3;
using Amazon.S3.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    class Helper
    {
        public static IEnumerable<string> GetFiles(string prefix)
        {
            prefix = prefix.Replace("\\", "/");

            var request = new ListObjectsV2Request
            {
                BucketName = Settings.Current.Bucket,
                Prefix = prefix
            };

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                Settings.Current.S3AwsSecretAccessKey, config);
            using var listObjects = client.ListObjectsV2Async(request);
            listObjects.Wait();

            foreach (var entry in listObjects.Result.S3Objects)
            {
                if (!entry.Key.EndsWith(".xml"))
                    continue;

                yield return entry.Key;
            }
        }

        public static string S3ReadAllText(string key)
        {
            key = key.Replace("\\", "/");
            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                Settings.Current.S3AwsSecretAccessKey, config);
            var getObjectRequest = new GetObjectRequest
            {
                BucketName = Settings.Current.Bucket,
                Key = key
            };

            try
            {
                var getObject = client.GetObjectAsync(getObjectRequest);
                getObject.Wait();
                using var response = getObject.Result;
                using var responseStream = response.ResponseStream;
                using var reader = new StreamReader(responseStream, Encoding.Default);
                var content = reader.ReadToEnd();
                return content;

            }
            catch (Exception ex)
            {
                if (((Amazon.Runtime.AmazonServiceException)ex.InnerException).StatusCode ==
                    System.Net.HttpStatusCode.NotFound)
                {
                    Console.Write(" - not exists");
                    return null;
                }

                throw;
            }
        }
    }
}
