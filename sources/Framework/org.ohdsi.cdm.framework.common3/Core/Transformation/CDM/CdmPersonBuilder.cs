using Force.DeepCloner;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Linq;

namespace org.ohdsi.cdm.framework.common.Core.Transformation.CDM
{
    /// <summary>
    ///  Implementation of PersonBuilder for CPRD, based on CDM Build spec
    /// </summary>
    public class CdmPersonBuilder : PersonBuilder
    {
        private readonly Dictionary<long, bool> _removedVisitIds = [];
        private readonly Dictionary<long, bool> _removedVisitDetailIds = [];

        private readonly Dictionary<long, HashSet<LookupValue>> _alternativeConcepts = [];
        private int _newId = 0;

        public override KeyValuePair<Person, Attrition> BuildPerson(List<Person> records)
        {
            if (records == null || records.Count == 0)
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnacceptablePatientQuality);

            var ordered = records.OrderByDescending(p => p.StartDate).ToArray();
            var person = ordered.Take(1).First();
            person.StartDate = ordered.Take(1).Last().StartDate;

            if (person.YearOfBirth < 1875)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBPast);

            if (person.YearOfBirth > DateTime.Now.Year)
                return new KeyValuePair<Person, Attrition>(null, Attrition.ImplausibleYOBFuture);

            if (person.GenderConceptId == 0 || person.GenderConceptId == 8551)
            {
                return new KeyValuePair<Person, Attrition>(null, Attrition.UnknownGender);
            }

