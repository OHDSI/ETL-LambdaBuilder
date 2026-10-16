namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class DeathTests
{
    [Fact]
    public void Build_Cprd_Death_R9888_KeepsValidDeathDate()
    {
        const long id = 9888;
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, yob: 169, pracid: 888, crd: "2009-01-01", deathDate: "2010-01-01", toreason: 1);
        var b = s.Build(id).Data;
        var death = Assert.Single(b.Deaths);
        Assert.Equal(CprdRAssert.Date("2010-01-01"), death.StartDate);
    }

    [Fact]
    public void Build_Cprd_Death_R10888_DoesNotCreateDeathWithoutDate()
    {
        const long id = 10888;
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, yob: 169, pracid: 888, crd: "2009-01-01");
        Assert.Empty(s.Build(id).Data.Deaths);
    }
}
