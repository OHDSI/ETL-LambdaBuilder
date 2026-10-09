using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class MeasurementTests
{
    [Fact]
    public void Build_OptumPanther_Measurement_R199_RoutesDiagnosisOfToMeasurement()
    {
        var source = StandardPersonWithEncounter(199, 200);
        source.AddDiagnosis(199, "7953", "ICD9", "Diagnosis of", "2009-01-01", Encounter(200));

        var measurement = SingleMeasurement(source, 199);

        Assert.Equal(4189544, measurement.ConceptId);
        Assert.Equal(new DateTime(2009, 1, 1), measurement.StartDate.Date);
        Assert.Equal("7953", measurement.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R201_RoutesUnknownDiagnosisStatusToMeasurement()
    {
        var source = StandardPersonWithEncounter(201, 202);
        source.AddDiagnosis(201, "7953", "ICD9", "Zachary", "2009-01-01", Encounter(202));

        var measurement = SingleMeasurement(source, 201);

        Assert.Equal(4189544, measurement.ConceptId);
        Assert.Equal(new DateTime(2009, 1, 1), measurement.StartDate.Date);
        Assert.Equal("7953", measurement.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R203_MapsIcd9SourceConcept()
    {
        var source = StandardPersonWithEncounter(203, 204);
        source.AddDiagnosis(203, "7953", "ICD9", diagnosisDate: "2009-01-01", encid: Encounter(204));

        Assert.Equal(44828170, SingleMeasurement(source, 203).SourceConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R205_RoutesSnomedDiagnosisToMeasurement()
    {
        var source = StandardPersonWithEncounter(205, 206);
        source.AddDiagnosis(205, "145003003", "SNOMED", diagnosisDate: "2009-01-01", encid: Encounter(206));

        var measurement = SingleMeasurement(source, 205);

        Assert.Equal(4120300, measurement.ConceptId);
        Assert.Equal(new DateTime(2009, 1, 1), measurement.StartDate.Date);
        Assert.Equal("145003003", measurement.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R207_ParsesNumericLabResult()
    {
        var source = StandardPersonWithEncounter(207, 208);
        source.AddLab(207, "2009-01-01", "Oxygen.partial pressure (PO2).unspecified specimen", "100", encid: Encounter(208));

        var measurement = SingleMeasurement(source, 207);

        Assert.Equal(3027315, measurement.ConceptId);
        Assert.Equal(new DateTime(2009, 1, 1), measurement.StartDate.Date);
        Assert.Equal("Oxygen.partial pressure (PO2).unspecified specimen", measurement.SourceValue);
        Assert.Equal(0, measurement.SourceConceptId);
        Assert.Equal(100m, measurement.ValueAsNumber);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R209_MapsNonNumericLabResultToConcept()
    {
        var source = StandardPersonWithEncounter(209, 210);
        source.AddLab(209, "2009-01-01", "Oxygen.partial pressure (PO2).unspecified specimen", "positive", encid: Encounter(210));

        var measurement = SingleMeasurement(source, 209);

        Assert.Equal(3027315, measurement.ConceptId);
        Assert.Equal(0, measurement.SourceConceptId);
        Assert.Null(measurement.ValueAsNumber);
        Assert.Equal(45884084, measurement.ValueAsConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R211_MapsValidOperator()
    {
        var source = StandardPersonWithEncounter(211, 212);
        source.AddLab(211, "2009-01-01", "O2 saturation.oximetry", "100", relativeIndicator: "<=", encid: Encounter(212));

        Assert.Equal(4171754, SingleMeasurement(source, 211).OperatorConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R213_InvalidOperatorMapsToZero()
    {
        var source = StandardPersonWithEncounter(213, 214);
        source.AddLab(213, "2009-01-01", "O2 saturation.oximetry", "100", relativeIndicator: "ZA", encid: Encounter(214));

        Assert.Equal(0, SingleMeasurement(source, 213).OperatorConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R215_MapsCaseSensitiveUcumUnit()
    {
        var source = StandardPersonWithEncounter(215, 216);
        source.AddLab(215, "2009-01-01", "O2 saturation.oximetry", "100", "pH", encid: Encounter(216));

        var result = Build(source, 215);

        Assert.Equal(8482, Assert.Single(result.Data.Measurements).UnitConceptId);
        Assert.Single(result.Data.Measurements);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R217_ParsesHyphenatedNormalRange()
    {
        var source = StandardPersonWithEncounter(217, 218);
        source.AddLab(217, "2009-01-01", "O2 saturation.oximetry", "100", normalRange: "55-65", encid: Encounter(218));

        var measurement = SingleMeasurement(source, 217);

        Assert.Equal(55m, measurement.RangeLow);
        Assert.Equal(65m, measurement.RangeHigh);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R219_IgnoresNormalRangeWithoutHyphen()
    {
        var source = StandardPersonWithEncounter(219, 220);
        source.AddLab(219, "2009-01-01", "O2 saturation.oximetry", "100", normalRange: "55", encid: Encounter(220));

        var measurement = SingleMeasurement(source, 219);

        Assert.Null(measurement.RangeLow);
        Assert.Null(measurement.RangeHigh);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R221_MapsNlpMeasurementType()
    {
        var source = StandardPersonWithEncounter(221, 222);
        source.AddNlpMeasurement(221, "2009-01-01", "WEIGHT", "100", encid: Encounter(222));

        var measurement = SingleMeasurement(source, 221);

        Assert.Equal(3025315, measurement.ConceptId);
        Assert.Equal(32858, measurement.TypeConceptId);
        Assert.Equal(0, measurement.SourceConceptId);
        Assert.Equal("WEIGHT", measurement.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R223_MapsNonNumericNlpValueToConcept()
    {
        var source = StandardPersonWithEncounter(223, 224);
        source.AddNlpMeasurement(223, "2009-01-01", "WEIGHT", "positive", encid: Encounter(224));

        var measurement = SingleMeasurement(source, 223);

        Assert.Equal(3025315, measurement.ConceptId);
        Assert.Equal(32858, measurement.TypeConceptId);
        Assert.Equal(0, measurement.SourceConceptId);
        Assert.Equal("WEIGHT", measurement.SourceValue);
        Assert.Equal(45884084, measurement.ValueAsConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R225_MapsNlpMeasurementDetailToUcumUnit()
    {
        var source = StandardPersonWithEncounter(225, 226);
        source.AddNlpMeasurement(225, "2009-01-01", "WEIGHT", "100", "pH", Encounter(226));

        var result = Build(source, 225);
        var measurement = Assert.Single(result.Data.Measurements);

        Assert.Equal(8482, measurement.UnitConceptId);
        Assert.Equal("pH", measurement.UnitSourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R227_RoutesMappableObservationTypeToMeasurement()
    {
        var source = StandardPersonWithEncounter(227, 228);
        source.AddObservation(227, "2009-01-01", "SBP", encid: Encounter(228));

        var measurement = SingleMeasurement(source, 227);

        Assert.Equal(3004249, measurement.ConceptId);
        Assert.Equal(32831, measurement.TypeConceptId);
        Assert.Equal("SBP", measurement.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R229_UnmappableObservationTypeStaysObservation()
    {
        var source = StandardPersonWithEncounter(229, 230);
        source.AddObservation(229, "2009-01-01", "Zach", encid: Encounter(230));

        var result = Build(source, 229);
        var observation = Assert.Single(result.Data.Observations, item => item.SourceValue == "Zach");

        Assert.Equal(0, observation.ConceptId);
        Assert.Empty(result.Data.Measurements);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R231_MapsObservationValueAsConcept()
    {
        var source = StandardPersonWithEncounter(231, 232);
        source.AddObservation(231, "2009-01-01", "SBP", observationResult: "normal", encid: Encounter(232));

        var measurement = SingleMeasurement(source, 231);

        Assert.Equal(4069590, measurement.ValueAsConceptId);
        Assert.Equal("normal", measurement.ValueSourceValue);
        Assert.Equal(0, measurement.SourceConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Measurement_R233_MapsObservationUcumUnit()
    {
        var source = StandardPersonWithEncounter(233, 234);
        source.AddObservation(233, "2009-01-01", "SBP", observationResult: "100", observationUnit: "pH", encid: Encounter(234));

        var result = Build(source, 233);
        var measurement = Assert.Single(result.Data.Measurements);

        Assert.Equal(8482, measurement.UnitConceptId);
        Assert.Equal("pH", measurement.UnitSourceValue);
    }

    private static string Encounter(long sequence) => OptumPantherInMemoryScenario.EncounterId(sequence);

    private static OptumPantherInMemoryScenario StandardPersonWithEncounter(long personId, long encounterSequence)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, "Male", "1950",
            firstMonthActive: "200701", lastMonthActive: "201001");
        source.AddEncounter(personId, Encounter(encounterSequence), "Inpatient", "2009-01-01");
        return source;
    }

    private static Measurement SingleMeasurement(OptumPantherInMemoryScenario source, long personId) =>
        Assert.Single(Build(source, personId).Data.Measurements);

    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long personId)
    {
        var result = source.Build(personId);
        Assert.Equal(Attrition.None, result.Attrition);
        return result;
    }
}
