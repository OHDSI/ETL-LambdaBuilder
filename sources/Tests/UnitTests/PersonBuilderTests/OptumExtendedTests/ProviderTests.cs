namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class ProviderTests
{
    [Fact]
    public void Build_OptumExtended_Provider_R501_CreatesProviderFromProviderAndBridgeRows()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddProvider(501, providerCategory: "1001");
        source.AddProviderBridge(501, "501", "DEA501", "NPI501");

        var provider = Assert.Single(source.BuildStaticData().Providers);

        Assert.Equal(501, provider.Id);
        Assert.Equal("501", provider.ProviderSourceValue);
    }

    [Fact]
    public void Build_OptumExtended_Provider_R502_MapsTaxonomyOneSpecialty()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddProvider(502, taxonomy1: "103TC2200X");

        var provider = Assert.Single(source.BuildStaticData().Providers);

        Assert.Equal(38003640, provider.ConceptId);
        Assert.Equal("103TC2200X", provider.SourceValue);
    }

    [Fact]
    public void Build_OptumExtended_Provider_R503_MapsTaxonomyTwoSpecialty()
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddProvider(503, taxonomy2: "207PE0004X");

        var provider = Assert.Single(source.BuildStaticData().Providers);

        Assert.Equal(38004510, provider.ConceptId);
        Assert.Equal("207PE0004X", provider.SourceValue);
    }
}
