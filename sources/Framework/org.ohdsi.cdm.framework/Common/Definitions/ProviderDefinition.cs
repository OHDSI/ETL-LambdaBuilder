﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
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

            if (genderConceptId == 8551)
                genderConceptId = 0;

            var providerIdKey = reader.GetString(ProviderIdKey);
            if (!string.IsNullOrEmpty(providerIdKey))
                providerIdKey = providerIdKey.TrimStart('0');

            if (concept == null)
            {
                var prov = new Provider
                {
                    CareSiteId = reader.GetLong(CareSiteId) ?? 0,
                    ProviderSourceValue = reader.GetString(ProviderSourceValue),
                    SourceValue = reader.GetString(SpecialtySourceValue),
                    Npi = reader.GetString(NPI),
                    Dea = reader.GetString(DEA),
                    Name = reader.GetString(Name),
                    YearOfBirth = reader.GetInt(YearOfBirth),
                    GenderConceptId = genderConceptId,
                    GenderSourceValue = reader.GetString(GenderSourceValue),
                    GenderSourceConceptId = reader.GetInt(GenderSourceConceptId) ?? 0,
                    SpecialtySourceConceptId = reader.GetInt(SpecialtySourceConceptId) ?? 0,
                    ProviderKey = providerIdKey
                };

                prov.Id = string.IsNullOrEmpty(Id) ? Entity.GetId(prov.GetKey()) : reader.GetLong(Id).Value;
                yield return prov;
            }
            else
            {
                var conceptField = concept.Fields[0];

                var sourceValue = conceptField.DefaultSource;
                if (string.IsNullOrEmpty(sourceValue))
                    sourceValue = reader.GetString(conceptField.Key);

                if (!string.IsNullOrEmpty(conceptField.SourceKey))
                    sourceValue = reader.GetString(conceptField.SourceKey);

                if (sourceValue != null && sourceValue.Length == 0)
                    sourceValue = null;

                var specialtyConceptIds = concept.GetConceptIdValues(Vocabulary, conceptField, reader).ToList();

                long? specialtyConcept = null;
                long? specialtySourceConceptId = null;

                var defaultConceptId = 0;
                if (conceptField.DefaultConceptId.HasValue)
                {
                    defaultConceptId = conceptField.DefaultConceptId.Value;
                }

                if (specialtyConceptIds.Count > 0)
                {
                    if (specialtyConceptIds[0].ConceptId != 0)
                        specialtyConcept = specialtyConceptIds[0].ConceptId;

                    if (specialtyConceptIds[0].SourceConcepts.Count > 0 && specialtyConceptIds[0].SourceConcepts.First().ConceptId != 0)
                        specialtySourceConceptId = specialtyConceptIds[0].SourceConcepts.First().ConceptId;

                    if (!specialtySourceConceptId.HasValue || specialtySourceConceptId.Value == 0)
                    {
                        specialtySourceConceptId = reader.GetLong(conceptField.SourceConceptId);
                    }

                    if (!specialtySourceConceptId.HasValue || specialtySourceConceptId.Value == 0)
                    {
                        specialtySourceConceptId = reader.GetLong(SpecialtySourceConceptId);
                    }
                }

                var prov = new Provider
                {
                    CareSiteId = reader.GetLong(CareSiteId) ?? 0,
                    ConceptId = specialtyConcept ?? defaultConceptId,
                    ProviderSourceValue = reader.GetString(ProviderSourceValue),
                    SourceValue = sourceValue,
                    Name = reader.GetString(Name),
                    YearOfBirth = reader.GetInt(YearOfBirth),
                    GenderConceptId = genderConceptId,
                    GenderSourceValue = reader.GetString(GenderSourceValue),
                    Npi = reader.GetString(NPI),
                    Dea = reader.GetString(DEA),
                    GenderSourceConceptId = reader.GetInt(GenderSourceConceptId) ?? 0,
                    SpecialtySourceConceptId = specialtySourceConceptId ?? 0,
                    ProviderKey = providerIdKey
                };

                prov.Id = string.IsNullOrEmpty(Id) ? Entity.GetId(prov.GetKey()) : reader.GetLong(Id).Value;

                yield return prov;
            }
        }
    }
}