namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class VisitOccurrenceTests
{
    [Fact]
    public void Build_Premier_VisitOccurrence_R150_CreatesFourVisitsWithSourceDates()
    {
        var s = new PremierInMemoryScenario();
        AddVisit(s, 150, "A", "2010-10-01", "2010-10-01");
        AddVisit(s, 150, "B", "2010-10-01", "2010-11-01");
        AddVisit(s, 150, "C", "2011-05-01", "2011-05-01");
        AddVisit(s, 150, "D", "2011-05-01", "2011-05-01");
        var r = s.Build(150);
        Assert.Equal(4, r.Data.VisitOccurrences.Count);
        AssertVisit(r, "P150A", "2010-10-01", "2010-10-01");
        AssertVisit(r, "P150B", "2010-10-01", "2010-11-01");
        AssertVisit(r, "P150C", "2011-05-01", "2011-05-01");
        AssertVisit(r, "P150D", "2011-05-01", "2011-05-01");
    }

    [Fact] public void Build_Premier_VisitOccurrence_R155_MapsPointOfOrigin0() => AssertOrigin(155, "0", 8976);
    [Fact] public void Build_Premier_VisitOccurrence_R157_MapsPointOfOrigin1() => AssertOrigin(157, "1", 8844);
    [Fact] public void Build_Premier_VisitOccurrence_R159_MapsPointOfOrigin2() => AssertOrigin(159, "2", 8716);
    [Fact] public void Build_Premier_VisitOccurrence_R161_MapsPointOfOrigin3() => AssertOrigin(161, "3", 8844);
    [Fact] public void Build_Premier_VisitOccurrence_R163_MapsPointOfOrigin4() => AssertOrigin(163, "4", 8717);
    [Fact] public void Build_Premier_VisitOccurrence_R165_MapsPointOfOrigin45() => AssertOrigin(165, "45", 581384);
    [Fact] public void Build_Premier_VisitOccurrence_R167_MapsPointOfOrigin46() => AssertOrigin(167, "46", 8650);
    [Fact] public void Build_Premier_VisitOccurrence_R169_MapsPointOfOrigin5() => AssertOrigin(169, "5", 8863);
    [Fact] public void Build_Premier_VisitOccurrence_R171_MapsPointOfOrigin6() => AssertOrigin(171, "6", 8844);
    [Fact] public void Build_Premier_VisitOccurrence_R173_MapsPointOfOrigin7() => AssertOrigin(173, "7", 8870);
    [Fact] public void Build_Premier_VisitOccurrence_R175_MapsPointOfOrigin8() => AssertOrigin(175, "8", 8844);
    [Fact] public void Build_Premier_VisitOccurrence_R177_MapsPointOfOrigin9() => AssertOrigin(177, "9", 8844);
    [Fact] public void Build_Premier_VisitOccurrence_R179_MapsPointOfOriginA() => AssertOrigin(179, "A", 8761);
    [Fact] public void Build_Premier_VisitOccurrence_R181_MapsPointOfOriginB() => AssertOrigin(181, "B", 8536);
    [Fact] public void Build_Premier_VisitOccurrence_R183_MapsPointOfOriginC() => AssertOrigin(183, "C", 8536);
    [Fact] public void Build_Premier_VisitOccurrence_R185_MapsPointOfOriginD() => AssertOrigin(185, "D", 8717);
    [Fact] public void Build_Premier_VisitOccurrence_R187_MapsPointOfOriginE() => AssertOrigin(187, "E", 8883);
    [Fact] public void Build_Premier_VisitOccurrence_R189_MapsPointOfOriginF() => AssertOrigin(189, "F", 8546);

    [Fact]
    public void Build_Premier_VisitOccurrence_R191_MapsPre2010ErToInpatient()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(191, "P191", "2005-01-01", pointOfOrigin: "7", iOInd: "I");
        Assert.Equal(262, s.Build(191).Visit("P191").ConceptId);
    }

    [Fact]
    public void Build_Premier_VisitOccurrence_R193_MapsPost2010ErToInpatient()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(193, "P193", "2013-01-01", pointOfOrigin: "7", iOInd: "I");
        Assert.Equal(262, s.Build(193).Visit("P193").ConceptId);
    }

    private static void AddVisit(PremierInMemoryScenario s, long personId, string suffix, string start, string end)
    {
        var key = $"P{personId}{suffix}";
        s.AddPat(personId, key, start, end);
        s.AddPatbill(key);
    }

    private static void AssertVisit(PremierBuildResult result, string key, string start, string end)
    {
        var visit = result.Visit(key);
        Assert.Equal(DateTime.Parse(start), visit.StartDate);
        Assert.Equal(DateTime.Parse(end), visit.EndDate);
    }

    private static void AssertOrigin(long personId, string source, long expectedConceptId)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, pointOfOrigin: source);
        var visit = s.Build(personId).Visit(key);
        Assert.Equal(source, visit.AdmittingSourceValue);
        Assert.Equal(expectedConceptId, visit.AdmittingSourceConceptId);
    }
}
