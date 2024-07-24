using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using System.Data;

namespace org.ohdsi.cdm.framework.desktop.Settings
{
    public class BuilderSettings(string machineName)
    {
        #region Variables
        private readonly DbBuilder _dbBuilder = new(Settings.Current.Building.BuilderConnectionString);
        #endregion

        #region Properties

        public int? Id { get; private set; }

        public int? BuildingId { get; set; }
        public int MaxDegreeOfParallelism { get; set; }

        public string Folder { get; set; }
        public string MachineName { get; private set; } = machineName;

        public bool IsLead { get; private set; }
        public bool IsNew { get; private set; }

        public static string Version => "2.0.0.21";

        #endregion
        #region Constructor
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