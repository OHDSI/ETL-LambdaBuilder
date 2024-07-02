using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.framework.etl.Transformation.Era
{
    /// <summary>
    ///  Implementation of PersonBuilder for CPRD, based on CDM Build spec
    /// </summary>
    public class EraPersonBuilder : PersonBuilder
    {
        #region Classes

        public class EraVendor : Vendor
        {
            public override string Name => "Era";
            public override string Folder => "Era";
            public override string Description => "Era v5.4";
            public override string CdmSource => "CdmSource.sql";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "Person";
            public override string Citation => "";
            public override string Publication => "No review required";
        }

        #endregion

        #region Constructors

        public EraPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not EraVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods 

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

        #endregion
    }
}