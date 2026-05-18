using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using System.Security.Cryptography;
using System.Text;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class Entity : IEntity
    {
        public bool IdUndefined { get; set; }
        public bool IsUnique { get; set; }

        public Guid SourceRecordGuid { get; set; }
        public string SourceFile { get; set; }

        public long Id { get; set; }
        public long PersonId { get; set; }
        public long ConceptId { get; set; }
        public string ConceptIdKey { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }

        public long? TypeConceptId { get; set; }
        public long? VisitOccurrenceId { get; set; }
        public long? VisitDetailId { get; set; }

        public string SourceValue { get; set; }

        public long? ProviderId { get; set; }
        public string ProviderKey { get; set; }

        public Dictionary<string, string> AdditionalFields { get; set; }
        
        public List<long> Ingredients { get; set; }
        public List<SourceConcepts> SourceConcepts { get; set; }


        public long SourceConceptId { get; set; }
        public string Domain { get; set; }
        public string VocabularySourceValue { get; set; }
        public long? ValueAsConceptId { get; set; }

        public DateTime ValidStartDate { get; set; }
        public DateTime ValidEndDate { get; set; }
        

        public Entity()
        {

        }

        public Entity(IEntity ent)
        {
            Init(ent);
        }

        public virtual string GetKey()
        {
            throw new NotImplementedException();
        }

        public virtual HashSet<long?> GetEraConceptIds()
        {
            return [ConceptId];
        }

        public virtual DateTime GetEndDate()
        {
            if (!EndDate.HasValue)
                return StartDate;

            return EndDate.Value == DateTime.MinValue ? StartDate : EndDate.Value;
        }

        public virtual bool IncludeInEra()
        {
            return true;
        }

        public virtual EntityType GeEntityType()
        {
            return EntityType.Entity;
        }        

        public void Init(IEntity ent)
        {
            SourceRecordGuid = ent.SourceRecordGuid;
            IsUnique = ent.IsUnique;
            PersonId = ent.PersonId;
            ConceptId = ent.ConceptId;
            StartDate = ent.StartDate;
            EndDate = ent.EndDate;
            TypeConceptId = ent.TypeConceptId;
            VisitOccurrenceId = ent.VisitOccurrenceId;
            VisitDetailId = ent.VisitDetailId;
            SourceValue = ent.SourceValue;
            ProviderId = ent.ProviderId;
            ProviderKey = ent.ProviderKey;
            AdditionalFields = ent.AdditionalFields;
            ValidStartDate = ent.ValidStartDate;
            ValidEndDate = ent.ValidEndDate;
            SourceConceptId = ent.SourceConceptId;
            Domain = ent.Domain;
            Ingredients = ent.Ingredients;
            ConceptIdKey = ent.ConceptIdKey;
            VocabularySourceValue = ent.VocabularySourceValue;
            ValueAsConceptId = ent.ValueAsConceptId;
            SourceConcepts = ent.SourceConcepts;
        }

        public static long GetId(string key)
        {
            if (string.IsNullOrEmpty(key))
                return 0;

            using var md5 = MD5.Create();
            return BitConverter.ToInt64(md5.ComputeHash(Encoding.UTF8.GetBytes(key)), 0);
        }
    }
}