namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class VisitOccurrenceTests
{
    [Fact]
    public void Build_Truven_VisitOccurrence_R218_TrimsVisitDetailStartToObservationPeriod()
    {
        var s = Scenario(218);
        s.AddInpatientServices(218, "2011-12-05", "2012-01-06", 219);
        Assert.Contains(s.Build(218).Data.VisitDetails, x => x.StartDate == new DateTime(2012, 1, 1));
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R220_NormalizesEndBeforeStart()
    {
        var s = Scenario(220);
        s.AddInpatientServices(220, "2012-03-21", "2012-03-19");
        Assert.Contains(s.Build(220).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 3, 21) && x.EndDate == new DateTime(2012, 3, 21));
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R222_DoesNotTrimVisitEndToObservationPeriod()
    {
        var s = Scenario(222);
        s.AddInpatientServices(222, "2012-12-30", "2013-01-08");
        Assert.Contains(s.Build(222).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 12, 30) && x.EndDate == new DateTime(2013, 1, 8));
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R224_MapsPlace23VisitDetail()
    {
        var s = Scenario(224);
        s.AddInpatientServices(224, "2012-04-12", "2012-04-12", stdplac: "23");
        Assert.Contains(s.Build(224).Data.VisitDetails,
            x => x.StartDate == new DateTime(2012, 4, 12) && x.ConceptId == 8870);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R226_SetsPrecedingVisitOccurrenceId()
    {
        var s = Scenario(226);
        s.AddInpatientServices(226, "2012-08-08", "2012-08-12");
        s.AddInpatientServices(226, "2012-10-01", "2012-10-05");
        var visits = s.Build(226).Data.VisitOccurrences.OrderBy(x => x.StartDate).ToArray();
        Assert.Equal(visits[0].Id, visits[1].PrecedingVisitOccurrenceId);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R228_KeepsSeparatedInpatientVisits()
    {
        var s = Scenario(228);
        s.AddInpatientServices(228, "2012-08-08", "2012-08-12");
        s.AddInpatientServices(228, "2012-10-01", "2012-10-05");
        var visits = s.Build(228).Data.VisitOccurrences;
        Assert.Contains(visits, x => x.StartDate == new DateTime(2012, 8, 8) && x.EndDate == new DateTime(2012, 8, 12));
        Assert.Contains(visits, x => x.StartDate == new DateTime(2012, 10, 1) && x.EndDate == new DateTime(2012, 10, 5));
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R230_CombinesEmergencyAndInpatientVisit()
    {
        var s = Scenario(230);
        s.AddInpatientServices(230, "2012-09-03", "2012-09-03", stdplac: "23");
        s.AddInpatientServices(230, "2012-09-03", "2012-09-10", revcode: "0100");
        Assert.Contains(s.Build(230).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 9, 3) && x.EndDate == new DateTime(2012, 9, 10) && x.ConceptId == 262);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R232_CollapsesAdjacentInpatientLines()
    {
        var s = Scenario(232);
        s.AddInpatientServices(232, "2012-05-15", "2012-05-16");
        s.AddInpatientServices(232, "2012-05-16", "2012-05-17");
        Assert.Contains(s.Build(232).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 5, 15) && x.EndDate == new DateTime(2012, 5, 17));
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R234_MapsDischargeStatus()
    {
        var s = Scenario(234);
        s.AddInpatientServices(234, "2012-03-21", "2012-03-19", dstatus: "01");
        Assert.Contains(s.Build(234).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 3, 21) && x.EndDate == new DateTime(2012, 3, 21) && x.DischargeToConceptId == 581476);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R236_KeepsVisitOutsideObservationPeriod()
    {
        var s = Scenario(236);
        s.AddInpatientServices(236, "2022-03-21", "2022-03-19", dstatus: "01");
        Assert.Contains(s.Build(236).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2022, 3, 21) && x.EndDate == new DateTime(2022, 3, 21) && x.DischargeToConceptId == 581476);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R238_DropsVisitWithoutPrescriptionBenefits()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(238, "2012-01-01", "2012-12-31", rx: "0");
        s.AddOutpatientServices(238, "2012-01-06", "2012-01-06", 239);
        Assert.Empty(s.Build(238).Data.VisitOccurrences);
    }

    [Fact]
    public void Build_Truven_VisitOccurrence_R240_CollapsesProviderVariantsWithinVisit()
    {
        var s = Scenario(240);
        s.AddInpatientServices(240, "2012-08-08", "2012-08-12", provid: "242", stdprov: "220");
        s.AddInpatientServices(240, "2012-08-08", "2012-08-12", provid: "243", stdprov: "540");
        Assert.Contains(s.Build(240).Data.VisitOccurrences,
            x => x.StartDate == new DateTime(2012, 8, 8) && x.EndDate == new DateTime(2012, 8, 12));
    }

    private static TruvenInMemoryScenario Scenario(long id)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2012-01-01", "2012-12-31");
        return s;
    }
}
