namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class CareSiteTests
{
    [Theory]
    [InlineData(401, null, 0)]
    [InlineData(402, "2", 8717)]
    [InlineData(403, "3", 38004693)]
    [InlineData(404, "4", 0)]
    public void Build_OptumExtended_CareSite_R401_R404_MapsProviderType(
        long providerId,
        string? providerType,
        long expectedConcept)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddProvider(providerId, providerType);

        var careSite = Assert.Single(source.BuildStaticData().CareSites);

        Assert.Equal(providerId, careSite.Id);
        Assert.Equal(providerId.ToString(), careSite.SourceValue);
        Assert.Equal(expectedConcept, careSite.ConceptId);
    }

    [Fact]
    public void Build_OptumExtended_CareSite_R405_CreatesPharmacyCareSiteFromRxClaim()
    {
        const long pharmacyId = 405;
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(45, "2000-05-01", "2009-12-31", yearOfBirth: 1988);
        source.AddRxClaim(45, "RX405", fillDate: "2001-01-01", pharmacyId: pharmacyId);

        var careSite = Assert.Single(source.BuildStaticData().CareSites);

        Assert.Equal(pharmacyId, careSite.Id);
        Assert.Equal(pharmacyId.ToString(), careSite.SourceValue);
        Assert.Equal(38004340, careSite.ConceptId);
    }
}
