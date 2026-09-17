using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R901_MapsPersonId()
    {
        var source = BasicScenario("M000000901", "C000000000901");

        Assert.Equal(901L, VisitProcedure(source, "M000000901", 901).PersonId);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R902_MapsVisitOccurrenceId()
    {
        var source = BasicScenario("M000000902", "C000000000902");

        Assert.Equal(902L, VisitProcedure(source, "M000000902", 902).VisitOccurrenceId);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R903_MapsProcedureTypeByProcedureClaimType()
    {
        const string memberId = "M000000903";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        AddClaimAndProcedure(source, memberId, "C000000000903", "Outpatient");
        AddClaimAndProcedure(source, memberId, "C000000000904", "Inpatient");
        AddClaimAndProcedure(source, memberId, "C000000000905", "DPC");

        var procedures = source.Build(memberId).ProcedureOccurrences;

        Assert.Equal(32859L, Assert.Single(procedures, x => x.VisitOccurrenceId == 903).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(procedures, x => x.VisitOccurrenceId == 904).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(procedures, x => x.VisitOccurrenceId == 905).TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R904_MapsProviderFromMedicalFacility()
    {
        const string memberId = "M000000904";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000907");
        source.AddProcedure(memberId, "C000000000907", medicalFacilityId: "F0000008");

        Assert.Equal(10000008L, VisitProcedure(source, memberId, 907).ProviderId);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R906_UsesProcedureDate()
    {
        const string memberId = "M000000906";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000909");
        source.AddProcedure(memberId, "C000000000909", dateOfProcedure: "2010-01-05");

        Assert.Equal(new DateTime(2010, 1, 5), VisitProcedure(source, memberId, 909).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R907_UsesVisitDateWhenProcedureDateIsNull()
    {
        const string memberId = "M000000907";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000910", monthAndYearOfMedicalCare: "201002");
        source.AddProcedure(memberId, "C000000000910", dateOfProcedure: null);

        Assert.Equal(new DateTime(2010, 2, 15), VisitProcedure(source, memberId, 910).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R908_MapsProcedureThroughProcedureMaster()
    {
        const string memberId = "M000000908";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000911");
        source.AddProcedure(memberId, "C000000000911",
            standardizedProcedureCode: 1, standardizedProcedureVersion: "1");
        source.AddProcedureMaster(1, "1", "9394");

        var procedure = VisitProcedure(source, memberId, 911);

        Assert.Equal(4206920L, procedure.ConceptId);
        Assert.Equal("9394", procedure.SourceValue);
        Assert.Equal(2007683L, procedure.SourceConceptId);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_R909_RoutesMappedDiagnosisToProcedureDomain()
    {
        const string memberId = "M000000909";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000912");
        source.AddDiagnosis(memberId, "C000000000912",
            standardDiseaseCode: 2, typeOfClaim: "Outpatient");
        source.AddDiagnosisMaster(2, "Z043");

        var procedure = VisitProcedure(source, memberId, 912);

        Assert.Equal(4085923L, procedure.ConceptId);
        Assert.Equal(32859L, procedure.TypeConceptId);
    }

    private static JmdcInMemoryScenario BasicScenario(string memberId, string claimId)
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, claimId);
        source.AddProcedure(memberId, claimId);
        return source;
    }

    private static void AddClaimAndProcedure(
        JmdcInMemoryScenario source,
        string memberId,
        string claimId,
        string typeOfClaim)
    {
        source.AddClaim(memberId, claimId);
        source.AddProcedure(memberId, claimId, typeOfClaim: typeOfClaim);
    }

    private static ProcedureOccurrence VisitProcedure(
        JmdcInMemoryScenario source,
        string memberId,
        long visitId)
    {
        return Assert.Single(
            source.Build(memberId).ProcedureOccurrences,
            item => item.VisitOccurrenceId == visitId);
    }
}
