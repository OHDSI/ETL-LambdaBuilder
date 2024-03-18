using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CsvHelper;
using org.ohdsi.cdm.framework.common.Attributes;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.presentation.lambdamerge
{
    class MergeMetadata(Settings settings)
    {
        private readonly Settings _settings = settings;
        private List<MetadataOMOP> _metadata;

        public void Start()
        {
            _metadata = CreateMetadata();

            _metadata.Add(new MetadataOMOP { MetadataConceptId = 37116952, Name = "Source data citation", ValueAsString = GetCitation(), MetadataDate = DateTime.Now });
            _metadata.Add(new MetadataOMOP { MetadataConceptId = 4123211, Name = "Publication review requirements", ValueAsString = GetPublication(), MetadataDate = DateTime.Now });

            for (int i = 0; i < _metadata.Count; i++)
            {
                _metadata[i].Id = i;
            }
        }

        private string GetCitation()
        {
            var value = string.Empty;
            switch (_settings.Vendor)
            {
                case Vendors.None:
                    break;
                case Vendors.Truven_CCAE:
                case Vendors.Truven_MDCR:
                case Vendors.Truven_MDCD:
                    value = "Follow the proper use of trademarks as detailed by IBM. The document with the information on how to do so can be found on the rwe catalog.";
                    break;
                case Vendors.CprdV5:
                case Vendors.CprdCovid:
                    value = "Cite Data Resource Profile: Clinical Practice Research Datalink (CPRD) DOI: 10.1093/ije/dyv098";
                    break;
                case Vendors.PremierV5:
                    break;
                case Vendors.PremierFull:
                    break;
                case Vendors.PremierCovid:
                    break;
                case Vendors.JMDCv5:
                    break;
                case Vendors.OptumExtendedSES:
                    break;
                case Vendors.OptumExtendedDOD:
                    break;
                case Vendors.OptumOncology:
                    break;
                case Vendors.OptumPantherFull:
                    break;
                case Vendors.OptumPantherCovid:
                    break;
                case Vendors.CprdHES:
                    break;
                case Vendors.Era:
                    break;
                case Vendors.PregnancyAlgorithm:
                    break;
                case Vendors.HealthVerity:
                    break;
                default:
                    break;
            }
            return value;
        }

        private string GetPublication()
        {
            var value = "No review required";
            switch (_settings.Vendor)
            {
                case Vendors.None:
                    break;
                case Vendors.Truven_CCAE:
                case Vendors.Truven_MDCR:
                case Vendors.Truven_MDCD:
                    value = "No review requirements.";
                    break;
                case Vendors.CprdV5:
                case Vendors.CprdCovid:
                    value = "Must have ISAC approval to conduct study. https://www.cprd.com/research-applications";
                    break;
                case Vendors.PremierV5:
                    break;
                case Vendors.PremierFull:
                    break;
                case Vendors.PremierCovid:
                    break;
                case Vendors.JMDCv5:
                    value = @"When sending a manuscript for publication, the external data disclosure form must be filled out and sent to JMDC for approval. It can be found on the rwe catalog under ""Contracts and Licenses"". https://catalog.rwe.jnj.com/index#jnjexplore?dataSetUri=%2Fdataset%2F06d7e4d1-6000-4779-bdc9-16ace880912a.xml";
                    break;
                case Vendors.OptumExtendedSES:
                case Vendors.OptumExtendedDOD:
                case Vendors.OptumOncology:
                case Vendors.OptumPantherFull:
                case Vendors.OptumPantherCovid:
                    value = "Any manuscripts submitted for review must be reviewed by Optum prior to publication. Please send to Kuklinski, Alyce M <alyce.kuklinski@optum.com> and Bree Tremain <bree.tremain@optum.com> allowing for a five day turn-around. ";
                    break;
                case Vendors.CprdHES:
                    break;
                case Vendors.Era:
                    break;
                case Vendors.PregnancyAlgorithm:
                    break;
                case Vendors.HealthVerity:
                    break;
                default:
                    break;
            }
            return value;
        }

        public MemoryStream GetMetadataCsvStream()
        {
            var cdm = _settings.Vendor.GetAttribute<CdmVersionAttribute>().Value;

            if (cdm == framework.common.Enums.CdmVersions.V54)
            {
                var reader = new MetadataOMOPDataReader54(_metadata);
                return reader.GetStreamCsv();
            }
            else
            {
                var reader = new MetadataOMOPDataReader(_metadata);
                return reader.GetStreamCsv();
            }
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
            using (var csv = new CsvReader(reader, _settings.CsvConfiguration))
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
