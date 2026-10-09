namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class PayerPlanPeriodTests
{
    [Fact]
    public void Build_Premier_PayerPlanPeriod_R066_MergesFourVisitsIntoTwoPeriodsForOnePayer()
    {
        var s = ScenarioWithPayors();
        AddVisit(s, 66, "A", "2010-10-01", "2010-10-01", 360);
        AddVisit(s, 66, "B", "2010-10-01", "2010-11-01", 360);
        AddVisit(s, 66, "C", "2011-05-01", "2011-05-01", 360);
        AddVisit(s, 66, "D", "2011-05-01", "2011-05-11", 360);
        var r = s.Build(66);
        AssertPeriods(r,
            ("2010-10-01", "2010-11-01", "MANAGED CARE - NON-CAP"),
            ("2011-05-01", "2011-05-11", "MANAGED CARE - NON-CAP"));
    }

    [Fact]
    public void Build_Premier_PayerPlanPeriod_R071_KeepsTwoPayers()
    {
        var s = ScenarioWithPayors();
        AddVisit(s, 71, "A", "2010-10-01", "2010-10-01", 360);
        AddVisit(s, 71, "B", "2010-10-01", "2010-11-01", 360);
        AddVisit(s, 71, "C", "2011-05-01", "2011-05-01", 330);
        AddVisit(s, 71, "D", "2011-05-01", "2011-05-11", 330);
        var r = s.Build(71);
        AssertPeriods(r,
            ("2010-10-01", "2010-11-01", "MANAGED CARE - NON-CAP"),
            ("2011-05-01", "2011-05-11", "MEDICAID - TRADITIONAL"));
    }

    [Fact]
    public void Build_Premier_PayerPlanPeriod_R076_ClampsInvertedMergedPeriod()
    {
        var s = ScenarioWithPayors();
        AddVisit(s, 76, "A", "2013-03-01", "2013-03-01", 360);
        AddVisit(s, 76, "B", "2013-05-01", "2013-05-01", 360);
        AddVisit(s, 76, "C", "2014-01-01", "2014-05-01", 360, patbillCount: 2);
        AddVisit(s, 76, "D", "2014-02-01", "2014-07-01", 330);
        AddVisit(s, 76, "E", "2014-04-01", "2014-04-01", 330);
        var r = s.Build(76);
        AssertPeriods(r,
            ("2013-03-01", "2013-03-01", "MANAGED CARE - NON-CAP"),
            ("2013-05-01", "2013-05-01", "MANAGED CARE - NON-CAP"),
            ("2014-01-01", "2014-05-01", "MANAGED CARE - NON-CAP"),
            ("2014-05-02", "2014-05-02", "MEDICAID - TRADITIONAL"));
    }

    private static PremierInMemoryScenario ScenarioWithPayors()
    {
        var s = new PremierInMemoryScenario();
        s.AddPayor(360, "MANAGED CARE - NON-CAP");
        s.AddPayor(330, "MEDICAID - TRADITIONAL");
        s.AddPayor(300, "MEDICARE - TRADITIONAL");
        s.AddPayor(380, "COMMERCIAL - INDEMNITY");
        return s;
    }

    private static void AddVisit(
        PremierInMemoryScenario s,
        long personId,
        string suffix,
        string start,
        string end,
        int payer,
        int patbillCount = 1)
    {
        var key = $"P{personId}{suffix}";
        s.AddPat(personId, key, start, end, stdPayor: payer);
        for (var i = 0; i < patbillCount; i++) s.AddPatbill(key);
    }

    private static void AssertPeriods(
        PremierBuildResult result,
        params (string Start, string End, string Payer)[] expected)
    {
        var actual = result.Data.PayerPlanPeriods.OrderBy(x => x.StartDate).ToArray();
        Assert.Equal(expected.Length, actual.Length);
        for (var i = 0; i < expected.Length; i++)
        {
            Assert.Equal(DateTime.Parse(expected[i].Start), actual[i].StartDate);
            Assert.Equal(DateTime.Parse(expected[i].End), actual[i].EndDate);
            Assert.Equal(expected[i].Payer, actual[i].PayerSourceValue);
        }
    }
}
