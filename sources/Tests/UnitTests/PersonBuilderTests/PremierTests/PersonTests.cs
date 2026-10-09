namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class PersonTests
{
    [Fact]
    public void Build_Premier_Person_R082_DropsYearOfBirthBefore1900()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(82, "P82", "1997-01-01", age: 100);
        Assert.Empty(s.Build(82).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R084_DropsYearOfBirthAfterCurrentYear()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(84, "P84", "2050-01-01", age: 8);
        Assert.Empty(s.Build(84).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R086_DropsWhenFirstVisitCannotProduceBirthYear()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(86, "P86", "2000-01-01", age: 999);
        Assert.Empty(s.Build(86).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R089_DropsVisitBeforeDecember1999()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(89, "P89", "1982-01-01", "1982-01-01", age: 23);
        Assert.Empty(s.Build(89).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R091_DropsBirthYearVariationOverTwoYears()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(91, "P91A", "2000-01-01", "2000-01-01", age: 23);
        s.AddPat(91, "P91B", "2010-01-01", "2010-01-01", age: 23);
        Assert.Empty(s.Build(91).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R094_DropsUnknownGender()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(94, "P94", "2000-01-01", "2000-01-01", gender: "Z");
        Assert.Empty(s.Build(94).Data.Persons);
    }

    [Fact]
    public void Build_Premier_Person_R096_UsesEarliestUsableAgeForBirthYear()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(96, "P96A", "2011-01-01", age: 999);
        s.AddPat(96, "P96B", "2012-01-01", age: 28);
        s.AddPat(96, "P96C", "2013-01-01", age: 29);
        Assert.Equal(1984, Assert.Single(s.Build(96).Data.Persons).YearOfBirth);
    }

    [Fact] public void Build_Premier_Person_R100_MapsHispanicRaceH() => AssertDemographics(100, "H", "Y", 0, 38003563);
    [Fact] public void Build_Premier_Person_R102_MapsHispanicRaceWhite() => AssertDemographics(102, "W", "Y", 8527, 38003563);
    [Fact] public void Build_Premier_Person_R104_MapsHispanicRaceBlack() => AssertDemographics(104, "B", "Y", 8516, 38003563);
    [Fact] public void Build_Premier_Person_R106_MapsNonHispanicRaceBlack() => AssertDemographics(106, "B", "N", 8516, 38003564);

    [Fact]
    public void Build_Premier_Person_R108_UsesMostFrequentRaceAcrossVisits()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(108, "P108A", "2011-01-01", "2011-01-01", 20, race: "B", hispanicInd: "N");
        s.AddPat(108, "P108B", "2012-01-01", "2012-01-01", 20, race: "W", hispanicInd: "N");
        s.AddPat(108, "P108C", "2013-01-01", "2013-01-01", 20, race: "B", hispanicInd: "N");
        var p = Assert.Single(s.Build(108).Data.Persons);
        Assert.Equal(8516, p.RaceConceptId);
        Assert.Equal("B", p.RaceSourceValue);
        Assert.Equal(38003564, p.EthnicityConceptId);
        Assert.Equal("N", p.EthnicitySourceValue);
    }

    [Fact]
    public void Build_Premier_Person_R112_PreservesBadRaceAndEthnicitySourcesAsUnmapped()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(112, "P112", "2011-01-01", age: 20, race: "Z", hispanicInd: "U");
        var p = Assert.Single(s.Build(112).Data.Persons);
        Assert.Equal(0, p.RaceConceptId);
        Assert.Equal("Z", p.RaceSourceValue);
        Assert.Equal(0, p.EthnicityConceptId);
        Assert.Equal("U", p.EthnicitySourceValue);
    }

    private static void AssertDemographics(
        long personId,
        string race,
        string ethnicity,
        long raceConcept,
        long ethnicityConcept)
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, $"P{personId}", "2011-01-01", age: 20, race: race, hispanicInd: ethnicity);
        var p = Assert.Single(s.Build(personId).Data.Persons);
        Assert.Equal(raceConcept, p.RaceConceptId);
        Assert.Equal(race, p.RaceSourceValue);
        Assert.Equal(ethnicityConcept, p.EthnicityConceptId);
        Assert.Equal(ethnicity, p.EthnicitySourceValue);
    }
}
