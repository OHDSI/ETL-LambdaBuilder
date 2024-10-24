﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class ObservationDefinition : EntityDefinition
    {
        public string[] ValuesAsNumber { get; set; }
        public string[] ValuesAsString { get; set; }

        public string RangeLow { get; set; }
        public string RangeHigh { get; set; }

        public string ValueAsConceptId { get; set; }
        public string UnitsConceptId { get; set; }
        public string AssociatedProviderId { get; set; }
        public string RelevantConditionConceptId { get; set; }

        public string UnitsSourceValue { get; set; }
        public string Time { get; set; }

        // CDM V5 props
        public string QualifierConceptId { get; set; }
        public string QualifierSourceValue { get; set; }

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
            //var personId = reader.GetLong(PersonId);

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
                if (!string.IsNullOrEmpty(Time) && DateTime.TryParse(reader.GetString(Time), out var time))
                {
                    entity.StartDate = new DateTime(entity.StartDate.Year, entity.StartDate.Month, entity.StartDate.Day, time.Hour, time.Minute, time.Second);
                }

                var createObservation = new Func<Observation>(() => new Observation(entity)
                {
                    //Id = offset.GetKeyOffset(entity.PersonId).ObservationId,
                    SourceValue = string.IsNullOrWhiteSpace(entity.SourceValue)
                        ? null
                        : entity.SourceValue,
                    RangeLow = reader.GetDecimal(RangeLow),
                    RangeHigh = reader.GetDecimal(RangeHigh),
                    UnitsConceptId = unitConcept.Key,
                    UnitsSourceValue = string.IsNullOrWhiteSpace(unitConcept.Value) ? null : unitConcept.Value,
                    ValueAsConceptId = valueAsConceptId ?? entity.ValueAsConceptId,
                    QualifierConceptId = reader.GetInt(QualifierConceptId) ?? 0,
                    QualifierSourceValue = reader.GetString(QualifierSourceValue),
                    ValueSourceValue = reader.GetString(ValueSourceValue),
                    EventId = reader.GetLong(EventId),
                    EventFieldConceptId = reader.GetInt(EventFieldConceptId)
                });

                if (ValuesAsNumber != null && ValuesAsNumber.Length > 1)
                {
                    foreach (var valueAsNumber in ValuesAsNumber)
                    {
                        var value = reader.GetDecimal(valueAsNumber);
                        if (value != null)
                        {
                            var observation = createObservation();

                            observation.ValueAsNumber = Math.Round(value.Value, 3);
                            observation.SourceValue = observation.ValueAsNumber.ToString();
                            observation.TypeConceptId = 38000277;
                            yield return observation;
                        }
                    }
                }
                else if (ValuesAsString != null && ValuesAsString.Length > 1)
                {
                    foreach (var valueAsString in ValuesAsString)
                    {
                        var value = reader.GetString(valueAsString);
                        if (!string.IsNullOrEmpty(value) && value != "-" && value != "9") //TMP
                        {
                            var observation = createObservation();
                            observation.ValueAsString = reader.GetString(valueAsString);
                            observation.SourceValue = valueAsString;
                            observation.TypeConceptId = 38000278;
                            yield return observation;
                        }
                    }
                }
                //else if (obsConcepts[0].ConceptId > 0 || !string.IsNullOrEmpty(obsConcepts[0].SourceValue))
                else if (entity.ConceptId > 0 || concept.Fields[0].IsNullable || !string.IsNullOrEmpty(entity.SourceValue))
                {
                    var observation = createObservation();
                    if (ValuesAsNumber != null && ValuesAsNumber.Length > 0)
                    {
                        observation.ValueAsNumber = reader.GetDecimal(ValuesAsNumber[0]);
                        if (observation.ValueAsNumber.HasValue)
                        {
                            observation.ValueAsNumber = Math.Round(observation.ValueAsNumber.Value, 3);
                        }
                    }

                    if (ValuesAsString != null && ValuesAsString.Length > 0)
                    {
                        observation.ValueAsString = reader.GetString(ValuesAsString[0]);

                        // Workaround, map ValueAsString (usind SourceLookup) and reset SourceValue to original value
                        if (observation.AdditionalFields != null &&
                            observation.AdditionalFields.ContainsKey("original_source"))
                        {
                            observation.ValueAsString = observation.SourceValue;
                            observation.SourceValue = observation.AdditionalFields["original_source"];
                        }
                    }

                    var id = reader.GetLong(Id);

                    if (id.HasValue)
                    {
                        observation.Id = id.Value;
                    }
                    else
                    {
                        observation.Id = offset.GetKeyOffset(observation.PersonId).ObservationId;
                    }

                    yield return observation;
                }
            }
        }
    }
}

