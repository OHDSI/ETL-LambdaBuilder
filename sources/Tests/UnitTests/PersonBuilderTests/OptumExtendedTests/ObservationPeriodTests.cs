namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ObservationPeriodTests
{
    [Fact]
    public void Build_OptumExtended_ObservationPeriod_R201_CollapsesSubsumedEnrollment()
    {
        var source = Scenario(201,
            ("2000-05-01", "2008-12-31"),
            ("2000-05-01", "2008-02-29"));

        var period = Assert.Single(source.Build(201).Data.ObservationPeriods);

        Assert.Equal(new DateTime(2000, 5, 1), period.StartDate);
        Assert.Equal(new DateTime(2008, 12, 31), period.EndDate);
    }

    [Fact]
    public void Build_OptumExtended_ObservationPeriod_R202_CollapsesEnrollmentWithinThirtyTwoDayGap()
    {
        var source = Scenario(202,
            ("2000-05-01", "2005-12-31"),
            ("2006-01-29", "2011-12-31"));

        var period = Assert.Single(source.Build(202).Data.ObservationPeriods);

        Assert.Equal(new DateTime(2000, 5, 1), period.StartDate);
        Assert.Equal(new DateTime(2011, 12, 31), period.EndDate);
    }

    [Fact]
    public void Build_OptumExtended_ObservationPeriod_R203_KeepsPeriodsSeparatedByMoreThanThirtyThreeDays()
    {
        var source = Scenario(203,
            ("2001-04-01", "2006-12-31"),
            ("2000-05-01", "2000-12-31"));

        var periods = source.Build(203).Data.ObservationPeriods.OrderBy(item => item.StartDate).ToArray();

        Assert.Equal(2, periods.Length);
        Assert.Equal(new DateTime(2000, 5, 1), periods[0].StartDate);
        Assert.Equal(new DateTime(2000, 12, 31), periods[0].EndDate);
        Assert.Equal(new DateTime(2001, 4, 1), periods[1].StartDate);
        Assert.Equal(new DateTime(2006, 12, 31), periods[1].EndDate);
    }

    private static OptumExtendedInMemoryScenario Scenario(long personId, params (string Start, string End)[] periods)
    {
        var source = new OptumExtendedInMemoryScenario();
        foreach (var period in periods)
        {
            source.AddContinuousEnrollment(personId, period.Start, period.End, "F", 1969);
            source.AddMemberEnrollment(personId, period.Start, period.End);
        }
        return source;
    }
}
