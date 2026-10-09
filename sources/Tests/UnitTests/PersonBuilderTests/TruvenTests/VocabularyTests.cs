namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class VocabularyTests
{
    [Fact]
    public void TruvenVocabulary_ContainsPopulatedMappings()
    {
        Assert.True(new TruvenTestVocabulary().MappingCount >= 50);
    }

    [Fact]
    public void TruvenVocabulary_PreservesCrossDomainDiagnosisRouting()
    {
        var vocabulary = new TruvenTestVocabulary();
        Assert.Equal("Procedure", Assert.Single(vocabulary.Lookup("V5302", "Diagnosis9", DateTime.MinValue).Where(x => x.ConceptId == 4047347)).Domain);
        Assert.Equal("Observation", Assert.Single(vocabulary.Lookup("E0152", "Diagnosis9", DateTime.MinValue)).Domain);
        Assert.Equal("Measurement", Assert.Single(vocabulary.Lookup("V726", "Diagnosis9", DateTime.MinValue)).Domain);
    }

    [Fact]
    public void TruvenVocabulary_MapsNdc9Fallbacks()
    {
        var vocabulary = new TruvenTestVocabulary();
        Assert.Equal(46275250, Assert.Single(vocabulary.Lookup("135330636", "Drug", new DateTime(2012, 1, 17))).ConceptId);
        Assert.Equal(45775771, Assert.Single(vocabulary.Lookup("000060325", "Drug", new DateTime(2014, 9, 18))).ConceptId);
    }

    [Fact]
    public void TruvenVocabulary_SelectsDateSpecificHcpcsMappings()
    {
        var vocabulary = new TruvenTestVocabulary();
        Assert.Equal(19124326, Assert.Single(vocabulary.Lookup("J9350", "Procedure", new DateTime(1970, 1, 1))).ConceptId);
        Assert.Equal(0, Assert.Single(vocabulary.Lookup("J9350", "Procedure", new DateTime(2014, 11, 11))).ConceptId);
        Assert.Equal(1302318, Assert.Single(vocabulary.Lookup("J9350", "Procedure", new DateTime(2023, 7, 1))).ConceptId);
    }

    [Fact]
    public void TruvenVocabulary_UsesJnjUnitsAndAbnormalValues()
    {
        var vocabulary = new TruvenTestVocabulary();
        Assert.Equal(8840, Assert.Single(vocabulary.Lookup("mg/dl", "Unit", DateTime.MinValue)).ConceptId);
        Assert.Equal(8739, Assert.Single(vocabulary.Lookup("lbs.", "Unit", DateTime.MinValue)).ConceptId);
        Assert.Equal(586323, Assert.Single(vocabulary.Lookup("C", "Unit", DateTime.MinValue)).ConceptId);
        Assert.Equal(9191, Assert.Single(vocabulary.Lookup("+", "ValueAsConcept", DateTime.MinValue)).ConceptId);
    }

    [Fact]
    public void TruvenVocabulary_MapsCmsPlaceOfService()
    {
        var vocabulary = new TruvenTestVocabulary();
        Assert.Equal(9201, Assert.Single(vocabulary.Lookup("9201", "CMSPlaceOfService", DateTime.MinValue)).ConceptId);
        Assert.Equal(9202, Assert.Single(vocabulary.Lookup("9202", "CMSPlaceOfService", DateTime.MinValue)).ConceptId);
        Assert.Equal(9203, Assert.Single(vocabulary.Lookup("8870", "CMSPlaceOfService", DateTime.MinValue)).ConceptId);
    }
}
