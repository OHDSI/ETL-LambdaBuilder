using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class PersonTests
{
    [Fact]
    public void Build_OptumExtended_Person_R101_RejectsZeroYearOfBirth()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddContinuousEnrollment(101, "2000-09-01", "2000-11-30", yearOfBirth: 0);
        source.AddMemberEnrollment(101, "2000-09-01", "2000-11-30");

        var result = source.Build(101);

        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumExtended_Person_R102_RejectsBirthMoreThanOneYearAfterCoverageStarts()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(102, "2000-05-01", "2006-08-31", yearOfBirth: 2003);

        var result = source.Build(102);

        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumExtended_Person_R103_MapsMaleGender()
    {
        var person = BuildPerson(103, "M");
        Assert.Equal(8507, person.GenderConceptId);
    }

    [Fact]
    public void Build_OptumExtended_Person_R104_MapsFemaleGender()
    {
        var person = BuildPerson(104, "F");
        Assert.Equal(8532, person.GenderConceptId);
    }

    [Fact]
    public void Build_OptumExtended_Person_R105_RejectsUnknownGender()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(105, gender: "U");

        var result = source.Build(105);

        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumExtended_Person_R106_RejectsYearsOfBirthMoreThanTwoYearsApart()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddContinuousEnrollment(106, "2011-01-01", "2011-04-30", "F", 1974);
        source.AddContinuousEnrollment(106, "2008-01-01", "2010-04-30", "F", 1989);
        source.AddMemberEnrollment(106, "2008-01-01", "2010-04-30");
        source.AddMemberEnrollment(106, "2011-01-01", "2011-04-30");

        var result = source.Build(106);

        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumExtended_Person_R107_RejectsGenderChangeAcrossEnrollmentPeriods()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddContinuousEnrollment(107, "2010-03-01", "2012-12-31", "M", 1943);
        source.AddContinuousEnrollment(107, "2015-01-01", "2015-02-28", "F", 1943);
        source.AddMemberEnrollment(107, "2010-03-01", "2012-12-31");
        source.AddMemberEnrollment(107, "2015-01-01", "2015-02-28");

        var result = source.Build(107);

        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumExtended_Person_R108_MapsBirthMonthFromFirstCoverageWhenBirthYearMatches()
    {
        var source = BirthDateScenario(108, 2010);
        Assert.Equal(3, Assert.Single(source.Build(108).Data.Persons).MonthOfBirth);
    }

    [Fact]
    public void Build_OptumExtended_Person_R109_DoesNotMapBirthMonthWhenBirthYearDiffers()
    {
        var source = BirthDateScenario(109, 2008, addSecondPeriod: false);
        Assert.Null(Assert.Single(source.Build(109).Data.Persons).MonthOfBirth);
    }

    [Fact]
    public void Build_OptumExtended_Person_R110_MapsBirthDayFromFirstCoverageWhenBirthYearMatches()
    {
        var source = BirthDateScenario(110, 2010);
        Assert.Equal(1, Assert.Single(source.Build(110).Data.Persons).DayOfBirth);
    }

    [Fact]
    public void Build_OptumExtended_Person_R111_DoesNotMapBirthDayWhenBirthYearDiffers()
    {
        var source = BirthDateScenario(111, 2008, addSecondPeriod: false);
        Assert.Null(Assert.Single(source.Build(111).Data.Persons).DayOfBirth);
    }

    [Theory]
    [InlineData(112, "A", 8515)]
    [InlineData(113, "B", 8516)]
    [InlineData(114, "W", 8527)]
    [InlineData(115, "U", 0)]
    public void Build_OptumExtended_Person_R112_R115_MapsRace(long personId, string sourceRace, long conceptId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, race: sourceRace, yearOfBirth: 1987);

        var person = Assert.Single(source.Build(personId).Data.Persons);

        Assert.Equal(conceptId, person.RaceConceptId);
        Assert.Equal(sourceRace, person.RaceSourceValue);
    }

    [Theory]
    [InlineData(116, "H", 38003563)]
    [InlineData(117, "N", 38003564)]
    [InlineData(118, "U", 0)]
    public void Build_OptumExtended_Person_R116_R118_MapsEthnicity(long personId, string sourceEthnicity, long conceptId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, ethnicity: sourceEthnicity, yearOfBirth: 1987);

        var person = Assert.Single(source.Build(personId).Data.Persons);

        Assert.Equal(conceptId, person.EthnicityConceptId);
        Assert.Equal(sourceEthnicity, person.EthnicitySourceValue);
    }

    private static Person BuildPerson(long personId, string gender)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2000-05-01", "2000-07-31", gender, 1994);
        return Assert.Single(source.Build(personId).Data.Persons);
    }

    private static OptumExtendedInMemoryScenario BirthDateScenario(long personId, int yearOfBirth, bool addSecondPeriod = true)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddContinuousEnrollment(personId, "2010-03-01", "2012-12-31", "M", yearOfBirth);
        source.AddMemberEnrollment(personId, "2010-03-01", "2012-12-31");
        if (addSecondPeriod)
        {
            source.AddContinuousEnrollment(personId, "2017-03-01", "2017-12-31", "M", yearOfBirth);
            source.AddMemberEnrollment(personId, "2017-03-01", "2017-12-31");
        }
        return source;
    }
}
