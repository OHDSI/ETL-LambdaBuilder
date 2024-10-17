using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public interface IEntity
    {
        bool IsUnique { get; set; }
        Guid SourceRecordGuid { get; set; }
        string SourceFile { get; set; }
        long Id { get; set; }

        long PersonId { get; set; }
        long ConceptId { get; set; }
        string ConceptIdKey { get; set; }
        DateTime StartDate { get; set; }
        DateTime? EndDate { get; set; }

        long? TypeConceptId { get; set; }
        long? VisitOccurrenceId { get; set; }
        long? VisitDetailId { get; set; }
        string SourceValue { get; set; }
        string ProviderKey { get; set; }
        long? ProviderId { get; set; }
        Dictionary<string, string> AdditionalFields { get; set; }

        List<long> Ingredients { get; set; }
        DateTime GetEndDate();
        bool IncludeInEra();
        EntityType GeEntityType();

        DateTime ValidStartDate { get; set; }
        DateTime ValidEndDate { get; set; }

        long SourceConceptId { get; set; }
        string Domain { get; set; }
        string VocabularySourceValue { get; set; }
        long? ValueAsConceptId { get; set; }

        List<SourceConcepts> SourceConcepts { get; set; }

        string GetKey();
    }
}
