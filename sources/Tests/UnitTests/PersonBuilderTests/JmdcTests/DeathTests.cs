namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class DeathTests
{
    [Fact]
    public void Build_Jmdc_Death_R601_DeathPersonIdFromDiagnosis()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000601");
        source.AddClaim("M000000601", "C000000000600");
        source.AddDiagnosis("M000000601", "C000000000600", outcome: 3);

        Assert.Equal(601L, Assert.Single(source.Build("M000000601").Deaths).PersonId);
    }

    [Fact]
    public void Build_Jmdc_Death_R602_DeathPersonIdFromEnrollment()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000602", withdrawalDeath: true);

        Assert.Equal(602L, Assert.Single(source.Build("M000000602").Deaths).PersonId);
    }

    [Fact]
    public void Build_Jmdc_Death_R603_DeathDateFromDiagnosis()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000603");
        source.AddClaim("M000000603", "C000000000601",
            monthAndYearOfMedicalCare: "201001", admissionDate: "2010-01-01", daysOfMedicalCare: 3);
        source.AddDiagnosis("M000000603", "C000000000601", outcome: 3);

        Assert.Equal(new DateTime(2010, 1, 3),
            Assert.Single(source.Build("M000000603").Deaths).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Death_R604_DeathDateFromEnrollment()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000604",
            observationStart: "201001", observationEnd: "201112", withdrawalDeath: true);

        Assert.Equal(new DateTime(2011, 12, 31),
            Assert.Single(source.Build("M000000604").Deaths).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Death_R605_DeathDateFromMultipleDiagnoses()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000605");
        source.AddClaim("M000000605", "C000000000602",
            monthAndYearOfMedicalCare: "201001", admissionDate: "2010-01-01", daysOfMedicalCare: 3);
        source.AddDiagnosis("M000000605", "C000000000602", outcome: 3);
        source.AddClaim("M000000605", "C000000000603",
            monthAndYearOfMedicalCare: "201002", admissionDate: "2010-02-01", daysOfMedicalCare: 3);
        source.AddDiagnosis("M000000605", "C000000000603", outcome: 3);

        Assert.Equal(new DateTime(2010, 2, 3),
            Assert.Single(source.Build("M000000605").Deaths).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Death_R606_DeathDateFromDiagnosisAndEnrollment()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000606",
            observationStart: "201001", observationEnd: "201112", withdrawalDeath: true);
        source.AddClaim("M000000606", "C000000000604",
            monthAndYearOfMedicalCare: "201001", admissionDate: "2010-01-01", daysOfMedicalCare: 3);
        source.AddDiagnosis("M000000606", "C000000000604", outcome: 3);

        Assert.Equal(new DateTime(2010, 1, 3),
            Assert.Single(source.Build("M000000606").Deaths).StartDate);
    }

    [Fact]
    public void Build_Jmdc_Death_R607_DeathTypeConceptId()
    {
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment("M000000607", withdrawalDeath: true);
        source.AddEnrollment("M000000608");
        source.AddClaim("M000000608", "C000000000605");
        source.AddDiagnosis("M000000608", "C000000000605", outcome: 3);

        Assert.Equal(32815L,
            Assert.Single(source.Build("M000000607").Deaths).TypeConceptId);
        Assert.Equal(32812L,
            Assert.Single(source.Build("M000000608").Deaths).TypeConceptId);
    }
}
