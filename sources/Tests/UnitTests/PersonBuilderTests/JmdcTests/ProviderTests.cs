namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ProviderTests
{
    [Fact]
    public void Build_Jmdc_Provider_R501_ProviderIdFromInstitution()
    {
        var source = new JmdcInMemoryScenario();
        source.AddMedicalFacility("F0000003");

        var provider = Assert.Single(source.BuildStaticData().Providers);

        Assert.Equal(10000003L, provider.Id);
        Assert.Equal("F0000003", provider.ProviderSourceValue);
    }

    [Fact]
    public void Build_Jmdc_Provider_R504_ProviderSpecialty()
    {
        var source = new JmdcInMemoryScenario();
        source.AddMedicalFacility("F0000005", "Cardiology");

        var provider = Assert.Single(source.BuildStaticData().Providers);

        Assert.Equal(10000005L, provider.CareSiteId);
        Assert.Equal(38004451L, provider.ConceptId);
        Assert.Equal("Cardiology", provider.SourceValue);
    }
}
