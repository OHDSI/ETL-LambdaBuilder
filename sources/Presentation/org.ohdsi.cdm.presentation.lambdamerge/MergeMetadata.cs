using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Omop;
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
    class MergeMetadata(Settings settings, int versionId)
    {
        private readonly Settings _settings = settings;
        private List<MetadataOMOP> _metadata;
        private readonly int _versionId = versionId;

        public void Start()
        {
            _metadata = CreateMetadata();

            _metadata.Add(new MetadataOMOP { MetadataConceptId = 0, Name = "CDMLoadId", ValueAsString = _versionId.ToString(), MetadataDate = DateTime.Now.Date });
            _metadata.Add(new MetadataOMOP { MetadataConceptId = 37116952, Name = "Source data citation", ValueAsString = _settings.Vendor.Citation, MetadataDate = DateTime.Now.Date });
            _metadata.Add(new MetadataOMOP { MetadataConceptId = 4123211, Name = "Publication review requirements", ValueAsString = _settings.Vendor.Publication, MetadataDate = DateTime.Now.Date });

            for (int i = 0; i < _metadata.Count; i++)
            {
                _metadata[i].Id = i + 1; // Starts with 1
            }
        }

        public MemoryStream GetMetadataCsvStream()
        {
            var reader = new MetadataOMOPDataReader(_metadata);
            return framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
        }

        private List<MetadataOMOP> CreateMetadata()
        {
            var output = new List<MetadataOMOP>();

            var metadatas = new ConcurrentQueue<Dictionary<string, int>>();
            var perfix = $"{_settings.Vendor}/{_settings.BuildingId}/{_settings.CdmFolder}/METADATA_TMP/METADATA_TMP.";

            var request = new ListObjectsV2Request
            {
                BucketName = _settings.Bucket,
                Prefix = perfix
            };
            int count = 0;
            Console.WriteLine("Reading from METADATA_TMP CSVs...");
            using (var client = new AmazonS3Client(_settings.AwsAccessKeyId, _settings.AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1))
            {
                Task<ListObjectsV2Response> task;

                do
                {
                    task = client.ListObjectsV2Async(request);
                    task.Wait();

                    Parallel.ForEach(task.Result.S3Objects, o =>
                    {
                        var fileMetadata = ReadMetadata(o);
                        metadatas.Enqueue(fileMetadata);

                        Interlocked.Increment(ref count);
                        if (count % 1000 == 0)
                            Console.WriteLine(o.Key + " | " + count);
                    });


                    request.ContinuationToken = task.Result.NextContinuationToken;

                } while (task.Result.IsTruncated);
            }

            Console.WriteLine("Metadata were merged | " + count);

            var result = new Dictionary<string, int>();
            foreach (var metadata in metadatas)
            {
                foreach (var m in metadata)
                {
                    if (!result.ContainsKey(m.Key))
                        result.Add(m.Key, 0);

                    result[m.Key] += m.Value;
                }
            }

            var dt = DateTime.Now;
            foreach (var r in result)
            {
                output.Add(new MetadataOMOP
                {
                    MetadataConceptId = 0,
                    Name = r.Key,
                    ValueAsString = r.Value.ToString(),
                    ValueAsConceptId = 0,
                    MetadataDate = dt
                    //,MetadataDatetime = dt.ToString("HH:mm:ss")
                });
            }

            return output;
        }

        private Dictionary<string, int> ReadMetadata(S3Object o)
        {
            var metadata = new Dictionary<string, int>();
            using (var transferUtility = new TransferUtility(_settings.AwsAccessKeyId, _settings.AwsSecretAccessKey,
                Amazon.RegionEndpoint.USEast1))
            using (var responseStream = transferUtility.OpenStream(_settings.Bucket, o.Key))
            using (var bufferedStream = new BufferedStream(responseStream))
            using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
            using (var reader = new StreamReader(gzipStream, Encoding.Default))
            using (var csv = framework.common.Helpers.CsvHelper.CreateCsvReader(reader))
            //using (var csv = new CsvReader(reader, _settings.CsvConfiguration))
            {

                while (csv.Read())
                {
                    var name = csv.GetField(1);
                    if (!metadata.ContainsKey(name))
                        metadata.Add(name, 0);

                    metadata[name]++;
                }
            }

            return metadata;
        }
    }
}
