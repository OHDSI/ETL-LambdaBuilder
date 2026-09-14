using System;
using System.Collections.Generic;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.etl.Transformation.JMDC;
using Xunit;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class PersonTests
{
    private static Person CreateDefaultPerson()
    {
        return new Person
        {
            PersonId = 1,
            PersonSourceValue = "M000000001",

            StartDate = new DateTime(2010, 1, 1),
            EndDate = new DateTime(2017, 12, 31),

            YearOfBirth = 1980,
            MonthOfBirth = 1,

            GenderConceptId = 8532,
            GenderSourceValue = "female",

            RaceConceptId = 0,
            RaceSourceValue = string.Empty,

            TypeConceptId = 32813,
            ObservationPeriodGap = 0,

            AdditionalFields =
                new Dictionary<string, string>()
        };
    }

    private static Person BuildSinglePerson(
        params Person[] sourcePersons)
    {
        var builder = new JmdcPersonBuilder(
            new JmdcPersonBuilder.JmdcVendor());

        var chunkData = new ChunkData(
            chunkId: 0,
            subChunkId: 0);

        var offsetManager = new KeyMasterOffsetManager(
            chunkId: 0,
            prefix: 0,
            attempt: 0);

        foreach (var sourcePerson in sourcePersons)
        {
            builder.AddData(sourcePerson);
        }

        var attrition = builder.Build(
            chunkData,
            offsetManager);

        Assert.Equal(Attrition.None, attrition);

        return Assert.Single(chunkData.Persons);
    }

    // R case 101: Person id
    [Fact]
    public void Build_R101_PreservesPersonIdAndSourceValue()
    {
        var sourcePerson = CreateDefaultPerson();

        sourcePerson.PersonId = 101;
        sourcePerson.PersonSourceValue = "M000000101";

        var builtPerson = BuildSinglePerson(sourcePerson);

        Assert.Equal(101L, builtPerson.PersonId);
        Assert.Equal("M000000101", builtPerson.PersonSourceValue);
    }

    // R case 102: Person gender mappings
    [Theory]
    [InlineData(102L, "M000000102", "male", 8507L)]
    [InlineData(103L, "M000000103", "female", 8532L)]
    public void Build_R102_PreservesMappedGenderFields(
        long personId,
        string personSourceValue,
        string genderSourceValue,
        long genderConceptId)
    {
        var sourcePerson = CreateDefaultPerson();

        sourcePerson.PersonId = personId;
        sourcePerson.PersonSourceValue = personSourceValue;
        sourcePerson.GenderSourceValue = genderSourceValue;
        sourcePerson.GenderConceptId = genderConceptId;

        var genderSourceValueBeforeBuild =
            sourcePerson.GenderSourceValue;

        var builtPerson = BuildSinglePerson(sourcePerson);

        Assert.Equal(personId, builtPerson.PersonId);
        Assert.Equal(
            (long?)genderConceptId,
            builtPerson.GenderConceptId);

        Assert.Equal(
            genderSourceValueBeforeBuild,
            builtPerson.GenderSourceValue);
    }

    // R case 103: Person year and month of birth
    [Fact]
    public void Build_R103_PreservesYearAndMonthOfBirth()
    {
        var sourcePerson = CreateDefaultPerson();

        sourcePerson.PersonId = 103;
        sourcePerson.PersonSourceValue = "M000000103";
        sourcePerson.YearOfBirth = 1975;
        sourcePerson.MonthOfBirth = 8;

        var builtPerson = BuildSinglePerson(sourcePerson);

        Assert.Equal<int?>(1975, builtPerson.YearOfBirth);
        Assert.Equal<int?>(8, builtPerson.MonthOfBirth);
    }
}