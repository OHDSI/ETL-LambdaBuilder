namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class VisitDetailTests
{
    [Fact]
    public void Build_OptumExtended_VisitDetail_R1501_CreatesDetailFromMedicalClaim()
    {
        var source = Person(1501, "2011-05-01", "2013-05-13", 1980);
        source.AddMedicalClaim(1501, "C1501", "2011-08-01", positionOfService: "17");

        var detail = Assert.Single(source.Build(1501).SourceVisitDetails);

        Assert.Equal(38003620, detail.ConceptId);
        Assert.Equal(new DateTime(2011, 8, 1), detail.StartDate);
    }

    [Fact]
    public void Build_OptumExtended_VisitDetail_R1502_CreatesDetailFromInpatientConfinement()
    {
        var source = Person(1502, "2010-05-01", "2014-10-31", 1980);
        source.AddInpatientConfinement(1502, "456", "2013-08-11", "2013-08-22", diagnosis1: "250.00");

        var detail = Assert.Single(source.Build(1502).SourceVisitDetails);

        Assert.Equal(8717, detail.ConceptId);
        Assert.Equal(new DateTime(2013, 8, 11), detail.StartDate);
        Assert.Equal(new DateTime(2013, 8, 22), detail.EndDate);
    }

    [Theory]
    [InlineData(1503, false, 30, "2012-02-02", 581458)]
    [InlineData(1504, true, 30, "2012-02-02", 38004348)]
    [InlineData(1505, false, -25, "2012-02-03", 581458)]
    [InlineData(1506, false, 400, "2012-02-04", 581458)]
    public void Build_OptumExtended_VisitDetail_R1503_R1506_CreatesPharmacyDetail(
        long personId,
        bool specialty,
        int daysSupply,
        string fillDate,
        long expectedConcept)
    {
        var source = Person(personId, "2010-05-01", "2013-10-31", 1969);
        source.AddRxClaim(personId, $"RX{personId}", fillDate: fillDate, daysSupply: daysSupply, specialty: specialty);

        var detail = Assert.Single(source.Build(personId).SourceVisitDetails);

        Assert.Equal(expectedConcept, detail.ConceptId);
        Assert.Equal(DateTime.Parse(fillDate), detail.StartDate);
        Assert.Equal(detail.StartDate, detail.EndDate);
    }

    private static OptumExtendedInMemoryScenario Person(long personId, string start, string end, int yearOfBirth)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, start, end, yearOfBirth: yearOfBirth);
        return source;
    }
}
