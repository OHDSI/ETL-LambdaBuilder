namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class ConditionEraTests
{
    [Fact]
    public void Build_Truven_ConditionEra_R035_DoesNotCreateEraForConceptZero()
    {
        var s = Scenario(35);
        s.AddInpatientServices(35, "2012-04-21", "2012-04-22", dxver: "0", pdx: "71978", dx1: "71978");
        Assert.Empty(s.Build(35).Data.ConditionEra);
    }

    [Fact]
    public void Build_Truven_ConditionEra_R037_CombinesOccurrencesWithinThirtyDays()
    {
        var s = Scenario(37);
        s.AddOutpatientServices(37, "2012-07-01", dx1: "37613");
        s.AddOutpatientServices(37, "2012-07-12", dx1: "37613");
        var era = Assert.Single(s.Build(37).Data.ConditionEra);
        Assert.Equal(new DateTime(2012, 7, 1), era.StartDate);
        Assert.Equal(new DateTime(2012, 7, 12), era.EndDate);
    }

    [Fact]
    public void Build_Truven_ConditionEra_R039_SplitsOccurrencesMoreThanThirtyDaysApart()
    {
        var s = Scenario(39, "2013-12-31");
        s.AddOutpatientServices(39, "2012-07-01", dx1: "37613");
        s.AddOutpatientServices(39, "2012-08-12", dx1: "37613");
        var starts = s.Build(39).Data.ConditionEra.Select(x => x.StartDate).OrderBy(x => x).ToArray();
        Assert.Equal([new DateTime(2012, 7, 1), new DateTime(2012, 8, 12)], starts);
    }

    private static TruvenInMemoryScenario Scenario(long id, string end = "2012-12-31")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2012-01-01", end);
        return s;
    }
}
