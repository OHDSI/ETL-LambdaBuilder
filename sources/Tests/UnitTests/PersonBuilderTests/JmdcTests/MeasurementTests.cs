using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class MeasurementTests
{
    [Fact]
    public void Build_Jmdc_Measurement_R1001_CreatesMeasurementsForPerson()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000001001");
        source.AddAnnualHealthCheckup("M000001001");

        var measurements = source.Build("M000001001").Measurements;

        Assert.NotEmpty(measurements);
        Assert.All(measurements, item => Assert.Equal(1001L, item.PersonId));
    }

    [Fact]
    public void Build_Jmdc_Measurement_R1002_MapsBmiAndAbnormalEcg()
    {
        const string memberId = "M000001002";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddAnnualHealthCheckup(memberId, bmi: "25", ecg: 1);

        var data = source.Build(memberId);
        var bmi = Measurement(data.Measurements, 3038553);
        var ecg = Assert.Single(data.ConditionOccurrences, item => item.ConceptId == 320536);

        Assert.Equal(32836L, bmi.TypeConceptId);
        Assert.Equal(32836L, ecg.TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_Measurement_R1003_MapsHealthCheckupDate()
    {
        const string memberId = "M000001003";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddAnnualHealthCheckup(memberId, dateOfHealthCheckup: "2010-01-16");

        Assert.Equal(new DateTime(2010, 1, 16),
            Measurement(source.Build(memberId).Measurements, 3038553).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Measurement_R1004_MapsMeasurementValuesAndUnits()
    {
        const string memberId = "M000001004";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddAnnualHealthCheckup(memberId,
            bmi: "25.0", ecg: 1, triglyceride: "40", ast: "20", alt: "21");

        var data = source.Build(memberId);

        AssertMeasurement(data.Measurements, 3038553, 25m, "25.0", 9531);
        var ecg = Assert.Single(data.ConditionOccurrences, item => item.ConceptId == 320536);
        Assert.Equal("Electrocardiogram abnormal", ecg.SourceValue);
        AssertMeasurement(data.Measurements, 3022038, 40m, "40", 8840);
        AssertMeasurement(data.Measurements, 3003792, 20m, "20", 8645);
        AssertMeasurement(data.Measurements, 3006923, 21m, "21", 8645);
    }

    [Fact]
    public void Build_Jmdc_Measurement_R1005_MapsNormalRanges()
    {
        const string memberId = "M000001005";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddAnnualHealthCheckup(memberId, systolicBp: "110", diastolicBp: "70");

        var measurements = source.Build(memberId).Measurements;
        var systolic = Measurement(measurements, 3004249);
        var diastolic = Measurement(measurements, 3012888);

        Assert.Equal(60m, systolic.RangeLow);
        Assert.Equal(300m, systolic.RangeHigh);
        Assert.Equal(30m, diastolic.RangeLow);
        Assert.Equal(150m, diastolic.RangeHigh);
    }

    [Fact]
    public void Build_Jmdc_Measurement_R1006_RoutesMappedDiagnosisToMeasurementDomain()
    {
        const string memberId = "M000001006";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001001");
        source.AddDiagnosis(memberId, "C000000001001",
            standardDiseaseCode: 3, typeOfClaim: "Outpatient");
        source.AddDiagnosisMaster(3, "R824");

        var measurement = Assert.Single(
            source.Build(memberId).Measurements,
            item => item.VisitOccurrenceId == 1001);

        Assert.Equal(4042243L, measurement.ConceptId);
        Assert.Equal(4181412L, measurement.ValueAsConceptId);
        Assert.Equal(32859L, measurement.TypeConceptId);
    }

    private static Measurement Measurement(IEnumerable<Measurement> measurements, long conceptId) =>
        Assert.Single(measurements, item => item.ConceptId == conceptId);

    private static void AssertMeasurement(
        IEnumerable<Measurement> measurements,
        long conceptId,
        decimal value,
        string sourceValue,
        long unitConceptId)
    {
        var measurement = Measurement(measurements, conceptId);
        Assert.Equal(value, measurement.ValueAsNumber);
        Assert.Equal(sourceValue, measurement.ValueSourceValue);
        Assert.Equal(unitConceptId, measurement.UnitConceptId);
    }
}
