namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public readonly struct LookupValue2 : IEquatable<LookupValue2>
    {
        public string Domain { get; init; }
        public string SourceCode { get; init; }

        public uint ValidStartDate { get; init; }
        public uint ValidEndDate { get; init; }

        public long ConceptId { get; init; }

        public bool Equals(LookupValue2 other)
        {
            return this.Domain == other.Domain &&
                   this.ConceptId == other.ConceptId &&
                   this.SourceCode == other.SourceCode &&
                   this.ValidStartDate.Equals(other.ValidStartDate) &&
                   this.ValidEndDate.Equals(other.ValidEndDate);
        }

        public override int GetHashCode()
        {
            return HashCode.Combine(Domain, ConceptId, SourceCode, ValidStartDate, ValidEndDate);
        }
    }
}