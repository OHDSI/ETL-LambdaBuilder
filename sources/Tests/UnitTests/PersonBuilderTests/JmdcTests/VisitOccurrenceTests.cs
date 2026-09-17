using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class VisitOccurrenceTests
{
    [Fact]
    public void Build_Jmdc_VisitOccurrence_R401_MapsVisitAndPersonIds()
    {
        var source = ClaimScenario("M000000401", "C000000000401");

        var visit = Visit(source, "M000000401", 401);

        Assert.Equal(401L, visit.Id);
        Assert.Equal(401L, visit.PersonId);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R402_MapsVisitConceptByClaimType()
    {
        const string memberId = "M000000402";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000402", typeOfClaim: "Outpatient");
        source.AddClaim(memberId, "C000000000403", typeOfClaim: "DPC");
        source.AddClaim(memberId, "C000000000404", typeOfClaim: "Inpatient");

        var visits = source.Build(memberId).VisitOccurrences;

        Assert.Equal(9202L, Assert.Single(visits, x => x.Id == 402).ConceptId);
        Assert.Equal(9201L, Assert.Single(visits, x => x.Id == 403).ConceptId);
        Assert.Equal(9201L, Assert.Single(visits, x => x.Id == 404).ConceptId);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R403_UsesMiddleOfClaimMonthWithoutOtherDates()
    {
        var source = ClaimScenario("M000000403", "C000000000406", "201002");

        Assert.Equal(new DateTime(2010, 2, 15), Visit(source, "M000000403", 406).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R404_UsesAdmissionDateWithinClaimMonth()
    {
        const string memberId = "M000000404";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000407",
            monthAndYearOfMedicalCare: "201002", admissionDate: "2010-02-05");

        Assert.Equal(new DateTime(2010, 2, 5), Visit(source, memberId, 407).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R405_UsesFirstOfClaimMonthWhenAdmissionIsOutsideMonth()
    {
        const string memberId = "M000000405";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000408",
            monthAndYearOfMedicalCare: "201002", admissionDate: "2010-01-05");

        Assert.Equal(new DateTime(2010, 2, 1), Visit(source, memberId, 408).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R406_UsesPrescriptionDate()
    {
        const string memberId = "M000000406";
        var source = ClaimScenario(memberId, "C000000000409", "201002");
        source.AddDrug(memberId, "C000000000409", dateOfPrescription: "2010-02-05");

        Assert.Equal(new DateTime(2010, 2, 5), Visit(source, memberId, 409).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R407_UsesProcedureDate()
    {
        const string memberId = "M000000407";
        var source = ClaimScenario(memberId, "C000000000410", "201002");
        source.AddProcedure(memberId, "C000000000410", dateOfProcedure: "2010-02-05");

        Assert.Equal(new DateTime(2010, 2, 5), Visit(source, memberId, 410).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R408_UsesUniqueDiagnosisStartWithinClaimMonth()
    {
        const string memberId = "M000000408";
        var source = ClaimScenario(memberId, "C000000000411", "201002");
        source.AddDiagnosis(memberId, "C000000000411", dateOfMedicalCareStart: "2010-02-08");

        Assert.Equal(new DateTime(2010, 2, 8), Visit(source, memberId, 411).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R409_IgnoresDiagnosisStartOutsideClaimMonth()
    {
        const string memberId = "M000000409";
        var source = ClaimScenario(memberId, "C000000000412", "201002");
        source.AddDiagnosis(memberId, "C000000000412", dateOfMedicalCareStart: "2010-01-01");

        Assert.Equal(new DateTime(2010, 2, 15), Visit(source, memberId, 412).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R410_ComputesEndFromFinalStartAndDays()
    {
        const string memberId = "M000000410";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000413", monthAndYearOfMedicalCare: "201002", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000414", monthAndYearOfMedicalCare: "201004", admissionDate: "2010-04-05", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000415", monthAndYearOfMedicalCare: "201006", admissionDate: "2010-05-05", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000416", monthAndYearOfMedicalCare: "201008", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000417", monthAndYearOfMedicalCare: "201010", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000418", monthAndYearOfMedicalCare: "201012", daysOfMedicalCare: 3);
        source.AddClaim(memberId, "C000000000419", monthAndYearOfMedicalCare: "201102", daysOfMedicalCare: 3);
        source.AddDrug(memberId, "C000000000416", dateOfPrescription: "2010-08-05");
        source.AddProcedure(memberId, "C000000000417", dateOfProcedure: "2010-10-05");
        source.AddDiagnosis(memberId, "C000000000418", dateOfMedicalCareStart: "2010-12-05");
        source.AddDiagnosis(memberId, "C000000000419", dateOfMedicalCareStart: "2011-01-08");

        var visits = source.Build(memberId).VisitOccurrences;

        AssertEnd(visits, 413, new DateTime(2010, 2, 17));
        AssertEnd(visits, 414, new DateTime(2010, 4, 7));
        AssertEnd(visits, 415, new DateTime(2010, 6, 3));
        AssertEnd(visits, 416, new DateTime(2010, 8, 7));
        AssertEnd(visits, 417, new DateTime(2010, 10, 7));
        AssertEnd(visits, 418, new DateTime(2010, 12, 7));
        AssertEnd(visits, 419, new DateTime(2011, 2, 17));
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R411_MapsVisitTypeConcept()
    {
        var source = ClaimScenario("M000000411", "C000000000420");

        Assert.Equal(32810L, Visit(source, "M000000411", 420).TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R412_MapsCareSiteFromMedicalFacility()
    {
        const string memberId = "M000000412";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000421", medicalFacilityId: "F0000002");

        Assert.Equal(10000002L, Visit(source, memberId, 421).CareSiteId);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R413_MapsClaimTypeAsVisitSourceValue()
    {
        const string memberId = "M000000413";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000422", typeOfClaim: "Outpatient");

        Assert.Equal("Outpatient", Visit(source, memberId, 422).SourceValue);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R414_UsesOnlyDiagnosisDatesUniqueByCodeProviderAndStart()
    {
        const string memberId = "M000000414";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000423", monthAndYearOfMedicalCare: "201002");
        source.AddDiagnosis(memberId, "C000000000423", dateOfMedicalCareStart: "2010-02-08");
        source.AddDiagnosis(memberId, "C000000000423", dateOfMedicalCareStart: "2010-02-12");

        source.AddClaim(memberId, "C000000000424", monthAndYearOfMedicalCare: "201003");
        source.AddDiagnosis(memberId, "C000000000424", dateOfMedicalCareStart: "2010-03-08");
        source.AddDiagnosis(memberId, "C000000000424", dateOfMedicalCareStart: "2010-03-12", medicalFacilityId: "F0000002");
        source.AddDiagnosis(memberId, "C000000000424", dateOfMedicalCareStart: "2010-03-10", medicalFacilityId: "F0000002");

        source.AddClaim(memberId, "C000000000425", monthAndYearOfMedicalCare: "201003");
        source.AddDiagnosis(memberId, "C000000000425", dateOfMedicalCareStart: "2010-03-12", medicalFacilityId: "F0000002");
        source.AddDiagnosis(memberId, "C000000000425", dateOfMedicalCareStart: "2010-03-10", medicalFacilityId: "F0000002");

        var visits = source.Build(memberId).VisitOccurrences;

        Assert.Equal(new DateTime(2010, 2, 12), Assert.Single(visits, x => x.Id == 423).StartDate);
        Assert.Equal(new DateTime(2010, 3, 8), Assert.Single(visits, x => x.Id == 424).StartDate);
        Assert.Equal(new DateTime(2010, 3, 15), Assert.Single(visits, x => x.Id == 425).StartDate);
    }

    [Fact]
    public void Build_Jmdc_VisitOccurrence_R415_DropsPharmacyVisit()
    {
        const string memberId = "M000000415";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000426", typeOfClaim: "Pharmacy");

        var data = source.Build(memberId);

        Assert.Single(data.VisitOccurrences);
        Assert.Single(data.VisitDetails);
        Assert.DoesNotContain(data.VisitOccurrences, item => item.Id == 426);
    }

    private static JmdcInMemoryScenario ClaimScenario(
        string memberId,
        string claimId,
        string monthAndYear = "202312")
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, claimId, monthAndYearOfMedicalCare: monthAndYear);
        return source;
    }

    private static VisitOccurrence Visit(
        JmdcInMemoryScenario source,
        string memberId,
        long visitId) =>
        Assert.Single(source.Build(memberId).VisitOccurrences, item => item.Id == visitId);

    private static void AssertEnd(
        IEnumerable<VisitOccurrence> visits,
        long visitId,
        DateTime expected) =>
        Assert.Equal(expected, Assert.Single(visits, item => item.Id == visitId).EndDate);
}
