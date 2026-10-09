namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class DrugEraTests
{
    [Fact]
    public void Build_Cprd_DrugEra_R11111_CollapsesTwoTherapyRecords()
    {
        const long id = 11111;
        var s = Patient(id);
        s.AddTherapy(id, "2012-01-01", "58976020", 20);
        s.AddTherapy(id, "2012-01-20", "58976020", 30);
        var era = Assert.Single(s.Build(id).Data.DrugEra);
        Assert.Equal(1316354, era.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), era.StartDate);
        Assert.Equal(CprdRAssert.Date("2012-02-18"), era.EndDate);
        Assert.Equal(2, era.OccurrenceCount);
    }

    [Fact]
    public void Build_Cprd_DrugEra_R12111_UsesMultilexIngredient()
    {
        const long id = 12111;
        var s = Patient(id);
        s.AddTherapy(id, "2012-01-31", "90473020", 30);
        var era = Assert.Single(s.Build(id).Data.DrugEra);
        Assert.Equal(1177480, era.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-31"), era.StartDate);
        Assert.Equal(CprdRAssert.Date("2012-02-29"), era.EndDate);
        Assert.Equal(1, era.OccurrenceCount);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, pracid: 111);
        return s;
    }
}
