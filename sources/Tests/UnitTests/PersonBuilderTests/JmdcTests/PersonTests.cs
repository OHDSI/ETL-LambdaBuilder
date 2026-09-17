namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class PersonTests
{
    [Fact]
    public void Build_Jmdc_Person_R101_MapsPersonIdAndSourceValue()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000101");

        var person = Assert.Single(source.Build("M000000101").Persons);

        Assert.Equal(101L, person.PersonId);
        Assert.Equal("M000000101", person.PersonSourceValue);
    }

    [Theory]
    [InlineData("M000000102", "male", 8507L)]
    [InlineData("M000000103", "female", 8532L)]
    public void Build_Jmdc_Person_R102_MapsGender(string memberId, string sourceGender, long expectedConceptId)
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId, genderOfMember: sourceGender);

        var person = Assert.Single(source.Build(memberId).Persons);

        Assert.Equal(expectedConceptId, person.GenderConceptId);
        Assert.Equal(sourceGender, person.GenderSourceValue);
    }

    [Fact]
    public void Build_Jmdc_Person_R103_MapsYearAndMonthOfBirth()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000104", monthAndYearOfBirth: "197508");

        var person = Assert.Single(source.Build("M000000104").Persons);

        Assert.Equal(1975, person.YearOfBirth);
        Assert.Equal(8, person.MonthOfBirth);
    }
}
