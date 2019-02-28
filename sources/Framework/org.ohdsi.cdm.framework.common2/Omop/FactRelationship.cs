namespace org.ohdsi.cdm.framework.common2.Omop
{
    public class FactRelationship
    {
        public long DomainConceptId1 { get; set; }

        public long FactId1 { get; set; }

        public long DomainConceptId2 { get; set; }

        public long FactId2 { get; set; }

        public long RelationshipConceptId { get; set; }
    }
}
