using Amazon.S3.Model;
using Amazon.S3.Transfer;
using System.IO.Compression;
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


        public IEnumerable<PersonValidationInfo> ReadPersonIds(CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            using var responseStream = transferUtility.OpenStream(_bucket, S3Object.Key);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = S3Object.Key.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream);
            using var reader = new StreamReader(compressedStream, Encoding.Default);
            using var csv = org.ohdsi.cdm.framework.common.Helpers.CsvHelper.CreateCsvReader(reader);

            if (ObjectKind == "PERSON")
            {
                while (csv.Read())
                {
                    cancellationToken.ThrowIfCancellationRequested();

                    var personId = (long)csv.GetField(typeof(long), 0);

                    var person = new PersonValidationInfo(ChunkId, personId, null, null);
                    person.SliceId = SliceId;
                    person.InPersonFilesCount++;

                    yield return person;
                }
            }
            else if (ObjectKind == "METADATA_TMP")
            {
                while (csv.Read())
                {
                    cancellationToken.ThrowIfCancellationRequested();

                    var personId = (long)csv.GetField(typeof(long), 0);
                    var attritionReason = csv.GetField(typeof(string), 1) as string;

                    var person = new PersonValidationInfo(ChunkId, personId, null, attritionReason);
                    person.SliceId = SliceId;
                    if (person.AttritionReason != "Discarded drug count")
                        person.InMetadataFilesCount++;

                    yield return person;
                }
            }
            else
            {
                throw new NotSupportedException("Unsupported object kind: " + ObjectKind);
            }
        }

        public PersonValidationInfo? CheckPersonFileForPersonId(long personIdToFind, CancellationToken cancellationToken = default)
        {
            foreach (var person in ReadPersonIds(cancellationToken))
            {
                cancellationToken.ThrowIfCancellationRequested();

                if (person.PersonId == personIdToFind)
                    return person;
            }

            return null;
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
