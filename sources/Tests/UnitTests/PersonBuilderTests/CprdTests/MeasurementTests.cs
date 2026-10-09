namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class MeasurementTests
{
    [Fact]
    public void Build_Cprd_Measurement_R34311_MapsClinicalMeasurementWithoutConsultation() =>
        AssertReadMeasurement(34311, CprdReadSource.Clinical, "2012-01-01", 32817);

    [Fact]
    public void Build_Cprd_Measurement_R35311_RetainsMeasurementOutsideObservationPeriod() =>
        AssertReadMeasurement(35311, CprdReadSource.Clinical, "2009-01-01", 32817);

    [Fact]
    public void Build_Cprd_Measurement_R36311_MapsImmunisationMeasurement() =>
        AssertReadMeasurement(36311, CprdReadSource.Immunisation, "2011-03-01", 32818);

    [Fact]
    public void Build_Cprd_Measurement_R37311_MapsReferralMeasurement() =>
        AssertReadMeasurement(37311, CprdReadSource.Referral, "2011-03-01", 32817);

    [Fact]
    public void Build_Cprd_Measurement_R38311_MapsTestEntityToMeasurement()
    {
        const long id = 38311;
        var s = Patient(id);
        s.AddTestResult(id, "2011-03-01", "424Z.00", "215-Clotting Tests");
        var measurement = Assert.Single(s.Build(id).Data.Measurements);
        Assert.Equal(4199172, measurement.ConceptId);
        Assert.Equal("424Z.00", measurement.SourceValue);
        Assert.Equal(CprdRAssert.Date("2011-03-01"), measurement.StartDate);
        Assert.Equal(1001, measurement.ProviderId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R39311_MapsFourFieldNormalQualifier()
    {
        var measurement = FourField(39311);
        Assert.Equal(4132152, measurement.ConceptId);
        Assert.Equal("Normal", measurement.ValueSourceValue);
        Assert.Equal(4069590, measurement.ValueAsConceptId);
        Assert.Equal("424Z.00", measurement.SourceValue);
    }

    [Fact]
    public void Build_Cprd_Measurement_R40311_MapsRangeLow()
    {
        var measurement = FourField(40311, rangeLow: 1.2m);
        Assert.Equal(1.2m, measurement.RangeLow);
        Assert.Equal(32856, measurement.TypeConceptId);
        Assert.Equal(4069590, measurement.ValueAsConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R41311_MapsRangeHigh()
    {
        var measurement = FourField(41311, rangeHigh: 4.3m);
        Assert.Equal(4.3m, measurement.RangeHigh);
        Assert.Equal(32856, measurement.TypeConceptId);
        Assert.Equal(4069590, measurement.ValueAsConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R42311_MapsSevenFieldHaemoglobin()
    {
        const long id = 42311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "42VZ.00", "173-Haemoglobin",
            value: 14.30m, rangeLow: 11.50m, rangeHigh: 16.50m,
            qualifierConceptId: 4172703, qualifierSource: "=",
            unitConceptId: 8713, unitSource: "g/dL");
        var m = Assert.Single(s.Build(id).Data.Measurements);
        Assert.Equal(4015178, m.ConceptId);
        Assert.Equal(14.30m, m.ValueAsNumber);
        Assert.Null(m.ValueAsConceptId);
        Assert.Equal(4172703, m.OperatorConceptId);
        Assert.Equal(11.50m, m.RangeLow);
        Assert.Equal(16.50m, m.RangeHigh);
        Assert.Equal("g/dL", m.UnitSourceValue);
        Assert.Equal(8713, m.UnitConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R43311_MapsMaternityUltrasoundEntity()
    {
        const long id = 43311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "42VZ.00", "284-Maternity ultra sound scan", value: 14m, unitSource: "week");
        var m = Assert.Single(s.Build(id).Data.Measurements);
        Assert.Equal(3031455, m.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), m.StartDate);
        Assert.Equal(32856, m.TypeConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R44311_MapsZeroConceptTestEntityToObservation()
    {
        const long id = 44311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "42VZ.00", "311-PF current", value: 120m, unitSource: "L/min");
        var observation = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(0, observation.ConceptId);
        Assert.Equal(32856, observation.TypeConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R45311_MapsAlphaFetoproteinEntity()
    {
        const long id = 45311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "42VZ.00", "154-Alpha fetoprotein", value: 1m);
        var m = Assert.Single(s.Build(id).Data.Measurements);
        Assert.Equal(4197249, m.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), m.StartDate);
        Assert.Equal(32856, m.TypeConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R46311_MapsAdditionalDiastolicBloodPressure()
    {
        var data = AdditionalBloodPressure();
        var m = CprdRAssert.Single(data.Measurements, x => x.SourceValue == "1-Examination Findings-Blood pressure-Diastolic");
        Assert.Equal(3012888, m.ConceptId);
        Assert.Equal(80m, m.ValueAsNumber);
        Assert.Equal(32817, m.TypeConceptId);
    }

    [Fact]
    public void Build_Cprd_Measurement_R46311_MapsAdditionalSystolicBloodPressure()
    {
        var data = AdditionalBloodPressure();
        var m = CprdRAssert.Single(data.Measurements, x => x.SourceValue == "1-Examination Findings-Blood pressure-Systolic");
        Assert.Equal(3004249, m.ConceptId);
        Assert.Equal(160m, m.ValueAsNumber);
        Assert.Equal(32817, m.TypeConceptId);
    }

    private static void AssertReadMeasurement(long id, CprdReadSource source, string date, long type)
    {
        var s = Patient(id);
        s.AddRead(id, source, date, "424Z.00");
        var m = Assert.Single(s.Build(id).Data.Measurements);
        CprdRAssert.Common(m, id, 4132152, date, "424Z.00", 45508441, type);
        Assert.Equal(1001, m.ProviderId);
    }

    private static org.ohdsi.cdm.framework.common.Omop.Measurement FourField(
        long id, decimal? rangeLow = null, decimal? rangeHigh = null)
    {
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "424Z.00", "220-Full blood count",
            valueSource: "Normal", rangeLow: rangeLow, rangeHigh: rangeHigh);
        return Assert.Single(s.Build(id).Data.Measurements);
    }

    private static org.ohdsi.cdm.framework.common.Builder.ChunkData AdditionalBloodPressure()
    {
        const long id = 46311;
        var s = Patient(id);
        s.AddMeasurement(id, "2010-01-01", 3012888,
            "1-Examination Findings-Blood pressure-Diastolic", valueAsNumber: 80m);
        s.AddMeasurement(id, "2010-01-01", 3004249,
            "1-Examination Findings-Blood pressure-Systolic", valueAsNumber: 160m);
        return s.Build(id).Data;
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        return s;
    }
}
