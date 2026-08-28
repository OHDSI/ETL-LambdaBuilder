using System.IO.Compression;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public sealed class ChunkFile
    {
        private static readonly char[] ChunkFileSeparators = new[] { ',', ' ', '\t' };
        private readonly IValidationStorage _storage;

        public ChunkFile(
            ValidationStorageObject storageObject,
            IValidationStorage storage)
        {
            StorageObject = storageObject
                ?? throw new ArgumentNullException(nameof(storageObject));
            _storage = storage
                ?? throw new ArgumentNullException(nameof(storage));

            ChunkId = int.Parse(new string(
                StorageObject.Key
                    .Split('/')
                    .Last()
                    .Where(char.IsDigit)
                    .ToArray()));
        }

        public ValidationStorageObject StorageObject { get; }
        public string ObjectKey => StorageObject.Key;

        public int ChunkId { get; }

        public IEnumerable<Person> ReadChunkFile(CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using var responseStream = _storage.OpenRead(ObjectKey, cancellationToken);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = ObjectKey.EndsWith(".gz", StringComparison.OrdinalIgnoreCase)
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
                    3 => new Person(
                        ChunkId: int.Parse(splits[0]),
                        PersonId: long.Parse(splits[1]),
                        PersonSourceValue: splits[2]),

                    4 => new Person(
                        ChunkId: int.Parse(splits[0]),
                        //PartitionId: int.Parse(splits[1]),
                        PersonId: long.Parse(splits[2]),
                        PersonSourceValue: splits[3]),

                    _ => throw new FormatException($"Invalid _chunks line format. Key={ObjectKey}, Line={line}")
                };

                yield return person;
                cancellationToken.ThrowIfCancellationRequested();
                line = reader.ReadLine();
            }
        }

        public Person? CheckChunkFileForPersonId(long personId, CancellationToken cancellationToken = default)
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
