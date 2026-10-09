namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class DeviceExposureTests
{
    [Fact]
    public void Build_Cprd_DeviceExposure_R32311_MapsReadDevice()
    {
        const long id = 32311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Immunisation, "2012-01-01", "9b20.00");
        var device = Assert.Single(s.Build(id).Data.DeviceExposure);
        CprdRAssert.Common(device, id, 4192787, "2012-01-01", "9b20.00", 0, 32818);
    }

    [Fact]
    public void Build_Cprd_DeviceExposure_R33311_MapsGemscriptDevice()
    {
        const long id = 33311;
        var s = Patient(id);
        s.AddTherapy(id, "2012-01-01", "99978020", 29);
        var device = Assert.Single(s.Build(id).Data.DeviceExposure);
        Assert.Equal(21380480, device.ConceptId);
        Assert.Equal("99978020", device.SourceValue);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), device.StartDate);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        return s;
    }
}
