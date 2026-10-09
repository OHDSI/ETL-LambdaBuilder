namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class VisitOccurrenceTests
{
    [Fact]
    public void Build_OptumPanther_VisitOccurrence_R353_UsesVisitInsteadOfDiagnosisEncounterDates()
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(353);
        source.AddDiagnosis(353, "4019", "ICD9", "Diagnosis of", encid: OptumPantherInMemoryScenario.EncounterId(354));
        source.AddDiagnosis(353, "2724", "ICD9", "Diagnosis of", encid: OptumPantherInMemoryScenario.EncounterId(355));
        source.AddVisit(353, "356", "2014-03-05", "2014-03-10");
        source.AddEncounter(353, OptumPantherInMemoryScenario.EncounterId(354), interactionDate: "2014-03-06", visitId: "356");
        source.AddEncounter(353, OptumPantherInMemoryScenario.EncounterId(355), interactionDate: "2014-03-07", visitId: "356");

        var visits = source.Build(353).SourceVisits.ToArray();
        Assert.Single(visits, visit => visit.StartDate == new DateTime(2014, 3, 5) && visit.EndDate == new DateTime(2014, 3, 10));
        Assert.DoesNotContain(visits, visit => visit.StartDate == new DateTime(2014, 3, 6));
        Assert.DoesNotContain(visits, visit => visit.StartDate == new DateTime(2014, 3, 7));
    }

    [Fact(Skip = "The active R case declares 'Visit from Drug Exposure' but contains no add_* data and no expect_* assertion.")]
    public void Build_OptumPanther_VisitOccurrence_R353_VisitFromDrugExposureHasNoRImplementation()
    {
    }
}
