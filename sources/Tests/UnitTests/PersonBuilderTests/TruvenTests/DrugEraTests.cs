namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class DrugEraTests
{
    [Fact]
    public void Build_Truven_DrugEra_R089_CombinesDuplicateIngredientExposures()
    {
        var s = Scenario(89);
        s.AddDrugClaims(89, "00463303410", "2012-02-04", 30);
        s.AddDrugClaims(89, "00463303410", "2012-02-04", 30);
        AssertEra(s.Build(89), 1134439, "2012-02-04", gapDays: 0);
    }

    [Fact]
    public void Build_Truven_DrugEra_R091_CalculatesGapDaysAcrossTwoExposures()
    {
        var s = Scenario(91);
        s.AddDrugClaims(91, "00463303410", "2012-02-04", 8);
        s.AddDrugClaims(91, "00463303410", "2012-02-22", 30);
        AssertEra(s.Build(91), 1134439, "2012-02-04", gapDays: 11);
    }

    [Fact]
    public void Build_Truven_DrugEra_R093_CombinesThreeExposuresIntoOneEra()
    {
        var s = Scenario(93);
        s.AddDrugClaims(93, "00463303410", "2012-02-04", 13);
        s.AddDrugClaims(93, "00463303410", "2012-02-22", 14);
        s.AddDrugClaims(93, "00463303410", "2012-03-12", 30);
        var result = s.Build(93);
        AssertEra(result, 1134439, "2012-02-04", gapDays: 12);
        Assert.Single(result.Data.DrugEra);
    }

    [Fact]
    public void Build_Truven_DrugEra_R095_SplitsExposuresMoreThanThirtyDaysApart()
    {
        var s = Scenario(95);
        s.AddDrugClaims(95, "00463303410", "2012-09-21");
        s.AddDrugClaims(95, "00463303410", "2012-12-08");
        var result = s.Build(95);
        var starts = result.Data.DrugEra.Where(x => x.ConceptId == 1134439).Select(x => x.StartDate).OrderBy(x => x).ToArray();
        Assert.Equal([new DateTime(2012, 9, 21), new DateTime(2012, 12, 8)], starts);
        Assert.All(result.Data.DrugEra, x => Assert.Equal(0, x.GapDays));
    }

    [Fact]
    public void Build_Truven_DrugEra_R097_UsesDaysSupplyForEraEnd()
    {
        var s = Scenario(97, "2010-01-01");
        s.AddDrugClaims(97, "00349835305", "2010-12-08", 14);
        var era = AssertEra(s.Build(97), 956874, "2010-12-08");
        Assert.Equal(new DateTime(2010, 12, 21), era.EndDate);
    }

    [Fact]
    public void Build_Truven_DrugEra_R099_CreatesEraFromProcedureDrug()
    {
        var s = Scenario(99);
        s.AddInpatientServices(99, "2012-03-26", "2012-03-30", 100, proc1: "90376");
        AssertEra(s.Build(99), 19135830, "2012-03-26");
    }

    [Fact]
    public void Build_Truven_DrugEra_R101_CreatesOneEraPerIngredient()
    {
        var s = Scenario(101, "2010-01-01");
        s.AddDrugClaims(101, "00008419001", "2010-05-01");
        var result = s.Build(101);
        AssertEra(result, 1134439, "2010-05-01");
        AssertEra(result, 1112807, "2010-05-01");
    }

    private static org.ohdsi.cdm.framework.common.Omop.EraEntity AssertEra(
        TruvenBuildResult result, long concept, string start, int? gapDays = null)
    {
        var era = Assert.Single(result.Data.DrugEra.Where(x => x.ConceptId == concept && x.StartDate == DateTime.Parse(start)));
        if (gapDays.HasValue) Assert.Equal(gapDays.Value, era.GapDays);
        return era;
    }

    private static TruvenInMemoryScenario Scenario(long id, string start = "2012-01-01")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, start, "2012-12-31");
        return s;
    }
}
