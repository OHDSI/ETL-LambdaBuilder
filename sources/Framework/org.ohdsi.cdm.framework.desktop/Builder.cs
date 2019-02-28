using System.Data;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop
{
   public class Builder
   {
      public int Id { get; private set; }
      public BuilderState State { get; set; }

      public void SetFrom(IDataReader reader)
      {
         Id = reader.GetInt("Id").Value;
         State = (BuilderState) reader.GetInt("StateId").Value;
      }
   }
}
