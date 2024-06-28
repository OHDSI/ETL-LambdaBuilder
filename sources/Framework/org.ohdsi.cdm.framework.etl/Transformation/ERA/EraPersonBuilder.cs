using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;
using System;
using System.Collections.Generic;
using System.Linq;

namespace org.ohdsi.cdm.framework.etl.Transformation.Era
{
    /// <summary>
    ///  Implementation of PersonBuilder for CPRD, based on CDM Build spec
    /// </summary>
    public class EraPersonBuilder : PersonBuilder
    {
        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            Person p = new() { PersonId = PersonRecords[0].PersonId };
            var observationPeriods = new[]
                {
                    new ObservationPeriod
                    {
                        PersonId = p.PersonId,
                        StartDate = DateTime.MinValue,
                        EndDate = DateTime.MaxValue
                    }
                };

            if (ConditionOccurrencesRaw.Count != 0)
            {
                foreach (var eraEntity in BuildConditionEra([.. ConditionOccurrencesRaw], observationPeriods))
                {
                    ChunkData.AddData(eraEntity, EntityType.ConditionEra);
                }
            }

            if (DrugExposuresRaw.Count != 0)
            {
                foreach (var eraEntity in BuildDrugEra([.. DrugExposuresRaw], observationPeriods))
                {
                    ChunkData.AddData(eraEntity, EntityType.DrugEra);
                }
            }

            ChunkData.AddData(p);

            return Attrition.None;
        }

        public override IEnumerable<EraEntity> BuildDrugEra(DrugExposure[] drugExposures, ObservationPeriod[] observationPeriods)
        {
            var ingredients = new Dictionary<string, List<long>>();

            foreach (var group in drugExposures.GroupBy(d => d.SourceValue))
            {
                ingredients.Add(group.First().SourceValue, group.Select(i => i.ConceptId).Distinct().ToList());
            }

            foreach (var de in drugExposures)
            {
                de.Ingredients = ingredients[de.SourceValue];
            }

            foreach (var eraEntity in EraHelper.GetEras(drugExposures, 30, 38000182))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).DrugEraId;
                yield return eraEntity;
            }
        }

        public override IEnumerable<EraEntity> BuildConditionEra(ConditionOccurrence[] conditionOccurrences, ObservationPeriod[] observationPeriods)
        {
            foreach (var eraEntity in EraHelper.GetEras(conditionOccurrences, 30, 38000247))
            {
                eraEntity.Id = Offset.GetKeyOffset(eraEntity.PersonId).ConditionEraId;
                yield return eraEntity;
            }
        }
    }
}