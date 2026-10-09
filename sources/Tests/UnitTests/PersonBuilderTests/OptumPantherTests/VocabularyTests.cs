namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class VocabularyTests
{
    [Fact]
    public void Lookup_OptumPanther_Vocabulary_ReturnsStandardAndSourceConcepts()
    {
        var mapping = Assert.Single(new OptumPantherTestVocabulary().Lookup("55111067101", "Drug", new DateTime(2012, 1, 8)));
        Assert.Equal(1322189, mapping.ConceptId); Assert.Equal("Drug", mapping.Domain); Assert.Contains(mapping.SourceConcepts, source => source.ConceptId == 45071548);
    }

    [Fact]
    public void Lookup_OptumPanther_Vocabulary_ReturnsNoMappingForUnknownCode()
    {
        Assert.Empty(new OptumPantherTestVocabulary().Lookup("UNKNOWN", "Drug", new DateTime(2012, 1, 8)));
    }

    [Fact]
    public void Lookup_OptumPanther_Vocabulary_RespectsValidityDates()
    {
        var vocabulary = new OptumPantherTestVocabulary();
        Assert.Empty(vocabulary.Lookup("55111067101", "Drug", new DateTime(1899, 12, 31)));
        Assert.Single(vocabulary.Lookup("55111067101", "Drug", new DateTime(2012, 1, 8)));
    }

    [Fact]
    public void Build_OptumPanther_Vocabulary_CustomConditionMappingFlowsThroughBuilder()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddStandardPerson(9001); source.Vocabulary.WithMapping("ConditionIcd10", "Q999", 7654321, "Condition", 1234567, "ICD10CM"); source.AddDiagnosis(9001, "Q999", "ICD10");
        var condition = Assert.Single(source.Build(9001).Data.ConditionOccurrences);
        Assert.Equal(7654321, condition.ConceptId); Assert.Equal(1234567, condition.SourceConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Vocabulary_CustomDrugMappingFlowsThroughBuilder()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddStandardPerson(9002); source.Vocabulary.WithMapping("Drug", "99999999999", 8765432, "Drug", 2345678, "NDC"); source.AddMedicationAdministration(9002, "99999999999", "2012-01-08");
        var drug = Assert.Single(source.Build(9002).Data.DrugExposures);
        Assert.Equal(8765432, drug.ConceptId); Assert.Equal(2345678, drug.SourceConceptId);
    }

    [Fact]
    public void Build_OptumPanther_Vocabulary_DomainControlsRouting()
    {
        var source = new OptumPantherInMemoryScenario(); source.AddStandardPerson(9003); source.Vocabulary.WithMapping("ConditionFromProcedure", "ZZ999", 9876543, "Drug", 3456789, "HCPCS"); source.AddProcedure(9003, "ZZ999", "HCPCS");
        Assert.Contains(source.Build(9003).Data.DrugExposures, drug => drug.ConceptId == 9876543 && drug.SourceConceptId == 3456789);
    }
}
