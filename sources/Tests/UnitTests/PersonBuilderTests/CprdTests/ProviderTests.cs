namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ProviderTests
{
    [Fact]
    public void Build_Cprd_Provider_R88_MapsPartnerSpecialty() => AssertProvider(88, "Partner", 32577);

    [Fact]
    public void Build_Cprd_Provider_R89_MapsRadiographerSpecialty() => AssertProvider(89, "Radiographer", 45756825);

    [Fact]
    public void Build_Cprd_Provider_R90_MapsDataNotEnteredSpecialty() => AssertProvider(90, "Data Not Entered", 38004514);

    private static void AssertProvider(long id, string source, long concept)
    {
        var s = new CprdInMemoryScenario();
        s.AddProvider(id, source, concept);
        var provider = Assert.Single(s.BuildStaticData().Providers);
        Assert.Equal(id, provider.Id);
        Assert.Equal(source, provider.SourceValue);
        Assert.Equal(concept, provider.ConceptId);
    }
}
