namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class CareSiteTests
{
    [Fact]
    public void Build_Cprd_CareSite_R311_MapsPracticeLocation()
    {
        var s = new CprdInMemoryScenario();
        s.AddCareSite(311, 13);
        var careSite = Assert.Single(s.BuildStaticData().CareSites);
        Assert.Equal(311, careSite.Id);
        Assert.Equal(13, careSite.LocationId);
    }
}
