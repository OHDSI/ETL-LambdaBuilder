using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;
using System.Linq;

namespace org.ohdsi.cdm.framework.etl.Transformation.PA
{
    public class PregnancyAlgorithmPersonBuilder : PersonBuilder
    {
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
    }
}