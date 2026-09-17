using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ObservationTests
{
    [Fact]
    public void Build_Jmdc_Observation_R1101_CreatesObservationFromDiagnosis()
    {
        var source = DiagnosisObservationScenario("M000001101", "C000000001101");

        Assert.Equal(1101L, VisitObservation(source, "M000001101", 1101).PersonId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1102_MapsObservationConceptAndSourceConcept()
    {
        var source = DiagnosisObservationScenario("M000001102", "C000000001102");

        var observation = VisitObservation(source, "M000001102", 1102);

        Assert.Equal(1340204L, observation.ConceptId);
        Assert.Equal(45590771L, observation.SourceConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1103_MapsObservationValueConcept()
    {
        var source = DiagnosisObservationScenario("M000001103", "C000000001103");

        Assert.Equal(439990L, VisitObservation(source, "M000001103", 1103).ValueAsConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1104_MapsVisitProviderAndTypeFromDiagnosis()
    {
        const string memberId = "M000001104";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001104");
        source.AddDiagnosis(memberId, "C000000001104",
            standardDiseaseCode: 4,
            medicalFacilityId: "F0000009",
            typeOfClaim: "Outpatient");
        source.AddDiagnosisMaster(4, "Z914");

        var observation = VisitObservation(source, memberId, 1104);

        Assert.Equal(10000009L, observation.ProviderId);
        Assert.Equal(32859L, observation.TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1105_UsesAdmissionDate()
    {
        const string memberId = "M000001105";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001105",
            monthAndYearOfMedicalCare: "201001", admissionDate: "2010-01-01");
        source.AddDiagnosis(memberId, "C000000001105", standardDiseaseCode: 4);
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(new DateTime(2010, 1, 1), VisitObservation(source, memberId, 1105).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1106_UsesClaimDateWithoutAdmissionDate()
    {
        const string memberId = "M000001106";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001106",
            monthAndYearOfMedicalCare: "201001", admissionDate: null);
        source.AddDiagnosis(memberId, "C000000001106", standardDiseaseCode: 4);
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(new DateTime(2010, 1, 15), VisitObservation(source, memberId, 1106).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1107_CreatesSleepObservationFromCheckup()
    {
        const string memberId = "M000001107";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddAnnualHealthCheckup(memberId, sleep: 2, dateOfHealthCheckup: "2010-01-13");

        var observation = Assert.Single(
            source.Build(memberId).Observations,
            item => item.ConceptId == 40764749);

        Assert.Equal(new DateTime(2010, 1, 13), observation.StartDate);
        Assert.Equal(4188540L, observation.ValueAsConceptId);
    }

    private static JmdcInMemoryScenario DiagnosisObservationScenario(
        string memberId,
        string claimId)
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, claimId);
        source.AddDiagnosis(memberId, claimId, standardDiseaseCode: 4);
        // The R suite reuses the master row inserted by R1101. Each xUnit test is isolated,
        // so the prerequisite master row is made explicit in every equivalent scenario.
        source.AddDiagnosisMaster(4, "Z914");
        return source;
    }

    private static Observation VisitObservation(
        JmdcInMemoryScenario source,
        string memberId,
        long visitId)
    {
        return Assert.Single(
            source.Build(memberId).Observations,
            item => item.VisitOccurrenceId == visitId);
    }
}
