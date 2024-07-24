namespace org.ohdsi.cdm.framework.common.Omop
{
    public class LocationHistory : Entity
    {
        public long? LocationId { get; set; }
        public long? EntityId { get; set; }
        public string DomainId { get; set; }

    }
}