using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
   public class CareSiteDefinition : EntityDefinition
   {
      public string LocationId { get; set; }
      public string Name { get; set; }
      public string PlaceOfSvcSourceValue { get; set; }
      public string PlaceOfSvcConceptId { get; set; }
      public string CareSiteSourceValue { get; set; }

      public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
      {
         var id = string.IsNullOrEmpty(Id) ? -1 : reader.GetLong(Id);
         int conceptId = 0;
         if (!string.IsNullOrEmpty(PlaceOfSvcConceptId) && reader.GetLong(PlaceOfSvcConceptId).HasValue)
         {
            conceptId = reader.GetInt(PlaceOfSvcConceptId).Value;
         }

         var locationId = reader.GetLong(LocationId);
         var careSiteSourceValue = string.IsNullOrEmpty(CareSiteSourceValue)
            ? id.Value.ToString(CultureInfo.InvariantCulture)
            : reader.GetString(CareSiteSourceValue);

         if (concept == null)
         {
            yield return new CareSite
            {
               Id = id.Value,
               LocationId = locationId ?? 0,
               PlaceOfSvcSourceValue = reader.GetString(PlaceOfSvcSourceValue),
               ConceptId = conceptId,
               Name = reader.GetString(Name),
               SourceValue = careSiteSourceValue
            };
         }
         else
         {
            var conceptField = concept.Fields[0];
            
            var source = reader.GetString(conceptField.Key) ?? reader.GetString(conceptField.SourceKey);
            if (source != null && source.Length == 0)
               source = null;

            var placeOfSvcConceptIds = concept.GetConceptIdValues(Vocabulary, conceptField, reader).ToList();
            int? placeOfSvcConceptId = null;

            int defaultConceptId = 0;
            if (conceptField.DefaultConceptId.HasValue)
            {
               defaultConceptId = conceptField.DefaultConceptId.Value;
            }

            if (placeOfSvcConceptIds.Count > 0 && placeOfSvcConceptIds[0].ConceptId != 0)
            {
               placeOfSvcConceptId = placeOfSvcConceptIds[0].ConceptId;
            }

            yield return new CareSite
            {
               Id = id.Value,
               LocationId = locationId ?? 0,
               PlaceOfSvcSourceValue = source,
               ConceptId =  placeOfSvcConceptId ?? defaultConceptId,
               Name = reader.GetString(Name),
               SourceValue = careSiteSourceValue
            };
         }
      }
   }
}
