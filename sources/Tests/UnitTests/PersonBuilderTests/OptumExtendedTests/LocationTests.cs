namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class LocationTests
{
    [Fact]
    public void Build_OptumExtendedSes_Location_R601_CreatesPersonRegionLocation()
    {
        var source = new OptumExtendedInMemoryScenario(OptumExtendedFlavor.Ses);
        source.AddStandardPerson(601, "2000-05-01", "2000-12-31", region: "PA", yearOfBirth: 1987);

        Assert.Contains(source.BuildStaticData().Locations, location => location.SourceValue == "PA");
    }

    [Fact]
    public void Build_OptumExtendedSes_Location_R602_CreatesProviderRegionLocation()
    {
        var source = new OptumExtendedInMemoryScenario(OptumExtendedFlavor.Ses);
        source.AddProvider(602, providerType: "2", region: "VA");

        Assert.Contains(source.BuildStaticData().Locations, location => location.SourceValue == "VA");
    }

    [Fact]
    public void Build_OptumExtendedDod_Location_R603_CreatesPersonStateLocation()
    {
        var source = new OptumExtendedInMemoryScenario(OptumExtendedFlavor.Dod);
        source.AddStandardPerson(603, "2000-05-01", "2000-12-31", state: "PA", yearOfBirth: 1987);

        Assert.Contains(source.BuildStaticData().Locations, location => location.SourceValue == "PA");
    }

    [Fact]
    public void Build_OptumExtendedDod_Location_R604_CreatesProviderStateLocation()
    {
        var source = new OptumExtendedInMemoryScenario(OptumExtendedFlavor.Dod);
        source.AddProvider(604, providerType: "2", state: "VA");

        Assert.Contains(source.BuildStaticData().Locations, location => location.SourceValue == "VA");
    }
}
