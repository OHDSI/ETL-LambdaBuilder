using Amazon.S3.Model;
using Amazon.S3.Transfer;
using System.IO.Compression;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public class ChunkFile
    {
        private static readonly char[] ChunkFileSeparators = new[] { ',', ' ', '\t' };

        public ChunkFile(S3Object s3Object, string awsAccessKeyId, string awsSecretAccessKey, string bucket)
        {
            S3Object = s3Object ?? throw new ArgumentNullException("s3Object can't be null!");

            ChunkId = int.Parse(new string(s3Object.Key.Split('/').Last().Where(a => Char.IsDigit(a)).ToArray()));

            _awsAccessKeyId = awsAccessKeyId ?? throw new ArgumentNullException("awsAccessKeyId can't be null!");
            _awsSecretAccessKey = awsSecretAccessKey ?? throw new ArgumentNullException("awsSecretAccessKey can't be null!");
            _bucket = bucket ?? throw new ArgumentNullException("bucket can't be null!");
        }

        public S3Object S3Object { get; protected set; }

        public int ChunkId { get; protected set; }

        private string _awsAccessKeyId;
        private string _awsSecretAccessKey;
        private string _bucket;


        public IEnumerable<PersonValidationInfo> ReadChunkFile(CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using var transferUtility = new TransferUtility(_awsAccessKeyId, _awsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            using var responseStream = transferUtility.OpenStream(_bucket, S3Object.Key);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = S3Object.Key.EndsWith(".gz")
                ? new GZipStream(bufferedStream, CompressionMode.Decompress)
                : new DecompressionStream(bufferedStream);
            using var reader = new StreamReader(compressedStream, Encoding.Default);

            var line = reader.ReadLine();

            while (!string.IsNullOrEmpty(line))
            {
                cancellationToken.ThrowIfCancellationRequested();

                var splits = line.Split(ChunkFileSeparators, StringSplitOptions.RemoveEmptyEntries);

                var person = splits.Length switch
                {
                    3 => new PersonValidationInfo(
                        ChunkId: int.Parse(splits[0]),
                        PersonId: long.Parse(splits[1]),
                        PersonSourceValue: splits[2]),

                    4 => new PersonValidationInfo(
                        ChunkId: int.Parse(splits[0]),
                        //PartitionId: int.Parse(splits[1]),
                        PersonId: long.Parse(splits[2]),
                        PersonSourceValue: splits[3]),

                    _ => throw new FormatException($"Invalid _chunks line format. Key={S3Object.Key}, Line={line}")
                };

                yield return person;
                cancellationToken.ThrowIfCancellationRequested();
                line = reader.ReadLine();
            }
        }

        public PersonValidationInfo? CheckChunkFileForPersonId(long personId, CancellationToken cancellationToken = default)
        {
            foreach (var person in ReadChunkFile(cancellationToken))
            {
                cancellationToken.ThrowIfCancellationRequested();

                if (person.PersonId == personId)
                    return person;
            }

            return null;
        }
    }
}
