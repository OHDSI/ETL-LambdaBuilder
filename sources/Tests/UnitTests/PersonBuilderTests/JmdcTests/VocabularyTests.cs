namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class VocabularyTests
{
    [Fact]
    public void Lookup_Jmdc_Vocabulary_S001_StartsWithSourceToConceptMappings()
    {
        var vocabulary = new JmdcTestVocabulary();

        Assert.True(vocabulary.MappingCount >= 16);
        Assert.NotEmpty(vocabulary.Lookup("I10", "JMDC-ICD10-SNOMED", new DateTime(2010, 1, 1)));
        Assert.NotEmpty(vocabulary.Lookup("100000008105", "JMDC_DRUGCODE_RXNORM", new DateTime(2010, 1, 1)));
        Assert.NotEmpty(vocabulary.Lookup("1", "JMDC_DRUGCODE_RXNORM", new DateTime(2010, 1, 1)));
        Assert.NotEmpty(vocabulary.Lookup("9394", "JMDC-ICDProcedure", new DateTime(2010, 1, 1)));
        Assert.NotEmpty(vocabulary.Lookup("2", "JMDC-JNJProcedure", new DateTime(2010, 1, 1)));
    }

    [Fact]
    public void Lookup_Jmdc_ConditionOccurrence_S002_MapsI10ConceptDomainAndSourceConcept()
    {
        var vocabulary = new JmdcTestVocabulary();

        var mapping = Assert.Single(
            vocabulary.Lookup("I10", "JMDC-ICD10-SNOMED", new DateTime(2010, 1, 1)));

        Assert.Equal(320128L, mapping.ConceptId);
        Assert.Equal("Condition", mapping.Domain);
        Assert.Equal("I10", mapping.SourceCode);
        Assert.Equal(45591453L, Assert.Single(mapping.SourceConcepts).ConceptId);
        Assert.Equal("SNOMED", vocabulary.GetSourceVocabularyId(320128));
        Assert.Equal("Condition", vocabulary.GetSourceDomain(320128));
    }

    [Fact]
    public void Build_Jmdc_Observation_S003_UsesMappingAddedToVocabulary()
    {
        const string memberId = "M000001303";
        var source = new JmdcInMemoryScenario();
        source.Vocabulary.WithMapping(
            "JMDC-ICD10-SNOMED",
            "Q999",
            7654321,
            "Observation",
            sourceConceptId: 7654322,
            vocabularyId: "SNOMED");
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001303");
        source.AddDiagnosis(
            memberId,
            "C000000001303",
            standardDiseaseCode: 1303,
            standardDiseaseName: "custom vocabulary observation");
        source.AddDiagnosisMaster(1303, "Q999");

        var observation = Assert.Single(
            source.Build(memberId).Observations,
            item => item.VisitOccurrenceId == 1303);

        Assert.Equal(7654321L, observation.ConceptId);
        Assert.Equal(7654322L, observation.SourceConceptId);
        Assert.Equal("Observation", observation.Domain);
        Assert.Equal("1303|custom vocabulary observation", observation.SourceValue);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_S004_UsesMappingAddedToVocabulary()
    {
        const string memberId = "M000001304";
        const long sourceDrugCode = 900000001304;
        var source = new JmdcInMemoryScenario();
        source.Vocabulary.WithMapping(
            "JMDC_DRUGCODE_RXNORM",
            sourceDrugCode.ToString(),
            7654331,
            "Drug",
            vocabularyId: "RxNorm");
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001304");
        source.AddDrug(memberId, "C000000001304", jmdcDrugCode: sourceDrugCode);

        var drug = Assert.Single(
            source.Build(memberId).DrugExposures,
            item => item.VisitOccurrenceId == 1304);

        Assert.Equal(7654331L, drug.ConceptId);
        Assert.Equal("Drug", drug.Domain);
        Assert.Equal(sourceDrugCode.ToString(), drug.VocabularySourceValue);
    }

    [Fact]
    public void Build_Jmdc_ProcedureOccurrence_S005_UsesMappingAddedToVocabulary()
    {
        const string memberId = "M000001305";
        var source = new JmdcInMemoryScenario();
        source.Vocabulary.WithMapping(
            "JMDC-ICDProcedure",
            "7777",
            7654341,
            "Procedure",
            sourceConceptId: 7654342,
            vocabularyId: "SNOMED");
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000001305");
        source.AddProcedure(
            memberId,
            "C000000001305",
            standardizedProcedureCode: 1305,
            standardizedProcedureVersion: "test");
        source.AddProcedureMaster(1305, "test", "7777");

        var procedure = Assert.Single(
            source.Build(memberId).ProcedureOccurrences,
            item => item.VisitOccurrenceId == 1305);

        Assert.Equal(7654341L, procedure.ConceptId);
        Assert.Equal(7654342L, procedure.SourceConceptId);
        Assert.Equal("Procedure", procedure.Domain);
        Assert.Equal("7777", procedure.VocabularySourceValue);
    }

    [Fact]
    public void Lookup_Jmdc_Vocabulary_S006_DoesNotInventMappingForUnknownCode()
    {
        var vocabulary = new JmdcTestVocabulary();

        Assert.Empty(vocabulary.Lookup("UNKNOWN", "JMDC-ICD10-SNOMED", DateTime.MinValue));
        Assert.Empty(vocabulary.Lookup("I10", "UNKNOWN-LOOKUP", DateTime.MinValue));
    }
}
