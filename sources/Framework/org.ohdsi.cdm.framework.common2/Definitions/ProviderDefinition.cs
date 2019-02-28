using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
    public class ProviderDefinition : EntityDefinition
    {
        public string CareSiteId { get; set; }
        public string ProviderSourceValue { get; set; }
        public string SpecialtySourceValue { get; set; }
        public string NPI { get; set; }
        public string DEA { get; set; }

        // CDM v5 props
        public string Name { get; set; }
        public string YearOfBirth { get; set; }
        public string GenderConceptId { get; set; }
        public string GenderSourceValue { get; set; }
        public string GenderSourceConceptId { get; set; }
        public string SpecialtySourceConceptId { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager keyOffset)
        {
            var genderConceptId = 0;

            if (string.IsNullOrEmpty(GenderConceptId) && Vocabulary != null)
            {
                genderConceptId = Vocabulary.LookupGender(GenderSourceValue) ?? 0;
            }
            else if (reader.GetInt(GenderConceptId).HasValue)
            {
                genderConceptId = reader.GetInt(GenderConceptId).Value;
            }

            if (concept == null)
            {
                var prov = new Provider
                {
                    CareSiteId = reader.GetInt(CareSiteId) ?? 0,
                    ProviderSourceValue = reader.GetString(ProviderSourceValue),
                    SourceValue = reader.GetString(SpecialtySourceValue),
                    Npi = reader.GetString(NPI),
                    Dea = reader.GetString(DEA),
                    Name = reader.GetString(Name),
                    YearOfBirth = reader.GetInt(YearOfBirth),
                    GenderConceptId = genderConceptId,
                    GenderSourceValue = reader.GetString(GenderSourceValue),
                    GenderSourceConceptId = reader.GetInt(GenderSourceConceptId) ?? 0,
                    SpecialtySourceConceptId = reader.GetInt(SpecialtySourceConceptId) ?? 0
                };

                prov.Id = string.IsNullOrEmpty(Id) ? Entity.GetId(prov.GetKey()) : reader.GetLong(Id).Value;
                yield return prov;
            }
            else
            {
                var conceptField = concept.Fields[0];


                var source = reader.GetString(conceptField.Key) ?? reader.GetString(conceptField.SourceKey);

                if (source != null && source.Length == 0)
                    source = null;

                var specialtyConceptIds = concept.GetConceptIdValues(Vocabulary, conceptField, reader).ToList();
                int? specialtyConcept = null;

                //(Unknown Physician Specialty)
                var defaultConceptId = 38004514;

                if (conceptField.DefaultConceptId.HasValue)
                {
                    defaultConceptId = conceptField.DefaultConceptId.Value;
                }

                if (specialtyConceptIds.Count > 0 && specialtyConceptIds[0].ConceptId != 0)
                {
                    specialtyConcept = specialtyConceptIds[0].ConceptId;
                }

                var prov = new Provider
                {
                    CareSiteId = reader.GetInt(CareSiteId) ?? 0,
                    ConceptId = specialtyConcept ?? defaultConceptId,
                    ProviderSourceValue = reader.GetString(ProviderSourceValue),
                    SourceValue = source,
                    Name = reader.GetString(Name),
                    YearOfBirth = reader.GetInt(YearOfBirth),
                    GenderConceptId = genderConceptId,
                    GenderSourceValue = reader.GetString(GenderSourceValue),
                    Npi = reader.GetString(NPI),
                    Dea = reader.GetString(DEA),
                    GenderSourceConceptId = reader.GetInt(GenderSourceConceptId) ?? 0,
                    SpecialtySourceConceptId = reader.GetInt(SpecialtySourceConceptId) ?? 0
                };

                prov.Id = string.IsNullOrEmpty(Id) ? Entity.GetId(prov.GetKey()) : reader.GetLong(Id).Value;
                
                yield return prov;
            }
        }
    }
}
