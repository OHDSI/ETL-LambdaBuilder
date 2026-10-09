namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class VisitOccurrenceTests
{
    [Fact]
    public void Build_OptumExtended_VisitOccurrence_R1401_CollapsesSameDayInpatientClaimsAcrossPlans()
    {
        var source = Person(1401, end: "2013-10-31");
        source.AddMedicalClaim(1401, "C1401", "2013-07-01", positionOfService: "21", planId: "1401");
        source.AddDiagnosis(1401, "C1401", "7061", planId: "1401");
        source.AddMedicalClaim(1401, "C1401", "2013-07-01", positionOfService: "21", planId: "1401000");
        source.AddDiagnosis(1401, "C1401", "7061", planId: "1401000");

        var result = source.Build(1401);

        Assert.Single(result.SourceVisits, visit => visit.ConceptId == 9201);
        Assert.Equal(2, result.SourceVisitDetails.Count(detail => detail.ConceptId == 8717));
    }

    [Fact]
    public void Build_OptumExtended_VisitOccurrence_R1402_BuildsInpatientVisitAndDetailDates()
    {
        var source = Person(1402);
        source.AddMedicalClaim(1402, "C1402", "2014-03-01", "2014-03-13", positionOfService: "21");
        source.AddDiagnosis(1402, "C1402", "7061", start: "2014-03-01");

        var result = source.Build(1402);
        var visit = Assert.Single(result.SourceVisits);
        var detail = Assert.Single(result.SourceVisitDetails);

        Assert.Equal(9201, visit.ConceptId);
        Assert.Equal((new DateTime(2014, 3, 1), new DateTime(2014, 3, 13)), (visit.StartDate, visit.EndDate!.Value));
        Assert.Equal(8717, detail.ConceptId);
        Assert.Equal((new DateTime(2014, 3, 1), new DateTime(2014, 3, 13)), (detail.StartDate, detail.EndDate!.Value));
    }

    [Theory]
    [InlineData(1403, "11", 9202, 581477, "2013-08-01", "2013-08-01")]
    [InlineData(1404, "23", 9203, 8870, "2013-09-01", "2013-09-01")]
    [InlineData(1405, "13", 42898160, 8615, "2013-10-01", "2013-10-30")]
    [InlineData(1406, "22", 9202, 8756, "2009-07-01", "2009-07-01")]
    public void Build_OptumExtended_VisitOccurrence_R1403_R1406_MapsPlaceOfService(
        long personId,
        string positionOfService,
        long visitConcept,
        long detailConcept,
        string start,
        string end)
    {
        var source = Person(personId, end: personId == 1405 ? "2015-10-31" : "2013-10-31");
        var claimId = $"C{personId}";
        source.AddMedicalClaim(personId, claimId, start, end, positionOfService: positionOfService);
        source.AddDiagnosis(personId, claimId, "7061", start: start);

        var result = source.Build(personId);

        var visit = Assert.Single(result.SourceVisits);
        Assert.Equal(visitConcept, visit.ConceptId);
        Assert.Equal(DateTime.Parse(start), visit.StartDate);
        var detail = Assert.Single(result.SourceVisitDetails);
        Assert.Equal(detailConcept, detail.ConceptId);
    }

    [Fact]
    public void Build_OptumExtended_VisitOccurrence_R1407_LinksConsecutiveVisitsAndDetails()
    {
        var source = Person(1407, end: "2013-10-31");
        source.AddMedicalClaim(1407, "C1407", "2012-11-01", positionOfService: "11");
        source.AddDiagnosis(1407, "C1407", "7061", start: "2012-11-01");
        source.AddMedicalClaim(1407, "C1407", "2012-11-02", positionOfService: "11");
        source.AddDiagnosis(1407, "C1407", "7061", start: "2012-11-02");

        var result = source.Build(1407);
        var visits = result.SourceVisits.OrderBy(item => item.StartDate).ToArray();
        var details = result.SourceVisitDetails.OrderBy(item => item.StartDate).ToArray();

        Assert.Equal(2, visits.Length);
        Assert.Equal(visits[0].Id, visits[1].PrecedingVisitOccurrenceId);
        Assert.Equal(2, details.Length);
        Assert.Equal(details[0].Id, details[1].PrecedingVisitDetailId);
    }

    [Fact]
    public void Build_OptumExtended_VisitOccurrence_R1408_RollsMedicalClaimIntoInpatientConfinement()
    {
        var source = Person(1408, end: "2015-10-31", yearOfBirth: 1959);
        source.AddMedicalClaim(1408, "C1408", "2013-08-21", positionOfService: "21", confinementId: "123");
        source.AddInpatientConfinement(1408, "123", "2013-08-11", "2013-08-22", diagnosis1: "250.00");
        source.AddInpatientConfinement(1408, "234", "2015-02-11", "2015-02-15", diagnosis1: "250.00");

        var result = source.Build(1408);

        Assert.Contains(result.SourceVisitDetails, item => item.StartDate == new DateTime(2013, 8, 21) && item.EndDate == new DateTime(2013, 8, 21));
        Assert.Contains(result.SourceVisitDetails, item => item.StartDate == new DateTime(2013, 8, 11) && item.EndDate == new DateTime(2013, 8, 22));
        Assert.Contains(result.SourceVisitDetails, item => item.StartDate == new DateTime(2015, 2, 11) && item.EndDate == new DateTime(2015, 2, 15));
        Assert.Contains(result.SourceVisits, item => item.StartDate == new DateTime(2013, 8, 11) && item.EndDate == new DateTime(2013, 8, 22));
        Assert.Contains(result.SourceVisits, item => item.StartDate == new DateTime(2015, 2, 11) && item.EndDate == new DateTime(2015, 2, 15));
    }

    [Fact]
    public void Build_OptumExtended_VisitOccurrence_R1409_MergesEmergencyRoomOnFirstInpatientDay()
    {
        var source = Person(1409, end: "2013-10-31", yearOfBirth: 1980);
        source.AddMedicalClaim(1409, "C1409", "2013-09-01", positionOfService: "23", confinementId: "987");
        source.AddInpatientConfinement(1409, "987", "2013-09-01", "2013-09-22", diagnosis1: "250.00");
        source.AddDiagnosis(1409, "C1409", "7061", start: "2013-09-01");

        var result = source.Build(1409);
        var visit = Assert.Single(result.SourceVisits);

        Assert.Equal(262, visit.ConceptId);
        Assert.Equal(new DateTime(2013, 9, 1), visit.StartDate);
        Assert.Equal(new DateTime(2013, 9, 22), visit.EndDate);
        Assert.Contains(result.SourceVisitDetails, item => item.ConceptId == 8870);
    }

    private static OptumExtendedInMemoryScenario Person(long personId, string end = "2014-10-31", int yearOfBirth = 1969)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", end, yearOfBirth: yearOfBirth);
        return source;
    }
}
