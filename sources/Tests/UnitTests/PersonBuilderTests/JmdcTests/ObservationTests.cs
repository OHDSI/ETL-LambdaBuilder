using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class ObservationTests
{
    [Fact]
    public void Build_Jmdc_Observation_R1101_ObservationPersonIdFromDiagnosis()
    {
        const string memberId = "M000001101";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001101");
        source.AddDiagnosis(memberId, "C000000001101", standardDiseaseCode: 4);
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(1101L, VisitObservation(source, memberId, 1101).PersonId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1102_ObservationConceptIdFromDiagnosis()
    {
        const string memberId = "M000001102";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001102");
        source.AddDiagnosis(memberId, "C000000001102", standardDiseaseCode: 4);
        // R1101 inserts this master row into the shared R source schema before R1102 runs.
        source.AddDiagnosisMaster(4, "Z914");

        var observation = VisitObservation(source, memberId, 1102);

        Assert.Equal(1340204L, observation.ConceptId);
        Assert.Equal(45590771L, observation.SourceConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1103_ObservationValueAsConceptIdFromDiagnosis()
    {
        const string memberId = "M000001103";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001103");
        source.AddDiagnosis(memberId, "C000000001103", standardDiseaseCode: 4);
        // R1101 inserts this master row into the shared R source schema before R1103 runs.
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(439990L, VisitObservation(source, memberId, 1103).ValueAsConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1104_ObservationVisitOccurrenceIdProviderIdAndTypeConceptIdFromDiagnosis()
    {
        const string memberId = "M000001104";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001104");
        source.AddDiagnosis(memberId, "C000000001104",
            standardDiseaseCode: 4,
            medicalFacilityId: "F0000009",
            typeOfClaim: "Outpatient");
        // R1101 inserts this master row into the shared R source schema before R1104 runs.
        source.AddDiagnosisMaster(4, "Z914");

        var observation = VisitObservation(source, memberId, 1104);

        Assert.Equal(10000009L, observation.ProviderId);
        Assert.Equal(32859L, observation.TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1105_ObservationDateFromDiagnosisWithAdmissionDate()
    {
        const string memberId = "M000001105";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001105",
            monthAndYearOfMedicalCare: "201001", admissionDate: "2010-01-01");
        source.AddDiagnosis(memberId, "C000000001105", standardDiseaseCode: 4);
        // R1101 inserts this master row into the shared R source schema before R1105 runs.
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(new DateTime(2010, 1, 1), VisitObservation(source, memberId, 1105).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1106_ObservationDateFromDiagnosisWithoutAdmissionDate()
    {
        const string memberId = "M000001106";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001106",
            monthAndYearOfMedicalCare: "201001", admissionDate: null);
        source.AddDiagnosis(memberId, "C000000001106", standardDiseaseCode: 4);
        // R1101 inserts this master row into the shared R source schema before R1106 runs.
        source.AddDiagnosisMaster(4, "Z914");

        Assert.Equal(new DateTime(2010, 1, 15), VisitObservation(source, memberId, 1106).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Observation_R1107_ObservationFromCheckup()
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
