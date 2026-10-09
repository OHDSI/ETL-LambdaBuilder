namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

public class VocabularyTests
{
    [Fact]
    public void PremierVocabulary_ContainsPopulatedMappings()
    {
        Assert.True(new PremierTestVocabulary().MappingCount >= 35);
    }

    [Fact]
    public void PremierVocabulary_MapsOneSourceToTwoConditionConcepts()
    {
        var values = new PremierTestVocabulary().Lookup("M05.421", "ConditionIcd", DateTime.MinValue);
        Assert.Equal([4107913L, 4116440L], values.Select(x => x.ConceptId!.Value).OrderBy(x => x).ToArray());
    }

    [Fact]
    public void PremierVocabulary_PreservesDomainRouting()
    {
        var vocabulary = new PremierTestVocabulary();
        Assert.Equal("Measurement", Assert.Single(vocabulary.Lookup("81003", "Measurement", DateTime.MinValue)).Domain);
        Assert.Equal("Drug", Assert.Single(vocabulary.Lookup("J9310", "DrugCpt", DateTime.MinValue)).Domain);
        Assert.Equal("Device", Assert.Single(vocabulary.Lookup("V5245", "Device", DateTime.MinValue)).Domain);
    }

    [Fact]
    public void PremierVocabulary_MapsRevenueAndDrgCodes()
    {
        var vocabulary = new PremierTestVocabulary();
        Assert.Equal(38003147, Assert.Single(vocabulary.Lookup("PHARMACY / PHARMACY", "RevenueCode", DateTime.MinValue)).ConceptId);
        Assert.Equal(38000887, Assert.Single(vocabulary.Lookup("001", "Drg", DateTime.MinValue)).ConceptId);
    }

    [Theory]
    [InlineData("F", 8532)]
    [InlineData("M", 8507)]
    [InlineData("Z", 8551)]
    public void PremierVocabulary_MapsGender(string source, int expected)
    {
        Assert.Equal(expected, new PremierTestVocabulary().LookupGender(source));
    }
}
