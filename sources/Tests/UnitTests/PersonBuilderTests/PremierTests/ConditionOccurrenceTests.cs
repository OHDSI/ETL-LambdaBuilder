using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class ConditionOccurrenceTests
{
    [Fact]
    public void Build_Premier_ConditionOccurrence_R001_MapsPaticdDiagIcd9()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(1, "P1", "2005-01-01", "2005-01-01");
        s.AddPatbill("P1");
        s.AddPaticdDiag("P1", "112.89", 9);

        var r = s.Build(1);
        Assert.Equal(Attrition.None, r.Attrition);
        var c = Assert.Single(r.Data.ConditionOccurrences.Where(x => x.ConceptId == 433968));
        Assert.Equal(new DateTime(2005, 1, 1), c.StartDate);
        Assert.Equal("112.89", c.SourceValue);
        Assert.Equal(r.Visit("P1").Id, c.VisitOccurrenceId);
    }

    [Fact]
    public void Build_Premier_ConditionOccurrence_R003_MapsPaticdDiagIcd10ToTwoConcepts()
    {
        var s = new PremierInMemoryScenario();
        s.AddPat(3, "P3", "2004-03-01", "2004-03-01");
        s.AddPatbill("P3");
        s.AddPaticdDiag("P3", "M05.421", 10);

        var r = s.Build(3);
        Assert.Equal(Attrition.None, r.Attrition);
        Assert.Equal([4107913L, 4116440L], r.Data.ConditionOccurrences
            .Where(x => x.SourceValue == "M05.421")
            .Select(x => x.ConceptId)
            .OrderBy(x => x)
            .ToArray());
        Assert.All(r.Data.ConditionOccurrences.Where(x => x.SourceValue == "M05.421"), c =>
        {
            Assert.Equal(new DateTime(2004, 3, 1), c.StartDate);
            Assert.Equal(r.Visit("P3").Id, c.VisitOccurrenceId);
        });
    }

    [Fact] public void Build_Premier_ConditionOccurrence_R005_MapsAdmittingStatus() => AssertStatus(5, "A", 32890);
    [Fact] public void Build_Premier_ConditionOccurrence_R007_MapsPrimaryStatus() => AssertStatus(7, "P", 32902);
    [Fact] public void Build_Premier_ConditionOccurrence_R009_MapsSecondaryStatus() => AssertStatus(9, "S", 32908);

    private static void AssertStatus(long personId, string source, long expected)
    {
        var key = $"P{personId}";
        var s = new PremierInMemoryScenario();
        s.AddPat(personId, key);
        s.AddPaticdDiag(key, icdPriSec: source);
        var r = s.Build(personId);
        var c = Assert.Single(r.Data.ConditionOccurrences.Where(x => x.SourceValue == "I10"));
        Assert.Equal(expected, c.StatusConceptId);
        Assert.Equal(source, c.StatusSourceValue);
        Assert.Equal(r.Visit(key).Id, c.VisitOccurrenceId);
    }
}
