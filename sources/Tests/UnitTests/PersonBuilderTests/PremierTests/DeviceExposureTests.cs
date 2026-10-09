namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class DeviceExposureTests
{
    [Fact]
    public void Build_Premier_DeviceExposure_R023_MapsStdChargeCode()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(23, "P23", "2011-11-01", "2011-11-01");
        s.AddPatbill("P23", 270270056010000);
        var r = s.Build(23);
        var d = Assert.Single(r.Data.DeviceExposure.Where(x => x.ConceptId == 4063122));
        Assert.Equal(new DateTime(2011, 11, 1), d.StartDate);
        Assert.Equal(r.Visit("P23").Id, d.VisitOccurrenceId);
    }

    [Fact]
    public void Build_Premier_DeviceExposure_R025_MapsHcpcs()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(25, "P25", "2012-04-01", "2012-04-01");
        s.AddPatbill("P25");
        s.AddPatcpt("P25", "V5245");
        var r = s.Build(25);
        var d = Assert.Single(r.Data.DeviceExposure.Where(x => x.ConceptId == 2721945));
        Assert.Equal(new DateTime(2012, 4, 1), d.StartDate);
        Assert.Equal("V5245", d.SourceValue);
        Assert.Equal(r.Visit("P25").Id, d.VisitOccurrenceId);
    }
}
