using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class DeviceExposureDefinition : EntityDefinition
    {
        public string UniqueDeviceId { get; set; }
        public string Quantity { get; set; }

        public string ProductionId { get; set; }

        public KeyValuePair<long?, string> GetUnitConcept(IDataRecord reader)
        {
            if (Concepts.Length < 2)
                return new KeyValuePair<long?, string>(null, string.Empty);

            var unitsConcepts = base.GetConcepts(Concepts[1], reader, null).Where(c => c.ConceptId != 0).ToList();
            var sourceValue = reader.GetString(Concepts[1].Fields[0].Key);

            if (unitsConcepts.Count > 0)
            {
                foreach (var uc in unitsConcepts)
                {
                    if (!string.IsNullOrEmpty(sourceValue) && !string.IsNullOrEmpty(uc.VocabularySourceValue) &&
                        sourceValue.Equals(uc.VocabularySourceValue, StringComparison.Ordinal))
                        return new KeyValuePair<long?, string>(uc.ConceptId, sourceValue);
                }

                return new KeyValuePair<long?, string>(unitsConcepts[0].ConceptId, unitsConcepts[0].SourceValue);

            }

            return new KeyValuePair<long?, string>(null, sourceValue);
        }


        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            var unitConcept = GetUnitConcept(reader);

            foreach (var entity in base.GetConcepts(concept, reader, offset))
            {
                yield return new DeviceExposure(entity)
                {
                    Id = offset.GetKeyOffset(entity.PersonId).DeviceExposureId,
                    UniqueDeviceId = reader.GetString(UniqueDeviceId),
                    Quantity = reader.GetInt(Quantity),
                    ProductionId = reader.GetString(ProductionId),
                    UnitConceptId = unitConcept.Key,
                    //UnitSourceConceptId = 0,
                    UnitSourceValue = string.IsNullOrWhiteSpace(unitConcept.Value) ? null : unitConcept.Value,
                };
            }
        }
    }
}