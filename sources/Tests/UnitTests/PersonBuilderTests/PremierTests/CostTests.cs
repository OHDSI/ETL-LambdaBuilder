namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class CostTests
{
    [Fact]
    public void Build_Premier_Cost_R011_CreatesDrugCost()
    {
        var r = BuildCost(11, 250250038820000, 500.50m, 300.75m, "PHARMACY", "PHARMACY");
        Assert.Contains(r.Data.DrugExposures, x => x.ConceptId == 19042590);
        AssertCost(r, "Drug", 500.50m, 300.75m, 38003147, "PHARMACY / PHARMACY");
    }

    [Fact]
    public void Build_Premier_Cost_R013_CreatesProcedureCost()
    {
        var r = BuildCost(13, 33840, 29374.99m, 13572.76m, "OR", "SURGERY");
        Assert.Contains(r.Data.ProcedureOccurrences, x => x.ConceptId == 4105220);
        AssertCost(r, "Procedure", 29374.99m, 13572.76m, 38003208, "OR / SURGERY");
    }

    [Fact]
    public void Build_Premier_Cost_R015_CreatesDeviceCost()
    {
        var r = BuildCost(15, 270275000120000, 499.99m, 99.99m, "SUPPLY", "CENTRAL SUPPLY");
        Assert.Contains(r.Data.DeviceExposure, x => x.ConceptId == 4236068);
        AssertCost(r, "Device", 499.99m, 99.99m, 38003163, "SUPPLY / CENTRAL SUPPLY");
    }

    [Fact]
    public void Build_Premier_Cost_R017_CreatesObservationCost()
    {
        var r = BuildCost(17, 110214000620000, 2347.77m, 2000m, "OTHER", "DIALYSIS");
        Assert.Contains(r.Data.Observations, x => x.ConceptId == 4227255);
        AssertCost(r, "Observation", 2347.77m, 2000m, 38003458, "OTHER / DIALYSIS");
    }

    [Fact]
    public void Build_Premier_Cost_R019_CreatesMeasurementCost()
    {
        var r = BuildCost(19, 85013, 79.99m, 19.50m, "LAB", "LABORATORY");
        Assert.Contains(r.Data.Measurements, x => x.ConceptId == 4016241);
        AssertCost(r, "Measurement", 79.99m, 19.50m, 38003172, "LAB / LABORATORY");
    }

    [Fact]
    public void Build_Premier_Cost_R021_PadsOneDigitMsDrg()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(21, "P21", "2005-01-01", "2005-01-01", msDrg: 1);
        s.AddPatbill("P21");
        var r = s.Build(21);
        var cost = Assert.Single(r.Data.Cost.Where(x => x.DrgConceptId == 38000887));
        Assert.Equal("001", cost.DrgSourceValue);
    }

    private static PremierBuildResult BuildCost(
        long personId,
        long code,
        decimal charge,
        decimal cost,
        string sumDepartment,
        string standardDepartment)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key);
        s.AddPatbill(key, code, billCharges: charge, billCost: cost);
        s.AddChgmstr(code, sumDeptDesc: sumDepartment, stdDeptDesc: standardDepartment);
        return s.Build(personId);
    }

    private static void AssertCost(
        PremierBuildResult result,
        string domain,
        decimal totalCharge,
        decimal totalCost,
        long revenueConcept,
        string revenueSource)
    {
        var cost = Assert.Single(result.Data.Cost.Where(x => x.Domain == domain));
        Assert.Equal(totalCharge, cost.TotalCharge);
        Assert.Equal(totalCost, cost.TotalCost);
        Assert.Equal(revenueConcept, cost.RevenueCodeConceptId);
        Assert.Equal(revenueSource, cost.RevenueCodeSourceValue);
    }
}
