namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_Premier_ProcedureOccurrence_R114_MapsStdChargeCode()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(114, "P114", "2011-07-01", "2011-07-01");
        s.AddPatbill("P114", 360360206110000);
        AssertProcedure(s.Build(114), "P114", 46257707, "2011-07-01");
    }

    [Fact] public void Build_Premier_ProcedureOccurrence_R116_MapsPaticdProcIcd9Cm() => AssertIcd(116, "2014-10-01", "V55.1", 9, 4125153);
    [Fact] public void Build_Premier_ProcedureOccurrence_R118_MapsPaticdProcIcd9Proc() => AssertIcd(118, "2013-04-01", "26.31", 9, 4239779);
    [Fact] public void Build_Premier_ProcedureOccurrence_R120_MapsPaticdProcIcd10Cm() => AssertIcd(120, "2004-03-01", "Z05.1", 19, 44789514);
    [Fact] public void Build_Premier_ProcedureOccurrence_R122_MapsPaticdProcIcd10Pcs() => AssertIcd(122, "2002-02-01", "0SG33KJ", 10, 2771840);

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R124_DoesNotMapIcd10PcsHierarchy()
    {
        var s = Basic(124);
        s.AddPaticdProc("P124", "0CN83Z", 10);
        Assert.Empty(s.Build(124).Data.ProcedureOccurrences);
    }

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R126_MapsHcpcs()
    {
        var r = BuildCpt(126, "2001-01-01", "S2325");
        AssertProcedure(r, "P126", 40489502, "2001-01-01");
    }

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R128_MapsCpt4()
    {
        var r = BuildCpt(128, "2013-03-01", "01210");
        AssertProcedure(r, "P128", 2101632, "2013-03-01");
    }

    [Fact] public void Build_Premier_ProcedureOccurrence_R130_DoesNotMapCptModifier() => AssertNoCptProcedure(130, "1P");
    [Fact] public void Build_Premier_ProcedureOccurrence_R132_ExcludesCptMeasurement() => AssertNoCptProcedure(132, "81003");
    [Fact] public void Build_Premier_ProcedureOccurrence_R134_ExcludesHcpcsMeasurement() => AssertNoCptProcedure(134, "G0432");

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R136_ExcludesStdChargeMeasurement()
    {
        var s = Basic(136);
        s.AddPatbill("P136", 300305856520000);
        Assert.Empty(s.Build(136).Data.ProcedureOccurrences);
    }

    [Fact] public void Build_Premier_ProcedureOccurrence_R138_ExcludesIcd9Measurement() => AssertNoDiagnosisProcedure(138, "V85.42", 9);
    [Fact] public void Build_Premier_ProcedureOccurrence_R140_ExcludesIcd10Measurement() => AssertNoDiagnosisProcedure(140, "Z68.3", 10);
    [Fact] public void Build_Premier_ProcedureOccurrence_R142_NormalizesPrimaryTypeToProviderFinancialSystem() => AssertProcedureType(142, "P");
    [Fact] public void Build_Premier_ProcedureOccurrence_R144_NormalizesSecondaryTypeToProviderFinancialSystem() => AssertProcedureType(144, "S");

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R146_MapsStdQuantity()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(146, "P146", "2002-02-01", "2002-02-01");
        s.AddPatbill("P146", 360360206110000, stdQty: 3);
        var r = s.Build(146);
        var p = AssertProcedure(r, "P146", 46257707, "2002-02-01");
        Assert.Equal(3, p.Quantity);
    }

    [Fact]
    public void Build_Premier_ProcedureOccurrence_R148_RoutesUnmappedStdChargeToObservation()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(148, "P148", "2002-02-01", "2002-02-01");
        s.AddPatbill("P148", 270270019860000, stdQty: 3);
        var r = s.Build(148);
        var observation = Assert.Single(r.Data.Observations.Where(x => x.ConceptId == 0));
        Assert.Equal(new DateTime(2002, 2, 1), observation.StartDate);
        Assert.Equal(r.Visit("P148").Id, observation.VisitOccurrenceId);
    }

    private static PremierInMemoryScenario Basic(long personId)
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, $"P{personId}");
        return s;
    }

    private static void AssertIcd(long personId, string date, string code, int version, long concept)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, date, date);
        s.AddPatbill(key);
        s.AddPaticdProc(key, code, version);
        var procedure = AssertProcedure(s.Build(personId), key, concept, date);
        Assert.Equal(code, procedure.SourceValue);
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

    private static void AssertNoCptProcedure(long personId, string code)
    {
        var s = Basic(personId);
        s.AddPatcpt($"P{personId}", code);
        Assert.Empty(s.Build(personId).Data.ProcedureOccurrences);
    }

    private static void AssertNoDiagnosisProcedure(long personId, string code, int version)
    {
        var s = Basic(personId);
        s.AddPaticdDiag($"P{personId}", code, version);
        Assert.Empty(s.Build(personId).Data.ProcedureOccurrences);
    }

    private static void AssertProcedureType(long personId, string source)
    {
        var s = Basic(personId);
        s.AddPaticdProc($"P{personId}", "86.28", icdPriSec: source);
        var p = Assert.Single(s.Build(personId).Data.ProcedureOccurrences.Where(x => x.SourceValue == "86.28"));
        Assert.Equal(32875, p.TypeConceptId);
    }

    private static org.ohdsi.cdm.framework.common.Omop.ProcedureOccurrence AssertProcedure(
        PremierBuildResult result,
        string patKey,
        long conceptId,
        string date)
    {
        var procedure = Assert.Single(result.Data.ProcedureOccurrences.Where(x => x.ConceptId == conceptId));
        Assert.Equal(DateTime.Parse(date), procedure.StartDate);
        Assert.Equal(result.Visit(patKey).Id, procedure.VisitOccurrenceId);
        return procedure;
    }
}
