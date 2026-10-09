using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class ConditionOccurrenceTests
{
    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R001_MapsDiagnosisDateToConditionStartDate()
    {
        var source = StandardPerson(1);
        source.AddDiagnosis(1, "7061", "ICD9", diagnosisDate: "2009-01-01");

        var condition = Assert.Single(Build(source, 1).Data.ConditionOccurrences);

        Assert.Equal(new DateTime(2009, 1, 1), condition.StartDate);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R002_MapsIcd9DiagnosisCode()
    {
        var source = StandardPerson(2);
        source.AddEncounter(2, OptumPantherInMemoryScenario.EncounterId(3), interactionDate: "2009-01-01");
        source.AddDiagnosis(2, "7061", "ICD9", diagnosisDate: "2009-01-01");

        var condition = Assert.Single(Build(source, 2).Data.ConditionOccurrences);

        Assert.Equal(141095, condition.ConceptId);
        Assert.Equal("7061", condition.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R004_MapsIcd10DiagnosisCode()
    {
        var source = StandardPerson(4);
        source.AddEncounter(4, OptumPantherInMemoryScenario.EncounterId(5), interactionDate: "2009-01-01");
        source.AddDiagnosis(4, "H44611", "ICD10", diagnosisDate: "2009-01-01");

        var condition = Assert.Single(Build(source, 4).Data.ConditionOccurrences);

        Assert.Equal(381850, condition.ConceptId);
        Assert.Equal("H44611", condition.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R006_MapsPrimaryAdmissionStatus()
    {
        var source = StandardPerson(6);
        source.AddEncounter(6, OptumPantherInMemoryScenario.EncounterId(7), interactionDate: "2009-01-01");
        source.AddDiagnosis(6, "7061", "ICD9", diagnosisDate: "2009-01-01", primaryDiagnosis: "1", admittingDiagnosis: "1");

        Assert.Equal(32901, Assert.Single(Build(source, 6).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R008_MapsPrimaryDiagnosisStatus()
    {
        var source = StandardPerson(8);
        source.AddEncounter(8, OptumPantherInMemoryScenario.EncounterId(9), interactionDate: "2009-01-01");
        source.AddDiagnosis(8, "7061", "ICD9", diagnosisDate: "2009-01-01", primaryDiagnosis: "1");

        Assert.Equal(32902, Assert.Single(Build(source, 8).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R010_MapsPrimaryDischargeStatus()
    {
        var source = StandardPerson(10);
        source.AddEncounter(10, OptumPantherInMemoryScenario.EncounterId(11), interactionDate: "2009-01-01");
        source.AddDiagnosis(10, "7061", "ICD9", diagnosisDate: "2009-01-01", primaryDiagnosis: "1", dischargeDiagnosis: "1");

        Assert.Equal(32903, Assert.Single(Build(source, 10).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R012_PossiblePrimaryDischargeIsPreliminary()
    {
        var source = StandardPerson(12);
        source.AddEncounter(12, OptumPantherInMemoryScenario.EncounterId(13), interactionDate: "2009-01-01");
        source.AddDiagnosis(12, "7061", "ICD9", "Possible diagnosis of", "2009-01-01", primaryDiagnosis: "1", dischargeDiagnosis: "1");

        Assert.Equal(32899, Assert.Single(Build(source, 12).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R014_PossiblePrimaryDiagnosisIsPreliminary()
    {
        var source = StandardPerson(14);
        source.AddEncounter(14, OptumPantherInMemoryScenario.EncounterId(15), interactionDate: "2009-01-01");
        source.AddDiagnosis(14, "7061", "ICD9", "Possible diagnosis of", "2009-01-01", primaryDiagnosis: "1");

        Assert.Equal(32899, Assert.Single(Build(source, 14).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R016_HistoryOfPrimaryDiagnosisMovesOutOfCondition()
    {
        var source = StandardPerson(16);
        source.AddEncounter(16, OptumPantherInMemoryScenario.EncounterId(17), interactionDate: "2009-01-01");
        source.AddDiagnosis(16, "7061", "ICD9", "History of", "2009-01-01", primaryDiagnosis: "1");

        Assert.Empty(Build(source, 16).Data.ConditionOccurrences);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R018_HistoryOfPrimaryDischargeMovesOutOfCondition()
    {
        var source = StandardPerson(18);
        source.AddEncounter(18, OptumPantherInMemoryScenario.EncounterId(19), interactionDate: "2009-01-01");
        source.AddDiagnosis(18, "7061", "ICD9", "History of", "2009-01-01", primaryDiagnosis: "1", dischargeDiagnosis: "1");

        Assert.Empty(Build(source, 18).Data.ConditionOccurrences);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R020_MapsAdmissionStatus()
    {
        var source = StandardPerson(20);
        source.AddEncounter(20, OptumPantherInMemoryScenario.EncounterId(21), interactionDate: "2009-01-01");
        source.AddDiagnosis(20, "7061", "ICD9", diagnosisDate: "2009-01-01", admittingDiagnosis: "1");

        Assert.Equal(32890, Assert.Single(Build(source, 20).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R022_MapsDischargeStatus()
    {
        var source = StandardPerson(22);
        source.AddEncounter(22, OptumPantherInMemoryScenario.EncounterId(23), interactionDate: "2009-01-01");
        source.AddDiagnosis(22, "7061", "ICD9", diagnosisDate: "2009-01-01", dischargeDiagnosis: "1");

        Assert.Equal(32896, Assert.Single(Build(source, 22).Data.ConditionOccurrences).StatusConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R024_WrongCodeTypeRemainsUnmapped()
    {
        var source = StandardPerson(24);
        source.AddEncounter(24, OptumPantherInMemoryScenario.EncounterId(25), interactionDate: "2009-01-01");
        source.AddDiagnosis(24, "44786629", "ICD9", diagnosisDate: "2009-01-01");

        Assert.Equal(0, Assert.Single(Build(source, 24).Data.ConditionOccurrences).ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R026_BlankDiagnosisCodeRemainsUnmapped()
    {
        var source = StandardPerson(26);
        source.AddEncounter(26, OptumPantherInMemoryScenario.EncounterId(27), interactionDate: "2009-01-01");
        source.AddDiagnosis(26, null, null, diagnosisDate: "2009-01-01");

        Assert.Equal(0, Assert.Single(Build(source, 26).Data.ConditionOccurrences).ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ConditionOccurrence_R028_RoutesHcpcsProcedureToCondition()
    {
        var source = StandardPerson(28);
        source.AddProcedure(28, "G9312", "HCPCS", "2009-01-01");

        var result = Build(source, 28);

        Assert.Contains(result.Data.ConditionOccurrences, item => item.ConceptId == 4334801);
        Assert.DoesNotContain(result.Data.ProcedureOccurrences, item => item.SourceValue == "G9312");
    }

    private static OptumPantherInMemoryScenario StandardPerson(long personId)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(
            personId,
            gender: "Male",
            birthYear: "1950",
            idnIndicator: false,
            firstMonthActive: "200701",
            lastMonthActive: "201001");
        return source;
    }

    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long personId)
    {
        var result = source.Build(personId);
        Assert.Equal(Attrition.None, result.Attrition);
        return result;
    }
}
