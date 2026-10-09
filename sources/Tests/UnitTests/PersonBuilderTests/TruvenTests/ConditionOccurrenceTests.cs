namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class ConditionOccurrenceTests
{
    [Fact]
    public void Build_Truven_ConditionOccurrence_R001_MapsTwoPrimaryDiagnoses()
    {
        var s = Scenario(1);
        s.AddInpatientServices(1, "2012-08-09", "2012-08-12", 2, pdx: "2500");
        s.AddInpatientAdmissions(1, 2, pdx: "0092");
        var data = s.Build(1).Data;
        Assert.Contains(data.ConditionOccurrences, x => x.ConceptId == 4008576 && x.TypeConceptId == 32854);
        Assert.Contains(data.ConditionOccurrences, x => x.ConceptId == 198337 && x.TypeConceptId == 32855);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R003_PreservesOutpatientAndFacilityDiagnoses()
    {
        var s = Scenario(3);
        s.AddOutpatientServices(3, "2012-10-16", "2012-10-16", 4, dx1: "1024");
        s.AddFacilityHeader(3, "2012-10-16", "2012-10-16", 4, dx9: "1024");
        var rows = s.Build(3).Data.ConditionOccurrences.Where(x => x.ConceptId == 433706).ToArray();
        Assert.Contains(rows, x => x.TypeConceptId == 32846 && x.StatusSourceValue == "DX1");
        Assert.Contains(rows, x => x.TypeConceptId == 32846 && x.StatusSourceValue == "DX9");
    }

    [Fact] public void Build_Truven_ConditionOccurrence_R005_MapsDx4() =>
        AssertCondition(5, s => s.AddInpatientServices(5, "2012-07-23", dx4: "57411"), 195587, 32854, "DX4");

    [Fact]
    public void Build_Truven_ConditionOccurrence_R007_MapsFacilityDx9()
    {
        var s = Scenario(7);
        s.AddInpatientServices(7, "2012-07-23", "2012-07-23", 8);
        s.AddFacilityHeader(7, "2012-07-23", "2012-07-23", 8, dx9: "4760");
        var c = Assert.Single(s.Build(7).Data.ConditionOccurrences.Where(x => x.ConceptId == 24970));
        Assert.Equal(32854, c.TypeConceptId);
        Assert.Equal("DX9", c.StatusSourceValue);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R009_ClassifiesEmergencyVisitAndDiagnoses()
    {
        var s = Scenario(9);
        s.AddInpatientServices(9, "2012-04-14", "2012-04-14", dx1: "57411", pdx: "4760", stdplac: "23", revcode: "0450");
        var data = s.Build(9).Data;
        Assert.Contains(data.VisitOccurrences, x => x.ConceptId == 9203);
        Assert.Contains(data.ConditionOccurrences, x => x.ConceptId == 195587 && x.TypeConceptId == 32854 && x.StatusSourceValue == "DX1");
        Assert.Contains(data.ConditionOccurrences, x => x.ConceptId == 24970 && x.TypeConceptId == 32854 && x.StatusSourceValue == "PDX");
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R011_RoutesDiagnosisToProcedure()
    {
        var s = Scenario(11);
        s.AddInpatientServices(11, "2012-10-15", "2012-10-17", pdx: "V5302");
        var data = s.Build(11).Data;
        Assert.Contains(data.ProcedureOccurrences, x => x.ConceptId == 4047347 && x.TypeConceptId == 32854);
        Assert.Contains(data.ProcedureOccurrences, x => x.ConceptId == 46272569 && x.TypeConceptId == 32854);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R013_RoutesDiagnosisToObservation()
    {
        var s = Scenario(13);
        s.AddInpatientServices(13, "2012-02-04", "2012-02-08", pdx: "E0152");
        Assert.Contains(s.Build(13).Data.Observations, x => x.ConceptId == 4117957 && x.TypeConceptId == 32854);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R015_RoutesDiagnosisToMeasurement()
    {
        var s = Scenario(15);
        s.AddInpatientServices(15, "2012-08-21", "2012-08-25", pdx: "V726");
        Assert.Contains(s.Build(15).Data.Measurements, x => x.ConceptId == 4034850 && x.TypeConceptId == 32854);
    }

    [Fact] public void Build_Truven_ConditionOccurrence_R017_UsesExplicitIcd10Version() =>
        AssertCondition(17, s => s.AddInpatientServices(17, "2012-08-09", "2012-08-12", dxver: "0", dx1: "S42241S"), 438021, 32854);

    [Fact]
    public void Build_Truven_ConditionOccurrence_R019_PrefersIcd10ObservationOverOverlappingCondition()
    {
        var s = Scenario(19);
        s.AddInpatientServices(19, "2012-08-09", "2012-08-12", dxver: "0", dx1: "V9001");
        var data = s.Build(19).Data;
        Assert.Contains(data.Observations, x => x.ConceptId == 4155106 && x.TypeConceptId == 32854);
        Assert.DoesNotContain(data.ConditionOccurrences, x => x.ConceptId == 46270117);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R021_InfersIcd10AfterCutover()
    {
        var s = Scenario(21, "2015-01-01", "2015-12-31");
        s.AddInpatientServices(21, "2015-11-09", "2015-11-12", dxver: "", dx1: "S42241S");
        Assert.Contains(s.Build(21).Data.ConditionOccurrences,
            x => x.ConceptId == 438021 && x.SourceConceptId == 45602528 && x.TypeConceptId == 32854);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R023_InfersIcd9BeforeCutover()
    {
        var s = Scenario(23);
        s.AddInpatientServices(23, "2012-08-09", "2012-08-12", dxver: "", dx1: "V9001");
        Assert.Contains(s.Build(23).Data.ConditionOccurrences,
            x => x.ConceptId == 46270117 && x.SourceConceptId == 44821630 && x.TypeConceptId == 32854);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R025_PreservesTwoServiceDates()
    {
        var s = Scenario(25);
        s.AddInpatientServices(25, "2012-07-01", "2012-07-01", dx4: "57411");
        s.AddInpatientServices(25, "2012-08-02", "2012-08-02", dx4: "57411");
        var rows = s.Build(25).Data.ConditionOccurrences.Where(x => x.ConceptId == 195587).ToArray();
        Assert.Contains(rows, x => x.StartDate == new DateTime(2012, 7, 1) && x.TypeConceptId == 32854);
        Assert.Contains(rows, x => x.StartDate == new DateTime(2012, 8, 2) && x.TypeConceptId == 32854);
    }

    [Fact] public void Build_Truven_ConditionOccurrence_R027_KeepsEventOutsideObservationPeriod() =>
        AssertCondition(27, s => s.AddInpatientServices(27, "2022-08-02", "2022-08-02", dx4: "57411"), 195587, 32854, start: "2022-08-02");

    [Fact]
    public void Build_Truven_ConditionOccurrence_R029_DefaultsEndDateToNull()
    {
        var s = Scenario(29);
        s.AddInpatientServices(29, "2022-08-03", dx4: "57411");
        var c = Assert.Single(s.Build(29).Data.ConditionOccurrences.Where(x => x.ConceptId == 195587));
        Assert.Equal(new DateTime(2022, 8, 3), c.StartDate);
        Assert.Null(c.EndDate);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R031_HraConditionHasNullEndDate()
    {
        var s = Scenario(31);
        s.AddHealthRiskAssessment(31, "2012-03-12", ccBackpain: "1");
        var c = Assert.Single(s.Build(31).Data.ConditionOccurrences.Where(x => x.ConceptId == 134736));
        Assert.Null(c.StatusConceptId);
        Assert.Equal(new DateTime(2012, 3, 12), c.StartDate);
        Assert.Null(c.EndDate);
    }

    [Fact]
    public void Build_Truven_ConditionOccurrence_R033_MapsSelfReportedAsthmaSource()
    {
        var s = Scenario(33);
        s.AddHealthRiskAssessment(33, "2012-09-13", ccAsthma: "1");
        var c = Assert.Single(s.Build(33).Data.ConditionOccurrences.Where(x => x.ConceptId == 317009));
        Assert.Equal("CC_ASTHMA", c.SourceValue);
        Assert.Null(c.StatusConceptId);
        Assert.Equal(new DateTime(2012, 9, 13), c.StartDate);
    }

    private static TruvenInMemoryScenario Scenario(long id, string start = "2012-01-01", string end = "2012-12-31")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, start, end);
        return s;
    }

    private static void AssertCondition(long id, Action<TruvenInMemoryScenario> add, long concept,
        long type, string? status = null, string? start = null)
    {
        var s = Scenario(id);
        add(s);
        var c = Assert.Single(s.Build(id).Data.ConditionOccurrences.Where(x => x.ConceptId == concept));
        Assert.Equal(type, c.TypeConceptId);
        if (status is not null) Assert.Equal(status, c.StatusSourceValue);
        if (start is not null) Assert.Equal(DateTime.Parse(start), c.StartDate);
    }
}
