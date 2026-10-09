namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class DrugExposureTests
{
    [Fact] public void Build_OptumPanther_DrugExposure_R136_LoadsMedicationAdministration()
    {
        var s = Person(136); s.AddMedicationAdministration(136, "55111067101", "2011-01-07");
        var d = Drug(s, 136); Assert.Equal(new DateTime(2011, 1, 7), d.StartDate); Assert.Equal(32818, d.TypeConceptId);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R137_KeepsMedicationAdministrationsInsideAndOutsideEnrollment()
    {
        var s = Person(137); s.AddMedicationAdministration(137, "55111067101", "2011-01-07"); s.AddMedicationAdministration(137, "58487000102", "2013-01-07");
        Assert.Equal(2, Build(s, 137).Data.DrugExposures.Count);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R138_DeduplicatesIdenticalMedicationAdministrations()
    {
        var s = Person(138); var e = Encounter(139); s.AddEncounter(138, e, interactionDate: "2011-01-07");
        s.AddMedicationAdministration(138, "55111067101", "2011-01-07", e); s.AddMedicationAdministration(138, "55111067101", "2011-01-07", e);
        Assert.Single(Build(s, 138).Data.DrugExposures);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R140_KeepsSameDrugAndDateFromDifferentEncounters()
    {
        var s = Person(140); var e1 = Encounter(141); var e2 = Encounter(142); s.AddEncounter(140, e1, interactionDate: "2011-01-07"); s.AddEncounter(140, e2, interactionDate: "2011-01-07");
        s.AddMedicationAdministration(140, "55111067101", "2011-01-07", e1); s.AddMedicationAdministration(140, "55111067101", "2011-01-07", e2);
        Assert.Equal(2, Build(s, 140).Data.DrugExposures.Count);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R143_KeepsMedicationSeriesWithDifferentDates()
    {
        var s = Person(143); var e = Encounter(144); s.AddEncounter(143, e, interactionDate: "2011-01-07");
        s.AddMedicationAdministration(143, "55111067101", "2011-01-07", e); s.AddMedicationAdministration(143, "55111067101", "2011-01-08", e);
        Assert.Equal(2, Build(s, 143).Data.DrugExposures.Count);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R145_UsesEncounterProviderWhenAdministrationProviderIsNull()
    {
        var s = Person(145); var e = Encounter(146); s.AddProvider(147, "Internal Medicine"); s.AddEncounter(145, e, interactionDate: "2012-01-08", providerId: 147);
        s.AddMedicationAdministration(145, "55111067101", "2012-01-08", e); Assert.Equal(new DateTime(2012, 1, 8), Drug(s, 145).StartDate);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R148_MapsMedicationAdministrationNdc()
    { var s = Person(148); s.AddMedicationAdministration(148, "55111067101", "2012-01-08"); AssertDrugMapping(Drug(s, 148), 1322189, 45071548, "55111067101"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R149_MapsMedicationAdministrationQuantity()
    { var s = Person(149); s.AddMedicationAdministration(149, "55111067101", "2012-01-08", quantityOfDose: .5m); Assert.Equal(.5m, Drug(s, 149).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R150_MapsMedicationAdministrationRoute()
    { var s = Person(150); s.AddMedicationAdministration(150, "55111067101", "2012-01-08", route: "Oral"); AssertRoute(Drug(s, 150), 4132161, "Oral"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R151_UsesZeroForUnknownMedicationAdministrationRoute()
    { var s = Person(151); s.AddMedicationAdministration(151, "55111067101", "2012-01-08", route: "Osmosis"); AssertRoute(Drug(s, 151), 0, "Osmosis"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R152_MapsMedicationAdministrationStrengthUnit()
    { var s = Person(152); s.AddMedicationAdministration(152, "55111067101", "2012-01-08", strengthUnit: "mg/mL"); Assert.Equal("mg/mL", Drug(s, 152).DoseUnitSourceValue); }

    [Fact] public void Build_OptumPanther_DrugExposure_R153_LoadsPrescriptionWritten()
    { var s = Person(153); s.AddPrescription(153, "2012-01-08"); Assert.Equal(32838, Drug(s, 153).TypeConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R154_KeepsPrescriptionsInsideAndOutsideEnrollment()
    { var s = Person(154); s.AddPrescription(154, "2012-01-08"); s.AddPrescription(154, "2014-01-08"); Assert.Equal(2, Build(s, 154).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R155_MapsPrescriptionNdc()
    { var s = Person(155); s.AddPrescription(155, "2012-01-08", "55111067101"); AssertDrugMapping(Drug(s, 155), 1322189, 45071548, "55111067101"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R156_ParsesNumericPrefixFromPrescriptionQuantity()
    { var s = Person(156); s.AddPrescription(156, "2012-01-08", "55111067101", quantityPerFill: "90 Tab"); Assert.Equal(90m, Drug(s, 156).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R157_ParsesNumericPrescriptionQuantity()
    { var s = Person(157); s.AddPrescription(157, "2012-01-08", "55111067101", quantityPerFill: "90"); Assert.Equal(90m, Drug(s, 157).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R158_FallsBackToDoseWhenFillQuantityIsNull()
    { var s = Person(158); s.AddPrescription(158, "2012-01-08", "55111067101", quantityOfDose: "1", quantityPerFill: null); Assert.Equal(1m, Drug(s, 158).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R159_ParsesNumericPrefixFromDoseFallback()
    { var s = Person(159); s.AddPrescription(159, "2012-01-08", "55111067101", quantityOfDose: "1 tablet", quantityPerFill: null); Assert.Equal(1m, Drug(s, 159).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R160_MapsPrescriptionRefills()
    { var s = Person(160); s.AddPrescription(160, "2012-01-08", "55111067101", refills: "0"); Assert.Equal(0, Drug(s, 160).Refills); }

    [Fact] public void Build_OptumPanther_DrugExposure_R161_KeepsDefaultRefillsWhenQuantityIsNull()
    { var s = Person(161); s.AddPrescription(161, "2012-01-08", "55111067101", quantityPerFill: null); Assert.Equal(0, Drug(s, 161).Refills); }

    [Fact] public void Build_OptumPanther_DrugExposure_R162_ParsesDecimalDaysSupplyAsInteger()
    { var s = Person(162); s.AddPrescription(162, "2012-01-08", "55111067101", daysSupply: "1.0"); Assert.Equal(1, Drug(s, 162).DaysSupply); }

    [Fact] public void Build_OptumPanther_DrugExposure_R163_DefaultsMissingDaysSupplyToOne()
    { var s = Person(163); s.AddPrescription(163, "2012-01-08", "55111067101", daysSupply: null); Assert.Equal(1, Drug(s, 163).DaysSupply); }

    [Fact] public void Build_OptumPanther_DrugExposure_R164_MapsPrescriptionRoute()
    { var s = Person(164); s.AddPrescription(164, "2012-01-08", "55111067101", route: "Oral"); AssertRoute(Drug(s, 164), 4132161, "Oral"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R165_ConcatenatesPrescriptionDoseUnitSourceValue()
    {
        var s = Person(165); s.AddPrescription(165, "2012-01-08", "55111067101", strength: "20 - 25", strengthUnit: "15 MG", dosageForm: "Capsule Delayed Release", doseFrequency: "1 time a day");
        Assert.Equal("20 - 25;15 MG;Capsule Delayed Release;1 time a day", Drug(s, 165).DoseUnitSourceValue);
    }

    [Fact] public void Build_OptumPanther_DrugExposure_R166_LoadsPatientReportedMedication()
    { var s = Person(166); s.AddReportedMedication(166, "2012-01-08"); Assert.Single(Build(s, 166).Data.DrugExposures); }

    [Fact] public void Build_OptumPanther_DrugExposure_R167_KeepsReportedMedicationsInsideAndOutsideEnrollment()
    { var s = Person(167); s.AddReportedMedication(167, "2012-01-08"); s.AddReportedMedication(167, "2014-01-08"); Assert.Equal(2, Build(s, 167).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R168_MapsReportedDateAndType()
    { var s = Person(168); s.AddReportedMedication(168, "2012-01-08", "55111067101"); var d = Drug(s, 168); Assert.Equal(new DateTime(2012, 1, 8), d.StartDate); Assert.Equal(32865, d.TypeConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R169_MapsReportedMedicationNdc()
    { var s = Person(169); s.AddReportedMedication(169, "2012-01-08", "55111067101"); AssertDrugMapping(Drug(s, 169), 1322189, 45071548, "55111067101"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R170_MapsReportedMedicationRoute()
    { var s = Person(170); s.AddReportedMedication(170, "2012-01-08", "55111067101", "Oral"); AssertRoute(Drug(s, 170), 4132161, "Oral"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R171_MapsReportedMedicationQuantity()
    { var s = Person(171); s.AddReportedMedication(171, "2012-01-08", "55111067101", quantityOfDose: 6m); Assert.Equal(6m, Drug(s, 171).Quantity); }

    [Fact] public void Build_OptumPanther_DrugExposure_R172_LoadsImmunization()
    { var s = Person(172); s.AddImmunization(172, "2011-10-12", "66521011802", patientReported: "N"); Assert.Single(Build(s, 172).Data.DrugExposures); }

    [Fact] public void Build_OptumPanther_DrugExposure_R173_KeepsImmunizationsInsideAndOutsideEnrollment()
    { var s = Person(173); s.AddImmunization(173, "2011-10-12", "66521011802", patientReported: "N"); s.AddImmunization(173, "2013-10-12", "66521011802", patientReported: "N"); Assert.Equal(2, Build(s, 173).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R174_KeepsDuplicateImmunizations()
    { var s = Person(174); s.AddImmunization(174, "2011-10-12", "66521011802", patientReported: "N"); s.AddImmunization(174, "2011-10-12", "66521011802", patientReported: "N"); Assert.Equal(2, Build(s, 174).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R175_DropsImmunizationWithoutDate()
    { var s = Person(175); s.AddImmunization(175, null, "66521011802", patientReported: "N"); Assert.Empty(Build(s, 175).Data.DrugExposures); }

    [Fact] public void Build_OptumPanther_DrugExposure_R176_MapsImmunizationNdc()
    { var s = Person(176); s.AddImmunization(176, "2011-10-12", "66521011802", patientReported: "N"); AssertDrugMapping(Drug(s, 176), 46275888, 46364505, "66521011802"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R177_MapsAdministeredImmunizationType()
    { var s = Person(177); s.AddImmunization(177, "2011-10-12", "66521011802", patientReported: "N"); Assert.Equal(32818, Drug(s, 177).TypeConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R178_MapsPfizerCovidVaccineDescription()
    { var s = Person(178); s.AddImmunization(178, "2011-10-12", null, "COVID-19 VACCINE, PFIZER"); Assert.Equal(37003436, Drug(s, 178).ConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R181_MapsModernaCovidVaccineDescription()
    { var s = Person(181); s.AddImmunization(181, "2011-10-12", null, "COVID-19 VACCINE, MODERNA"); Assert.Equal(37003518, Drug(s, 181).ConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R184_MapsUnspecifiedCovidVaccineDescription()
    { var s = Person(184); s.AddImmunization(184, "2011-10-12", null, "SARS-COV-2 (COVID-19) vaccine, UNSPECIFIED"); Assert.Equal(724904, Drug(s, 184).ConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R187_RoutesDrugProcedureToDrugExposure()
    { var s = Person(187); s.AddProcedure(187, "J9310", "HCPCS", "2011-02-11"); Assert.Equal(32833, Drug(s, 187).TypeConceptId); }

    [Fact] public void Build_OptumPanther_DrugExposure_R188_KeepsDrugProceduresInsideAndOutsideEnrollment()
    { var s = Person(188); s.AddProcedure(188, "J9310", "HCPCS", "2011-10-12"); s.AddProcedure(188, "J9310", "HCPCS", "2013-10-12"); Assert.Equal(2, Build(s, 188).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R189_KeepsDuplicateDrugProcedures()
    { var s = Person(189); s.AddProcedure(189, "J9310", "HCPCS", "2011-10-12"); s.AddProcedure(189, "J9310", "HCPCS", "2011-10-12"); Assert.Equal(2, Build(s, 189).Data.DrugExposures.Count); }

    [Fact] public void Build_OptumPanther_DrugExposure_R190_MapsHcpcsDrugProcedure()
    { var s = Person(190); s.AddProcedure(190, "J9310", "HCPCS", "2011-10-12"); AssertDrugMapping(Drug(s, 190), 46275081, 2718907, "J9310"); }

    [Fact] public void Build_OptumPanther_DrugExposure_R191_LoadsAcceptedNlpDrugRationale()
    { var s = Person(191); var e = Encounter(192); s.AddEncounter(191, e, interactionDate: "2011-01-07"); s.AddNlpDrugRationale(191, "2011-01-07", "COUMADIN", "TAKE", null, "stop", e); var d = Drug(s, 191); Assert.Equal(1310149, d.ConceptId); Assert.Equal(32831, d.TypeConceptId); Assert.Equal("stop", d.StopReason); }

    [Fact] public void Build_OptumPanther_DrugExposure_R193_DropsStoppedNlpDrugRationale()
    { var s = Person(193); var e = Encounter(194); s.AddEncounter(193, e, interactionDate: "2011-01-07"); s.AddNlpDrugRationale(193, "2011-01-07", "COUMADIN", "STOP", null, "stop", e); Assert.Empty(Build(s, 193).Data.DrugExposures); }

    [Fact] public void Build_OptumPanther_DrugExposure_R195_DropsNeedNotNlpDrugRationale()
    { var s = Person(195); var e = Encounter(196); s.AddEncounter(195, e, interactionDate: "2011-01-07"); s.AddNlpDrugRationale(195, "2011-01-07", "COUMADIN", null, "NEED.NOT", "stop", e); Assert.Empty(Build(s, 195).Data.DrugExposures); }

    private static OptumPantherInMemoryScenario Person(long id)
    { var s = new OptumPantherInMemoryScenario(); s.AddStandardPerson(id, firstMonthActive: "201005", lastMonthActive: "201212"); return s; }

    private static string Encounter(long id) => OptumPantherInMemoryScenario.EncounterId(id);
    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long id) => source.Build(id);
    private static org.ohdsi.cdm.framework.common.Omop.DrugExposure Drug(OptumPantherInMemoryScenario source, long id) => Assert.Single(Build(source, id).Data.DrugExposures);

    private static void AssertDrugMapping(org.ohdsi.cdm.framework.common.Omop.DrugExposure drug, long concept, long sourceConcept, string source)
    { Assert.Equal(concept, drug.ConceptId); Assert.Equal(sourceConcept, drug.SourceConceptId); Assert.Equal(source, drug.SourceValue); }

    private static void AssertRoute(org.ohdsi.cdm.framework.common.Omop.DrugExposure drug, long concept, string source)
    { Assert.Equal(concept, drug.RouteConceptId); Assert.Equal(source, drug.RouteSourceValue); }
}
