using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
    public class MeasurementDefinition : EntityDefinition
    {
        public string Time { get; set; }
        public string DateTime { get; set; }
        public string OperatorConceptId { get; set; }
        public string ValueAsNumber { get; set; }
        public string ValueAsConceptId { get; set; }
        public string UnitConceptId { get; set; }
        public string RangeLow { get; set; }
        public string RangeHigh { get; set; }
        public string UnitSourceValue { get; set; }
        public string ValueSourceValue { get; set; }

        public KeyValuePair<int?, string> GetUnitConcept(IDataRecord reader)
        {
            if (Concepts.Length < 2)
                return new KeyValuePair<int?, string>(null, string.Empty);

            var unitsConcepts = base.GetConcepts(Concepts[1], reader, null).Where(c => c.ConceptId != 0).ToList();
            var sourceValue = reader.GetString(Concepts[1].Fields[0].Key);

            if (unitsConcepts.Count > 0)
            {
                foreach (var uc in unitsConcepts)
                {
                    if (!string.IsNullOrEmpty(sourceValue) && !string.IsNullOrEmpty(uc.VocabularySourceValue) &&
                        sourceValue.Equals(uc.VocabularySourceValue, StringComparison.Ordinal))
                        return new KeyValuePair<int?, string>(uc.ConceptId, sourceValue);
                }

                return new KeyValuePair<int?, string>(unitsConcepts[0].ConceptId, unitsConcepts[0].SourceValue);
            }

            return new KeyValuePair<int?, string>(null, sourceValue);
        }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
           var obsConcepts = base.GetConcepts(concept, reader, offset).ToList();
           var unitConcept = GetUnitConcept(reader);

           int? valueAsConceptId = null;
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

            if (obsConcepts.Count > 0)
            {
                yield return new Measurement(obsConcepts[0])
            {
                Id = KeyMasterOffsetManager.GetKeyOffset(obsConcepts[0].PersonId).MeasurementId,
                SourceValue = string.IsNullOrWhiteSpace(obsConcepts[0].SourceValue) ? null : obsConcepts[0].SourceValue,
                RangeLow = reader.GetDecimal(RangeLow),
                RangeHigh = reader.GetDecimal(RangeHigh),
                ValueAsNumber = reader.GetDecimal(ValueAsNumber),
                OperatorConceptId = reader.GetInt(OperatorConceptId) ?? 0,
                UnitConceptId = unitConcept.Key ?? 0,
                UnitSourceValue = string.IsNullOrWhiteSpace(unitConcept.Value) ? null : unitConcept.Value,
                ValueSourceValue = reader.GetString(ValueSourceValue),
                ValueAsConceptId = valueAsConceptId ?? 0,
                DateTime = reader.GetTime(DateTime),
                Time = reader.GetTime(Time)
            };
            }

        }
    }
}

