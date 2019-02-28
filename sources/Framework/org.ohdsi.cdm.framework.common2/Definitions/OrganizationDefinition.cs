using System.Collections.Generic;
using System.Data;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
   public class OrganizationDefinition : EntityDefinition
   {
      public string LocationId { get; set; }
      public string PlaceOfService { get; set; }

      public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager keyOffset)
      {
         var conceptField = Concepts[0].Fields[0];
         var id = string.IsNullOrEmpty(Id) ? -1 : reader.GetLong(Id);

         yield return new Organization
                         {
                            Id = id.Value,
                            ConceptId = conceptField.DefaultConceptId ?? 0,
                            LocationId = 0, 
                            SourceValue = reader.GetString(conceptField.Key),
                            PlaceOfSvcSourceValue = string.IsNullOrEmpty(PlaceOfService) ? "" : reader.GetString(PlaceOfService)
                         };
      }
   }
}
