using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class SourceConcepts : IEquatable<SourceConcepts>
    {
        public long ConceptId { get; set; }
        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
        public char InvalidReason { get; set; }

        public override int GetHashCode()
        {
            return ConceptId.GetHashCode() ^
                  ValidStartDate.GetHashCode() ^
                  ValidEndDate.GetHashCode() ^
                  InvalidReason.GetHashCode();
        }

        public bool Equals(SourceConcepts other)
        {
            return this.GetHashCode() == other.GetHashCode();
        }

        string ToXML()
        {
            string res = "<SourceConcepts>"
                    + " \r\n" + "<ConceptId>" + (this.ConceptId.ToString() ?? "") + "</ConceptId>"
                    + " \r\n" + "<ValidStartDate>" + (this.ValidStartDate.ToString() ?? "") + "</ValidStartDate>"
                    + " \r\n" + "<ValidEndDate>" + (this.ValidEndDate.ToString() ?? "") + "</ValidEndDate>"
                    + " \r\n" + "<InvalidReason>" + (this.ConceptId.ToString() ?? "") + "</InvalidReason>"
                    + " \r\n" + "</SourceConcepts>"
                    ;
            return res;
        }

        /// <summary>
        /// This method is for comparing hashes across different runs to ensure the data is the same before and after code changes
        /// </summary>
        /// <returns></returns>
        public int GetHashCode256()
        {
            return GetStableHashCode.GetHashCodeSha256(this.ToXML());
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
        public HashSet<long> Ingredients { get; set; } = [];
        public long? ValueAsConceptId { get; set; }

        public override int GetHashCode()
        {
            return Domain.GetHashCode() ^
                  ConceptId.GetHashCode() ^
                  SourceCode.GetHashCode() ^
                  (ValidStartDate.GetHashCode()) ^
                  (ValidEndDate.GetHashCode());
        }

        public bool Equals(LookupValue other)
        {
            return this.GetHashCode() == other.GetHashCode();
        }

        string ToXML()
        {
            string res = "<LookupValue>"
                    + " \r\n" + "<Domain>" + (this.Domain?.ToString() ?? "") + "</Domain>"
                    + " \r\n" + "<ConceptId>" + (this.ConceptId?.ToString() ?? "") + "</ConceptId>"
                    + " \r\n" + "<SourceCode>" + (this.SourceCode?.ToString() ?? "") + "</SourceCode>"
                    + " \r\n" + "<ValidStartDate>" + (this.ValidStartDate.ToString() ?? "") + "</ValidStartDate>"
                    + " \r\n" + "<ValidEndDate>" + (this.ValidEndDate.ToString() ?? "") + "</ValidEndDate>"
                    + " \r\n" + "<SourceConcepts>" + (string.Join(",", this.SourceConcepts?
                                                                        .OrderBy(s => s.ConceptId)
                                                                        .Select(s => GetStableHashCode.GetHashCodeSha256(s.GetHashCode256().ToString()))) 
                                                      ?? "") 
                              + "</SourceConcepts>"
                    + " \r\n" + "<Ingredients>" + (string.Join(",", this.Ingredients?
                                                                        .OrderBy(s => s) 
                                                                        .Select(s => GetStableHashCode.GetHashCodeSha256(s.ToString())))
                                                   ?? "") 
                              + "</Ingredients>"
                    + " \r\n" + "<ValueAsConceptId>" + (this.ValueAsConceptId?.ToString() ?? "") + "</ValueAsConceptId>"
                    + " \r\n" + "</LookupValue>"
                    ;
            return res;
        }

        /// <summary>
        /// This method is for comparing hashes across different runs to ensure the data is the same before and after code changes
        /// </summary>
        /// <returns></returns>
        public int GetHashCodeSha256()
        {
            return GetStableHashCode.GetHashCodeSha256(this.ToXML());
        }
    }
}