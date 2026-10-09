using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ConditionOccurrenceTests
{
    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R701_ConditionOccurrencePersonId()
    {
        const string memberId = "M000000701";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000701");
        source.AddDiagnosis(memberId, "C000000000701");

        Assert.Equal(701L, VisitCondition(source, memberId, 701).PersonId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R702_ConditionOccurrenceVisitOccurrenceId()
    {
        const string memberId = "M000000702";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000702");
        source.AddDiagnosis(memberId, "C000000000702");

        Assert.Equal(702L, VisitCondition(source, memberId, 702).VisitOccurrenceId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R703_ConditionTypeConceptId()
    {
        const string memberId = "M000000703";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000703");
        source.AddDiagnosis(memberId, "C000000000703", typeOfClaim: "Outpatient");
        source.AddClaim(memberId, "C000000000704");
        source.AddDiagnosis(memberId, "C000000000704", typeOfClaim: "Inpatient");
        source.AddClaim(memberId, "C000000000705");
        source.AddDiagnosis(memberId, "C000000000705", typeOfClaim: "DPC");

        var conditions = source.Build(memberId).ConditionOccurrences;

        Assert.Equal(32859L, Assert.Single(conditions, x => x.VisitOccurrenceId == 703).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(conditions, x => x.VisitOccurrenceId == 704).TypeConceptId);
        Assert.Equal(32853L, Assert.Single(conditions, x => x.VisitOccurrenceId == 705).TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R704_ConditionStartDateFromAdmissionDate()
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
    public void Build_Jmdc_ConditionOccurrence_R705_ConditionStartDateFromClaimDate()
    {
        const string memberId = "M000000705";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000707", monthAndYearOfMedicalCare: "201002");
        source.AddDiagnosis(memberId, "C000000000707");

        Assert.Equal(new DateTime(2010, 2, 15), VisitCondition(source, memberId, 707).StartDate);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R706_ConditionProviderId()
    {
        const string memberId = "M000000706";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000708");
        source.AddDiagnosis(memberId, "C000000000708", medicalFacilityId: "F0000006");

        Assert.Equal(10000006L, VisitCondition(source, memberId, 708).ProviderId);
    }

    [Fact]
    public void Build_Jmdc_ConditionOccurrence_R707_ConditionConceptIdAndSourceValues()
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
    public void Build_Jmdc_ConditionOccurrence_R710_ConditionWithSuspicionFlag()
    {
        const string memberId = "M000000710";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000712");
        source.AddDiagnosis(memberId, "C000000000712",
            standardDiseaseCode: 1, suspicionFlag: 1);

        Assert.Empty(source.Build(memberId).ConditionOccurrences);
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
