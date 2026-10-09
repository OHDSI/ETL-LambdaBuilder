using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class PersonTests
{
    [Fact]
    public void Build_OptumPanther_Person_R305_DoesNotLoadUnknownGender()
    {
        var result = BuildPerson(305, 306, gender: "Unknown", birthYear: "1950");

        Assert.Equal(Attrition.UnknownGender, result.Attrition);
        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumPanther_Person_R307_MapsMaleGender()
    {
        var person = SuccessfulPerson(307, 308, gender: "Male", birthYear: "1950");

        Assert.Equal(8507, person.GenderConceptId);
        Assert.Equal(1950, person.YearOfBirth);
    }

    [Fact]
    public void Build_OptumPanther_Person_R309_MapsFemaleGender()
    {
        var person = SuccessfulPerson(309, 310, gender: "Female", birthYear: "1950");

        Assert.Equal(8532, person.GenderConceptId);
        Assert.Equal(1950, person.YearOfBirth);
    }

    [Fact]
    public void Build_OptumPanther_Person_R311_DoesNotLoadUnknownBirthYear()
    {
        var result = BuildPerson(311, 312, gender: "Male", birthYear: "Unknown");

        Assert.Equal(Attrition.UnknownYearOfBirth, result.Attrition);
        Assert.Empty(result.Data.Persons);
    }

    [Fact]
    public void Build_OptumPanther_Person_R313_MapsAndEarlierBirthYearTo1927()
    {
        var person = SuccessfulPerson(313, 314, gender: "Male", birthYear: "1927 and earlier");

        Assert.Equal(8507, person.GenderConceptId);
        Assert.Equal(1927, person.YearOfBirth);
    }

    [Fact]
    public void Build_OptumPanther_Person_R315_Maps1930BirthYear()
    {
        var person = SuccessfulPerson(315, 316, gender: "Male", birthYear: "1930");

        Assert.Equal(8507, person.GenderConceptId);
        Assert.Equal(1930, person.YearOfBirth);
    }

    [Fact]
    public void Build_OptumPanther_Person_R317_MapsAsianRaceAndNotHispanicEthnicity()
    {
        var person = SuccessfulPerson(317, 318, race: "Asian", ethnicity: "Not Hispanic");

        Assert.Equal(8515, person.RaceConceptId);
        Assert.Equal(38003564, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R319_MapsAfricanAmericanRaceAndNotHispanicEthnicity()
    {
        var person = SuccessfulPerson(319, 320, race: "African American", ethnicity: "Not Hispanic");

        Assert.Equal(8516, person.RaceConceptId);
        Assert.Equal(38003564, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R321_MapsCaucasianRaceAndNotHispanicEthnicity()
    {
        var person = SuccessfulPerson(321, 322, race: "Caucasian", ethnicity: "Not Hispanic");

        Assert.Equal(8527, person.RaceConceptId);
        Assert.Equal(38003564, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R323_MapsUnknownRaceToZero()
    {
        var person = SuccessfulPerson(323, 324, race: "Other/Unknown", ethnicity: "Not Hispanic");

        Assert.Equal(0, person.RaceConceptId);
        Assert.Equal(38003564, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R325_MapsHispanicEthnicityAndAsianRace()
    {
        var person = SuccessfulPerson(325, 326, race: "Asian", ethnicity: "Hispanic");

        Assert.Equal(8515, person.RaceConceptId);
        Assert.Equal(38003563, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R327_MapsHispanicEthnicityAndAfricanAmericanRace()
    {
        var person = SuccessfulPerson(327, 328, race: "African American", ethnicity: "Hispanic");

        Assert.Equal(8516, person.RaceConceptId);
        Assert.Equal(38003563, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R329_MapsHispanicEthnicityAndCaucasianRace()
    {
        var person = SuccessfulPerson(329, 330, race: "Caucasian", ethnicity: "Hispanic");

        Assert.Equal(8527, person.RaceConceptId);
        Assert.Equal(38003563, person.EthnicityConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Person_R331_MapsHispanicEthnicityAndUnknownRace()
    {
        var person = SuccessfulPerson(331, 332, race: "Other/Unknown", ethnicity: "Hispanic");

        Assert.Equal(0, person.RaceConceptId);
        Assert.Equal(38003563, person.EthnicityConceptId);
    }

    private static Person SuccessfulPerson(
        long personId,
        long encounterSequence,
        string gender = "Male",
        string? birthYear = "1950",
        string race = "Caucasian",
        string ethnicity = "Not Hispanic")
    {
        var result = BuildPerson(personId, encounterSequence, gender, birthYear, race, ethnicity);
        Assert.Equal(Attrition.None, result.Attrition);
        return Assert.Single(result.Data.Persons);
    }

    private static OptumPantherBuildResult BuildPerson(
        long personId,
        long encounterSequence,
        string gender,
        string? birthYear,
        string race = "Caucasian",
        string ethnicity = "Not Hispanic")
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, gender, birthYear, race, ethnicity, idnIndicator: false,
            firstMonthActive: "200701", lastMonthActive: "201001");
        source.AddEncounter(personId, OptumPantherInMemoryScenario.EncounterId(encounterSequence),
            "Inpatient", "2009-01-01");
        return source.Build(personId);
    }
}
