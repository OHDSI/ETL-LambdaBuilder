namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class SourceConcepts2 : IEquatable<SourceConcepts2>
    {
        public long ConceptId { get; set; }
        public uint ValidStartDate { get; set; }
        public uint ValidEndDate { get; set; }
        public char InvalidReason { get; set; }

        public bool Equals(SourceConcepts2 other)
        {
            return this.ConceptId == other.ConceptId &&
                   this.ValidStartDate.Equals(other.ValidStartDate) &&
                   this.ValidEndDate.Equals(other.ValidEndDate) &&
                   this.InvalidReason.Equals(other.InvalidReason);
        }

        public override int GetHashCode()
        {
            return HashCode.Combine(ConceptId, ValidStartDate, ValidEndDate, InvalidReason);
        }
    }
}