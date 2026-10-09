namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ConditionEraTests
{
    [Fact]
    public void Build_OptumExtended_ConditionEra_R801_CollapsesMappedConditionsAndExcludesConceptZero()
    {
        const long personId = 801;
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2013-10-31");
        AddClaimAndDiagnosis(source, personId, "C801A", "2013-07-01", "7061");
        AddClaimAndDiagnosis(source, personId, "C801B", "2013-07-25", "7061");
        AddClaimAndDiagnosis(source, personId, "C801C", "2013-07-25", "7872");
        AddClaimAndDiagnosis(source, personId, "C801D", "2013-07-25", "V1582");

        var eras = source.Build(personId).Data.ConditionEra;

        var allergicRhinitis = Assert.Single(eras, item => item.ConceptId == 141095);
        Assert.Equal(2, allergicRhinitis.OccurrenceCount);
        var dysphagia = Assert.Single(eras, item => item.ConceptId == 31317);
        Assert.Equal(1, dysphagia.OccurrenceCount);
        Assert.DoesNotContain(eras, item => item.ConceptId == 0);
    }

    private static void AddClaimAndDiagnosis(
        OptumExtendedInMemoryScenario source,
        long personId,
        string claimId,
        string date,
        string diagnosis)
    {
        source.AddMedicalClaim(personId, claimId, date, locationCode: "2");
        source.AddDiagnosis(personId, claimId, diagnosis, date, locationCode: "2");
    }
}
