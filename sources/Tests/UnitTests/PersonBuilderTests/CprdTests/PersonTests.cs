namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class PersonTests
{
    [Fact]
    public void Build_Cprd_Person_R71311_DropsUnacceptedPerson() => AssertNoPerson(71311, accept: 0);

    [Fact]
    public void Build_Cprd_Person_R72311_MapsValidMale()
    {
        var person = BuildPerson(72311);
        Assert.Equal(1999, person.YearOfBirth);
        Assert.Equal(1, person.MonthOfBirth);
        Assert.Equal(311, person.CareSiteId);
        Assert.Equal(8507, person.GenderConceptId);
        Assert.Equal("72311", person.PersonSourceValue);
        Assert.Equal("1", person.GenderSourceValue);
    }

    [Fact]
    public void Build_Cprd_Person_R73311_RemovesDeathBeforeObservationStart()
    {
        const long id = 73311;
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, crd: "2013-01-01", deathDate: "2012-01-01");
        Assert.Empty(s.Build(id).Data.Deaths);
    }

    [Fact]
    public void Build_Cprd_Person_R74311_DropsCrdAfterTod() =>
        AssertNoPerson(74311, crd: "2013-01-01", tod: "2011-05-03");

    [Fact]
    public void Build_Cprd_Person_R75113_DropsInvalidPracticeWindow() =>
        AssertNoPerson(75113, pracid: 113);

    [Fact]
    public void Build_Cprd_Person_R76311_MapsZeroBirthMonthToNull()
    {
        var person = BuildPerson(76311, mob: 0);
        Assert.Equal(1999, person.YearOfBirth);
        Assert.Null(person.MonthOfBirth);
    }

    [Fact]
    public void Build_Cprd_Person_R77311_DropsImplausibleYearOfBirth() => AssertNoPerson(77311, yob: 74);

    [Fact]
    public void Build_Cprd_Person_R78311_MapsFemale()
    {
        var person = BuildPerson(78311, gender: 2, yob: 195);
        Assert.Equal(8532, person.GenderConceptId);
        Assert.Equal("2", person.GenderSourceValue);
    }

    [Fact]
    public void Build_Cprd_Person_R79311_DropsGenderNotEntered() => AssertNoPerson(79311, gender: 0, yob: 195);

    [Fact]
    public void Build_Cprd_Person_R80311_DropsIndeterminateGender() => AssertNoPerson(80311, gender: 3, yob: 195, mob: 6);

    [Fact]
    public void Build_Cprd_Person_R81311_DropsUnknownGender() => AssertNoPerson(81311, gender: 4, yob: 195, mob: 6);

    private static org.ohdsi.cdm.framework.common.Omop.Person BuildPerson(
        long id, int gender = 1, int yob = 199, int? mob = 1)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, gender: gender, yob: yob, mob: mob);
        return Assert.Single(s.Build(id).Data.Persons);
    }

    private static void AssertNoPerson(
        long id, int gender = 1, int yob = 199, int? mob = 1, int accept = 1,
        string crd = "2010-01-01", long pracid = 311, string? tod = null)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, gender: gender, yob: yob, mob: mob, accept: accept, crd: crd, pracid: pracid, tod: tod);
        Assert.Empty(s.Build(id).Data.Persons);
    }
}
