﻿namespace org.ohdsi.cdm.framework.common.Omop
{
    public class EpisodeEvent
    {
        public long PersonId { get; set; }

        public long EpisodeId { get; set; }
        public long EventId { get; set; }
        public long EpisodeEventFieldConceptId { get; set; }
    }
}