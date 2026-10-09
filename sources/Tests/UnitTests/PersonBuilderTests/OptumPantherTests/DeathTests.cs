namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class DeathTests
{
    [Fact]
    public void Build_OptumPanther_Death_R029_UsesLastDayOfDeathMonth()
    {
        var source = DeadPerson(29);
        source.AddEncounter(29, Encounter(30), interactionDate: "2014-04-30");
        var death = Assert.Single(source.Build(29).Data.Deaths);
        Assert.Equal(new DateTime(2014, 4, 30), death.StartDate);
    }

    [Fact] public void Build_OptumPanther_Death_R032_DiagnosisThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(32, "diagnosis", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R035_EncounterThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(35, "encounter", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R038_ImmunizationsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(38, "immunizations", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R041_InsuranceThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(41, "insurance", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R044_LabsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(44, "labs", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R047_MedicationAdministrationsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(47, "medication_administrations", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R050_MicrobiologyThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(50, "microbiology", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R053_NlpBiomarkersThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(53, "nlp_biomarkers", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R056_NlpDrugRationaleThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(56, "nlp_drug_rationale", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R059_NlpMeasurementThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(59, "nlp_measurement", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R062_NlpSdsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(62, "nlp_sds", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R065_NlpSdsFamilyThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(65, "nlp_sds_family", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R068_ObservationsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(68, "observations", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R071_PatientReportedMedicationsThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(71, "patient_reported_medications", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R074_PrescriptionsWrittenThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(74, "prescriptions_written", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R077_ProcedureThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(77, "procedure", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R080_VisitThirtyDaysAfterDeathKeepsDeath()
    { AssertDeathProbe(80, "visit", "2014-05-30", true); }

    [Fact] public void Build_OptumPanther_Death_R083_DiagnosisSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(83, "diagnosis", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R086_EncounterSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(86, "encounter", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R089_ImmunizationsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(89, "immunizations", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R092_InsuranceSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(92, "insurance", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R095_LabsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(95, "labs", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R098_MedicationAdministrationsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(98, "medication_administrations", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R101_MicrobiologySixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(101, "microbiology", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R104_NlpBiomarkersSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(104, "nlp_biomarkers", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R107_NlpDrugRationaleSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(107, "nlp_drug_rationale", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R110_NlpMeasurementSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(110, "nlp_measurement", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R113_NlpSdsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(113, "nlp_sds", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R116_NlpSdsFamilySixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(116, "nlp_sds_family", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R119_ObservationsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(119, "observations", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R122_PatientReportedMedicationsSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(122, "patient_reported_medications", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R125_PrescriptionsWrittenSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(125, "prescriptions_written", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R128_ProcedureSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(128, "procedure", "2014-06-29", false); }

    [Fact] public void Build_OptumPanther_Death_R131_VisitSixtyDaysAfterDeathRemovesDeath()
    { AssertDeathProbe(131, "visit", "2014-06-29", false); }

    private static void AssertDeathProbe(long personId, string table, string date, bool expected)
    {
        var source = DeadPerson(personId);
        var encounterId = Encounter(personId + 1);
        source.AddEncounter(personId, encounterId, interactionDate: date, visitId: (personId + 2).ToString());
        source.AddDeathProbe(personId, table, date, encounterId);
        if (expected) Assert.Single(source.Build(personId).Data.Deaths);
        else Assert.Empty(source.Build(personId).Data.Deaths);
    }

    private static OptumPantherInMemoryScenario DeadPerson(long personId)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, deathYearMonth: "201404", deceased: true);
        return source;
    }

    private static string Encounter(long id) => OptumPantherInMemoryScenario.EncounterId(id);
}

