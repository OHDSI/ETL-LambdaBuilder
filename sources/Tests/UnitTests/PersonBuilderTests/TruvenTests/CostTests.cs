namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class CostTests
{
    [Fact]
    public void Build_Truven_Cost_R041_MapsDrugClaimCostComponents()
    {
        var s = Scenario(41);
        s.AddDrugClaims(41, "00378510501", "2012-02-09", copay: 20, ingcost: 50, dispfee: 25, awp: 20);
        var b = s.Build(41).Data;
        var d = b.DrugExposures.Where(x => x.Domain == "Drug").Select(s => s.DrugCost);
        var cost = Assert.Single(d);
        Assert.Equal(20, cost.PaidCopay);
        Assert.Equal(50, cost.IngredientCost);
        Assert.Equal(25, cost.DispensingFee);
        Assert.Equal(20, cost.TotalPaid);
    }

/*
    [Fact]
    public void Build_Truven_Cost_R043_AssociatesProcedureCosts()
    {
        var s = Scenario(43);
        s.AddInpatientServices(43, "2012-06-11", "2012-06-30", 44, proc1: "65779", copay: 40, deduct: 120);
        s.AddInpatientAdmissions(43, 44);
        var data = s.Build(43).Data.ProcedureOccurrences;
        Assert.Contains(data, x => x.ConceptId == 40757105 && x.StartDate == new DateTime(2012, 6, 11));
        var costs = data.Where(x => x.Domain == "Procedure").SelectMany(s => s.ProcedureCosts);
        var cost = Assert.Single(costs);
        Assert.Equal(40, cost.PaidCopay);
        Assert.Equal(120, cost.PaidTowardDeductible);
        Assert.Equal(160, cost.PaidByPayer);
    }

    [Fact]
    public void Build_Truven_Cost_R045_RoutesProcedureCostToMeasurement()
    {
        var s = Scenario(45);
        s.AddOutpatientServices(45, "2012-05-07", proc1: "82985", netpay: 120, copay: 37);
        var data = s.Build(45).Data.Measurements;
        Assert.Contains(data, x => x.ConceptId == 2212375 && x.StartDate == new DateTime(2012, 5, 7));
        var costs = data.Where(x => x.Domain == "Measurement").SelectMany(s => s.MeasurementCost);
        var cost = Assert.Single(costs);
        Assert.Equal(37, cost.PaidCopay);
        Assert.Equal(120, cost.PaidByPayer);
        Assert.Equal(157, cost.TotalPaid);
    }

    [Fact]
    public void Build_Truven_Cost_R047_RoutesProcedureCostToObservation()
    {
        var s = Scenario(47);
        s.AddOutpatientServices(47, "2012-10-03", proc1: "S9368", cob: 52, netpay: 75, coins: 100);
        var data = s.Build(47).Data.Observations;
        Assert.Contains(data, x => x.ConceptId == 2721503 && x.StartDate == new DateTime(2012, 10, 3));
        var costs = data.Where(x => x.Domain == "Observation").SelectMany(s => s.ObservationCost);
        var cost = Assert.Single(costs);
        Assert.Equal(100, cost.PaidCoinsurance);
        Assert.Equal(52, cost.PaidCopay);
        Assert.Equal(75, cost.PaidByPayer);
    }

    [Fact] public void Build_Truven_Cost_R049_MapsRevenueOnlyProcedureCost() => AssertRevenueOnlyCost(49);
    [Fact] public void Build_Truven_Cost_R051_PopulatesDrgCostFields() => AssertRevenueOnlyCost(51);
    */

    [Fact]
    public void Build_Truven_Cost_R053_UsesProcedureOccurrenceAsEvent()
    {
        var s = Scenario(53);
        s.AddInpatientServices(53, "2012-06-11", "2012-06-30", 54, proc1: "65779", copay: 40, deduct: 120);
        s.AddInpatientAdmissions(53, 54);
        var data = s.Build(53).Data;
        var procedure = Assert.Single(data.ProcedureOccurrences.Where(x => x.ConceptId == 40757105));
        Assert.Contains(data.Cost, x => x.EventId == procedure.Id);
    }
/*
    [Fact]
    public void Build_Truven_Cost_R055_InvalidRevenueCodeMapsToZero()
    {
        var s = Scenario(55);
        s.AddInpatientServices(55, "2012-06-05", "2012-06-05", 56, proc1: "65779", revcode: "0000", copay: 80, deduct: 20);
        s.AddInpatientAdmissions(55, 56);
        var data = s.Build(55).Data;
        var procedure = Assert.Single(data.ProcedureOccurrences.Where(x => x.ConceptId == 40757105));
        Assert.Contains(data.Cost, x => x.EventId == procedure.Id && x.RevenueCodeConceptId == 0);
    }

    [Fact] public void Build_Truven_Cost_R057_DrugClaimsConstants() => AssertCostConstants(57, 32869, add: s => s.AddDrugClaims(57));
    [Fact] public void Build_Truven_Cost_R059_OutpatientServicesConstants() => AssertCostConstants(59, 32860, add: s => s.AddOutpatientServices(59));
    [Fact] public void Build_Truven_Cost_R061_InpatientServicesConstants() => AssertCostConstants(61, 32854);
    [Fact] public void Build_Truven_Cost_R063_InpatientAdmissionsConstants() => AssertCostConstants(63, 32855);
*/
    private static void AssertRevenueOnlyCost(long id)
    {
        var s = Scenario(id);
        s.AddInpatientServices(id, "2012-06-05", "2012-06-05", id + 1, revcode: "0420", copay: 80, deduct: 20);
        s.AddInpatientAdmissions(id, id + 1);
        var cost = Assert.Single(s.Build(id).Data.Cost.Where(x => x.Domain == "Procedure"));
        Assert.Equal(80, cost.PaidPatientCopay);
        Assert.Equal(20, cost.PaidPatientDeductible);
        Assert.Equal(100, cost.PaidByPatient);
    }

    private static void AssertCostConstants(long id, long type, Action<TruvenInMemoryScenario>? add = null)
    {
        var s = Scenario(id);
        s.AddInpatientServices(id, "2012-06-05", "2012-06-05", id + 1, proc1: "65779", copay: 80, deduct: 20);
        s.AddInpatientAdmissions(id, id + 1);
        add?.Invoke(s);
        var data = s.Build(id).Data;
        var procedure = Assert.Single(data.ProcedureOccurrences.Where(x => x.ConceptId == 40757105));
        Assert.Contains(data.Cost, x => x.EventId == procedure.Id && x.Domain == "Visit Detail" &&
            x.TypeId == type && x.CurrencyConceptId == 44818668 &&
            x.RevenueCodeConceptId == 0 && x.DrgConceptId == 0);
    }

    private static TruvenInMemoryScenario Scenario(long id)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2012-01-01", "2012-12-31");
        return s;
    }
}
