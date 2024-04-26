using System;
using System.Collections.Generic;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class SourceConcepts
    {
        public long ConceptId { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
    }

    public class LookupValue
    {
        public string Domain { get; set; }
        public long? ConceptId { get; set; }
        public string SourceCode { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }

        public List<SourceConcepts> SourceConcepts { get; set; } = [];
        public HashSet<long> Ingredients { get; set; }
        public long? ValueAsConceptId { get; set; }
    }
}
