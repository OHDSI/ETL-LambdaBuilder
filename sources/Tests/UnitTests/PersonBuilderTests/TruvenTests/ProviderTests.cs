namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class ProviderTests
{
    [Fact] public void Build_Truven_Provider_R204_MapsFacilityEmergencyMedicine() => AssertProvider(204, "facility", "220", 38004510);
    [Fact] public void Build_Truven_Provider_R206_DefaultsMissingSpecialty() => AssertProvider(206, "facility", "", 38004514);
    [Fact] public void Build_Truven_Provider_R208_MapsOutpatientInfectiousDisease() => AssertProvider(208, "outpatient", "285", 38004484);
    [Fact] public void Build_Truven_Provider_R210_MapsInpatientCardiacSurgery() => AssertProvider(210, "inpatient", "540", 38004497);
    [Fact] public void Build_Truven_Provider_R212_MapsLabAddictionMedicine() => AssertProvider(212, "lab", "22", 38004498);

    [Fact]
    public void Build_Truven_Provider_R214_CreatesProviderWhenProvidIsNull()
    {
        var s = new TruvenInMemoryScenario();
        s.AddFacilityHeader(215, provid: null, stdprov: "220");
        var provider = Assert.Single(s.BuildStaticData().Providers);
        Assert.Null(provider.ProviderSourceValue);
        Assert.Equal("220", provider.SourceValue);
    }

    [Fact]
    public void Build_Truven_Provider_R216_PreservesProviderConstants()
    {
        var s = new TruvenInMemoryScenario();
        s.AddFacilityHeader(217, provid: null, stdprov: "220");
        var provider = Assert.Single(s.BuildStaticData().Providers);
        Assert.Equal(0, provider.CareSiteId);
        Assert.Equal(0, provider.GenderConceptId);
        Assert.Equal(0, provider.ConceptId);
        Assert.Equal(0, provider.GenderSourceConceptId);
    }

    private static void AssertProvider(long providerId, string sourceTable, string specialty, long expected)
    {
        var s = new TruvenInMemoryScenario();
        var personId = providerId + 1;
        switch (sourceTable)
        {
            case "facility": s.AddFacilityHeader(personId, provid: providerId.ToString(), stdprov: specialty); break;
            case "outpatient": s.AddOutpatientServices(personId, provid: providerId.ToString(), stdprov: specialty); break;
            case "inpatient": s.AddInpatientServices(personId, provid: providerId.ToString(), stdprov: specialty); break;
            default: s.AddLab(personId, provid: providerId.ToString(), stdprov: specialty); break;
        }
        var provider = Assert.Single(s.BuildStaticData().Providers);
        Assert.Equal(expected, provider.ConceptId);
        if (specialty.Length > 0) Assert.Equal(specialty, provider.SourceValue);
    }
}
