using Amazon.S3.Model;
using Amazon.S3.Transfer;
using org.ohdsi.cdm.framework.common.Enums;
using System.IO.Compression;
using System.Net.Sockets;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public class PersonFile
    {
        public PersonFile(S3Object s3Object, string awsAccessKeyId, string awsSecretAccessKey, string bucket)
        {
            S3Object = s3Object ?? throw new ArgumentNullException("s3Object can't be null!");
            ObjectKind = DetectObjectKind() ?? throw new Exception("Failed to assign ObjectKind!");
            
            var parts = S3Object.Key.Split('/').Last().Split('.');
            ChunkId = int.Parse(parts[2]);
            SliceId = int.Parse(parts[1]);

            _awsAccessKeyId = awsAccessKeyId ?? throw new ArgumentNullException("awsAccessKeyId can't be null!");
            _awsSecretAccessKey = awsSecretAccessKey ?? throw new ArgumentNullException("awsSecretAccessKey can't be null!");
            _bucket = bucket ?? throw new ArgumentNullException("bucket can't be null!");
        }

        public S3Object S3Object { get; protected set; }
        public string ObjectKind { get; protected set; }

        public int ChunkId { get; protected set; }
        public int SliceId { get; protected set; }

        private string _awsAccessKeyId;
        private string _awsSecretAccessKey;
        private string _bucket;


        public IEnumerable<(long PersonId, string? AttritionReason)> ReadPersonIds()
        {
            using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            using var responseStream = transferUtility.OpenStream(_bucket, S3Object.Key);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = S3Object.Key.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream);
            using var reader = new StreamReader(compressedStream, Encoding.Default);
            using var csv = org.ohdsi.cdm.framework.common.Helpers.CsvHelper.CreateCsvReader(reader);

            while (csv.Read())
            {
                var personId = (long)csv.GetField(typeof(long), 0);
                
                var attritionReason = ObjectKind == "METADATA_TMP"
                    ? csv.GetField(typeof(string), 1) as string
                    : "";

                yield return (personId, attritionReason);
            }
        }

        private string DetectObjectKind()
        {
            var key = S3Object.Key;

            if (key.Contains("/PERSON/") || key.Contains("PERSON."))
            {
                return "PERSON";
            }

            if (key.Contains("/METADATA_TMP/") || key.Contains("METADATA_TMP."))
            {
                return "METADATA_TMP";
            }

            throw new NotImplementedException("Unsupported object key: " + key);
        }
    }
}
