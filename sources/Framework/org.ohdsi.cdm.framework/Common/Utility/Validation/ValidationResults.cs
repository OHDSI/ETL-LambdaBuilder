namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public enum ValidationIssueType
    {
        ChunkFileMissing,
        ChunkFileEmpty,
        SliceObjectsMissing,
        UnexpectedPersonIdInRawFile,
        PersonWithoutSliceId,
        DuplicatedPersonId,
        MissingPersonId,
        ObjectReadFailed,
        UnsupportedObjectKey,
        ParseFailed,
        Exception
    }

    public sealed record ValidationIssue(
        ValidationIssueType Type,
        int BuildingId,
        int? ChunkId,
        int? SliceId,
        long? PersonId,
        string Message);

    public enum PersonValidationProblemType
    {
        WithoutSliceId,
        Duplicated,
        Missing
    }

    public sealed record PersonValidationProblem(
        long PersonId,
        int? SliceId,
        int InPersonFilesCount,
        int InMetadataFilesCount,
        PersonValidationProblemType Type);

    public sealed record PersonValidationCounts(
        int Total,
        int Correct,
        int WithoutSliceId,
        int Duplicated,
        int Missing)
    {
        public bool IsValid => WithoutSliceId == 0 && Duplicated == 0 && Missing == 0;
    }

    public sealed record SliceValidationResult(
        string VendorName,
        int BuildingId,
        int ChunkId,
        int SliceId,
        int PersonObjectCount,
        int MetadataObjectCount,
        int PersonRowsRead,
        int MetadataRowsRead,
        int UnexpectedPersonIdsCount,
        IReadOnlyList<ValidationIssue> Issues,
        TimeSpan Elapsed)
    {
        public bool IsValid => Issues.Count == 0;
    }

    public sealed record ChunkValidationResult(
        string VendorName,
        int BuildingId,
        int ChunkId,
        int PersonsInChunkFile,
        int SlicesChecked,
        PersonValidationCounts Counts,
        IReadOnlyList<SliceValidationResult> SliceResults,
        IReadOnlyList<PersonValidationProblem> PersonProblems,
        IReadOnlyList<ValidationIssue> Issues,
        TimeSpan Elapsed)
    {
        public bool IsValid => Counts.IsValid && Issues.Count == 0 && SliceResults.All(s => s.IsValid);
    }

    public sealed record BuildingValidationResult(
        string VendorName,
        int BuildingId,
        int TotalChunkFilesFound,
        int ChunkFilesValidated,
        int ChunkFilesSkipped,
        int ActualSlicesCount,
        IReadOnlyList<ChunkValidationResult> ChunkResults,
        IReadOnlyList<ValidationIssue> Issues,
        TimeSpan Elapsed)
    {
        public int ChunksWithErrors => ChunkResults.Count(c => !c.IsValid);

        public int TotalPersons => ChunkResults.Sum(c => c.PersonsInChunkFile);

        public bool IsValid => Issues.Count == 0 && ChunkResults.All(c => c.IsValid);
    }

    public sealed record PersonIdValidationResult(
        string VendorName,
        int BuildingId,
        int ChunkId,
        long PersonId,
        bool Found,
        int? SliceId,
        IReadOnlyList<ValidationIssue> Issues,
        TimeSpan Elapsed)
    {
        public bool IsValid => Found && Issues.Count == 0;
    }

    internal sealed record SliceObjects(
        int SliceId,
        IReadOnlyList<Amazon.S3.Model.S3Object> PersonObjects,
        IReadOnlyList<Amazon.S3.Model.S3Object> MetadataObjects);

    internal sealed class PersonSliceCounters
    {
        public int InPersonFilesCount { get; set; }

        public int InMetadataFilesCount { get; set; }
    }
}