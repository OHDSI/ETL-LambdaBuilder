using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public sealed class AwsValidationStorage : IValidationStorage
    {
        private readonly string _bucket;
        private readonly AmazonS3Client _client;
        private readonly TransferUtility _transferUtility;
        private bool _disposed;

        public AwsValidationStorage(
            string awsAccessKeyId,
            string awsSecretAccessKey,
            string bucket)
        {
            EnsureNotEmpty(awsAccessKeyId, nameof(awsAccessKeyId));
            EnsureNotEmpty(awsSecretAccessKey, nameof(awsSecretAccessKey));
            EnsureNotEmpty(bucket, nameof(bucket));

            _bucket = bucket;
            _client = new AmazonS3Client(
                awsAccessKeyId,
                awsSecretAccessKey,
                RegionEndpoint.USEast1);
            _transferUtility = new TransferUtility(_client);
        }

        public string ProviderName => "AWS S3";

        public IReadOnlyList<ValidationStorageObject> ListObjects(
            string prefix,
            CancellationToken cancellationToken = default)
        {
            ThrowIfDisposed();
            EnsureNotEmpty(prefix, nameof(prefix));

            var result = new List<ValidationStorageObject>();
            var request = new ListObjectsV2Request
            {
                BucketName = _bucket,
                Prefix = prefix
            };

            ListObjectsV2Response response;

            do
            {
                cancellationToken.ThrowIfCancellationRequested();

                response = _client
                    .ListObjectsV2Async(request, cancellationToken)
                    .GetAwaiter()
                    .GetResult();

                result.AddRange(
                    (response?.S3Objects ?? new List<S3Object>())
                    .Select(s => new ValidationStorageObject(s.Key)));

                request.ContinuationToken = response?.NextContinuationToken;
            }
            while (response?.IsTruncated ?? false);

            return result;
        }

        public Stream OpenRead(
            string objectKey,
            CancellationToken cancellationToken = default)
        {
            ThrowIfDisposed();
            EnsureNotEmpty(objectKey, nameof(objectKey));
            cancellationToken.ThrowIfCancellationRequested();

            return _transferUtility.OpenStream(_bucket, objectKey);
        }

        public void Dispose()
        {
            if (_disposed)
                return;

            _transferUtility.Dispose();
            _client.Dispose();
            _disposed = true;
        }

        private void ThrowIfDisposed()
        {
            if (_disposed)
                throw new ObjectDisposedException(nameof(AwsValidationStorage));
        }

        private static void EnsureNotEmpty(string value, string parameterName)
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Value cannot be null or empty.", parameterName);
        }
    }
}