            return new KeyValuePair<Person, Attrition>(person, Attrition.None);
        }

        private void TryToRemap(IEnumerable<IEntity> records)
        {
            foreach (var record in records)
            {
                if(record.VisitOccurrenceId.HasValue && _removedVisitIds.ContainsKey(record.VisitOccurrenceId.Value))
                {
                    record.VisitOccurrenceId = null;
                }

                if (record.VisitDetailId.HasValue && _removedVisitDetailIds.ContainsKey(record.VisitDetailId.Value))
                {
                    record.VisitDetailId = null;
                }

               UpdateLookup(record);
            }
        }

        private void UpdateLookup(IEntity e)
        {
            var sourceVocabularyId = Vocabulary.GetSourceVocabularyId(e.SourceConceptId);
            string lookupName = null;
            if (!string.IsNullOrEmpty(sourceVocabularyId))
            {
                switch (sourceVocabularyId.ToLower())
                {
                    case "cpt4":
                        lookupName = "cpt4";
                        break;
                    case "hcpcs":
                        lookupName = "hcpcs";
                        break;
                    case "icd10cm":
                        lookupName = "icd10cm";
                        break;
                    case "icd10pcs":
                        lookupName = "icd10pcs";
                        break;
                    case "icd9cm":
                        lookupName = "icd9cm";
                        break;
                    case "icd9proc":
                        lookupName = "icd9proc";
                        break;
                    case "ndc":
                        lookupName = "ndc";
                        break;
                    case "revenue code":
                        lookupName = "revenue_code";
                        break;
                }
            }
            if (!string.IsNullOrEmpty(lookupName)) 
            {
                var lookup = Vocabulary.Lookup(e.SourceValue, lookupName, DateTime.MinValue);
                
                var newConceptIds = new List<Tuple<long, long, string>>();
                foreach (var l in lookup)
                {
                    foreach (var sc in l.SourceConcepts)
                    {
                        // Year > 1900 = invalid_reason = 'R'
                        if (sc.ValidStartDate.Year <= 1900)
                            continue;

                        long newSourceConceptId = 0;
                        long newConceptId = 0;
                        if (sc.ConceptId > 0 && e.StartDate.Between(sc.ValidStartDate, sc.ValidEndDate))
                        {
                            newSourceConceptId = sc.ConceptId;
                        }

                        if (l.ConceptId.HasValue && l.ConceptId.Value > 0 && e.StartDate.Between(l.ValidStartDate, l.ValidEndDate))
                        {
                            newConceptId = l.ConceptId.Value;
                        }
                        newConceptIds.Add(new Tuple<long, long, string>(newSourceConceptId, newConceptId, l.Domain));
                    }
                }

                if (newConceptIds.Count > 0) // Fix for invalid_reason = 'R'
                {
                    Tuple<long, long, string> newMap = null;
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
                    
                    if (newMap != null)
                    {
                        e.SourceConceptId = newMap.Item1;
                        e.ConceptId = newMap.Item2;
                        e.Domain = newMap.Item3;
                    }
                    else
                    {
                        e.SourceConceptId = 0;
                        e.ConceptId = 0;
                    }
                }
                else // Others
                {
                    var newMap = lookup.Where(l => l.ConceptId != e.ConceptId || l.Domain != e.Domain);
                    if (newMap.Any())
                    {
                        if (newMap.Count() == 1)
                        {
                            var l = newMap.First();
                            if (l.ConceptId.HasValue && l.ConceptId.Value > 0)
                            {
                                if (lookupName != "ndc" || e.StartDate.Between(l.ValidStartDate, l.ValidEndDate))
                                {
                                    e.ConceptId = l.ConceptId.Value;
                                    e.Domain = l.Domain;

                                    var sc = l.SourceConcepts.Where(c => c.ConceptId > 0).FirstOrDefault();
                                    if (sc != null)
                                    {
                                        e.SourceConceptId = sc.ConceptId;
                                    }
                                }
                            }
                        }
                        else
                        {
                            foreach (var l in lookup)
                            {
                                foreach (var sc in l.SourceConcepts)
                                {
                                    e.ConceptId = 0;

                                    if (!_alternativeConcepts.ContainsKey(sc.ConceptId))
                                        _alternativeConcepts.Add(sc.ConceptId, []);

                                    _alternativeConcepts[sc.ConceptId].Add(l);
                                }
                            }
                        }
                    }
                }
            }
            else if(e.ConceptId > 0)
            {
                var lookup = Vocabulary.Lookup(e.ConceptId.ToString(), "domain", DateTime.MinValue);
                if(lookup.Count > 0)
                {
                    var l = lookup.First();
                    e.Domain = l.Domain;
                }
            }
        }

        private long GetId()
        {
            _newId++;
             return 1000000000000000000 + ChunkData.ChunkId * 1000000000000000 + PersonRecords[0].PersonId * 100000L + _newId;
        }

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            var result = BuildPerson([.. PersonRecords]);
            var person = result.Key;
            if (person == null)
            {
                Complete = true;
                return result.Value;
            }

            //if(person.PersonId == 136899754)
            //{

            //}

            if(ObservationPeriodsRaw.Count == 0)
                return Attrition.InvalidObservationTime;

            var observationPeriods = new List<ObservationPeriod>();
            foreach (var op in ObservationPeriodsRaw)
            {
                if(op.StartDate.Date > DateTime.Now.Date)
                    return Attrition.InvalidObservationTime;

                if (op.EndDate.Value.Date > DateTime.Now.Date)
                    op.EndDate = DateTime.Now.Date;

                if (op.StartDate.Date > op.EndDate.Value.Date)
                    return Attrition.InvalidObservationTime;

                observationPeriods.Add(new ObservationPeriod
                {
                    Id = op.Id,
                    PersonId = op.PersonId,
                    StartDate = op.StartDate,
                    EndDate = op.EndDate,
                    TypeConceptId = op.TypeConceptId,
                });
            }

            var payerPlanPeriods = PayerPlanPeriodsRaw.ToArray();
            var visitOccurrences = new Dictionary<long, VisitOccurrence>();

            foreach (var visitOccurrence in VisitOccurrencesRaw)
            {
                if(visitOccurrence.StartDate.Date > DateTime.Now.Date)
                {
                    _removedVisitIds.TryAdd(visitOccurrence.Id, false);
                    continue;
                }

                visitOccurrences.Add(visitOccurrence.Id, visitOccurrence);
            }

            var visitDetails = new List<VisitDetail>();

            foreach (var vd in VisitDetailsRaw)
            {
                if (vd.StartDate.Date > DateTime.Now.Date)
                {
                    _removedVisitDetailIds.TryAdd(vd.Id, false);
                    continue;
                }

                visitDetails.Add(vd);
            }

            foreach (var de in DrugExposuresRaw)
            {
                if (string.IsNullOrEmpty(de.Domain))
                    de.Domain = "Drug";
            }

            foreach (var co in ConditionOccurrencesRaw)
            {
                if (string.IsNullOrEmpty(co.Domain))
                    co.Domain = "Condition";
            }

            foreach (var po in ProcedureOccurrencesRaw)
            {
                if (string.IsNullOrEmpty(po.Domain))
                    po.Domain = "Procedure";
            }

            foreach (var obs in ObservationsRaw)
            {
                if (string.IsNullOrEmpty(obs.Domain))
                    obs.Domain = "Observation";
            }

            foreach (var m in MeasurementsRaw)
            {
                if (string.IsNullOrEmpty(m.Domain))
                    m.Domain = "Measurement";
            }

            foreach (var de in DeviceExposureRaw)
            {
                if (string.IsNullOrEmpty(de.Domain))
                    de.Domain = "Device";
            }

            TryToRemap(DrugExposuresRaw);
            TryToRemap(ConditionOccurrencesRaw);
            TryToRemap(ProcedureOccurrencesRaw);
            TryToRemap(ObservationsRaw);
            TryToRemap(MeasurementsRaw);
            TryToRemap(DeviceExposureRaw);

            var newEntities = new List<IEntity>();

            var drugExposures = GetNewMap(DrugExposuresRaw, newEntities).ToArray();
            var conditionOccurrences = GetNewMap(ConditionOccurrencesRaw, newEntities).ToArray();
            var procedureOccurrences = GetNewMap(ProcedureOccurrencesRaw, newEntities).ToArray();
            var observations = GetNewMap(ObservationsRaw, newEntities).ToArray();
            var measurements = GetNewMap(MeasurementsRaw, newEntities).ToArray();
            var deviceExposure = GetNewMap(DeviceExposureRaw, newEntities).ToArray();

            Death death = DeathRecords.FirstOrDefault();

            if(death != null && death.StartDate.Date > DateTime.Now.Date)
                death = null;


            foreach (var byVisitDetailId in newEntities.GroupBy(i => i.VisitDetailId))
            {
                foreach (var bySourceConceptId in byVisitDetailId.GroupBy(i => i.SourceConceptId))
                {
                    foreach (var byConceptId in bySourceConceptId.GroupBy(i => i.ConceptId))
                    {
                        if (byConceptId.Count() > 1)
                        {

                        }

                        var newEnt = byConceptId.First();
                        //newEnt.Id = GetId();

                        AddToChunk(newEnt.Domain, [newEnt]);
                    }
                }
            }

            // push built entities to ChunkBuilder for further save to CDM database
            AddToChunk(person, death, [.. observationPeriods], payerPlanPeriods, [.. drugExposures],
                [.. conditionOccurrences], [.. procedureOccurrences], [.. observations], [.. measurements],
                [.. visitOccurrences.Values], [.. visitDetails], null, [.. deviceExposure], null, null);


            Complete = true;

            var pg = new PregnancyAlgorithm.PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, [.. observationPeriods],
                ChunkData.ConditionOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.ProcedureOccurrences.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Observations.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.Measurements.Where(e => e.PersonId == person.PersonId).ToArray(),
                ChunkData.DrugExposures.Where(e => e.PersonId == person.PersonId).ToArray()))
            {
                r.Id = Offset.GetKeyOffset(r.PersonId).ConditionEraId;
                ChunkData.ConditionEra.Add(r);
            }
            return Attrition.None;
        }

        protected IEnumerable<T> GetNewMap<T>(IEnumerable<T> entities, List<IEntity> newEntities) where T : class, IEntity
        {
            foreach (var byVisitDetailId in entities.GroupBy(i => i.VisitDetailId))
            {
                foreach (var bySource in byVisitDetailId.GroupBy(i => i.SourceValue))
                {
                    foreach (var bySourceConceptId in bySource.GroupBy(i => i.SourceConceptId))
                    {
                        var sourceConceptId = bySourceConceptId.First().SourceConceptId;
                        if (_alternativeConcepts.Count > 0 && _alternativeConcepts.ContainsKey(sourceConceptId))
                        {
                            //if(bySourceConceptId.Count() > 1)
                            //{

                            //}

                            foreach (var e in bySourceConceptId.Distinct())
                            {
                                foreach (var c in _alternativeConcepts[sourceConceptId])
                                {
                                    var newEntity = e.DeepClone();

                                    newEntity.Id = 0;
                                    newEntity.SourceRecordGuid = Guid.Empty;
                                    newEntity.ConceptId = c.ConceptId.Value;
                                    newEntity.Domain = c.Domain;
                                    newEntities.Add(newEntity);

                                }
                            }
                        }
                        else
                        {
                            foreach (var e in bySourceConceptId)
                            {
                                yield return e;
                            }
                        }
                    }
                }
            }
        }

        public override void AddToChunk(string domain, IEnumerable<IEntity> entities)
        {
            foreach (var entity in entities)
            {
                var entityDomain = GetDomain(domain, entity.Domain);

                switch (entityDomain)
                {
                    case "Condition":
                        {
                            var c = entity as ConditionOccurrence ??
                                           new ConditionOccurrence(entity);

                            if (c.Id == 0)
                                c.Id = GetId();

                            ConditionForEra.Add(c);
                            ChunkData.AddData(c);
                        }
                        break;

                    case "Measurement":
                        {
                            var m = entity as Measurement ?? new Measurement(entity);

                            if (m.Id == 0)
                                m.Id = GetId();

                            ChunkData.AddData(m);
                        }
                        break;

                    case "Observation":
                        {
                            var o = entity as Observation ?? new Observation(entity);

                            if (o.Id == 0)
                                o.Id = GetId();

                            ChunkData.AddData(o);
                        }
                        break;

                    case "Procedure":
                        {
                            var p = entity as ProcedureOccurrence ??
                                          new ProcedureOccurrence(entity);

                            if (p.Id == 0)
                                p.Id = GetId();

                            ChunkData.AddData(p);
                        }
                        break;

                    case "Device":
                        {
                            var d = entity as DeviceExposure ??
                                          new DeviceExposure(entity);

                            if (d.Id == 0)
                                d.Id = GetId();

                            ChunkData.AddData(d);
                        }
                        break;

                    case "Drug":
                        {
                            var drg = entity as DrugExposure ??
                                      new DrugExposure(entity);

                            if (drg.Id == 0)
                                drg.Id = GetId();

                            if (drg.ConceptId > 0)
                            {
                                var result = Vocabulary.Lookup(drg.ConceptId.ToString(), "ingredient", DateTime.MinValue);

                                if (result.Count != 0)
                                {
                                    drg.Ingredients = [];
                                    foreach (var r in result)
                                    {
                                        if(r.ConceptId.HasValue && r.ConceptId > 0)
                                            drg.Ingredients.Add(r.ConceptId.Value);
                                    }
                                }
                            }

                            DrugForEra.Add(drg);
                            ChunkData.AddData(drg);
                        }
                        break;
                }
            }
        }

        //public override IEnumerable<EraEntity> BuildDrugEra(DrugExposure[] drugExposures, ObservationPeriod[] observationPeriods)
        //{
        //    foreach (var eraEntity in EraHelper.GetEras(
        //        Clean(drugExposures, observationPeriods, false).Where(d => string.IsNullOrEmpty(d.Domain) || d.Domain == "Drug"), 30, 38000182))
        //    {
        //        eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).DrugEraId;
        //        yield return eraEntity;
        //    }
        //}

    }
}