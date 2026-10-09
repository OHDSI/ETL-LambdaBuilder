namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class DrugExposureTests
{
    [Fact]
    public void Build_OptumExtended_DrugExposure_R1001_KeepsRxInsideAndOutsideEnrollment()
    {
        var source = Person(1001, end: "2013-10-31");
        source.AddRxClaim(1001, "RX1001A", "55111067101", "2013-10-01");
        source.AddRxClaim(1001, "RX1001B", "58487000102", "2013-12-01");

        var result = source.Build(1001);

        Assert.Contains(result.Data.DrugExposures, item => item.ConceptId == 1322189 && item.SourceValue == "55111067101");
        Assert.Contains(result.Data.DrugExposures, item => item.ConceptId == 0 && item.SourceValue == "58487000102");
        Assert.Contains(result.SourceVisits, item => item.ConceptId == 581458 && item.StartDate == new DateTime(2013, 10, 1));
        Assert.Contains(result.SourceVisits, item => item.ConceptId == 581458 && item.StartDate == new DateTime(2013, 12, 1));
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1002_KeepsThreeRxRowsButCollapsesVisit()
    {
        var source = Person(1002, end: "2013-10-31");
        for (var i = 0; i < 3; i++)
            source.AddRxClaim(1002, "RX1002", "55111067101", "2013-10-01");

        var result = source.Build(1002);

        Assert.Equal(3, result.Data.DrugExposures.Count);
        Assert.Single(result.SourceVisits);
        Assert.Equal(3, result.SourceVisitDetails.Count());
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1003_RoutesMedicalProcedureCodeToDrug()
    {
        var source = Person(1003, end: "2013-10-31");
        source.AddMedicalClaim(1003, "C1003", "2013-07-01", procedureCode: "J0456");

        Assert.Contains(source.Build(1003).Data.DrugExposures, item => item.ConceptId == 35603391);
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1004_RoutesMedProcedureCodeToDrugNotProcedure()
    {
        var source = Person(1004, end: "2013-10-31");
        source.AddMedicalClaim(1004, "C1004", "2013-07-01");
        source.AddProcedure(1004, "C1004", "J0456");

        var result = source.Build(1004).Data;

        Assert.Contains(result.DrugExposures, item => item.ConceptId == 35603391);
        Assert.DoesNotContain(result.ProcedureOccurrences, item => item.SourceValue == "J0456");
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1005_RoutesMedicalNdcToDrug()
    {
        var source = Person(1005, end: "2013-10-31");
        source.AddMedicalClaim(1005, "C1005", "2013-07-01", ndc: "55111067101");

        var drug = Assert.Single(source.Build(1005).Data.DrugExposures);

        Assert.Equal(1322189, drug.ConceptId);
        Assert.Equal("55111067101", drug.SourceValue);
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1006_RoutesLabProcedureCodeToDrug()
    {
        var source = Person(1006);
        source.AddLabResult(1006, "L1006", procedureCode: "90651");

        var drug = Assert.Single(source.Build(1006).Data.DrugExposures);

        Assert.Equal(45892510, drug.ConceptId);
        Assert.Equal("90651", drug.SourceValue);
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1007_RoutesInpatientProcedureCodeToDrug()
    {
        var source = Person(1007);
        source.AddInpatientConfinement(1007, "CONF1007", "2013-08-11", "2013-08-22", diagnosis1: "250.00", procedure1: "90651");

        var drug = Assert.Single(source.Build(1007).Data.DrugExposures);

        Assert.Equal(45892510, drug.ConceptId);
        Assert.Equal("90651", drug.SourceValue);
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1008_SetsNonMedicalDrugEndDateToStartDate()
    {
        var source = Person(1008, end: "2013-10-31");
        source.AddMedicalClaim(1008, "C1008", "2013-07-01", end: "2013-07-05");
        source.AddProcedure(1008, "C1008", "XW033A7", icdFlag: "10");

        var drug = Assert.Single(source.Build(1008).Data.DrugExposures);

        Assert.Equal("XW033A7", drug.SourceValue);
        Assert.Equal(drug.StartDate, drug.EndDate);
    }

    [Fact]
    public void Build_OptumExtended_DrugExposure_R1009_SetsMedicalDrugEndDateToStartDate()
    {
        var source = Person(1009, end: "2013-10-31");
        source.AddMedicalClaim(1009, "C1009", "2013-07-01", ndc: "55111067101");

        var drug = Assert.Single(source.Build(1009).Data.DrugExposures);

        Assert.Equal(new DateTime(2013, 7, 1), drug.EndDate);
    }

    private static OptumExtendedInMemoryScenario Person(long personId, string end = "2014-10-31")
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", end);
        return source;
    }
}
