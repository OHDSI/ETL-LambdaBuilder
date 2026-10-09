namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class LocationTests
{
    [Fact]
    public void Build_OptumPanther_Location_R197_MapsRegionAndDivision()
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(197, "Male", "1950", region: "REGION", division: "DIVISION", firstMonthActive: "200701", lastMonthActive: "201001");
        var location = Assert.Single(source.BuildStaticData().Locations);
        Assert.Equal("REGION_DIVISION", location.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Location_R198_DeduplicatesLocations()
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(198, "Male", "1950", region: "DUPE_REGION", division: "DUPE_DIVISION", firstMonthActive: "200701", lastMonthActive: "201001");
        source.AddStandardPerson(198, "Male", "1950", region: "DUPE_REGION", division: "DUPE_DIVISION", firstMonthActive: "200701", lastMonthActive: "201001");
        var location = Assert.Single(source.BuildStaticData().Locations);
        Assert.Equal("DUPE_REGION_DUPE_DIVISION", location.SourceValue);
    }
}
