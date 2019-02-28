using System;
using System.Collections.Generic;

namespace org.ohdsi.cdm.framework.common2.Lookups
{
    public class LookupValue
    {
        public int? ConceptId { get; set; }

        public string SourceCode { get; set; }

        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
        public string Domain { get; set; }
        //public string SourceVocabularyId { get; set; }

        public int SourceConceptId { get; set; }
        //public DateTime SourceValidStartDate { get; set; }
        //public DateTime SourceValidEndDate { get; set; }

        public HashSet<int> Ingredients { get; set; }
    }
}
