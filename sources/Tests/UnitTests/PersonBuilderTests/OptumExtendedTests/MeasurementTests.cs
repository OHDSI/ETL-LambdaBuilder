namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class MeasurementTests
{
    [Fact]
    public void Build_OptumExtended_Measurement_R1201_PreservesZeroNumericLabResult()
    {
        var source = Person(1201);
        source.AddLabResult(1201, "L1201", loinc: "22962-5", procedureCode: "87517", resultNumber: 0m, resultText: "STUFF");

        var measurement = Assert.Single(source.Build(1201).Data.Measurements);

        Assert.Equal("22962-5", measurement.SourceValue);
        Assert.Equal(0m, measurement.ValueAsNumber);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1202_PreservesNonZeroNumericLabResult()
    {
        var source = Person(1202);
        source.AddLabResult(1202, "L1202", loinc: "22962-5", procedureCode: "87517", resultNumber: 111m, resultText: "STUFF");

        Assert.Equal(111m, Assert.Single(source.Build(1202).Data.Measurements).ValueAsNumber);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1203_PrefersLoincOverProcedureMapping()
    {
        var source = Person(1203);
        source.AddLabResult(1203, "L1203", loinc: "22962-5", procedureCode: "87517");

        var measurements = source.Build(1203).Data.Measurements;

        Assert.Contains(measurements, item => item.SourceValue == "22962-5");
        Assert.DoesNotContain(measurements, item => item.SourceValue == "87517");
    }

    [Theory]
    [InlineData(1204, "21", 9201)]
    [InlineData(1205, "11", 9202)]
    public void Build_OptumExtended_Measurement_R1204_R1205_RoutesDiagnosisDomainToMeasurement(
        long personId,
        string positionOfService,
        long expectedVisitConcept)
    {
        var source = Person(personId);
        var claimId = $"C{personId}";
        source.AddMedicalClaim(personId, claimId, "2013-07-01", positionOfService: positionOfService, locationCode: "2");
        source.AddDiagnosis(personId, claimId, "V8271", locationCode: "2");

        var result = source.Build(personId);

        Assert.DoesNotContain(result.Data.ConditionOccurrences, item => item.SourceValue == "V8271");
        Assert.Contains(result.Data.Measurements, item => item.ConceptId == 4237017);
        Assert.Contains(result.SourceVisits, item => item.ConceptId == expectedVisitConcept);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1206_MapsLoincAndNumericValue()
    {
        var source = Person(1206);
        source.AddLabResult(1206, "L1206", loinc: "22962-5", resultNumber: 1000m);

        var measurement = Assert.Single(source.Build(1206).Data.Measurements);

        Assert.Equal(3012939, measurement.ConceptId);
        Assert.Equal(1000m, measurement.ValueAsNumber);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1207_RoutesMedicalProcedureCodeToMeasurement()
    {
        var source = Person(1207);
        source.AddMedicalClaim(1207, "C1207", "2013-07-01", procedureCode: "87517");

        Assert.Contains(source.Build(1207).Data.Measurements, item => item.ConceptId == 2213127);
    }

    [Theory]
    [InlineData(1208, "LOW")]
    [InlineData(1209, "HIGH")]
    public void Build_OptumExtended_Measurement_R1208_R1209_KeepsTextualLabResult(long personId, string resultText)
    {
        var source = Person(personId);
        source.AddLabResult(personId, $"L{personId}", loinc: "22962-5", resultNumber: 1000m, resultText: resultText);

        Assert.Single(source.Build(personId).Data.Measurements);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1210_MapsLabUnit()
    {
        var source = Person(1210);
        source.AddLabResult(1210, "L1210", loinc: "22962-5", resultNumber: 1000m, unit: "cal");

        Assert.Equal(9472, Assert.Single(source.Build(1210).Data.Measurements).UnitConceptId);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1211_PreservesNormalRange()
    {
        var source = Person(1211);
        source.AddLabResult(1211, "L1211", loinc: "22962-5", resultNumber: 1000m, rangeLow: 10m, rangeHigh: 100m);

        var measurement = Assert.Single(source.Build(1211).Data.Measurements);

        Assert.Equal(10m, measurement.RangeLow);
        Assert.Equal(100m, measurement.RangeHigh);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1212_RoutesMedProcedureCodeToMeasurement()
    {
        var source = Person(1212);
        source.AddMedicalClaim(1212, "C1212", "2013-07-01", locationCode: "2");
        source.AddProcedure(1212, "C1212", "87517");

        Assert.Contains(source.Build(1212).Data.Measurements, item => item.ConceptId == 2213127);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1213_RoutesInpatientProcedureCodeToMeasurement()
    {
        var source = Person(1213);
        source.AddInpatientConfinement(1213, "CONF1213", "2013-08-11", "2013-08-22", diagnosis1: "250.00", procedure3: "87517");

        Assert.Contains(source.Build(1213).Data.Measurements, item => item.ConceptId == 2213127);
    }

    [Fact]
    public void Build_OptumExtended_Measurement_R1214_KeepsUnmappedLoincSourceValue()
    {
        var source = Person(1214);
        source.AddLabResult(1214, "L1214", loinc: "000");

        Assert.Contains(source.Build(1214).Data.Measurements, item => item.SourceValue == "000");
    }

    private static OptumExtendedInMemoryScenario Person(long personId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2014-10-31", yearOfBirth: 1980);
        return source;
    }
}
