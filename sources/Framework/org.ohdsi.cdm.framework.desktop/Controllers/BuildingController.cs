using System;
using System.Collections.Generic;
using System.Threading;
using Amazon.EC2;
using Amazon.EC2.Model;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop.Controllers
{
    public class BuildingController
    {
        #region Variables

        private readonly BuilderController _builderController;

        #endregion

        #region Properties

        public Building Building { get; }

        public Builder Builder => _builderController.Builder;

        public int ChunksCount => _builderController.ChunksCount;

        public int CompleteChunksCount => _builderController.CompleteChunksCount;

        public IEnumerable<string> GetOtherBuilderInfo => _builderController.GetOtherBuilderInfo();

        #endregion

        #region Constructor

        public BuildingController()
        {
            _builderController = new BuilderController();
            Building = new Building();
        }

        #endregion

        #region Methods

        public void Process()
        {
            if (Builder.State != BuilderState.Stopping && Builder.State != BuilderState.Running)
            {
                _builderController.UpdateState(BuilderState.Running);
            }
            else
            {
                Stop();
            }
        }

        public void Stop()
        {
            if (_builderController.Builder.State != BuilderState.Stopped)
                _builderController.UpdateState(BuilderState.Stopping);
        }

        private void TryToStop()
        {
            if (_builderController?.Builder == null) return;


            _builderController.UpdateState(BuilderState.Stopped);
        }

        public void Refresh()
        {
            _builderController.RefreshState();
            Load();

            if (Building == null) return;

            if (Builder.State == BuilderState.Stopping)
                TryToStop();

            if (Builder.State == BuilderState.Running)
            {
                if (Settings.Settings.Current.Builder.IsLead)
                {
                    CreateDestination();
                    CreateChunks(false);
                    CreateLookup();
                }
                
                var complete = Build();

                if (Settings.Settings.Current.Builder.IsLead)
                {
                    CopyVocabulary();
                    FillPostBuildTables();
                }
                else
                {
                    StopEc2Instance();
                }

                if (Settings.Settings.Current.Builder.IsLead && complete)
                {
                    CreateIndexes();
                    if (Builder.State == BuilderState.Running)
                        _builderController.UpdateState(BuilderState.Stopped);

                    //StopEC2Instance();
                }

                if (Builder.State == BuilderState.Running)
                {
                    if (!Settings.Settings.Current.Builder.IsLead && Building.ChunksCreated &&
                        _builderController.AllChunksStarted)
                        _builderController.UpdateState(BuilderState.Stopped);
                }
            }
        }

        private static void StopEc2Instance()
        {
            try
            {
                using (var ec2Client = new AmazonEC2Client(Settings.Settings.Current.Ec2AwsAccessKeyId,
                    Settings.Settings.Current.Ec2AwsSecretAccessKey,
                    Amazon.RegionEndpoint.USEast1))
                {
                    ec2Client.StopInstancesAsync(
                        new StopInstancesRequest(new List<string> {Amazon.Util.EC2InstanceMetadata.InstanceId})).Wait();
                }
            }
            catch (Exception e)
            {
            }
        }

        private void Load()
        {
            var dbBuilding = new DbBuilding(Settings.Settings.Current.Building.BuilderConnectionString);
            foreach (var dataReader in dbBuilding.Load(Settings.Settings.Current.Building.Id.Value))
            {
                Building.SetFrom(dataReader);
            }

            if (!Building.Id.HasValue)
            {
                Building.Id = Settings.Settings.Current.Building.Id.Value;
                dbBuilding.Create(Settings.Settings.Current.Building.Id.Value);
            }
        }

        private void CreateDestination()
        {
            if (Building.DestinationCreated) return;

            UpdateDate("CreateDestinationDbStart");
            _builderController.CreateDestination();
            UpdateDate("CreateDestinationDbEnd");
        }

        private void CreateChunks(bool restart)
        {
            if (Building.ChunksCreated) return;

            UpdateDate("CreateChunksStart");
            _builderController.CreateChunks(restart);
            UpdateDate("CreateChunksEnd");
        }

        private void CreateLookup()
        {
            if (Building.LookupCreated) return;

            UpdateDate("CreateLookupStart");
            _builderController.CreateLookup();
            UpdateDate("CreateLookupEnd");
        }

        private bool Build()
        {
            while (!Settings.Settings.Current.Builder.IsLead && !Building.LookupCreated)
            {
                if (Builder.State == BuilderState.Error)
                    return false;

                Thread.Sleep(1000);
                Load();
            }

            var allChunksComplete = false;
            //if (!Settings.Current.Builder.IsLead && !Building.LookupCreated) return false;
            if (Building.BuildingComplete) return true;
            if (Builder.State == BuilderState.Error) return false;


            CreateLookup();

            if (Building.LookupCreated)
            {
                if (!Building.BuildingStarted)
                {
                    UpdateDate("BuildingStart");
                }

                
                _builderController.Build();
                
                while ((Settings.Settings.Current.Builder.IsLead && !_builderController.AllChunksComplete) ||
                       (!Settings.Settings.Current.Builder.IsLead && !_builderController.AllChunksStarted))
                {
                    if (Builder.State == BuilderState.Error)
                        break;

                    Thread.Sleep(1000);
                }

                if (Builder.State != BuilderState.Error)
                {
                    if (_builderController.AllChunksComplete)
                    {
                        allChunksComplete = true;
                        UpdateDate("BuildingEnd");
                        _builderController.ClenupChunks();
                        _builderController.PopulateMetadata();
                    }
                }

            }
            return allChunksComplete;
        }

        private void CopyVocabulary()
        {
            if (!Building.BuildingComplete) return;
            if (Building.VocabularyCopied) return;

            UpdateDate("CopyVocabularyStart");
            _builderController.CopyVocabulary();
            UpdateDate("CopyVocabularyEnd");
        }

        public void FillPostBuildTables()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            if (!string.IsNullOrEmpty(Settings.Settings.Current.Building.CdmSourceScript))
                dbDestination.ExecuteQuery(Settings.Settings.Current.Building.CdmSourceScript);

            if (!string.IsNullOrEmpty(Settings.Settings.Current.Building.CohortDefinitionScript))
                dbDestination.ExecuteQuery(Settings.Settings.Current.Building.CohortDefinitionScript);
        }

        private void CreateIndexes()
        {
            if (!Building.VocabularyCopied) return;
            if (Building.IndexesCreated) return;

            UpdateDate("CreateIndexesStart");
            _builderController.CreateIndexes();
            UpdateDate("CreateIndexesEnd");
        }

       
        private DateTime? UpdateDate(string fieldName)
        {
            if (Builder.State == BuilderState.Error) return null;

            var time = DateTime.Now;
            typeof(Building).GetProperty(fieldName).SetValue(Building, time, null);
            var dbBuilding = new DbBuilding(Settings.Settings.Current.Building.BuilderConnectionString);
            dbBuilding.SetFieldToNowDate(Building.Id.Value, fieldName);

            return time;
        }

        private void UpdateDate(string fieldName, DateTime? time)
        {
            if (time.HasValue && time.Value.Year == DateTime.MaxValue.Year)
            {
                var currentValue = typeof(Building).GetProperty(fieldName).GetValue(Building, null);
                if (currentValue is DateTime)
                {
                    if (((DateTime) currentValue).Year == DateTime.MaxValue.Year)
                    {
                        time = null;
                    }
                }
            }

            typeof(Building).GetProperty(fieldName).SetValue(Building, time, null);
            var dbBuilding = new DbBuilding(Settings.Settings.Current.Building.BuilderConnectionString);
            dbBuilding.SetFieldTo(Building.Id.Value, fieldName, time);
        }

        public IEnumerable<string> GetErrors()
        {
            var log = new DbLog(Settings.Settings.Current.Building.BuilderConnectionString);
            foreach (var error in log.GetErrors(Settings.Settings.Current.Building.Id.Value))
            {
                yield return error;
            }
        }

        public void ResetDbCreationStep()
        {
            _builderController.DropDestination();
            UpdateDate("CreateDestinationDbStart", null);
            UpdateDate("CreateDestinationDbEnd", null);
        }

        public void CreateTablesStep()
        {
            _builderController.CreateTablesStep();
            UpdateDate("CreateDestinationDbStart", DateTime.Now);
            UpdateDate("CreateDestinationDbEnd", DateTime.Now);
        }

        public void SkipDbCreationStep()
        {
            UpdateDate("CreateDestinationDbStart", DateTime.MaxValue);
            UpdateDate("CreateDestinationDbEnd", DateTime.MaxValue);
        }

        public void SkipChunksCreationStep()
        {
            UpdateDate("CreateChunksStart", DateTime.MaxValue);
            UpdateDate("CreateChunksEnd", DateTime.MaxValue);
        }

        public void RestartChunksCreationStep()
        {
            CreateChunks(true);
        }

        public void ResetChunksCreationStep()
        {
            UpdateDate("CreateChunksStart", null);
            UpdateDate("CreateChunksEnd", null);
        }

        public void ResetLookupCreationStep(bool onlyDataUpdate)
        {
            if (!onlyDataUpdate)
                _builderController.TruncateLookup();

            UpdateDate("CreateLookupStart", null);
            UpdateDate("CreateLookupEnd", null);
        }

        public void SkipLookupCreationStep()
        {
            UpdateDate("CreateLookupStart", DateTime.MaxValue);
            UpdateDate("CreateLookupEnd", DateTime.MaxValue);
        }

        public void ResetBuildingStep(bool onlyDataUpdate)
        {
            if (!onlyDataUpdate)
            {
                _builderController.TruncateWithoutLookupTables();
                _builderController.ResetChunk();
            }

            UpdateDate("BuildingStart", null);
            UpdateDate("BuildingEnd", null);
        }

        public void SkipBuildingStep()
        {
            UpdateDate("BuildingStart", DateTime.MaxValue);
            UpdateDate("BuildingEnd", DateTime.MaxValue);
        }

        public void ResetVocabularyStep(bool onlyDataUpdate)
        {
            if (!onlyDataUpdate)
                _builderController.ResetVocabularyStep();

            UpdateDate("CopyVocabularyStart", null);
            UpdateDate("CopyVocabularyEnd", null);
        }

        public void SkipVocabularyStep()
        {
            UpdateDate("CopyVocabularyStart", DateTime.MaxValue);
            UpdateDate("CopyVocabularyEnd", DateTime.MaxValue);
        }

        public void SkipIndexesStep()
        {
            UpdateDate("CreateIndexesStart", DateTime.MaxValue);
            UpdateDate("CreateIndexesEnd", DateTime.MaxValue);
        }

        public void ResetPostprocessStep()
        {
            UpdateDate("PostprocessStart", null);
            UpdateDate("PostprocessEnd", null);
        }

        public void SkipPostprocessStep()
        {
            UpdateDate("PostprocessStart", DateTime.MaxValue);
            UpdateDate("PostprocessEnd", DateTime.MaxValue);
        }

        public void ResetNotFinishedChunks()
        {
            _builderController.ResetNotFinishedChunks();
        }

        public void TruncateTables()
        {
            _builderController.TruncateTables();
        }

        public void TruncateWithoutLookupTables()
        {
            _builderController.TruncateWithoutLookupTables();
        }

        public void ResetSettings()
        {
            var setting = new DbBuildingSettings(Settings.Settings.Current.Building.BuilderConnectionString);
            setting.Reset();

            var builder = new DbBuilder(Settings.Settings.Current.Building.BuilderConnectionString);
            if (Settings.Settings.Current.Builder.Id.HasValue)
                builder.Reset(Settings.Settings.Current.Builder.Id.Value);
        }

        public void ResetErrors()
        {
            var log = new DbLog(Settings.Settings.Current.Building.BuilderConnectionString);
            log.Reset(Settings.Settings.Current.Building.Id.Value);

            if (Builder.State == BuilderState.Error)
                _builderController.UpdateState(BuilderState.Stopped);
        }

        #endregion
    }
}
