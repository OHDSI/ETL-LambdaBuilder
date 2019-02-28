using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Omop;

namespace org.ohdsi.cdm.framework.common2.Definitions
{
   public class DeviceExposureDefinition : EntityDefinition
   {
      public string UniqueDeviceId { get; set; }
      public string Quantity { get; set; }

      public override IEnumerable<IEntity> GetConcepts(Concept concept, IDataRecord reader, KeyMasterOffsetManager offset)
      {
         var de = base.GetConcepts(concept, reader, offset).ToList();
         
         if(de.Count > 0)
         {
            yield return new DeviceExposure(de[0])
                                     {
                                        Id = KeyMasterOffsetManager.GetKeyOffset(de[0].PersonId).DeviceExposureId,
                                        UniqueDeviceId = reader.GetString(UniqueDeviceId),
                                        StartTime = de[0].StartTime ?? de[0].StartDate.ToString("HH:mm:ss", CultureInfo.InvariantCulture),
                                        Quantity = reader.GetInt(Quantity) ?? 0
                                     };
            
         }
      }
   }
}
