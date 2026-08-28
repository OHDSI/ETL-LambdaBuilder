using System.IO.Compression;
using System.Text;
using ZstdSharp;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public sealed class PersonFile
    {
        private readonly IValidationStorage _storage;

        public PersonFile(
            ValidationStorageObject storageObject,
            IValidationStorage storage)
        {
            StorageObject = storageObject
                ?? throw new ArgumentNullException(nameof(storageObject));
            _storage = storage
                ?? throw new ArgumentNullException(nameof(storage));

            ObjectKind = DetectObjectKind();

            var parts = StorageObject.Key.Split('/').Last().Split('.');
            ChunkId = int.Parse(parts[2]);
            SliceId = int.Parse(parts[1]);
        }

        public ValidationStorageObject StorageObject { get; }
        public string ObjectKey => StorageObject.Key;
        public string ObjectKind { get; }

        public int ChunkId { get; }
        public int SliceId { get; }

        public IEnumerable<Person> ReadPersonIds(CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using var responseStream = _storage.OpenRead(ObjectKey, cancellationToken);
            using var bufferedStream = new BufferedStream(responseStream);
            using Stream compressedStream = ObjectKey.EndsWith(".gz", StringComparison.OrdinalIgnoreCase)
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

                    var person = new Person(ChunkId, personId, null, null);
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

                    var person = new Person(ChunkId, personId, null, attritionReason);
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

        public Person? CheckPersonFileForPersonId(long personIdToFind, CancellationToken cancellationToken = default)
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
            if (ObjectKey.Contains("/PERSON/") || ObjectKey.Contains("PERSON."))
            {
                return "PERSON";
            }

            if (ObjectKey.Contains("/METADATA_TMP/") || ObjectKey.Contains("METADATA_TMP."))
            {
                return "METADATA_TMP";
            }

            throw new NotImplementedException("Unsupported object key: " + ObjectKey);
        }
    }
}
