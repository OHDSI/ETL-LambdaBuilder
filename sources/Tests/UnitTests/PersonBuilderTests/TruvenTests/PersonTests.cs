namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class PersonTests
{
    [Fact]
    public void Build_Truven_Person_R167_DropsGenderChanges()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(167, "2012-01-01", "2012-01-31", sex: "1");
        s.AddEnrollmentDetail(167, "2012-02-01", "2012-02-28", sex: "2");
        Assert.Empty(s.Build(167).Data.Persons);
    }

    [Fact]
    public void Build_Truven_Person_R168_DropsBirthYearsMoreThanTwoYearsApart()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(168, "2012-01-01", "2012-01-31", "1970");
        s.AddEnrollmentDetail(168, "2012-02-01", "2012-02-28", "1980");
        Assert.Empty(s.Build(168).Data.Persons);
    }

    [Fact]
    public void Build_Truven_Person_R169_UsesLatestCloseBirthYear()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(169, "2012-01-01", "2012-01-31", "1970");
        s.AddEnrollmentDetail(169, "2012-02-01", "2012-02-28", "1971");
        Assert.Equal(1971, Assert.Single(s.Build(169).Data.Persons).YearOfBirth);
    }

    [Fact] public void Build_Truven_Person_R170_DropsBirthBefore1900() => AssertDropped(170, "1899");
    [Fact] public void Build_Truven_Person_R171_DropsBirthAfterCurrentYear() => AssertDropped(171, "2099");

    [Fact]
    public void Build_Truven_Person_R172_DropsBirthTwoYearsAfterEnrollment()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(172, "2012-01-01", "2012-01-31", "2014");
        Assert.Empty(s.Build(172).Data.Persons);
    }

    [Fact]
    public void Build_Truven_Person_R173_KeepsBirthOneYearAfterEnrollment()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(173, "2012-01-01", "2012-01-31", "2013");
        Assert.Equal(2013, Assert.Single(s.Build(173).Data.Persons).YearOfBirth);
    }

    [Fact]
    public void Build_Truven_Person_R174_CollapsesEnrollmentRowsToOnePerson()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(174, "2012-01-01", "2012-01-31", "1980");
        s.AddEnrollmentDetail(174, "2012-02-01", "2012-02-28", "1980");
        var person = Assert.Single(s.Build(174).Data.Persons);
        Assert.Equal(1980, person.YearOfBirth);
    }

    [Fact] public void Build_Truven_Person_R175_DropsUnknownSex() => AssertDropped(175, sex: "3");
    [Fact] public void Build_Truven_Person_R176_DropsSecondFutureBirthYearCase() => AssertDropped(176, "2032");

    [Fact]
    public void Build_Truven_Person_R177_KeepsLaterKnownSex()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(177, "2012-01-01", "2012-01-31", sex: "3");
        s.AddEnrollmentDetail(177, "2012-02-01", "2012-02-28", sex: "1");
        Assert.Equal(8507, Assert.Single(s.Build(177).Data.Persons).GenderConceptId);
    }

    [Fact]
    public void Build_Truven_Person_R178_UsesEnrollmentDateForSameYearBirthDate()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(178, "2012-04-01", "2012-04-30", "2012");
        var person = Assert.Single(s.Build(178).Data.Persons);
        Assert.Equal(2012, person.YearOfBirth);
        Assert.Equal(4, person.MonthOfBirth);
        Assert.Equal(1, person.DayOfBirth);
    }

    [Fact] public void Build_Truven_Person_R179_MapsSexOneToMale() => AssertGender(179, "1", 8507);
    [Fact] public void Build_Truven_Person_R180_MapsSexTwoToFemale() => AssertGender(180, "2", 8532);
    [Fact] public void Build_Truven_Person_R181_DiscardsSexThree() => AssertDropped(181, sex: "3");

    [Fact]
    public void Build_Truven_Person_R182_PreservesPersonConstants()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(182);
        var person = Assert.Single(s.Build(182).Data.Persons);
        Assert.Equal(0, person.RaceConceptId);
        Assert.Equal(0, person.EthnicityConceptId);
        Assert.Equal(0, person.GenderSourceConceptId);
        Assert.Equal(0, person.RaceSourceConceptId);
        Assert.Equal(0, person.EthnicitySourceConceptId);
    }

    [Fact]
    public void Build_Truven_Person_R183_KeepsPrescriptionCoverage()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(183, rx: "1");
        Assert.Single(s.Build(183).Data.Persons);
    }

    [Fact]
    public void Build_Truven_Person_R184_DropsMissingPrescriptionCoverage()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(184, rx: "0");
        Assert.Empty(s.Build(184).Data.Persons);
    }

    [Fact]
    public void Build_Truven_Person_R185_UsesLatestEnrollmentLocation()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(185, "2012-01-01", "2012-01-31", egeoloc: "89");
        s.AddEnrollmentDetail(185, "2012-02-01", "2012-02-28", egeoloc: "11");
        Assert.Single(s.Build(185).Data.Persons);
    }

    private static void AssertDropped(long id, string dobyr = "1935", string sex = "1")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, dobyr: dobyr, sex: sex);
        Assert.Empty(s.Build(id).Data.Persons);
    }

    private static void AssertGender(long id, string sex, long expected)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, sex: sex);
        Assert.Equal(expected, Assert.Single(s.Build(id).Data.Persons).GenderConceptId);
    }
}
