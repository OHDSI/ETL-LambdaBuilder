namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class SourceConcepts : IEquatable<SourceConcepts>
    {
        public long ConceptId { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
        public char InvalidReason { get; set; }

        public bool Equals(SourceConcepts other)
        {
            return this.ConceptId == other.ConceptId &&
                   this.ValidStartDate.Equals(other.ValidStartDate) &&
                   this.ValidEndDate.Equals(other.ValidEndDate) &&
                   this.InvalidReason.Equals(other.InvalidReason);
        }

        public override int GetHashCode()
        {
            return ConceptId.GetHashCode() ^
              (ValidStartDate.GetHashCode()) ^
              (ValidEndDate.GetHashCode()) ^
              InvalidReason.GetHashCode();
        }
    }

    public class LookupValue : IEquatable<LookupValue>
    {
        public string Domain { get; set; }
        public long? ConceptId { get; set; }
        public string SourceCode { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }

        public HashSet<SourceConcepts> SourceConcepts { get; set; } = [];
        public HashSet<long> Ingredients { get; set; }
        public HashSet<long> ValueAsConceptIds { get; set; }

        public bool Equals(LookupValue other)
        {
            return this.Domain == other.Domain &&
                   this.ConceptId == other.ConceptId &&
                   this.SourceCode == other.SourceCode &&
                   this.ValidStartDate.Equals(other.ValidStartDate) &&
                   this.ValidEndDate.Equals(other.ValidEndDate) &&
                   this.SourceConcepts.Equals(other.SourceConcepts);
        }

        public override int GetHashCode()
        {
            return Domain.GetHashCode() ^
                  ConceptId.GetHashCode() ^
                  SourceCode.GetHashCode() ^
                  (ValidStartDate.GetHashCode()) ^
                  (ValidEndDate.GetHashCode());
        }
    }
}