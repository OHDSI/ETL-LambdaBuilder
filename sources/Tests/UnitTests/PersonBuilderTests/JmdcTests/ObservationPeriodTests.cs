namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ObservationPeriodTests
{
    [Fact]
    public void Build_Jmdc_ObservationPeriod_R201_ObservationPeriodPersonId()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000201");

        Assert.Equal(201L, Assert.Single(source.Build("M000000201").ObservationPeriods).PersonId);
    }

    [Fact]
    public void Build_Jmdc_ObservationPeriod_R202_ObservationPeriodStartDate()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000202", observationStart: "201001", observationEnd: "201212");

        Assert.Equal(new DateTime(2010, 1, 1),
            Assert.Single(source.Build("M000000202").ObservationPeriods).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ObservationPeriod_R203_ObservationPeriodEndDate()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000203", observationStart: "201001", observationEnd: "201412");

        Assert.Equal(new DateTime(2014, 12, 31),
            Assert.Single(source.Build("M000000203").ObservationPeriods).EndDate);
    }

    [Fact]
    public void Build_Jmdc_ObservationPeriod_R204_ObservationPeriodType()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000204", observationStart: "201001", observationEnd: "201412");

        Assert.Equal(32813L,
            Assert.Single(source.Build("M000000204").ObservationPeriods).TypeConceptId);
    }
}
