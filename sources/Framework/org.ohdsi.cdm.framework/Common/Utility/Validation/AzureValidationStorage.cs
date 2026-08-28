using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public sealed class AzureValidationStorage : IValidationStorage
    {
        private readonly BlobContainerClient _containerClient;

        public AzureValidationStorage(
            string tenantId,
            string clientId,
            string clientSecret,
            string serviceId,
            string blobContainerName)
        {
            EnsureNotEmpty(tenantId, nameof(tenantId));
            EnsureNotEmpty(clientId, nameof(clientId));
            EnsureNotEmpty(clientSecret, nameof(clientSecret));
            EnsureNotEmpty(serviceId, nameof(serviceId));
            EnsureNotEmpty(blobContainerName, nameof(blobContainerName));

            var credential = new ClientSecretCredential(
                tenantId,
                clientId,
                clientSecret);

            var serviceUri = BuildServiceUri(serviceId);
            var serviceClient = new BlobServiceClient(serviceUri, credential);

            _containerClient = serviceClient.GetBlobContainerClient(blobContainerName);
        }

        public string ProviderName => "Azure Blob Storage";

        public IReadOnlyList<ValidationStorageObject> ListObjects(
            string prefix,
            CancellationToken cancellationToken = default)
        {
            EnsureNotEmpty(prefix, nameof(prefix));

            return _containerClient
                .GetBlobs(
                    new GetBlobsOptions { Prefix = prefix },
                    cancellationToken)
                .Select(s => new ValidationStorageObject(s.Name))
                .ToList();
        }

        public Stream OpenRead(
            string objectKey,
            CancellationToken cancellationToken = default)
        {
            EnsureNotEmpty(objectKey, nameof(objectKey));

            return _containerClient
                .GetBlobClient(objectKey)
                .OpenRead(
                    new BlobOpenReadOptions(allowModifications: false),
                    cancellationToken);
        }

        public void Dispose()
        {

        }

        private static Uri BuildServiceUri(string serviceId)
        {
            if (Uri.TryCreate(serviceId, UriKind.Absolute, out var serviceUri))
                return serviceUri;

            return new Uri($"https://{serviceId}.blob.core.windows.net");
        }

        private static void EnsureNotEmpty(string value, string parameterName)
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Value cannot be null or empty.", parameterName);
        }
    }
}
