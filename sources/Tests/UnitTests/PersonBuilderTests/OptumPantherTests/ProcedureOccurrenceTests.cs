using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R333_MapsCpt4Procedure()
    {
        var procedure = BuildProcedure(333, "36415", "CPT4");

        Assert.Equal(4102442, procedure.ConceptId);
        Assert.Equal("36415", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R334_MapsHcpcsProcedure()
    {
        var procedure = BuildProcedure(334, "C9743", "HCPCS");

        Assert.Equal(37204304, procedure.ConceptId);
        Assert.Equal("C9743", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R335_MapsIcd9Procedure()
    {
        var procedure = BuildProcedure(335, "33.50", "ICD9");

        Assert.Equal(4337138, procedure.ConceptId);
        Assert.Equal("33.50", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R336_MapsIcd10Procedure()
    {
        var procedure = BuildProcedure(336, "0J8S0", "ICD10");

        Assert.Equal(2863829, procedure.ConceptId);
        Assert.Equal("0J8S0", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R337_UsesEhrProcedureType()
    {
        Assert.Equal(32833, BuildProcedure(337, "36415", "CPT4").TypeConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R338_BlankCodeTypeIsUnmapped()
    {
        Assert.Equal(0, BuildProcedure(338, "36415", string.Empty).ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R339_CustomCodeTypeIsUnmapped()
    {
        Assert.Equal(0, BuildProcedure(339, "36415", "CUSTOM").ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R340_RevenueCodeTypeIsUnmappedProcedure()
    {
        Assert.Equal(0, BuildProcedure(340, "36415", "REV").ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R341_ClaimUnknownCodeTypeIsUnmapped()
    {
        Assert.Equal(0, BuildProcedure(341, "36415", "CLM_UNK").ConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R342_DiagnosisUsesEhrDiagnosisType()
    {
        Assert.Equal(32840, BuildDiagnosisProcedure(342, 343, "7606", "ICD9").TypeConceptId);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R344_RoutesIcd9DiagnosisToProcedure()
    {
        var procedure = BuildDiagnosisProcedure(344, 345, "7606", "ICD9");

        Assert.Equal(4301351, procedure.ConceptId);
        Assert.Equal("7606", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R346_RoutesIcd10DiagnosisToProcedure()
    {
        var procedure = BuildDiagnosisProcedure(346, 347, "Z01.110", "ICD10");

        Assert.Equal(4134565, procedure.ConceptId);
        Assert.Equal("Z01.110", procedure.SourceValue);
    }

    [Fact]
    public void Build_OptumPanther_ProcedureOccurrence_R348_RoutesSnomedDiagnosisToProcedure()
    {
        var procedure = BuildDiagnosisProcedure(348, 349, "10019001", "SNOMED");

        Assert.Equal(4001760, procedure.ConceptId);
        Assert.Equal("10019001", procedure.SourceValue);
    }

    private static org.ohdsi.cdm.framework.common.Omop.ProcedureOccurrence BuildProcedure(
        long personId,
        string code,
        string codeType)
    {
        var source = StandardPerson(personId);
        source.AddProcedure(personId, code, codeType, "2009-01-01");

        return Assert.Single(Build(source, personId).Data.ProcedureOccurrences);
    }

    private static org.ohdsi.cdm.framework.common.Omop.ProcedureOccurrence BuildDiagnosisProcedure(
        long personId,
        long encounterSequence,
        string code,
        string codeType)
    {
        var source = StandardPerson(personId);
        source.AddEncounter(personId, OptumPantherInMemoryScenario.EncounterId(encounterSequence),
            interactionDate: "2009-01-01");
        source.AddDiagnosis(personId, code, codeType, diagnosisDate: "2009-01-01");

        return Assert.Single(Build(source, personId).Data.ProcedureOccurrences);
    }

    private static OptumPantherInMemoryScenario StandardPerson(long personId)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, "Male", "1950", idnIndicator: false,
            firstMonthActive: "200701", lastMonthActive: "201001");
        return source;
    }

    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long personId)
    {
        var result = source.Build(personId);
        Assert.Equal(Attrition.None, result.Attrition);
        return result;
    }
}
