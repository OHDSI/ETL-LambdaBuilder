namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class CostTests
{
    [Fact]
    public void Build_Jmdc_Cost_R1201_ClaimCost()
    {
        const string memberId = "M000001201";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001201", totalPoint: 123);

        var cost = Assert.Single(source.Build(memberId).Cost, item => item.Domain == "Visit");

        Assert.Equal(1201L, cost.EventId);
        Assert.Equal(5031L, cost.TypeId);
        Assert.Equal(44818592L, cost.CurrencyConceptId);
        Assert.Equal(1230m, cost.TotalPaid);
    }

    [Fact]
    public void Build_Jmdc_Cost_R1202_ProcedureCost()
    {
        const string memberId = "M000001202";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001202");
        source.AddProcedure(memberId, "C000000001202",
            standardizedProcedureCode: 2,
            standardizedProcedureVersion: "201404",
            numberOfTimes: 3,
            procedureStandardPoint: 50);
        source.AddProcedureMaster(2, "201404");

        var data = source.Build(memberId);
        var procedure = Assert.Single(data.ProcedureOccurrences, item => item.VisitOccurrenceId == 1202);
        var cost = Assert.Single(data.Cost, item => item.Domain == "Procedure");

        Assert.Equal(procedure.Id, cost.EventId);
        Assert.NotEqual(0L, cost.EventId);
        Assert.Equal(5032L, cost.TypeId);
        Assert.Equal(44818592L, cost.CurrencyConceptId);
        Assert.Equal(1500m, cost.TotalCharge);
    }

    [Fact]
    public void Build_Jmdc_Cost_R1203_DrugCost()
    {
        const string memberId = "M000001203";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001203");
        source.AddDrug(memberId, "C000000001203",
            jmdcDrugCode: 1,
            drugPrice: 40,
            administeredAmount: "2");

        var data = source.Build(memberId);
        var drug = Assert.Single(data.DrugExposures, item => item.VisitOccurrenceId == 1203);
        var cost = Assert.Single(data.Cost, item => item.Domain == "Drug");

        Assert.Equal(drug.Id, cost.EventId);
        Assert.NotEqual(0L, cost.EventId);
        Assert.Equal(5032L, cost.TypeId);
        Assert.Equal(44818592L, cost.CurrencyConceptId);
        Assert.Equal(80m, cost.TotalCharge);
    }
}
