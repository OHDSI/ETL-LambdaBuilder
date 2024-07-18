using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;

namespace org.ohdsi.cdm.framework.etl.Transformation.PA
{
    public class PregnancyAlgorithmPersonBuilder : PersonBuilder
    {
        #region Classes

        public class PregnancyAlgorithmVendor : Vendor
        {
            DateTime? _sourceReleaseDate;
            public override DateTime? SourceReleaseDate { get => _sourceReleaseDate; set => _sourceReleaseDate = value; }

            public override string Name => "PregnancyAlgorithm";
            public override string Folder => "PregnancyAlgorithm";
            public override string Description => "PregnancyAlgorithm v5.4";
            public override string CdmSource => "CdmSource.sql";
            public override CdmVersions CdmVersion => CdmVersions.V54;
            public override int PersonIdIndex => 0;
            public override string PersonTableName => "Person";
            public override string Citation => "";
            public override string Publication => "No review required";
        }

        #endregion

        #region Constructors

        public PregnancyAlgorithmPersonBuilder(Vendor vendor)
            : base(vendor)
        {
            if (
                vendor is not PregnancyAlgorithmVendor
                )
                throw new Exception($"Unsupported vendor type: {vendor.GetType().Name}");
        }

        #endregion

        #region Methods

        public override Attrition Build(ChunkData data, KeyMasterOffsetManager o)
        {
            this.Offset = o;
            this.ChunkData = data;

            var person = PersonRecords[0];

            var observationPeriods =
                BuildObservationPeriods(person.ObservationPeriodGap, [.. ObservationPeriodsRaw]).ToArray();

            var pg = new PregnancyAlgorithm();
            foreach (var r in pg.GetPregnancyEpisodes(Vocabulary, person, [.. observationPeriods],
                [.. ConditionOccurrencesRaw],
                [.. ProcedureOccurrencesRaw],
                [.. ObservationsRaw],
                [.. MeasurementsRaw],
                [.. DrugExposuresRaw]))
            {
                r.Id = Offset.GetKeyOffset(r.PersonId).ConditionEraId * -1;
                ChunkData.ConditionEra.Add(r);
                ChunkData.Persons.Add(person);
            }

            return Attrition.None;
        }

        #endregion
    }
}