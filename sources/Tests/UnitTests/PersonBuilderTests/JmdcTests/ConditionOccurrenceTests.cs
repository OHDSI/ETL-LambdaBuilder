using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ConditionOccurrenceTests
{
    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R701_MapsPersonId()
    {
        var source = BasicScenario("M000000701", "C000000000701");

        Assert.Equal(701L, VisitCondition(source, "M000000701", 701).PersonId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R702_MapsVisitOccurrenceId()
    {
        var source = BasicScenario("M000000702", "C000000000702");

        Assert.Equal(702L, VisitCondition(source, "M000000702", 702).VisitOccurrenceId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R703_MapsConditionTypeByDiagnosisClaimType()
    {
        const string memberId = "M000000703";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        AddClaimAndDiagnosis(source, memberId, "C000000000703", "Outpatient");
        AddClaimAndDiagnosis(source, memberId, "C000000000704", "Inpatient");
        AddClaimAndDiagnosis(source, memberId, "C000000000705", "DPC");

        var conditions = source.Build(memberId).ConditionOccurrences;

        Assert.Equal(32859L, Assert.Single(conditions, x => x.VisitOccurrenceId == 703).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(conditions, x => x.VisitOccurrenceId == 704).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(conditions, x => x.VisitOccurrenceId == 705).TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R704_UsesAdmissionDateAsConditionStart()
    {
        const string memberId = "M000000704";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000706",
            monthAndYearOfMedicalCare: "201002", admissionDate: "2010-01-01");
        source.AddDiagnosis(memberId, "C000000000706");

        Assert.Equal(new DateTime(2010, 1, 1), VisitCondition(source, memberId, 706).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R705_UsesClaimDateAsConditionStart()
    {
        const string memberId = "M000000705";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000707", monthAndYearOfMedicalCare: "201002");
        source.AddDiagnosis(memberId, "C000000000707");

        Assert.Equal(new DateTime(2010, 2, 15), VisitCondition(source, memberId, 707).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R706_MapsProviderFromMedicalFacility()
    {
        const string memberId = "M000000706";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000708");
        source.AddDiagnosis(memberId, "C000000000708", medicalFacilityId: "F0000006");

        Assert.Equal(10000006L, VisitCondition(source, memberId, 708).ProviderId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R707_MapsConditionConceptAndSourceFieldsThroughDiagnosisMaster()
    {
        const string memberId = "M000000707";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000709");
        source.AddDiagnosis(memberId, "C000000000709",
            standardDiseaseCode: 8842488,
            standardDiseaseName: "hypertensive urgency");
        source.AddDiagnosisMaster(8842488, "I10-");

        var condition = VisitCondition(source, memberId, 709);

        Assert.Equal(320128L, condition.ConceptId);
        Assert.Equal("8842488|hypertensive urgency", condition.SourceValue);
        Assert.Equal(45591453L, condition.SourceConceptId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R710_RemovesDiagnosisWithSuspicionFlag()
    {
        const string memberId = "M000000710";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000712");
        source.AddDiagnosis(memberId, "C000000000712",
            standardDiseaseCode: 1, suspicionFlag: 1);

        Assert.Empty(source.Build(memberId).ConditionOccurrences);
    }

    private static JmdcInMemoryScenario BasicScenario(string memberId, string claimId)
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, claimId);
        source.AddDiagnosis(memberId, claimId);
        return source;
    }

    private static void AddClaimAndDiagnosis(
        JmdcInMemoryScenario source,
        string memberId,
        string claimId,
        string typeOfClaim)
    {
        source.AddClaim(memberId, claimId);
        source.AddDiagnosis(memberId, claimId, typeOfClaim: typeOfClaim);
    }

    private static ConditionOccurrence VisitCondition(
        JmdcInMemoryScenario source,
        string memberId,
        long visitId)
    {
        return Assert.Single(
            source.Build(memberId).ConditionOccurrences,
            item => item.VisitOccurrenceId == visitId);
    }
}
