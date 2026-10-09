namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R901_MapsRepeatedMedicalAndMedProcedureCodes()
    {
        var source = Person(901);
        for (var row = 1; row <= 2; row++)
        {
            source.AddMedicalClaim(901, "C901", "2013-07-01", procedureCode: "92928", claimSequence: row.ToString("000"), locationCode: "2");
            for (var position = 1; position <= 3; position++)
                source.AddProcedure(901, "C901", "70481", procedurePosition: position);
        }

        var procedures = source.Build(901).Data.ProcedureOccurrences;

        Assert.Contains(procedures, item => item.ConceptId == 2211331);
        Assert.Contains(procedures, item => item.ConceptId == 43527998);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R902_KeepsMappedAndUnmappedProcedureCodes()
    {
        var source = Person(902);
        source.AddMedicalClaim(902, "C902", "2013-07-01", procedureCode: "92928");
        for (var position = 1; position <= 3; position++)
            source.AddProcedure(902, "C902", "2", procedurePosition: position);

        var procedures = source.Build(902).Data.ProcedureOccurrences;

        Assert.Contains(procedures, item => item.ConceptId == 43527998);
        Assert.Contains(procedures, item => item.ConceptId == 0 && item.SourceValue == "2");
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R903_KeepsRepeatedInpatientProcedures()
    {
        var source = Person(903);
        for (var row = 0; row < 3; row++)
        {
            source.AddMedicalClaim(903, "C903", "2013-07-01", positionOfService: "21", procedureCode: "92928");
            source.AddProcedure(903, "C903", "70481");
        }

        var procedures = source.Build(903).Data.ProcedureOccurrences;

        Assert.Contains(procedures, item => item.ConceptId == 2211331);
        Assert.Contains(procedures, item => item.ConceptId == 43527998);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R904_UsesMedicalClaimStartDate()
    {
        var source = Person(904);
        source.AddMedicalClaim(904, "C904", "2013-07-01", procedureCode: "92928");
        source.AddMedicalClaim(904, "C904", "2013-07-31", end: "2013-07-01", procedureCode: "70481");

        var procedures = source.Build(904).Data.ProcedureOccurrences;

        Assert.Contains(procedures, item => item.ConceptId == 43527998 && item.StartDate == new DateTime(2013, 7, 1));
        Assert.Contains(procedures, item => item.ConceptId == 2211331 && item.StartDate == new DateTime(2013, 7, 31));
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R905_PreservesRealCodesAlongsidePlaceholders()
    {
        var source = Person(905);
        source.AddMedicalClaim(905, "C905", "2013-07-01", procedureCode: "92928");
        for (var i = 1; i <= 3; i++)
            source.AddProcedure(905, "C905", "0000000", procedurePosition: i);
        source.AddMedicalClaim(905, "C905", "2013-07-01", procedureCode: "70481");
        for (var i = 1; i <= 3; i++)
            source.AddProcedure(905, "C905", "0000000", procedurePosition: i);

        var procedures = source.Build(905).Data.ProcedureOccurrences;

        Assert.Contains(procedures, item => item.ConceptId == 43527998);
        Assert.Contains(procedures, item => item.ConceptId == 2211331);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R906_BuildsProcedureWithMultiMappedDiagnosis()
    {
        var source = Person(906);
        source.AddMedicalClaim(906, "C906", "2013-07-01", procedureCode: "70481", locationCode: "2");
        source.AddDiagnosis(906, "C906", "24910", locationCode: "2");

        var result = source.Build(906).Data;

        Assert.Equal(2, result.ConditionOccurrences.Count(item => item.SourceValue == "24910"));
        Assert.Contains(result.ProcedureOccurrences, item => item.ConceptId == 2211331);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R907_KeepsBothProceduresWhenOnlyOneClaimHasDiagnosis()
    {
        var source = Person(907);
        source.AddMedicalClaim(907, "C907", "2013-07-01", procedureCode: "92928", locationCode: "2");
        source.AddDiagnosis(907, "C907", "7061", locationCode: "2");
        source.AddMedicalClaim(907, "C907", "2013-07-01", procedureCode: "70481", locationCode: "2");

        var result = source.Build(907).Data;

        Assert.Contains(result.ConditionOccurrences, item => item.ConceptId == 141095);
        Assert.Contains(result.ProcedureOccurrences, item => item.ConceptId == 43527998);
        Assert.Contains(result.ProcedureOccurrences, item => item.ConceptId == 2211331);
    }

    [Theory]
    [InlineData(908, "21", 9201)]
    [InlineData(909, "11", 9202)]
    public void Build_OptumExtended_ProcedureOccurrence_R908_R909_RoutesDiagnosisDomainToProcedure(
        long personId,
        string positionOfService,
        long expectedVisitConcept)
    {
        var claimId = $"C{personId}";
        var source = Person(personId);
        source.AddMedicalClaim(personId, claimId, "2013-07-01", positionOfService: positionOfService, procedureCode: "92928", locationCode: "2");
        source.AddDiagnosis(personId, claimId, "V5789", locationCode: "2");

        var result = source.Build(personId);

        Assert.Contains(result.Data.ProcedureOccurrences, item => item.ConceptId == 4180248);
        Assert.DoesNotContain(result.Data.ConditionOccurrences, item => item.SourceValue == "V5789");
        Assert.Contains(result.SourceVisits, item => item.ConceptId == expectedVisitConcept);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R910_RoutesLabProcedureCodeToProcedure()
    {
        var source = Person(910);
        source.AddLabResult(910, "L910", loinc: null, procedureCode: "70481");

        Assert.Contains(source.Build(910).Data.ProcedureOccurrences, item => item.ConceptId == 2211331);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R911_LeavesMedProcedureEndDateNull()
    {
        var source = Person(911);
        source.AddMedicalClaim(911, "C911", "2013-07-01");
        source.AddProcedure(911, "C911", "V5789");

        Assert.Null(Assert.Single(source.Build(911).Data.ProcedureOccurrences).EndDate);
    }

    [Fact]
    public void Build_OptumExtended_ProcedureOccurrence_R912_SetsMedicalProcedureEndDate()
    {
        var source = Person(912);
        source.AddMedicalClaim(912, "C912", "2013-07-01", procedureCode: "92928");

        Assert.Equal(new DateTime(2013, 7, 1), Assert.Single(source.Build(912).Data.ProcedureOccurrences).EndDate);
    }

    private static OptumExtendedInMemoryScenario Person(long personId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2013-10-31");
        return source;
    }
}
