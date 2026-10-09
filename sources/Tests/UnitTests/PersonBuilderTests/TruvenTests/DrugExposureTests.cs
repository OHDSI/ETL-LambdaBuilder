namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class DrugExposureTests
{
    [Fact]
    public void Build_Truven_DrugExposure_R065_DeduplicatesDrugClaims()
    {
        var s = Scenario(65);
        s.AddDrugClaims(65, "36987257801", "2012-02-01");
        s.AddDrugClaims(65, "36987257801", "2012-02-01");
        var rows = s.Build(65).Data.DrugExposures.Where(x => x.ConceptId == 40161912 && x.StartDate == new DateTime(2012, 2, 1));
        Assert.Single(rows);
    }

    [Fact] public void Build_Truven_DrugExposure_R067_ClampsNegativeDaysSupplyToOne() => AssertDaysSupply(67, -30, 1, "2012-06-12");
    [Fact] public void Build_Truven_DrugExposure_R069_ClampsDaysSupplyAbove365() => AssertDaysSupply(69, 432, 365, "2012-08-07");

    [Fact]
    public void Build_Truven_DrugExposure_R071_RoutesCptDrugFromInpatientServices()
    {
        var s = Scenario(71);
        s.AddInpatientServices(71, "2012-08-09", "2012-08-12", 72, proc1: "90376");
        Assert.Contains(s.Build(71).Data.DrugExposures,
            x => x.ConceptId == 46234006 && x.StartDate == new DateTime(2012, 8, 9));
    }

    [Fact]
    public void Build_Truven_DrugExposure_R073_DefaultsProcedureDrugEndToStart()
    {
        var s = Scenario(73);
        s.AddInpatientServices(73, "2012-08-09", "2012-08-12", 74, proc1: "90376");
        Assert.Contains(s.Build(73).Data.DrugExposures,
            x => x.ConceptId == 46234006 && x.StartDate == new DateTime(2012, 8, 9) && x.EndDate == x.StartDate);
    }

    [Fact]
    public void Build_Truven_DrugExposure_R075_FallsBackFromNdc11ToNdc9()
    {
        var s = Scenario(75);
        s.AddDrugClaims(75, "13533063670", "2012-01-17");
        Assert.Contains(s.Build(75).Data.DrugExposures,
            x => x.ConceptId == 46275250 && x.StartDate == new DateTime(2012, 1, 17));
    }

    [Fact]
    public void Build_Truven_DrugExposure_R077_PreservesNullQuantity()
    {
        var s = Scenario(77);
        s.AddDrugClaims(77, "13533063670", "2012-01-19", metqty: null);
        Assert.Contains(s.Build(77).Data.DrugExposures,
            x => x.ConceptId == 46275250 && x.StartDate == new DateTime(2012, 1, 19) && x.Quantity is null);
    }

    [Fact]
    public void Build_Truven_DrugExposure_R079_UsesZeroWhenNdc9MappingIsOutsideValidity()
    {
        var s = Scenario(79, "2006-01-01", "2006-12-31");
        s.AddDrugClaims(79, "00006000543", "2006-07-08");
        Assert.Contains(s.Build(79).Data.DrugExposures,
            x => x.ConceptId == 0 && x.StartDate == new DateTime(2006, 7, 8));
    }

    [Fact]
    public void Build_Truven_DrugExposure_R081_UsesNdc9MappingInsideValidity()
    {
        var s = Scenario(81, "2014-01-01", "2014-12-31");
        s.AddDrugClaims(81, "00006032582", "2014-09-18");
        Assert.Contains(s.Build(81).Data.DrugExposures,
            x => x.ConceptId == 45775771 && x.StartDate == new DateTime(2014, 9, 18));
    }

    [Fact]
    public void Build_Truven_DrugExposure_R083_PrefersElevenDigitNdcSourceConcept()
    {
        var s = Scenario(83, "2014-01-01", "2014-12-31");
        s.AddDrugClaims(83, "00069100101", "2014-09-18");
        Assert.Contains(s.Build(83).Data.DrugExposures, x => x.SourceConceptId == 45332969);
    }

    [Fact]
    public void Build_Truven_DrugExposure_R085_KeepsEventOutsideObservationPeriod()
    {
        var s = Scenario(85, "2014-01-01", "2014-12-31");
        s.AddDrugClaims(85, "00069100101", "2019-09-18");
        Assert.Contains(s.Build(85).Data.DrugExposures, x => x.StartDate == new DateTime(2019, 9, 18));
    }

    [Fact]
    public void Build_Truven_DrugExposure_R087_SelectsDateSpecificSourceConcepts()
    {
        var s = Scenario(87, "1970-01-01", "2023-06-30");
        s.AddInpatientServices(87, "1970-01-01", "1970-01-01", 88, proc1: "J9350");
        s.AddInpatientServices(87, "2014-11-11", "2014-11-11", 88, proc1: "J9350");
        s.AddInpatientServices(87, "2023-07-01", "2023-07-01", 88, proc1: "J9350");
        var rows = s.Build(87).Data.DrugExposures;
        Assert.Contains(rows, x => x.ConceptId == 19124326 && x.SourceConceptId == 2718911 && x.StartDate == new DateTime(1970, 1, 1) && x.EndDate == new DateTime(2014, 11, 10));
        Assert.Contains(rows, x => x.ConceptId == 0 && x.SourceConceptId == 0 && x.StartDate == new DateTime(2014, 11, 11) && x.EndDate == new DateTime(2023, 6, 30));
        Assert.Contains(rows, x => x.ConceptId == 1302318 && x.SourceConceptId == 2100003123 && x.StartDate == new DateTime(2023, 7, 1) && x.EndDate == new DateTime(2099, 12, 31));
    }

    private static void AssertDaysSupply(long id, int input, int expected, string date)
    {
        var s = Scenario(id);
        s.AddDrugClaims(id, "58864060830", date, input);
        var drug = Assert.Single(s.Build(id).Data.DrugExposures.Where(x => x.ConceptId == 1545998));
        Assert.Equal(expected, drug.DaysSupply);
        Assert.Equal(DateTime.Parse(date), drug.StartDate);
    }

    private static TruvenInMemoryScenario Scenario(long id, string start = "2012-01-01", string end = "2012-12-31")
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, start, end);
        return s;
    }
}
