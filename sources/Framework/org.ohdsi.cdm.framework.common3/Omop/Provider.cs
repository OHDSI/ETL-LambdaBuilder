namespace org.ohdsi.cdm.framework.common.Omop
{
    public class Provider : Entity
    {
        public long? CareSiteId { get; set; }
        public string ProviderSourceValue { get; set; }
        public string Npi { get; set; }
        public string Dea { get; set; }

        // CDM v5 props
        public string Name { get; set; }
        public int? YearOfBirth { get; set; }
        public long? GenderConceptId { get; set; }
        public string GenderSourceValue { get; set; }
        public long? GenderSourceConceptId { get; set; }
        public long? SpecialtySourceConceptId { get; set; }


        public override string GetKey()
        {
            if (!string.IsNullOrEmpty(ProviderKey))
                return ProviderKey;

            var source = SourceValue;
            if (!string.IsNullOrEmpty(SourceValue))
                source = SourceValue.TrimStart('0');

            return (source ?? "") + ";" + (ProviderSourceValue ?? "");
        }
    }
}