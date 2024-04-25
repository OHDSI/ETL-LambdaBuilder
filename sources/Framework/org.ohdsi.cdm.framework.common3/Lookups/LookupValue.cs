using System;
using System.Collections.Generic;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class LookupValue
    {
        public long? ConceptId { get; set; }
        public string SourceCode { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
        public DateTime SourceValidStartDate { get; set; }
        public DateTime SourceValidEndDate { get; set; }
        public string Domain { get; set; }
        public long SourceConceptId { get; set; }
        public HashSet<long> Ingredients { get; set; }
        public long? ValueAsConceptId { get; set; }
    }
}
