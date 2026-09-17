namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class CareSiteTests
{
    [Fact]
    public void Build_Jmdc_CareSite_R301_MapsCareSiteIdAndSourceValue()
    {
        var source = new JmdcInMemoryScenario();
        source.AddMedicalFacility("F0000001");

        var careSite = Assert.Single(source.BuildStaticData().CareSites);

        Assert.Equal(10000001L, careSite.Id);
        Assert.Equal("F0000001", careSite.SourceValue);
    }
}
