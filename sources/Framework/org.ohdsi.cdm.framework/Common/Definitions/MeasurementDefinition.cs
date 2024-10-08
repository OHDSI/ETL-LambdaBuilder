﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class MeasurementDefinition : EntityDefinition
    {
        public string Time { get; set; }

        public string OperatorConceptId { get; set; }
        public string ValueAsNumber { get; set; }
        public string ValueAsConceptId { get; set; }
        public string UnitConceptId { get; set; }
        public string RangeLow { get; set; }
        public string RangeHigh { get; set; }
        public string UnitSourceValue { get; set; }
        public string ValueSourceValue { get; set; }
        public string EventId { get; set; }
        public string EventFieldConceptId { get; set; }

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

            return new KeyValuePair<long?, string>(0, sourceValue);
        }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            //var obsConcepts = base.GetConcepts(concept, reader, offset).ToList();
            var unitConcept = GetUnitConcept(reader);

            long? valueAsConceptId = null;
            if (Concepts.Length > 2)
            {
                var valueConcepts = base.GetConcepts(Concepts[2], reader, null).ToList();
                if (valueConcepts.Count > 0)
                {
                    valueAsConceptId = valueConcepts[0].ConceptId;
                }
            }
            else
            {
                valueAsConceptId = reader.GetInt(ValueAsConceptId);
            }

            foreach (var entity in base.GetConcepts(concept, reader, offset))
            {
                var m = new Measurement(entity)
                {
                    SourceValue = string.IsNullOrWhiteSpace(entity.SourceValue)
                        ? null
                        : entity.SourceValue,
                    RangeLow = reader.GetDecimal(RangeLow),
                    RangeHigh = reader.GetDecimal(RangeHigh),
                    ValueAsNumber = reader.GetDecimal(ValueAsNumber),
                    OperatorConceptId = reader.GetInt(OperatorConceptId),
                    UnitConceptId = unitConcept.Key,
                    UnitSourceValue = string.IsNullOrWhiteSpace(unitConcept.Value) ? null : unitConcept.Value,
                    ValueSourceValue = reader.GetString(ValueSourceValue),
                    ValueAsConceptId = valueAsConceptId ?? entity.ValueAsConceptId,
                    Time = reader.GetString(Time),
                    EventId = reader.GetLong(EventId),
                    EventFieldConceptId = reader.GetInt(EventFieldConceptId)
                };

                var id = reader.GetLong(Id);

                if (id.HasValue)
                {
                    m.Id = id.Value;
                }
                else
                {
                    m.Id = offset.GetKeyOffset(entity.PersonId).MeasurementId;
                }
                yield return m;
            }
        }
    }
}