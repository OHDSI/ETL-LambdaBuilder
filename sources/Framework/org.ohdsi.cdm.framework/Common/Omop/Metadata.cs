using System.ComponentModel;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public enum Attrition
    {
        None,
        [Description("Gender changes")]
        GenderChanges,
        [Description("Implausible year of birth - future")]
        ImplausibleYOBFuture,
        [Description("Implausible year of birth - past")]
        ImplausibleYOBPast,
        [Description("Implausible year of birth - post earliest observation period")]
        ImplausibleYOBPostEarliestOP,
        [Description("Invalid observation time")]
        InvalidObservationTime,
        [Description("Missing insurance coverage")]
        MissingInsuranceCoverage,
        [Description("Multiple years of birth")]
        MultipleYearsOfBirth,
        [Description("Unacceptable patient quality")]
        UnacceptablePatientQuality,
        [Description("Unknown gender")]
        UnknownGender,
        [Description("Unknown year of birth")]
        UnknownYearOfBirth,
        [Description("Discarded drug count")]
        DiscardedDrugCount
    }

    public class MetadataOMOP
    {
        public int Id { get; set; }

        public long MetadataConceptId { get; set; }

        public long MetadataTypeConceptId { get; set; }

        public string Name { get; set; }

        public string ValueAsString { get; set; }

        public long ValueAsConceptId { get; set; }

        public DateTime MetadataDate { get; set; }

        public decimal ValueAsNumber { get; set; }
    }

    public class Metadata
    {
        public long PersonId { get; set; }

        public string Name { get; set; }

        public int Count { get; set; }
    }
}
