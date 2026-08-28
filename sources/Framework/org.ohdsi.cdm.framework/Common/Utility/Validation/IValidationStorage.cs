namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public interface IValidationStorage : IDisposable
    {
        string ProviderName { get; }

        IReadOnlyList<ValidationStorageObject> ListObjects(
            string prefix,
            CancellationToken cancellationToken = default);

        Stream OpenRead(
            string objectKey,
            CancellationToken cancellationToken = default);
    }

    public sealed record ValidationStorageObject(string Key);
}
