namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class MeasurementTests
{
    [Fact]
    public void Build_Premier_Measurement_R036_MapsCpt4()
    {
        var r = BuildCpt(36, "2004-11-01", "81003");
        AssertMeasurement(r, "P36", 2212168, "2004-11-01", "81003");
    }

    [Fact]
    public void Build_Premier_Measurement_R038_MapsHcpcs()
    {
        var r = BuildCpt(38, "2012-08-01", "G0432");
        AssertMeasurement(r, "P38", 40664440, "2012-08-01", "G0432");
    }

    [Fact]
    public void Build_Premier_Measurement_R040_MapsStdChargeAndCombinedSource()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(40, "P40", "2013-07-01", "2013-07-01");
        s.AddPatbill("P40", 300305856520000, -999);
        s.AddHospchg(-999, "SEDIMENTATION RATE");
        s.AddChgmstr(300305856520000, "SED RATE RBC AUTO");
        var r = s.Build(40);
        AssertMeasurement(r, "P40", 4016246, "2013-07-01", "SED RATE RBC AUTO / SEDIMENTATION RATE");
    }

    [Fact]
    public void Build_Premier_Measurement_R042_MapsPaticdDiagIcd9()
    {
        var r = BuildDiagnosis(42, "2009-12-01", "796.0", 9);
        AssertMeasurement(r, "P42", 4195512, "2009-12-01", "796.0");
    }

    [Fact]
    public void Build_Premier_Measurement_R044_MapsPaticdDiagIcd10()
    {
        var r = BuildDiagnosis(44, "2009-10-01", "Z01.83", 10);
        AssertMeasurement(r, "P44", 4258677, "2009-10-01", "Z01.83");
    }

    [Fact]
    public void Build_Premier_Measurement_R046_ProducesProcedureAndTwoOperationTimeObservations()
    {
        const long major = 900000000000010;
        const long minor = 900000000000011;
        var s = new PremierInMemoryScenario();
        s.AddPat(46, "P46", "2010-01-01", "2010-01-05");
        s.AddPatbill("P46", major, -11325652, stdQty: 1);
        s.AddPatbill("P46", minor, -11395900, stdQty: 4);
        s.AddPaticdProc("P46", "33.51", 9);
        s.AddChgmstr(major, "OR MAJOR 2 HR 30 MIN", "SURGERY TIME");
        s.AddChgmstr(minor, "OR MINOR ADDL 30 MIN", "SURGERY TIME");
        s.AddHospchg(-11325652, "OR TIME 151-180 MIN LEV I");
        s.AddHospchg(-11395900, "OR TIME-ADDL 30MIN L1-IP");

        var r = s.Build(46);
        var procedure = Assert.Single(r.Data.ProcedureOccurrences.Where(x => x.ConceptId == 4337611));
        Assert.Equal(new DateTime(2010, 1, 5), procedure.StartDate);
        Assert.Equal("33.51", procedure.SourceValue);
        var operationTimes = r.Data.Observations.Where(x => x.ConceptId == 3016562).ToArray();
        Assert.Equal(2, operationTimes.Length);
        Assert.All(operationTimes, o =>
        {
            Assert.Equal(new DateTime(2010, 1, 1), o.StartDate);
            Assert.Equal(32875, o.TypeConceptId);
            Assert.Equal(r.Visit("P46").Id, o.VisitOccurrenceId);
        });
    }

    [Fact]
    public void Build_Premier_Measurement_R048_WrongDayOperationTimeCreatesNoMeasurement()
    {
        const long major = 900000000000010;
        const long minor = 900000000000011;
        var s = new PremierInMemoryScenario();
        s.AddPat(48, "P48", "2010-01-01", "2010-01-01");
        s.AddPatbill("P48", major, stdQty: 1);
        s.AddPatbill("P48", minor, stdQty: 4);
        s.AddPaticdProc("P48", "33.51", 9);
        var r = s.Build(48);
        Assert.Empty(r.Data.Measurements);
    }

    private static PremierBuildResult BuildCpt(long personId, string date, string code)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, date, date);
        s.AddPatbill(key);
        s.AddPatcpt(key, code);
        return s.Build(personId);
    }

    private static PremierBuildResult BuildDiagnosis(long personId, string date, string code, int version)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, date, date);
        s.AddPatbill(key);
        s.AddPaticdDiag(key, code, version);
        return s.Build(personId);
    }

    private static void AssertMeasurement(
        PremierBuildResult result,
        string patKey,
        long conceptId,
        string date,
        string source)
    {
        var measurement = Assert.Single(result.Data.Measurements.Where(x => x.ConceptId == conceptId));
        Assert.Equal(DateTime.Parse(date), measurement.StartDate);
        Assert.Equal(source, measurement.SourceValue);
        Assert.Equal(result.Visit(patKey).Id, measurement.VisitOccurrenceId);
    }
}
