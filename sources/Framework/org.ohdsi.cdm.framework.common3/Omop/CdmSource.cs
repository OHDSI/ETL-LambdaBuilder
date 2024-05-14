using org.ohdsi.cdm.framework.common.Enums;
using System;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class CdmSource
    {
        public long CdmVersionConceptId { get; set; }

        public string CdmSourceName { get; set; }
        public string CdmSourceAbbreviation { get; set; }
        public string CdmHolder { get; set; }
        public string SourceDescription { get; set; }
        public string SourceDocumentationReference { get; set; }
        public string CdmEtlReference { get; set; }
        public DateTime SourceReleaseDate { get; set; }
        public DateTime CdmReleaseDate { get; set; }
        public string CdmVersion { get; set; }
        public string VocabularyVersion { get; set; }

        public CdmSource()
        {
            CdmReleaseDate = DateTime.Now;
            CdmVersion = "v5.4";
        }
    }
}
