using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class ObservationPeriodDefinition : EntityDefinition
    {
        public string TypeConceptId { get; set; }

        public IEnumerable<EraEntity> GetObservationPeriods(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            yield return new EraEntity
            {
                Id = reader.GetLong(Id) ?? 0,
                PersonId = reader.GetLong(PersonId) ?? 0,
                TypeConceptId = reader.GetLong(TypeConceptId) ?? 0,
                StartDate = reader.GetDateTime(StartDate),
                EndDate = reader.GetDateTime(EndDate),
            };
        }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
        {
            throw new NotImplementedException("ObservationPeriodDefinition.GetConcepts()");
        }
    }
}