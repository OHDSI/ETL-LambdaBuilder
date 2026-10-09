namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class PayerPlanPeriodTests
{
    [Fact]
    public void Build_OptumExtended_PayerPlanPeriod_R301_KeepsTwoPlansInSameWindow()
    {
        const long personId = 301;
        var source = Continuous(personId, "2000-10-01", "2000-10-31");
        source.AddMemberEnrollment(personId, "2000-10-01", "2000-10-31", product: "HMO", healthExchange: "0");
        source.AddMemberEnrollment(personId, "2000-10-01", "2000-10-31", product: "EPO", healthExchange: "0", aso: "Y");

        var periods = source.Build(personId).Data.PayerPlanPeriods;

        Assert.Equal(2, periods.Count);
        Assert.All(periods, period =>
        {
            Assert.Equal(new DateTime(2000, 10, 1), period.StartDate);
            Assert.Equal(new DateTime(2000, 10, 31), period.EndDate);
        });
    }

    [Theory]
    [InlineData(302, "MCR", "0", 281, "MCR0")]
    [InlineData(303, "COM", "0", 327, "COM0")]
    [InlineData(304, "COM", "3", 276, "COM3")]
    [InlineData(305, "COM", "1", 275, "COM1")]
    [InlineData(306, "UNK", "0", 0, "UNK0")]
    [InlineData(307, "NONE", "2", 276, "NONE2")]
    public void Build_OptumExtended_PayerPlanPeriod_R302_R307_MapsPayer(
        long personId,
        string business,
        string exchange,
        long expectedConcept,
        string expectedSource)
    {
        var source = Continuous(personId, "2000-05-01", "2006-05-31");
        source.AddMemberEnrollment(personId, "2000-05-01", "2006-05-31", bus: business, healthExchange: exchange);

        var period = Assert.Single(source.Build(personId).Data.PayerPlanPeriods);

        Assert.Equal(expectedConcept, period.PayerConceptId);
        Assert.Equal(expectedSource, period.PayerSourceValue);
    }

    [Theory]
    [InlineData(308, "HMO", "HMO3")]
    [InlineData(309, "PPO", "PPO3")]
    [InlineData(310, "OTH", "OTH3")]
    [InlineData(311, "POS", "POS3")]
    public void Build_OptumExtended_PayerPlanPeriod_R308_R311_MapsPlan(
        long personId,
        string product,
        string expectedSource)
    {
        var source = Continuous(personId, "2000-05-01", "2006-06-30");
        source.AddMemberEnrollment(personId, "2000-05-01", "2006-06-30", product: product, cdhp: 3);

        Assert.Equal(expectedSource, Assert.Single(source.Build(personId).Data.PayerPlanPeriods).PlanSourceValue);
    }

    [Fact]
    public void Build_OptumExtended_PayerPlanPeriod_R312_CollapsesPeriodsWithSamePayerAndPlan()
    {
        const long personId = 312;
        var source = Continuous(personId, "2000-05-01", "2004-10-31");
        source.AddMemberEnrollment(personId, "2000-05-01", "2000-10-31", bus: "COM", healthExchange: "0", product: "HMO");
        source.AddMemberEnrollment(personId, "2000-12-01", "2004-08-31", bus: "COM", healthExchange: "0", product: "HMO");

        Assert.Single(source.Build(personId).Data.PayerPlanPeriods);
    }

    private static OptumExtendedInMemoryScenario Continuous(long personId, string start, string end)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddContinuousEnrollment(personId, start, end, "M", 1969);
        return source;
    }
}
