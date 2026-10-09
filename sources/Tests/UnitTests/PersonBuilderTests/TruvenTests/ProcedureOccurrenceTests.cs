namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_Truven_ProcedureOccurrence_R186_MapsPprocAndProc1()
    {
        var s = Scenario(186, "2000-01-01", "2000-12-31");
        s.AddInpatientServices(186, "2000-01-01", "2000-01-02", 187, pproc: "99238", proc1: "99221");
        var rows = s.Build(186).Data.ProcedureOccurrences;
        Assert.Contains(rows, x => x.ConceptId == 2514413 && x.StartDate == new DateTime(2000, 1, 1));
        Assert.Contains(rows, x => x.ConceptId == 2514404 && x.StartDate == new DateTime(2000, 1, 1));
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R188_MapsDetailAndHeaderPproc()
    {
        var s = Scenario(188);
        s.AddInpatientServices(188, "2012-06-11", "2012-06-12", 189, pproc: "65779");
        s.AddInpatientAdmissions(188, 189, admdate: "2012-06-11", pproc: "29914");
        var rows = s.Build(188).Data.ProcedureOccurrences;
        Assert.Contains(rows, x => x.ConceptId == 40757105 && x.StartDate == new DateTime(2012, 6, 11));
        Assert.Contains(rows, x => x.ConceptId == 40757126 && x.StartDate == new DateTime(2012, 6, 11));
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R190_KeepsProcedureOutsideObservationPeriod()
    {
        var s = Scenario(190);
        s.AddInpatientServices(190, "2022-06-11", "2022-06-12", 191, pproc: "65779");
        Assert.Contains(s.Build(190).Data.ProcedureOccurrences, x => x.StartDate == new DateTime(2022, 6, 11));
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R192_PreservesNullQuantity()
    {
        var s = Scenario(192);
        s.AddInpatientServices(192, "2022-05-15", "2022-05-17", 193, pproc: "65779", qty: null);
        Assert.Contains(s.Build(192).Data.ProcedureOccurrences,
            x => x.StartDate == new DateTime(2022, 5, 15) && x.Quantity is null);
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R194_PreservesDifferentProviders()
    {
        var s = Scenario(194);
        s.AddInpatientAdmissions(194, 195, admdate: "2012-10-20");
        s.AddInpatientServices(194, "2012-10-20", "2012-10-22", 195, proc1: "50760", provid: "3456789", stdprov: "220");
        s.AddInpatientServices(194, "2012-10-20", "2012-10-22", 195, proc1: "50760", provid: "1234567", stdprov: "540");
        Assert.Equal(2, s.Build(194).Data.ProcedureOccurrences.Count(x => x.ConceptId == 4021253 && x.StartDate == new DateTime(2012, 10, 20)));
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R196_MapsHcpcsModifier()
    {
        var s = Scenario(196);
        s.AddOutpatientServices(196, "2012-05-12", "2012-05-12", proc1: "C9727", procmod: "P1");
        Assert.Contains(s.Build(196).Data.ProcedureOccurrences,
            x => x.ConceptId == 4196153 && x.StartDate == new DateTime(2012, 5, 12) && x.ModifierConceptId == 4320556);
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R198_PreservesDuplicateProcedureAcrossTables()
    {
        var s = Scenario(198);
        s.AddOutpatientServices(198, "2012-02-15", "2012-02-15", 199, proc1: "54861");
        s.AddFacilityHeader(198, "2012-02-15", "2012-02-15", 199, proc1: "54861");
        Assert.Equal(2, s.Build(198).Data.ProcedureOccurrences.Count(x =>
            x.ConceptId == 4200063 && x.StartDate == new DateTime(2012, 2, 15) && x.TypeConceptId == 32846));
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R200_MapsFacilityHeaderProc5()
    {
        var s = Scenario(200);
        s.AddOutpatientServices(200, "2012-03-03", "2012-03-03", 201);
        s.AddFacilityHeader(200, "2012-03-03", "2012-03-03", 201, proc5: "93042");
        var rows = s.Build(200).Data.ProcedureOccurrences;
        Assert.Contains(rows, x => x.TypeConceptId == 32846);
        Assert.Contains(rows, x => x.ConceptId == 2313827 && x.TypeConceptId == 32846);
    }

    [Fact]
    public void Build_Truven_ProcedureOccurrence_R202_MapsAllFacilityProcedurePositions()
    {
        var s = Scenario(202);
        s.AddOutpatientServices(202, "2012-03-03", "2012-03-03", 203);
        s.AddFacilityHeader(202, "2012-03-03", "2012-03-03", 203,
            proc1: "96900", proc2: "97811", proc3: "92570", proc4: "92568", proc5: "97780", proc6: "0093U");
        var data = s.Build(202).Data;
        foreach (var concept in new long[] { 4180942, 2314322, 40757149, 42739018 })
            Assert.Contains(data.ProcedureOccurrences, x => x.ConceptId == concept && x.TypeConceptId == 32846);
        Assert.Contains(data.Measurements, x => x.ConceptId == 4167674 && x.TypeConceptId == 32846);
        Assert.Contains(data.Measurements, x => x.ConceptId == 709845 && x.TypeConceptId == 32846);
    }

    private static TruvenInMemoryScenario Scenario(long id, string start = "2012-01-01", string end = "2012-12-31")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, start, end);
        return s;
    }
}
