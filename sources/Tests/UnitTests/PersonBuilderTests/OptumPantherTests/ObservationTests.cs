using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class ObservationTests
{
    private const string EmptyRCase = "The R source only calls declareTest; it contains no add_* source data and no expect_* assertion.";

    [Fact]
    public void Build_OptumPanther_Observation_R237_MapsObservationDate()
    {
        var source = StandardPerson(237);
        source.AddObservation(237, "2009-01-01", "SMOKE");

        Assert.Equal(new DateTime(2009, 1, 1), SingleObservation(source, 237).StartDate.Date);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R238_KeepsObservationOutsideEnrollmentDates()
    {
        var source = StandardPerson(238);
        source.AddObservation(238, "2009-01-01", "SMOKE");
        source.AddObservation(238, "2015-01-01", "SMOKE");

        Assert.Equal(2, Build(source, 238).Data.Observations.Count);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R239_KeepsDuplicateObservationRows()
    {
        var source = StandardPerson(239);
        source.AddObservation(239, "2009-01-01", "SMOKE");
        source.AddObservation(239, "2009-01-01", "SMOKE");

        Assert.Equal(2, Build(source, 239).Data.Observations.Count);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R240_MapsObservationTypeThroughStcm()
    {
        var source = StandardPerson(240);
        source.AddObservation(240, "2009-01-01", "SMOKE");

        Assert.Equal(40766362, SingleObservation(source, 240).ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R241_UnmappedObservationTypeUsesZero()
    {
        var source = StandardPerson(241);
        source.AddObservation(241, "2009-01-01", "SMOKEX");

        Assert.Equal(0, SingleObservation(source, 241).ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R242_UsesEhrObservationType()
    {
        var source = StandardPerson(242);
        source.AddObservation(242, "2009-01-01", "SMOKE");

        Assert.Equal(32831, SingleObservation(source, 242).TypeConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R243_CombinesObservationDateAndTime()
    {
        var source = StandardPerson(243);
        source.AddObservation(243, "2009-01-01", "SMOKE", "14:30:00");

        Assert.Equal(new DateTime(2009, 1, 1, 14, 30, 0), SingleObservation(source, 243).StartDate);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R244_ParsesNumericResultAsNumber()
    {
        var source = StandardPerson(244);
        source.AddObservation(244, "2009-01-01", "SMOKE", observationResult: "100");

        var observation = SingleObservation(source, 244);

        Assert.Equal(100m, observation.ValueAsNumber);
        Assert.Null(observation.ValueAsString);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R245_StoresNonNumericResultAsString()
    {
        var source = StandardPerson(245);
        source.AddObservation(245, "2009-01-01", "SMOKE", observationResult: "One Hundred");

        var observation = SingleObservation(source, 245);

        Assert.Null(observation.ValueAsNumber);
        Assert.Equal("One Hundred", observation.ValueAsString);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R246_MapsKilogramUcumUnit()
    {
        var source = StandardPerson(246);
        source.AddObservation(246, "2009-01-01", "SMOKE", observationResult: "100", observationUnit: "kilogram");

        var observation = SingleObservation(source, 246);

        Assert.Equal(9529, observation.UnitsConceptId);
        Assert.Equal("kilogram", observation.UnitsSourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R247_MapsKgUcumUnit()
    {
        var source = StandardPerson(247);
        source.AddObservation(247, "2009-01-01", "SMOKE", observationResult: "100", observationUnit: "kg");

        var observation = SingleObservation(source, 247);

        Assert.Equal(9529, observation.UnitsConceptId);
        Assert.Equal("kg", observation.UnitsSourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R248_UnmappedUnitUsesZero()
    {
        var source = StandardPerson(248);
        source.AddObservation(248, "2009-01-01", "SMOKE", observationResult: "100", observationUnit: "TEST_UNIT");

        var observation = SingleObservation(source, 248);

        Assert.Equal(0, observation.UnitsConceptId);
        Assert.Equal("TEST_UNIT", observation.UnitsSourceValue);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R249_HistoryOfPrimaryDischargeBecomesObservation()
    {
        var source = StandardPerson(249);
        source.AddEncounter(249, Encounter(250), interactionDate: "2009-01-01");
        source.AddDiagnosis(249, "H44611", "ICD10", "History of", "2009-01-01",
            primaryDiagnosis: "1", dischargeDiagnosis: "1");

        var observation = SingleObservation(source, 249);

        Assert.Equal(1340204, observation.ConceptId);
        Assert.Equal(381850, observation.ValueAsConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Observation_R251_HistoryOfPrimaryDiagnosisBecomesObservation()
    {
        var source = StandardPerson(251);
        source.AddEncounter(251, Encounter(252), interactionDate: "2009-01-01");
        // This deliberately mirrors R exactly: its second case also sets discharge_diagnosis = '1'.
        source.AddDiagnosis(251, "H44611", "ICD10", "History of", "2009-01-01",
            primaryDiagnosis: "1", dischargeDiagnosis: "1");

        var observation = SingleObservation(source, 251);

        Assert.Equal(1340204, observation.ConceptId);
        Assert.Equal(381850, observation.ValueAsConceptId);
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R253_DiagnosisDateAndTimePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R255_DiagnosisInsideAndOutsideEnrollmentPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R257_Icd10DiagnosisMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R259_CielDiagnosisMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R261_DiagnosisVisitMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R263_DiagnosisProviderMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R265_ProcedureDateAndTimePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R267_ProcedureInsideAndOutsideEnrollmentPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R269_Icd10ProcedureMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R271_CielProcedureMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R273_ProcedureVisitMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R275_ProcedureProviderMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R277_MicrobiologyDateAndTimePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R279_MicrobiologyInsideAndOutsideEnrollmentPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R281_MicrobiologyVisitMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R283_MicrobiologyProviderMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R285_MicrobiologyOrganismPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R287_NlpBiomarkerDatePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R289_NlpBiomarkerInsideAndOutsideEnrollmentPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R291_NlpBiomarkerConceptPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R293_NlpBiomarkerConcatenationPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R295_InsuranceDateAndTimePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R297_InsuranceInsideAndOutsideEnrollmentPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R299_InsuranceTypePlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R301_InsuranceVisitMappingPlaceholderFromR()
    {
    }

    [Fact(Skip = EmptyRCase)]
    public void Build_OptumPanther_Observation_R303_InsuranceProviderMappingPlaceholderFromR()
    {
    }

    private static string Encounter(long sequence) => OptumPantherInMemoryScenario.EncounterId(sequence);

    private static OptumPantherInMemoryScenario StandardPerson(long personId)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, "Male", "1950", idnIndicator: false,
            firstMonthActive: "200701", lastMonthActive: "201001");
        return source;
    }

    private static org.ohdsi.cdm.framework.common.Omop.Observation SingleObservation(
        OptumPantherInMemoryScenario source,
        long personId) => Assert.Single(Build(source, personId).Data.Observations);

    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long personId)
    {
        var result = source.Build(personId);
        Assert.Equal(Attrition.None, result.Attrition);
        return result;
    }
}
