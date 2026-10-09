namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ObservationTests
{
    [Fact]
    public void Build_OptumExtended_Observation_R1301_RoutesLoincCodesToObservations()
    {
        var source = Person(1301);
        source.AddLabResult(1301, "L1301A", "2013-07-01", loinc: "76345-8");
        source.AddLabResult(1301, "L1301B", "2013-07-02", loinc: "75415-0");

        var observations = source.Build(1301).Data.Observations;

        Assert.Contains(observations, item => item.SourceValue == "76345-8");
        Assert.Contains(observations, item => item.SourceValue == "75415-0");
    }

    [Theory]
    [InlineData(1302, "21", 9201)]
    [InlineData(1303, "11", 9202)]
    public void Build_OptumExtended_Observation_R1302_R1303_RoutesDiagnosisDomainToObservation(
        long personId,
        string positionOfService,
        long expectedVisitConcept)
    {
        var source = Person(personId);
        var claimId = $"C{personId}";
        source.AddMedicalClaim(personId, claimId, "2013-07-01", positionOfService: positionOfService, locationCode: "2");
        source.AddDiagnosis(personId, claimId, "E001", locationCode: "2");

        var result = source.Build(personId);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == expectedVisitConcept);
        Assert.Contains(result.Data.Observations, item => item.SourceValue == "E001");
        Assert.DoesNotContain(result.Data.ConditionOccurrences, item => item.SourceValue == "E001");
    }

    [Fact]
    public void Build_OptumExtended_Observation_R1304_RoutesMedicalProcedureCodeToObservation()
    {
        var source = Person(1304);
        source.AddMedicalClaim(1304, "C1304", "2013-07-01", positionOfService: "21", procedureCode: "A0170", locationCode: "2");

        var result = source.Build(1304);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == 9201);
        Assert.Contains(result.Data.Observations, item => item.SourceValue == "A0170");
    }

    [Fact]
    public void Build_OptumExtended_Observation_R1305_RoutesInpatientProcedureCodeToObservation()
    {
        var source = Person(1305);
        source.AddInpatientConfinement(1305, "CONF1305", "2013-08-11", "2013-08-22", diagnosis1: "250.00", procedure2: "A0170");

        var result = source.Build(1305);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == 9201);
        Assert.Contains(result.Data.Observations, item => item.SourceValue == "A0170");
    }

    private static OptumExtendedInMemoryScenario Person(long personId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2014-10-31", yearOfBirth: 1980);
        return source;
    }
}
