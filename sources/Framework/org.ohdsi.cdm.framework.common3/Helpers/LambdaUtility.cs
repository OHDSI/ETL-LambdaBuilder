using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Core.Transformation.HealthVerity;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.framework.common.Helpers
{
    public class LambdaUtility(string cdmAccessKeyId, string cdmSecretAccessKey,
        string messageAccessKeyId,
        string messageSecretAccessKey, string buildMessageBucket, string cdmBucket, string mergeMessageBucket, string rawFolder)
    {
        private readonly string _cdmAccessKeyId = cdmAccessKeyId;
        private readonly string _cdmSecretAccessKey = cdmSecretAccessKey;
        private readonly string _messageAccessKeyId = messageAccessKeyId;
        private readonly string _messageSecretAccessKey = messageSecretAccessKey;

        private readonly string _cdmBucket = cdmBucket;

        private readonly string _rawFolder = rawFolder;

        private readonly AmazonS3Config _config = new()
        {
            Timeout = TimeSpan.FromMinutes(60),
            RegionEndpoint = Amazon.RegionEndpoint.USEast1,
            BufferSize = 512 * 1024,
            MaxErrorRetry = 20
        };

        public string BuildMessageBucket { get; } = buildMessageBucket;

        public string MergeMessageBucket { get; } = mergeMessageBucket;

        public bool AllChunksWereDone(Vendors vendor, int buildingId, string bucket)
        {
            return AllChunksWereDone(vendor, buildingId, bucket, "");
        }

        public static string GetBucket(string fullName)
        {
            if (fullName.Split('/').Length == 2)
            {
                return fullName.Split('/')[0];
            }

            return fullName;
        }

        public static string GetPrefix(string fullBucketName, string prefix)
        {
            if (fullBucketName.Split('/').Length == 2)
            {
                return $"{fullBucketName.Split('/')[1]}/{prefix}";
            }

            return prefix;
        }

        public bool AllChunksWereDone(Vendors vendor, int buildingId, string bucketFullName, string prefix)
        {
            var previousLastModified = DateTime.MinValue;
            var previousCount = 0;

            var bucket = GetBucket(bucketFullName);
            prefix = GetPrefix(bucketFullName, $"{prefix}{vendor}.{buildingId}.");

            Console.WriteLine("Awaiting lambda functions");
            Console.WriteLine("BucketName " + bucket);
            Console.WriteLine("Prefix " + prefix);

            Thread.Sleep(TimeSpan.FromSeconds(1));

            while (true)
            {
                var lastModified = DateTime.MinValue;

                var count = 0;

                using (var client = new AmazonS3Client(_messageAccessKeyId, _messageSecretAccessKey, _config))
                {
                    var request = new ListObjectsV2Request
                    {
                        BucketName = bucket,
                        Prefix = prefix
                    };

                    Task<ListObjectsV2Response> task;

                    do
                    {
                        task = client.ListObjectsV2Async(request);
                        task.Wait();

                        count += task.Result.S3Objects.Count;
                        if (task.Result.S3Objects.Count == 0)
                        {
                            Console.WriteLine("All chunks were converted");
                            return true;
                        }

                        foreach (var o in task.Result.S3Objects.OrderByDescending(o => o.LastModified))
                        {
                            if (o.LastModified > lastModified)
                                lastModified = o.LastModified;

                            break;
                        }

                        request.ContinuationToken = task.Result.NextContinuationToken;

                    } while (task.Result.IsTruncated);
                }

                Console.WriteLine($"{count} slices were not processed | PreviouLastModified={previousLastModified.ToLongTimeString()} LastModified={lastModified.ToLongTimeString()}");

                if (previousCount == count && previousLastModified == lastModified)
                {
                    Console.WriteLine("Something goes wrong. All chunks were not converted and lambdas message files were not updated longer than 10 minutes");
                    if (count > 100)
                    {
                        throw new Exception($"Too many slices were not converted | {count}");
                    }

                    return false;
                }

                previousLastModified = lastModified;
                previousCount = count;
                // decrease for unit tests
                Thread.Sleep(TimeSpan.FromMinutes(15));
            }
        }

        public List<Task> TriggerBuildFunction(Vendors vendor, int buildingId, int? chunkId, bool testMode)
        {
            var tasks = new List<Task>();
            int count = 0;

            var tuple = GetChunks(vendor, buildingId, chunkId, _cdmBucket, _rawFolder);
            Console.WriteLine($"{_cdmBucket}.{vendor}.{buildingId}.{_rawFolder} => {BuildMessageBucket}");
            Console.WriteLine(chunkId.HasValue
                ? $"ChunkId={chunkId.Value}; SlicesCount={tuple.Item2.Count}"
                : $"ChunksCount={tuple.Item1.Count}; SlicesCount={tuple.Item2.Count}");

            using (var client = new AmazonS3Client(_messageAccessKeyId, _messageSecretAccessKey, _config))
            using (var tu = new TransferUtility(client))
            {
                foreach (var cId in tuple.Item1)
                {
                    foreach (var slice in tuple.Item2)
                    {
                        if (!testMode)
                        {
                            var bucket = GetBucket(BuildMessageBucket);
                            var prefix = GetPrefix(BuildMessageBucket, $"{vendor}.{buildingId}.{cId}.{slice}.txt");

                            tasks.Add(tu.UploadAsync(new MemoryStream(), bucket, prefix));
                        }

                        count++;
                    }
                }
            }

            return tasks;
        }

        public void TriggerMergeFunction(Vendors vendor, int buildingId, int versionId, string cdmFolder, bool testMode)
        {
            var tasks = new List<Task>();
            var count = 0;

            var tables2 = new[]
            {
                "METADATA",
                "FACT_RELATIONSHIP",
                "_VERSION"
            };

            using (var client = new AmazonS3Client(_messageAccessKeyId, _messageSecretAccessKey, _config))
            using (var tu = new TransferUtility(client))
            {
                foreach (var table in tables2)
                {
                    if (!testMode)
                    {
                        var bucket = GetBucket(MergeMessageBucket);
                        var prefix = GetPrefix(MergeMessageBucket, $"{vendor}.{buildingId}.{table}.0.{versionId}.txt");

                        tasks.Add(tu.UploadAsync(new MemoryStream(), bucket, prefix));
                    }

                    Console.WriteLine($"For {table} created file on {MergeMessageBucket}");
                    count++;
                }
            }

            Task.WaitAll([.. tasks]);
            Console.WriteLine($"{count} merge lambda functions were triggered");
        }

        private Tuple<List<string>, List<string>> GetChunks(Vendors vendor, int buildingId, int? chunkId, string cdmBucket, string rawFolder)
        {
            using var client = new AmazonS3Client(_cdmAccessKeyId, _cdmSecretAccessKey, _config);
            var prefix = $"{vendor}/{buildingId}/{rawFolder}";
            if (chunkId.HasValue)
            {
                prefix = $"{vendor}/{buildingId}/{rawFolder}/{chunkId.Value}/";
            }

            var request = new ListObjectsV2Request
            {
                BucketName = cdmBucket,
                Prefix = prefix
            };

            Task<ListObjectsV2Response> task;
            var chunks = new HashSet<string>();
            var slices = new HashSet<string>();

            do
            {
                task = client.ListObjectsV2Async(request);
                task.Wait();

                foreach (var o in task.Result.S3Objects)
                {

                    if (o.Key.Contains("/metadata/"))
                        continue;

                    if (o.Key.Split('/').Length < 6)
                        continue;

                    chunks.Add(o.Key.Split('/')[3]);
                    var tableName = o.Key.Split('/')[4];
                    var fileName = o.Key.Split('/')[5];
                    var tail = fileName[fileName.IndexOf("_part")..];
                    var slice = fileName.Replace(tableName, "").Replace(tail, "");


                    slices.Add(slice);
                }

                request.ContinuationToken = task.Result.NextContinuationToken;

            } while (task.Result.IsTruncated);

            return Tuple.Create(chunks.ToList(), slices.ToList());
        }
    }
}