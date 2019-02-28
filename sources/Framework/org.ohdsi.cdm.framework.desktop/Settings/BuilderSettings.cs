using System.Data;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.DbLayer;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
   public class BuilderSettings
   {
      #region Variables

      private readonly DbBuilder _dbBuilder;
      #endregion

      #region Properties

      public int? Id { get; private set; }

      public int? BuildingId { get; set; }
      public int MaxDegreeOfParallelism { get; set; }
      //public int BatchSize { get; set; }
      public string Folder { get; set; }
      public string MachineName { get; private set; }
      
      public bool IsLead { get; private set; }
      public bool IsNew { get; private set; }

      public string Version => "2.0.0.15";

       #endregion

      #region Constructor
      public BuilderSettings(string machineName)
      {
         MachineName = machineName;
         _dbBuilder = new DbBuilder(Settings.Current.Building.BuilderConnectionString);
      }
      #endregion

      #region Methods
      private void SetFrom(IDataReader reader)
      {
         Id = reader.GetInt("Id").Value;

         BuildingId = reader.GetInt("BuildingId");
         MaxDegreeOfParallelism = reader.GetInt("MaxDegreeOfParallelism").Value;
         Folder = reader.GetString("Folder");
         IsNew = false;
      }

      public void Load()
      {

            //System.IO.File.WriteAllText(@"D:\2.0.0.0\debug.txt", MachineName + "|" + Version);
         foreach (var dataReader in _dbBuilder.LoadSettings(MachineName, Version))
         {
            SetFrom(dataReader);
         }

         if (!Id.HasValue)
         {
            Id = _dbBuilder.CreateSettings(MachineName, Folder, 1, Version);
            IsNew = true;
         }
      }

      public void Save()
      {
         _dbBuilder.UpdateSettings(Id.Value, MachineName, BuildingId.Value, Folder, MaxDegreeOfParallelism, Version);
         IsLead = _dbBuilder.IsLead(Id.Value, BuildingId.Value);
      }
      #endregion
   }
}
