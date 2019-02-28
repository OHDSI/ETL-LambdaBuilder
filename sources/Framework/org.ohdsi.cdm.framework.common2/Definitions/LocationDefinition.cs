using System.Collections.Generic;
using System.Data;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
    public class LocationDefinition : EntityDefinition
    {
        public string Zip { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string SourceValue { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }

        public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader,
            KeyMasterOffsetManager keyOffset)
        {
            var loc = new Location
            {
                State = reader.GetString(State),
                SourceValue = reader.GetString(SourceValue),
                County = reader.GetString(Country),
                Address1 = reader.GetString(Address1),
                Address2 = reader.GetString(Address2)
            };

            loc.Id = string.IsNullOrEmpty(Id) ? Entity.GetId(loc.GetKey()) : reader.GetLong(Id).Value;
            yield return loc;
        }
    }
}
