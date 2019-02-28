using org.ohdsi.cdm.framework.common2.Enums;

namespace org.ohdsi.cdm.framework.common2.Omop
{
   public class ObservationPeriod : Entity
   {
      public override EntityType GeEntityType()
      {
         return EntityType.ObservationPeriod;
      }
   }
}
