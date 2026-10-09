namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class DrugExposureTests
{
    [Fact]
    public void Build_Premier_DrugExposure_R027_MapsHcpcs()
    {
        var r = BuildCpt(27, "2010-04-01", "J9310");
        AssertDrug(r, "P27", 46275081, "2010-04-01", "J9310");
    }

    [Fact]
    public void Build_Premier_DrugExposure_R029_MapsCpt4()
    {
        var r = BuildCpt(29, "2010-06-01", "90687");
        AssertDrug(r, "P29", 40213145, "2010-06-01", "90687");
    }

    [Fact]
    public void Build_Premier_DrugExposure_R031_UsesSecondVisitForStdChargeDate()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(31, "P31A", "2011-08-01", "2011-08-01");
        s.AddPatbill("P31A");
        s.AddPat(31, "P31B", "2011-08-01", "2011-08-01");
        s.AddPatbill("P31B", 250250015090000);
        s.AddPatbill("P31B");
        var r = s.Build(31);
        var drug = Assert.Single(r.Data.DrugExposures.Where(x => x.ConceptId == 1100333));
        Assert.Equal(new DateTime(2011, 8, 1), drug.StartDate);
        Assert.Equal(r.Visit("P31B").Id, drug.VisitOccurrenceId);
    }

    [Fact]
    public void Build_Premier_DrugExposure_R034_DefaultsEndDateToStartDate()
    {
        var r = BuildCpt(34, "2010-04-01", "J9310");
        var d = AssertDrug(r, "P34", 46275081, "2010-04-01", "J9310");
        Assert.Equal(new DateTime(2010, 4, 1), d.EndDate);
    }

    private static PremierBuildResult BuildCpt(long personId, string date, string code)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key, date, date);
        s.AddPatbill(key);
        s.AddPatcpt(key, code);
        return s.Build(personId);
    }

    private static org.ohdsi.cdm.framework.common.Omop.DrugExposure AssertDrug(
        PremierBuildResult result,
        string patKey,
        long conceptId,
        string date,
        string source)
    {
        var drug = Assert.Single(result.Data.DrugExposures.Where(x => x.ConceptId == conceptId));
        Assert.Equal(DateTime.Parse(date), drug.StartDate);
        Assert.Equal(source, drug.SourceValue);
        Assert.Equal(result.Visit(patKey).Id, drug.VisitOccurrenceId);
        return drug;
    }
}