namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class LocationTests
{
    [Fact]
    public void Build_Truven_Location_R105_MapsEgeolocToState()
    {
        var s = new TruvenInMemoryScenario();
        s.AddGeoloc("11", "New Jersey", "NJ");
        s.AddEnrollmentDetail(105, egeoloc: "11");
        var location = Assert.Single(s.BuildStaticData().Locations);
        Assert.Equal("NJ", location.State);
        Assert.Equal("11", location.SourceValue);
    }

    [Fact]
    public void Build_Truven_Location_R106_CreatesSingleUnknownLocation()
    {
        var s = new TruvenInMemoryScenario();
        s.AddGeoloc("62", "California", "CA");
        s.AddEnrollmentDetail(106, egeoloc: "89");
        var location = Assert.Single(s.BuildStaticData().Locations.Where(x => x.SourceValue == "89"));
        Assert.Equal("UN", location.State);
    }

    [Fact]
    public void Build_Truven_Location_R107_DeduplicatesLocationAcrossEnrollmentRows()
    {
        var s = new TruvenInMemoryScenario();
        s.AddGeoloc("38", "Virginia", "VA");
        s.AddEnrollmentDetail(107, "2012-07-01", "2012-07-31", egeoloc: "38");
        s.AddEnrollmentDetail(107, "2012-06-01", "2012-06-30", egeoloc: "38");
        var location = Assert.Single(s.BuildStaticData().Locations.Where(x => x.SourceValue == "38"));
        Assert.Equal("VA", location.State);
    }
}
