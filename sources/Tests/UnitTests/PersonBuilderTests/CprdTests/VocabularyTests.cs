namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class VocabularyTests
{
    [Fact]
    public void Vocabulary_Cprd_ReadCode_MapsConditionAndSourceConcept()
    {
        var value = Assert.Single(new CprdTestVocabulary().Lookup("F563500", "Read_Code", new DateTime(2012, 1, 1)));
        Assert.Equal(75555, value.ConceptId);
        Assert.Equal("Condition", value.Domain);
        Assert.Equal(45436713, Assert.Single(value.SourceConcepts).ConceptId);
    }

    [Fact]
    public void Vocabulary_Cprd_ReadCode_IsCaseSensitive()
    {
        var vocabulary = new CprdTestVocabulary();
        var upper = Assert.Single(vocabulary.Lookup("339A.00", "Read_Code", new DateTime(2012, 1, 1)));
        var lower = Assert.Single(vocabulary.Lookup("339a.00", "Read_Code", new DateTime(2012, 1, 1)));
        Assert.Equal(45455049, Assert.Single(upper.SourceConcepts).ConceptId);
        Assert.Equal(45421972, Assert.Single(lower.SourceConcepts).ConceptId);
    }

    [Fact]
    public void Vocabulary_Cprd_Gemscript_MapsDrugAndIngredient()
    {
        var value = Assert.Single(new CprdTestVocabulary().Lookup("58976020", "Drug", new DateTime(2012, 1, 1)));
        Assert.Equal(19073982, value.ConceptId);
        Assert.Equal("Drug", value.Domain);
        Assert.Contains(1316354, value.Ingredients);
    }

    [Fact]
    public void Vocabulary_Cprd_TestEntity_MapsMeasurementDomain()
    {
        var value = Assert.Single(new CprdTestVocabulary().Lookup("173-Haemoglobin", "Test_Ent", new DateTime(2012, 1, 1)));
        Assert.Equal(4015178, value.ConceptId);
        Assert.Equal("Measurement", value.Domain);
    }

    [Fact]
    public void Vocabulary_Cprd_MapsQualifierAndUnit()
    {
        var vocabulary = new CprdTestVocabulary();
        Assert.Equal(4069590, Assert.Single(vocabulary.Lookup("Normal", "ValueAsConceptId", DateTime.MinValue)).ConceptId);
        Assert.Equal(8713, Assert.Single(vocabulary.Lookup("g/dL", "Units", DateTime.MinValue)).ConceptId);
    }

    [Fact]
    public void Vocabulary_Cprd_MapsProviderSpecialties()
    {
        var vocabulary = new CprdTestVocabulary();
        Assert.Equal(32577, Assert.Single(vocabulary.Lookup("Partner", "Specialty", DateTime.MinValue)).ConceptId);
        Assert.Equal(45756825, Assert.Single(vocabulary.Lookup("Radiographer", "Specialty", DateTime.MinValue)).ConceptId);
        Assert.Equal(38004514, Assert.Single(vocabulary.Lookup("Data Not Entered", "Specialty", DateTime.MinValue)).ConceptId);
    }
}
