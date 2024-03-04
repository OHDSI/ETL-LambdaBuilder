using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Omop;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class LocationHistoryDefinition : EntityDefinition
    {
        public string EntityId { get; set; }
        public string DomainId { get; set; }
        public string LocationId { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager offset)
        {
            var id = string.IsNullOrEmpty(Id) ? 0 : reader.GetLong(Id).Value;

            var lh = new LocationHistory()
            {
                Id = id,
                EntityId = reader.GetLong(EntityId),
                LocationId = reader.GetLong(LocationId),
                DomainId = reader.GetString(DomainId),
                StartDate = reader.GetDateTime(StartDate),
                EndDate = reader.GetDateTime(StartDate),
            };

            if (concept == null)
            {
                yield return lh;
            }
            else
            {
                lh.TypeConceptId = concept.GetTypeId(concept.Fields[0], reader);
            }

            yield return lh;
        }
    }
}
