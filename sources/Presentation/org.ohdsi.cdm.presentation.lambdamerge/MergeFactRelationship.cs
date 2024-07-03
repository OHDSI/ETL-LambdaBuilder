using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.Utility;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.lambdamerge
{
    public class MergeFactRelationship(Settings settings)
    {
        private readonly Settings _settings = settings;

        private IEnumerable<FactRelationship> Cleanup(List<FactRelationship> factRelationships)
        {
            Console.WriteLine("Cleanup...");

            var prefix = $"{_settings.Vendor}/{_settings.BuildingId}/{_settings.CdmFolder}/METADATA_TMP/METADATA_TMP.";
            var personIdsToDrop = new ConcurrentDictionary<long, bool>();

            Console.WriteLine("BucketName " + _settings.Bucket);
            Console.WriteLine("Prefix " + prefix);
            var request = new ListObjectsV2Request
            {
                BucketName = _settings.Bucket,
                Prefix = prefix
            };
            int count = 0;
            Console.WriteLine("Reading from METADATA_TMP CSVs...");
            using (var client = S3ClientFactory.CreateS3Client())
            {
                Task<ListObjectsV2Response> task;

                do
                {
                    task = client.ListObjectsV2Async(request);
                    task.Wait();

                    Parallel.ForEach(task.Result.S3Objects, o =>
                    {
                        using (var transferUtility = new TransferUtility(_settings.AwsAccessKeyId, _settings.AwsSecretAccessKey,
              Amazon.RegionEndpoint.USEast1))
                        using (var responseStream = transferUtility.OpenStream(_settings.Bucket, o.Key))
                        using (var bufferedStream = new BufferedStream(responseStream))
                        using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                        using (var reader = new StreamReader(gzipStream, Encoding.Default))
                        using (var csv = new CsvReader(reader, _settings.CsvConfiguration))
                        {

                            while (csv.Read())
                            {
                                var id = long.Parse(csv.GetField(0));
                                personIdsToDrop.TryAdd(id, false);
                            }
                        }

                        Interlocked.Increment(ref count);

                        if (count % 1000 == 0)
                            Console.WriteLine(o.Key + " | " + count);
                    });


                    request.ContinuationToken = task.Result.NextContinuationToken;

                } while (task.Result.IsTruncated);
            }

            Console.WriteLine("Metadata count=" + count);

            var removed = 0;
            var cnt = 0;
            foreach (var fr in factRelationships)
            {
                if (personIdsToDrop.ContainsKey(fr.FactId1) || personIdsToDrop.ContainsKey(fr.FactId2))
                {
                    removed++;
                }
                else
                {
                    cnt++;
                    yield return fr;
                }
            }

            Console.WriteLine($"Removed count {removed} from {cnt}");
            Console.WriteLine("Cleanup DONE.");
        }

        public MemoryStream GetFactRelationshipCsvStream()
        {
            var factRelationships = CreateFactRelationships();

            Console.WriteLine("factRelationships.Count=" + factRelationships.Count);
            if (factRelationships.Count == 0)
            {
                factRelationships.Add(new FactRelationship
                {
                    DomainConceptId1 = 0,
                    DomainConceptId2 = 0,
                    FactId1 = 0,
                    FactId2 = 0,
                    RelationshipConceptId = 0
                });

                var reader = new FactRelationshipDataReader(factRelationships);
                return reader.GetStream(framework.common.Enums.S3StorageType.CSV);
            }
            else
            {
                var reader = new FactRelationshipDataReader(Cleanup(factRelationships));
                return reader.GetStream(framework.common.Enums.S3StorageType.CSV);
            }
        }

        private List<FactRelationship> CreateFactRelationships()
        {
            var fr = new ConcurrentDictionary<long, HashSet<FactRelationship>>();

            var prefix = $"{_settings.Vendor}/{_settings.BuildingId}/{_settings.CdmFolder}/FACT_RELATIONSHIP_TMP/FACT_RELATIONSHIP_TMP.";
            int filesProcessed = 0;

            var request = new ListObjectsV2Request
            {
                BucketName = _settings.Bucket,
                Prefix = prefix
            };

            Console.WriteLine("Reading from FACT_RELATIONSHIP_TMP CSVs...");
            using (var client = S3ClientFactory.CreateS3Client())
            {
                Task<ListObjectsV2Response> task;

                do
                {
                    task = client.ListObjectsV2Async(request);
                    task.Wait();

                    Parallel.ForEach(task.Result.S3Objects, o =>
                    {
                        foreach (var factRelationship in ReadFactRelationships(o))
                        {
                            var childId = factRelationship.FactId2;
                            if (!fr.ContainsKey(childId))
                                fr.TryAdd(childId, []);

                            fr[childId].Add(factRelationship);
                        }

                        Interlocked.Increment(ref filesProcessed);

                        if (filesProcessed % 1000 == 0)
                            Console.WriteLine(o.Key + " | " + filesProcessed);
                    });


                    request.ContinuationToken = task.Result.NextContinuationToken;
                } while (task.Result.IsTruncated);
            }

            var result2 = new List<FactRelationship>();
            foreach (var group in fr)
            {
                if (group.Value.Count != 1)
                    continue;

                var relation = group.Value.First();

                result2.Add(relation);
                result2.Add(new FactRelationship
                {
                    DomainConceptId1 = 56,
                    DomainConceptId2 = 56,
                    FactId1 = relation.FactId2,
                    FactId2 = relation.FactId1,
                    RelationshipConceptId = 40485452
                });
            }

            Console.WriteLine("FactRelationships were merged | " + filesProcessed);
            return result2;
        }

        private List<FactRelationship> ReadFactRelationships(S3Object o)
        {
            var fr = new HashSet<FactRelationship>();
            var attempt = 0;
            var complete = false;

            while (!complete)
            {
                try
                {
                    attempt++;

                    using (var transferUtility = new TransferUtility(_settings.AwsAccessKeyId, _settings.AwsSecretAccessKey,
                        Amazon.RegionEndpoint.USEast1))
                    using (var responseStream = transferUtility.OpenStream(_settings.Bucket, o.Key))
                    using (var bufferedStream = new BufferedStream(responseStream))
                    using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
                    using (var reader = new StreamReader(gzipStream, Encoding.Default))
                    using (var csv = new CsvReader(reader, _settings.CsvConfiguration))
                    {
                        while (csv.Read())
                        {
                            var domainConceptId1 = long.Parse(csv.GetField(0));
                            var factId1 = long.Parse(csv.GetField(1));
                            var domainConceptId2 = long.Parse(csv.GetField(2));
                            var factId2 = long.Parse(csv.GetField(3));
                            var relationshipConceptId = long.Parse(csv.GetField(4));

                            if (relationshipConceptId == 40478925)
                            {
                                fr.Add(new FactRelationship
                                {
                                    DomainConceptId1 = domainConceptId1,
                                    DomainConceptId2 = domainConceptId2,
                                    FactId1 = factId1,
                                    FactId2 = factId2,
                                    RelationshipConceptId = relationshipConceptId
                                });
                            }
                        }
                    }

                    complete = true;

                }
                catch (Exception e)
                {
                    Console.Write(" | Exception " + e.Message);
                    if (attempt > 3)
                    {
                        throw;
                    }
                }
            }
            return [.. fr];
        }
    }
}
