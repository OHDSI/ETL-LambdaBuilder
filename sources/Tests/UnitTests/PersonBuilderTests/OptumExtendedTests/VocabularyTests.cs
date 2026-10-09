namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class VocabularyTests
{
    [Fact]
    public void Lookup_OptumExtended_Vocabulary_S001_IsPopulatedWithSourceMappings()
    {
        var vocabulary = new OptumExtendedTestVocabulary();

        Assert.True(vocabulary.MappingCount >= 45);
        Assert.NotEmpty(vocabulary.Lookup("7061", "ConditionICD9", new DateTime(2013, 7, 1)));
        Assert.NotEmpty(vocabulary.Lookup("55111067101", "DrugRx", new DateTime(2013, 7, 1)));
        Assert.NotEmpty(vocabulary.Lookup("92928", "ProcedureICD9", new DateTime(2013, 7, 1)));
        Assert.NotEmpty(vocabulary.Lookup("22962-5", "Lab", new DateTime(2013, 7, 1)));
    }

    [Theory]
    [InlineData("ConditionICD9", "7061", 141095, "Condition")]
    [InlineData("DrugRx", "55111067101", 1322189, "Drug")]
    [InlineData("ProcedureICD9", "K0901", 45890555, "Device")]
    [InlineData("ProcedureICD9", "87517", 2213127, "Measurement")]
    [InlineData("ProcedureICD9", "A0170", 46221652, "Observation")]
    [InlineData("Lab", "22962-5", 3012939, "Measurement")]
    public void Lookup_OptumExtended_Vocabulary_S002_MapsConceptAndDomain(
        string lookup,
        string sourceCode,
        long expectedConcept,
        string expectedDomain)
    {
        var mapping = Assert.Single(
            new OptumExtendedTestVocabulary().Lookup(sourceCode, lookup, new DateTime(2013, 7, 1)));

        Assert.Equal(expectedConcept, mapping.ConceptId);
        Assert.Equal(expectedDomain, mapping.Domain);
        Assert.Equal(sourceCode, mapping.SourceCode);
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_S003_UsesMappingAddedToDictionary()
    {
        const long personId = 1703;
        var source = new OptumExtendedInMemoryScenario();
        source.Vocabulary.WithMapping(
            "ConditionICD9",
            "UT1703",
            7651703,
            "Condition",
            sourceConceptId: 7651704,
            vocabularyId: "ICD9CM");
        source.AddStandardPerson(personId);
        source.AddMedicalClaim(personId, "C1703", "2013-07-01", locationCode: "2");
        source.AddDiagnosis(personId, "C1703", "UT1703", locationCode: "2");

        var condition = Assert.Single(source.Build(personId).Data.ConditionOccurrences);

        Assert.Equal(7651703, condition.ConceptId);
        Assert.Equal(7651704, condition.SourceConceptId);
        Assert.Equal("Condition", condition.Domain);
        Assert.NotNull(condition.VisitOccurrenceId);
        Assert.NotNull(condition.VisitDetailId);
    }

    [Fact]
    public void Lookup_OptumExtended_Vocabulary_S004_DoesNotInventUnknownMapping()
    {
        var vocabulary = new OptumExtendedTestVocabulary();

        Assert.Empty(vocabulary.Lookup("UNKNOWN", "ConditionICD9", DateTime.MinValue));
        Assert.Empty(vocabulary.Lookup("7061", "UNKNOWN", DateTime.MinValue));
    }
}
