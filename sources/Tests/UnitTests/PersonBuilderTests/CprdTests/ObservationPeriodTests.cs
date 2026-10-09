namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ObservationPeriodTests
{
    [Fact]
    public void Build_Cprd_ObservationPeriod_R47222_UsesUtsAndTod()
    {
        var period = Period(47222, "2000-10-26", "2010-01-01");
        Assert.Equal(CprdRAssert.Date("2001-02-12"), period.StartDate);
        Assert.Equal(CprdRAssert.Date("2010-01-01"), period.EndDate);
    }

    [Fact]
    public void Build_Cprd_ObservationPeriod_R48222_UsesCrdAndLcd()
    {
        var period = Period(48222, "2005-10-26", null);
        Assert.Equal(CprdRAssert.Date("2005-10-26"), period.StartDate);
        Assert.Equal(CprdRAssert.Date("2011-11-11"), period.EndDate);
    }

    [Fact]
    public void Build_Cprd_ObservationPeriod_R49222_DropsTodBeforeUts()
    {
        const long id = 49222;
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, yob: 169, crd: "2000-10-26", tod: "1997-01-01", pracid: 222);
        Assert.Empty(s.Build(id).Data.ObservationPeriods);
    }

    private static org.ohdsi.cdm.framework.common.Omop.ObservationPeriod Period(long id, string crd, string? tod)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, yob: 169, crd: crd, tod: tod, pracid: 222);
        return Assert.Single(s.Build(id).Data.ObservationPeriods);
    }
}
