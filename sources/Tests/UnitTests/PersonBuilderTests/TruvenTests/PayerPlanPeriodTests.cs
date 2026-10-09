namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class PayerPlanPeriodTests
{
    [Fact] public void Build_Truven_PayerPlanPeriod_R159_DropsEnrollmentWithoutPrescriptionBenefits() => AssertNoPlan(159);

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R160_PreservesPlansSeparatedByLongGap()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(160, "2013-01-01", "2013-01-31");
        s.AddEnrollmentDetail(160, "2013-05-01", "2013-05-31");
        var plans = s.Build(160).Data.PayerPlanPeriods.OrderBy(x => x.StartDate).ToArray();
        Assert.Equal(2, plans.Length);
        AssertPlan(plans[0], "2013-01-01", "2013-01-31", "N Commercial PPO");
        AssertPlan(plans[1], "2013-05-01", "2013-05-31", "N Commercial PPO");
    }

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R161_CombinesPlansSeparatedByShortGap()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(161, "2013-01-01", "2013-01-31");
        s.AddEnrollmentDetail(161, "2013-02-05", "2013-02-28");
        var plan = Assert.Single(s.Build(161).Data.PayerPlanPeriods);
        AssertPlan(plan, "2013-01-01", "2013-02-28", "N Commercial PPO");
    }

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R162_TruncatesOverlappingPlanSwitch()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(162, "2012-04-01", "2012-04-30", datatyp: "2", plantyp: "6");
        s.AddEnrollmentDetail(162, "2012-04-07", "2012-04-30", datatyp: "2", plantyp: "5");
        var plans = s.Build(162).Data.PayerPlanPeriods.OrderBy(x => x.StartDate).ToArray();
        AssertPlan(plans[0], "2012-04-01", "2012-04-06", "C Commercial PPO");
        AssertPlan(plans[1], "2012-04-07", "2012-04-30", "C Commercial POS");
    }

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R163_DerivesFamilySourceFromEnrolid()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(163, "2012-04-01", "2012-04-30", datatyp: "2", plantyp: "6");
        var plan = Assert.Single(s.Build(163).Data.PayerPlanPeriods);
        AssertPlan(plan, "2012-04-01", "2012-04-30", "C Commercial PPO");
        Assert.Equal("000000001", plan.FamilySourceValue);
    }

    [Fact] public void Build_Truven_PayerPlanPeriod_R164_DropsSecondEnrollmentWithoutPrescriptionBenefits() => AssertNoPlan(164);

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R165_MapsDataTypeOnePlanTypeOne()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(165, "2013-01-01", "2013-01-31", plantyp: "1", rx: "0");
        var plans = s.Build(165).Data.PayerPlanPeriods;
        Assert.DoesNotContain(plans, x => x.PayerSourceValue == "");
        Assert.Contains(plans, x => x.PayerSourceValue == "N Commercial Basic/Major Medical");
    }

    [Fact]
    public void Build_Truven_PayerPlanPeriod_R166_MapsDataTypeTwoPlanTypeTwo()
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(166, "2013-01-01", "2013-01-31", datatyp: "2", plantyp: "2", rx: "0");
        var plans = s.Build(166).Data.PayerPlanPeriods;
        Assert.DoesNotContain(plans, x => x.PayerSourceValue == "");
        Assert.Contains(plans, x => x.PayerSourceValue == "C Commercial Comprehensive");
    }

    private static void AssertNoPlan(long id)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2013-01-01", "2013-01-31", rx: "0");
        Assert.Empty(s.Build(id).Data.PayerPlanPeriods);
    }

    private static void AssertPlan(org.ohdsi.cdm.framework.common.Omop.PayerPlanPeriod plan,
        string start, string end, string payer)
    {
        Assert.Equal(DateTime.Parse(start), plan.StartDate);
        Assert.Equal(DateTime.Parse(end), plan.EndDate);
        Assert.Equal(payer, plan.PayerSourceValue);
    }
}
