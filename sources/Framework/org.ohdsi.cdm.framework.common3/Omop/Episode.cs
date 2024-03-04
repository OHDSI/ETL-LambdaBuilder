namespace org.ohdsi.cdm.framework.common.Omop
{
    public class Episode : Entity
    {
        public long EpisodeParentId { get; set; }
        public int EpisodeNumber { get; set; }
        public long EpisodeObjectConceptId { get; set; }

        public Episode(IEntity ent)
        {
            Init(ent);
        }
    }
}