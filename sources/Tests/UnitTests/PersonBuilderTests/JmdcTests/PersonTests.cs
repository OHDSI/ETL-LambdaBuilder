namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class PersonTests
{
    [Fact]
    public void Build_Jmdc_Person_R101_PersonId()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000101");

        var person = Assert.Single(source.Build("M000000101").Persons);

        Assert.Equal(101L, person.PersonId);
        Assert.Equal("M000000101", person.PersonSourceValue);
    }

    [Fact]
    public void Build_Jmdc_Person_R102_PersonGenderMappings()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000102", genderOfMember: "male");
        source.AddEnrollment("M000000103", genderOfMember: "female");

        var male = Assert.Single(source.Build("M000000102").Persons);
        var female = Assert.Single(source.Build("M000000103").Persons);

        Assert.Equal(8507L, male.GenderConceptId);
        Assert.Equal("male", male.GenderSourceValue);
        Assert.Equal(8532L, female.GenderConceptId);
        Assert.Equal("female", female.GenderSourceValue);
    }

    [Fact]
    public void Build_Jmdc_Person_R103_PersonYearAndMonthOfBirth()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000104", monthAndYearOfBirth: "197508");

        var person = Assert.Single(source.Build("M000000104").Persons);

        Assert.Equal(1975, person.YearOfBirth);
        Assert.Equal(8, person.MonthOfBirth);
    }
}
