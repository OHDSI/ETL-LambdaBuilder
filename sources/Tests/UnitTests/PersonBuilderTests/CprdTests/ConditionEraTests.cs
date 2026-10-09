namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ConditionEraTests
{
    [Fact]
    public void Build_Cprd_ConditionEra_R1311_CollapsesNearbyConditions()
    {
        const long id = 1311;
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        s.AddRead(id, CprdReadSource.Clinical, "2012-01-01", "F563500");
        s.AddRead(id, CprdReadSource.Clinical, "2012-01-02", "F563500");
        var era = Assert.Single(s.Build(id).Data.ConditionEra);
        Assert.Equal(75555, era.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), era.StartDate);
        Assert.Equal(CprdRAssert.Date("2012-01-02"), era.EndDate);
        Assert.Equal(2, era.OccurrenceCount);
    }
}
