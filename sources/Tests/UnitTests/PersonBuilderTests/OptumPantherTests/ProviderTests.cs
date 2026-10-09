namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class ProviderTests
{
    [Fact]
    public void Build_OptumPanther_Provider_R350_MapsPrimarySpecialty()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddProvider(350, "Internal Medicine", "1");
        var provider = Assert.Single(source.BuildStaticData().Providers);
        Assert.Equal(38004456, provider.ConceptId); Assert.Equal(0, provider.SpecialtySourceConceptId); Assert.Equal("Internal Medicine", provider.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Provider_R351_DeduplicatesProviderRows()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddProvider(351, "Family Medicine", "1"); source.AddProvider(351, "Family Medicine", "1");
        var provider = Assert.Single(source.BuildStaticData().Providers);
        Assert.Equal(38004453, provider.ConceptId); Assert.Equal("Family Medicine", provider.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Provider_R352_KeepsOnlyPrimarySpecialty()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddProvider(352, "Primary Medicine", "1"); source.AddProvider(352, "Emergency Medicine", "0");
        var provider = Assert.Single(source.BuildStaticData().Providers);
        Assert.Equal("Primary Medicine", provider.SourceValue);
    }
}
