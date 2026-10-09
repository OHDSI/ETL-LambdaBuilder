namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class ObservationTests
{
    [Fact]
    public void Build_Premier_Observation_R050_MapsCpt4()
    {
        var r = BuildCpt(50, "2010-10-01", "0581F");
        AssertObservation(r, "P50", 44816517, "2010-10-01");
    }

    [Fact]
    public void Build_Premier_Observation_R052_MapsHcpcs()
    {
        var r = BuildCpt(52, "2012-11-01", "G8997");
        AssertObservation(r, "P52", 43533318, "2012-11-01");
    }

    [Fact]
    public void Build_Premier_Observation_R054_MapsStdChargeAndCombinedSource()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(54, "P54", "2009-07-01", "2009-07-01");
        s.AddPatbill("P54", 300301800060000, -882725);
        s.AddHospchg(-882725, "I-STAT (6+ PANEL)");
        s.AddChgmstr(300301800060000, "*6 CLINICAL CHEMISTRY TESTS");
        var r = s.Build(54);
        var o = AssertObservation(r, "P54", 4148655, "2009-07-01");
        Assert.Equal("*6 CLINICAL CHEMISTRY TESTS / I-STAT (6+ PANEL)", o.SourceValue);
    }

    [Fact]
    public void Build_Premier_Observation_R056_MapsPaticdProcIcd9()
    {
        var r = BuildProcedureCode(56, "2008-05-01", "E826", 9);
        var o = AssertObservation(r, "P56", 443423, "2008-05-01");
        Assert.Equal("E826", o.SourceValue);
    }

    [Fact]
    public void Build_Premier_Observation_R058_MapsPaticdProcIcd10()
    {
        var r = BuildProcedureCode(58, "2008-10-01", "V80.02", 10);
        var o = AssertObservation(r, "P58", 4067275, "2008-10-01");
        Assert.Equal("V80.02", o.SourceValue);
    }

    [Fact]
    public void Build_Premier_Observation_R060_MapsPaticdDiagIcd9()
    {
        var r = BuildDiagnosis(60, "2005-12-01", "E872.9", 9);
        var o = AssertObservation(r, "P60", 439633, "2005-12-01");
        Assert.Equal("E872.9", o.SourceValue);
    }

    [Fact]
    public void Build_Premier_Observation_R062_MapsPaticdDiagIcd10()
    {
        var r = BuildDiagnosis(62, "2004-12-01", "T71.131", 10);
        var o = AssertObservation(r, "P62", 439470, "2004-12-01");
        Assert.Equal("T71.131", o.SourceValue);
    }

    [Fact]
    public void Build_Premier_Observation_R064_MapsStdChargeCode()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(64, "P64", "2004-12-01", "2004-12-01");
        s.AddPatbill("P64", 999999040442008);
        var r = s.Build(64);
        AssertObservation(r, "P64", 2108550, "2004-12-01");
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

    private static PremierBuildResult BuildProcedureCode(long personId, string date, string code, int version)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, date, date);
        s.AddPatbill(key);
        s.AddPaticdProc(key, code, version);
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

    private static org.ohdsi.cdm.framework.common.Omop.Observation AssertObservation(
        PremierBuildResult result,
        string patKey,
        long conceptId,
        string date)
    {
        var observation = Assert.Single(result.Data.Observations.Where(x => x.ConceptId == conceptId));
        Assert.Equal(DateTime.Parse(date), observation.StartDate);
        Assert.Equal(result.Visit(patKey).Id, observation.VisitOccurrenceId);
        return observation;
    }
}
