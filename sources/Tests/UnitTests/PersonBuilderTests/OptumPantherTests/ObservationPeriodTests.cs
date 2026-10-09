namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class ObservationPeriodTests
{
    [Fact]
    public void Build_OptumPanther_ObservationPeriod_R235_MergesSubsumedPatientDurations()
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(235, firstMonthActive: "201005", lastMonthActive: "201412");
        source.AddStandardPerson(235, firstMonthActive: "201006", lastMonthActive: "201411");
        source.AddEncounter(235, OptumPantherInMemoryScenario.EncounterId(236), interactionType: "Inpatient", interactionDate: "2009-01-01");
        Assert.Single(source.Build(235).Data.ObservationPeriods);
    }
}
