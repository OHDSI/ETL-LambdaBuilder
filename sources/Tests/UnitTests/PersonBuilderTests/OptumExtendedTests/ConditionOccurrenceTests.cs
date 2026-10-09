namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ConditionOccurrenceTests
{
    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R701_MapsPrimaryDiagnosisAndPoaStatus()
    {
        var source = Scenario(701, "C701");
        source.AddDiagnosis(701, "C701", "7061", diagnosisPosition: "01", presentOnAdmission: "Y", locationCode: "2");

        var condition = Assert.Single(source.Build(701).Data.ConditionOccurrences);

        Assert.Equal(141095, condition.ConceptId);
        Assert.Equal(32810, condition.TypeConceptId);
        Assert.Equal(32901, condition.StatusConceptId);
        Assert.NotNull(condition.VisitOccurrenceId);
        Assert.NotNull(condition.VisitDetailId);
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R702_MapsDiagnosisInFourthPosition()
    {
        var source = Scenario(702, "C702");
        source.AddDiagnosis(702, "C702", "7061", diagnosisPosition: "04", locationCode: "2");

        Assert.Equal(141095, Assert.Single(source.Build(702).Data.ConditionOccurrences).ConceptId);
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R703_KeepsValidAndUnmappedDiagnosisCodes()
    {
        var source = Scenario(703, "C703");
        source.AddDiagnosis(703, "C703", "7061", diagnosisPosition: "01", locationCode: "2");
        source.AddDiagnosis(703, "C703", "99999", diagnosisPosition: "02", locationCode: "2");

        var conditions = source.Build(703).Data.ConditionOccurrences;

        Assert.Contains(conditions, item => item.ConceptId == 141095);
        Assert.Contains(conditions, item => item.ConceptId == 0 && item.SourceValue == "99999");
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R704_KeepsThreeRepeatedInpatientDiagnoses()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(704, "2010-05-01", "2013-10-31");
        for (var sequence = 1; sequence <= 3; sequence++)
        {
            source.AddMedicalClaim(704, "C704", "2013-07-01", positionOfService: "21", claimSequence: sequence.ToString("000"), locationCode: "2");
            source.AddDiagnosis(704, "C704", "7061", diagnosisPosition: "01", locationCode: "2");
        }

        var conditions = source.Build(704).Data.ConditionOccurrences;

        Assert.Equal(3, conditions.Count);
        Assert.All(conditions, item => Assert.Equal(141095, item.ConceptId));
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R705_CreatesTwoConditionsForMultiMappedIcd9Code()
    {
        var source = Scenario(705, "C705");
        source.AddDiagnosis(705, "C705", "24910", diagnosisPosition: "01", locationCode: "2");

        var concepts = source.Build(705).Data.ConditionOccurrences.Select(item => item.ConceptId).Order().ToArray();

        Assert.Equal(new long[] { 195771, 443727 }, concepts);
    }

    [Fact]
    public void Build_OptumExtended_ConditionOccurrence_R706_MapsIcd10CmWithoutInternationalSourceConcept()
    {
        var source = Scenario(706, "C706");
        source.AddDiagnosis(706, "C706", "A921", icdFlag: "10", diagnosisPosition: "01", locationCode: "2");

        var condition = Assert.Single(source.Build(706).Data.ConditionOccurrences);

        Assert.Equal(4310683, condition.ConceptId);
        Assert.Equal("A921", condition.SourceValue);
        Assert.NotEqual(45542543, condition.SourceConceptId);
    }

    [Theory]
    [InlineData(707, "Y", "Y;01", 32901)]
    [InlineData(708, "N", "N;01", 32902)]
    [InlineData(709, "U", "U;01", 32902)]
    [InlineData(710, "W", "W;01", 32902)]
    public void Build_OptumExtended_ConditionOccurrence_R707_R710_MapsPresentOnAdmission(
        long personId,
        string poa,
        string expectedSource,
        long expectedConcept)
    {
        var claimId = $"C{personId}";
        var source = Scenario(personId, claimId);
        source.AddDiagnosis(personId, claimId, "A921", icdFlag: "10", diagnosisPosition: "01", presentOnAdmission: poa, locationCode: "2");

        var condition = Assert.Single(source.Build(personId).Data.ConditionOccurrences);

        Assert.Equal(expectedSource, condition.StatusSourceValue);
        Assert.Equal(expectedConcept, condition.StatusConceptId);
    }

    private static OptumExtendedInMemoryScenario Scenario(long personId, string claimId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2013-10-31");
        source.AddMedicalClaim(personId, claimId, "2013-07-01", locationCode: "2");
        return source;
    }
}
