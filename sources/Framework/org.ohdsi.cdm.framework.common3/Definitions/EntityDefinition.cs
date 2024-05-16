using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Xml.Serialization;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class EntityDefinition
    {
        private Condition1 _condition;

        public bool IsUnique { get; set; }

        public string Id { get; set; }
        public string PersonId { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }

        public string ProviderId { get; set; }
        public string ProviderIdKey { get; set; }

        public string[] AdditionalFields { get; set; }

        public string VisitOccurrenceId { get; set; }

        public string VisitDetailId { get; set; }

        public string Condition { get; set; }
        public Concept[] Concepts { get; set; }

        [XmlIgnore]
        public IVocabulary Vocabulary { get; set; }

        public bool Match(IDataRecord reader)
        {
            if (string.IsNullOrEmpty(Condition))
                return true;

            _condition ??= new Condition1(Condition);

            return _condition.Match(reader);
        }

        public virtual IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            var personId = reader.GetLong(PersonId);

            if (personId.HasValue)
            {
                var startDate = reader.GetDateTime(StartDate);
                //var endDate = startDate;
                DateTime? endDate = null;
                if (!string.IsNullOrEmpty(EndDate))
                    endDate = reader.GetDateTime(EndDate);

                Dictionary<string, string> additionalFields = null;
                if (AdditionalFields != null)
                {
                    additionalFields =
                        new Dictionary<string, string>(AdditionalFields.Length, StringComparer.OrdinalIgnoreCase);
                    foreach (var additionalField in AdditionalFields)
                    {
                        //additionalFields.Add(String.Intern(additionalField.ToLower()), reader.GetString(additionalField));
                        additionalFields.Add(additionalField, reader.GetString(additionalField));
                    }
                }

                foreach (var field in concept.Fields)
                {
                    var sourceValue = field.DefaultSource;
                    if (string.IsNullOrEmpty(sourceValue))
                        sourceValue = reader.GetString(field.Key);

                    if (!field.IsNullable && string.IsNullOrEmpty(sourceValue) && field.DefaultConceptId == null &&
                        field.ConceptId == null)
                        continue;

                    // Used when: field.Key used for conceptId mapping and
                    // field.SourceKey used for SourceValue (by default field.Key and field.SourceKey are identical)
                    if (!string.IsNullOrEmpty(field.SourceKey))
                        sourceValue = reader.GetString(field.SourceKey);

                    var result = new List<Entity>();
                    var newConceptIds = new List<Tuple<long, long, string>>();
                    foreach (var lookupValue in concept.GetConceptIdValues(Vocabulary, field, reader))
                    {
                        var cId = lookupValue.ConceptId;
                        if (!cId.HasValue && field.DefaultConceptId.HasValue)
                            cId = field.DefaultConceptId;

                        if (!concept.IdRequired || cId.HasValue)
                        {
                            var providerIdKey = reader.GetString(ProviderIdKey);
                            if (!string.IsNullOrEmpty(providerIdKey))
                                providerIdKey = providerIdKey.TrimStart('0');

                            List<long> ingredients = null;
                            if (lookupValue.Ingredients != null)
                            {
                                ingredients = [.. lookupValue.Ingredients];
                            }

                            if (!string.IsNullOrEmpty(StartTime))
                            {
                                if (DateTime.TryParse(reader.GetString(StartTime), out var dt))
                                {
                                    startDate += dt.TimeOfDay;
                                }
                            }

                            if (endDate.HasValue && endDate != DateTime.MinValue && !string.IsNullOrEmpty(EndTime))
                            {
                                if (DateTime.TryParse(reader.GetString(EndTime), out var dt))
                                {
                                    endDate += dt.TimeOfDay;
                                }
                            }

                            // TMP
                            var sourceConceptId = lookupValue.SourceConcepts.Count != 0 ? lookupValue.SourceConcepts[0].ConceptId : 0;
                            if (!string.IsNullOrEmpty(field.SourceConceptId))
                            {
                                var scId  = reader.GetLong(field.SourceConceptId);
                                if(scId.HasValue)
                                {
                                    sourceConceptId = scId.Value;
                                }
                            }

                            foreach (var sc in lookupValue.SourceConcepts)
                            {
                                if (char.ToLower(sc.InvalidReason) != 'r')
                                    continue;

                                long newSourceConceptId = 0;
                                long newConceptId = 0;
                                if (sc.ConceptId > 0 && startDate.Between(sc.ValidStartDate, sc.ValidEndDate))
                                {
                                    newSourceConceptId = sc.ConceptId;
                                }

                                if (lookupValue.ConceptId.HasValue && 
                                    lookupValue.ConceptId.Value > 0 && 
                                    startDate.Between(lookupValue.ValidStartDate, lookupValue.ValidEndDate))
                                {
                                    newConceptId = lookupValue.ConceptId.Value;
                                }
                                newConceptIds.Add(new Tuple<long, long, string>(newSourceConceptId, newConceptId, lookupValue.Domain));
                            }

                            result.Add(new Entity
                            {
                                IsUnique = IsUnique,
                                PersonId = personId.Value,
                                SourceValue = sourceValue,
                                ConceptId = cId ?? 0,
                                TypeConceptId = concept.GetTypeId(field, reader),
                                ConceptIdKey = reader.GetString(field.Key),
                                StartDate = startDate,
                                EndDate = endDate == DateTime.MinValue ? (DateTime?)null : endDate,
                                ProviderId = reader.GetLong(ProviderId),
                                ProviderKey = providerIdKey,
                                VisitOccurrenceId = reader.GetLong(VisitOccurrenceId),
                                VisitDetailId = reader.GetLong(VisitDetailId),
                                AdditionalFields = additionalFields,
                                ValidStartDate = lookupValue.ValidStartDate,
                                ValidEndDate = lookupValue.ValidEndDate,
                                SourceConceptId = sourceConceptId,
                                Domain = lookupValue.Domain,
                                //SourceVocabularyId = lookupValue.SourceVocabularyId,
                                VocabularySourceValue = lookupValue.SourceCode,
                                Ingredients = ingredients,
                                ValueAsConceptId = lookupValue.ValueAsConceptId
                            });
                        }
                    }

                    // SourceConceptId, ConceptId, Domain
                    Tuple<long, long, string> newMap = null;
                    if (newConceptIds.Count > 0) // Fix for invalid_reason = 'R'
                    {
                        // SourceConceptId
                        var r1 = newConceptIds.Where(c => c.Item1 > 0);

                        if (r1.Any())
                        {
                            // ConceptId
                            var r2 = r1.Where(c => c.Item2 > 0);
                            if (r2.Any())
                            {
                                newMap = r2.FirstOrDefault();
                            }
                        }
                        else
                        {
                            var r2 = newConceptIds.Where(c => c.Item2 > 0);
                            if (r2.Any())
                            {
                                newMap = r2.FirstOrDefault();
                            }
                        }

                        newMap ??= r1.FirstOrDefault();
                    }

                    foreach (var item in result)
                    {
                        if (newMap != null)
                        {
                            item.SourceConceptId = newMap.Item1;
                            item.ConceptId = newMap.Item2;
                            item.Domain = newMap.Item3;
                        }

                        yield return item;
                    }
                }
            }
        }
    }
}
