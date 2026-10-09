namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class DeathTests
{
    [Fact]
    public void Build_OptumExtendedDod_Death_R1601_ConvertsYearMonthToLastDayOfMonth()
    {
        var source = Person(1601);
        source.AddDeath(1601, "201307");

        Assert.Equal(new DateTime(2013, 7, 31), Assert.Single(source.Build(1601).Data.Deaths).StartDate);
    }

    [Fact]
    public void Build_OptumExtendedDod_Death_R1602_RemovesDeathBeforeBirth()
    {
        var source = Person(1602, "2015-04-01", "2015-05-01", 2015);
        source.AddDeath(1602, "201307");

        Assert.Empty(source.Build(1602).Data.Deaths);
    }

    [Theory]
    [InlineData(1603, "21")]
    [InlineData(1605, "23")]
    public void Build_OptumExtendedDod_Death_R1603_R1605_KeepsDeathWithIpOrErVisitWithinThirtyDays(
        long personId,
        string positionOfService)
    {
        var source = Person(personId);
        source.AddDeath(personId, "201307");
        AddVisitAndDiagnosis(source, personId, "2013-07-31", positionOfService);

        Assert.Single(source.Build(personId).Data.Deaths);
    }

    [Theory]
    [InlineData(1604, "21")]
    [InlineData(1606, "23")]
    public void Build_OptumExtendedDod_Death_R1604_R1606_RemovesDeathWithIpOrErVisitAfterThirtyDays(
        long personId,
        string positionOfService)
    {
        var source = Person(personId);
        source.AddDeath(personId, "201307");
        AddVisitAndDiagnosis(source, personId, "2013-10-02", positionOfService);

        Assert.Empty(source.Build(personId).Data.Deaths);
    }

    [Fact]
    public void Build_OptumExtendedDod_Death_R1607_PrefersDodRecordOverDiagnosisAndProcedureHistory()
    {
        var source = Person(1607);
        source.AddDeath(1607, "201307");
        source.AddMedicalClaim(1607, "C1607", "2011-08-02", procedureCode: "64475");
        source.AddDiagnosis(1607, "C1607", "7616", start: "2011-08-02");

        Assert.Equal(new DateTime(2013, 7, 31), Assert.Single(source.Build(1607).Data.Deaths).StartDate);
    }

    private static void AddVisitAndDiagnosis(
        OptumExtendedInMemoryScenario source,
        long personId,
        string date,
        string positionOfService)
    {
        var claimId = $"C{personId}";
        source.AddMedicalClaim(personId, claimId, date, positionOfService: positionOfService);
        source.AddDiagnosis(personId, claimId, "7061", start: date);
    }

    private static OptumExtendedInMemoryScenario Person(
        long personId,
        string start = "2010-05-01",
        string end = "2013-10-31",
        int yearOfBirth = 1969)
    {
        var source = new OptumExtendedInMemoryScenario(OptumExtendedFlavor.Dod);
        source.AddStandardPerson(personId, start, end, yearOfBirth: yearOfBirth);
        return source;
    }
}
