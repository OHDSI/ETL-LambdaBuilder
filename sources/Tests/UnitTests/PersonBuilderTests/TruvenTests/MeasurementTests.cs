namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class MeasurementTests
{
    [Fact] public void Build_Truven_Measurement_R110_KeepsLabOutsideObservationPeriod() => AssertLab(110, s => s.AddLab(110, "2013-07-09", "56773-5"));
    [Fact] public void Build_Truven_Measurement_R112_MapsLowAbnormalFlag() => AssertAbnormal(112, "L", 4267416);
    [Fact] public void Build_Truven_Measurement_R114_MapsHighAbnormalFlag() => AssertAbnormal(114, "H", 4328749);
    [Fact] public void Build_Truven_Measurement_R116_MapsNormalAbnormalFlag() => AssertAbnormal(116, "N", 4069590);
    [Fact] public void Build_Truven_Measurement_R118_MapsAbnormalFlag() => AssertAbnormal(118, "A", 4135493);
    [Fact] public void Build_Truven_Measurement_R120_MapsPlusAbnormalFlag() => AssertAbnormal(120, "+", 9191);

    [Fact]
    public void Build_Truven_Measurement_R122_ParsesNumericResult()
    {
        var measurement = AssertLab(122, s => s.AddLab(122, "2012-08-24", "56789-1", result: "120"));
        Assert.Equal(120, measurement.ValueAsNumber);
    }

    [Fact]
    public void Build_Truven_Measurement_R124_NormalizesLowercaseUnit()
    {
        var measurement = AssertLab(124, s => s.AddLab(124, "2012-04-06", "56789-1", "100", "mg/dl"));
        Assert.Equal(100, measurement.ValueAsNumber);
        Assert.Equal(8840, measurement.UnitConceptId);
    }

    [Fact] public void Build_Truven_Measurement_R126_UsesJnjPoundsUnit() => AssertUnit(126, "lbs.", 8739);
    [Fact] public void Build_Truven_Measurement_R128_UsesJnjCelsiusUnit() => AssertUnit(128, "C", 586323);

    [Fact]
    public void Build_Truven_Measurement_R130_LeavesNullUnitFieldsNull()
    {
        var measurement = AssertLab(130, s => s.AddLab(130, "2012-04-06", "56789-1", result: null, resunit: null));
        Assert.Null(measurement.UnitConceptId);
        Assert.Null(measurement.UnitSourceConceptId);
    }

    [Fact]
    public void Build_Truven_Measurement_R132_StripsPaddedWeightResult()
    {
        var measurement = AssertLab(132, s => s.AddLab(132, "2012-04-06", "29463-7", "1500000", "lbs."));
        Assert.Equal(150, measurement.ValueAsNumber);
        Assert.Equal(8739, measurement.UnitConceptId);
    }

    [Fact]
    public void Build_Truven_Measurement_R134_MapsReferenceRange()
    {
        var measurement = AssertLab(134, s => s.AddLab(134, "2012-12-20", "56784-2", refhigh: 10.8m, reflow: 1m));
        Assert.Equal(10.8m, measurement.RangeHigh);
        Assert.Equal(1m, measurement.RangeLow);
    }

    [Fact]
    public void Build_Truven_Measurement_R136_NormalizesUppercasePaddedWeightResult()
    {
        var measurement = AssertLab(136, s => s.AddLab(136, "2012-04-06", "29463-7", "1950000", "LBS"));
        Assert.Equal(195, measurement.ValueAsNumber);
        Assert.Equal(8739, measurement.UnitConceptId);
    }

    [Fact]
    public void Build_Truven_Measurement_R138_KeepsMeasurementOutsideObservationPeriod()
    {
        var measurement = AssertLab(138, s => s.AddLab(138, "2022-04-06", "29463-7", "1950000", "LBS"));
        Assert.Equal(new DateTime(2022, 4, 6), measurement.StartDate);
    }

    [Fact]
    public void Build_Truven_Measurement_R140_MapsHraWeight()
    {
        var s = Scenario(140);
        s.AddHealthRiskAssessment(140, "2012-07-16", weight: "201");
        var measurement = Assert.Single(s.Build(140).Data.Measurements.Where(x => x.SourceValue == "WEIGHT"));
        Assert.Equal(201, measurement.ValueAsNumber);
        Assert.Equal(new DateTime(2012, 7, 16), measurement.StartDate);
    }

    [Fact]
    public void Build_Truven_Measurement_R142_MapsHraBmiAsOnlyMeasurement()
    {
        var s = Scenario(142);
        s.AddHealthRiskAssessment(142, "2012-09-22", bmi: "28.6");
        var measurement = Assert.Single(s.Build(142).Data.Measurements);
        Assert.Equal("BMI", measurement.SourceValue);
        Assert.Equal(28.6m, measurement.ValueAsNumber);
        Assert.Equal(new DateTime(2012, 9, 22), measurement.StartDate);
    }

    private static void AssertAbnormal(long id, string source, long expected)
    {
        var measurement = AssertLab(id, s => s.AddLab(id, "2012-12-20", "56784-2", abnormal: source));
        Assert.Equal(expected, measurement.ValueAsConceptId);
    }

    private static void AssertUnit(long id, string source, long expected)
    {
        var measurement = AssertLab(id, s => s.AddLab(id, "2012-04-06", "56789-1", "100", source));
        Assert.Equal(expected, measurement.UnitConceptId);
    }

    private static org.ohdsi.cdm.framework.common.Omop.Measurement AssertLab(long id, Action<TruvenInMemoryScenario> add)
    {
        var s = Scenario(id);
        add(s);
        return Assert.Single(s.Build(id).Data.Measurements);
    }

    private static TruvenInMemoryScenario Scenario(long id)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2012-01-01", "2012-12-31");
        return s;
    }
}
