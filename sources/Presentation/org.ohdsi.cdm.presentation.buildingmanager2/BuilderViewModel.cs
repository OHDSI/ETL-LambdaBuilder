using System;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Windows;
using System.Windows.Input;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.desktop.Controllers;
using org.ohdsi.cdm.framework.desktop.Enums;
using Settings = org.ohdsi.cdm.framework.desktop.Settings.Settings;

namespace org.ohdsi.cdm.presentation.buildingmanager2
{

    public class BuilderViewModel : INotifyPropertyChanged
    {
        #region Variables

        private string _builder;
        private string _vocabulary;
        private string _destination;


        private string _source;
        private Vendors _vendor;
        private string _saver;
        private int _maxDegreeOfParallelism;
        private int _batchSize;
        private int _batches;
        private BuildingController _buildingController;
        private bool _buttonEnabled;
        private bool _settingUnlocked;

        
        private readonly System.Timers.Timer _timer = new System.Timers.Timer {Interval = 1000};
        private readonly System.Timers.Timer _timerUi = new System.Timers.Timer {Interval = 3000};
        private int _errorsCount;

        #endregion

        #region Properties

        public event PropertyChangedEventHandler PropertyChanged;

        public int Batches
        {
            get => _batches;
            set
            {
                if (value != _batches)
                {
                    _batches = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Batches"));
                }
            }
        }

        public int BatchSize
        {
            get => _batchSize;
            set
            {
                if (value != _batchSize)
                {
                    _batchSize = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("BatchSize"));
                }
            }
        }

        public int MaxDegreeOfParallelism
        {
            get => _maxDegreeOfParallelism;
            set
            {
                if (value != _maxDegreeOfParallelism)
                {
                    _maxDegreeOfParallelism = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("MaxDegreeOfParallelism"));
                }
            }
        }

        public string Source
        {
            get => _source;
            set
            {
                if (value != _source)
                {
                    _source = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Source"));
                }
            }
        }

        public Vendors Vendor
        {
            get => _vendor;
            set
            {
                if (value != _vendor)
                {
                    _vendor = value;
                    if (PropertyChanged != null)
                    {
                        PropertyChanged(this, new PropertyChangedEventArgs("Vendor"));
                        SetVendorDefaultSettings();
                    }
                }
            }
        }

        public string Saver
        {
            get => _saver;
            set
            {
                if (value != _saver)
                {
                    _saver = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Saver"));
                }
            }
        }

        public string Destination
        {
            get => _destination;
            set
            {
                if (value != _destination)
                {
                    _destination = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Destination"));
                }
            }
        }

        public string Vocabulary
        {
            get => _vocabulary;
            set
            {
                if (value != _vocabulary)
                {
                    _vocabulary = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Vocabulary"));
                }
            }
        }

        public string Builder
        {
            get => _builder;
            set
            {
                if (value != _builder)
                {
                    _builder = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Builder"));
                }
            }
        }

        public bool ButtonEnabled
        {
            get => _buttonEnabled;
            set
            {
                if (value != _buttonEnabled)
                {
                    _buttonEnabled = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("ButtonEnabled"));
                }
            }
        }

        public bool SettingUnlocked
        {
            get => _settingUnlocked;
            set
            {
                if (value != _settingUnlocked)
                {
                    _settingUnlocked = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("SettingUnlocked"));
                }
            }
        }

        public bool DestinationStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.DestinationStarted;
            }
        }

        public bool DestinationWorking => DestinationStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool DestinationCreated
        {
            get
            {
                if (_buildingController == null) return false;
                return !DestinationSkipped && _buildingController.Building.DestinationCreated;
            }
        }

        public bool DestinationSkipped => _buildingController != null && IsSkipped(_buildingController.Building.CreateDestinationDbStart,
                                              _buildingController.Building.CreateDestinationDbEnd);

        public string DestinationInfo
        {
            get
            {
                if (DestinationSkipped)
                    return "skipped";

                if (DestinationCreated)
                {
                    return _buildingController.Building.CreateDestinationDbEnd.Value.Subtract(
                        _buildingController.Building.CreateDestinationDbStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }

        public bool ChunksStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.ChunksStarted;
            }
        }

        public bool ChunksWorking => ChunksStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool ChunksCreated
        {
            get
            {
                if (_buildingController == null) return false;
                return !ChunksSkipped && _buildingController.Building.ChunksCreated;
            }
        }

        public bool ChunksSkipped => _buildingController != null && IsSkipped(_buildingController.Building.CreateChunksStart,
                                         _buildingController.Building.CreateChunksEnd);

        public string ChunksInfo
        {
            get
            {
                if (ChunksSkipped)
                    return "skipped";

                if (ChunksCreated)
                {
                    return _buildingController.Building.CreateChunksEnd.Value.Subtract(
                        _buildingController.Building.CreateChunksStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }

        public bool LookupStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.LookupStarted;
            }
        }

        public bool LookupWorking => LookupStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool LookupCreated
        {
            get
            {
                if (_buildingController == null) return false;
                return !LookupSkipped && _buildingController.Building.LookupCreated;
            }
        }

        public bool LookupSkipped => _buildingController != null && IsSkipped(_buildingController.Building.CreateLookupStart,
                                         _buildingController.Building.CreateLookupEnd);

        public string LookupInfo
        {
            get
            {
                if (LookupSkipped)
                    return "skipped";

                if (LookupCreated)
                {
                    return _buildingController.Building.CreateLookupEnd.Value.Subtract(
                        _buildingController.Building.CreateLookupStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }

        public bool BuildingStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.BuildingStarted;
            }
        }

        public bool BuildingEnded
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.BuildingComplete;
            }
        }

        public bool BuildingWorking => BuildingStarted && !BuildingComplete && !BuildingSkipped &&
                                       _buildingController.Builder.State == BuilderState.Running;

        public bool BuildingComplete
        {
            get
            {
                if (_buildingController == null) return false;
                return !BuildingSkipped && _buildingController.Building.BuildingComplete;
            }
        }

        public bool BuildingSkipped => _buildingController != null && IsSkipped(_buildingController.Building.BuildingStart,
                                           _buildingController.Building.BuildingEnd);

        public string BuildingInfo
        {
            get
            {
                if (BuildingSkipped)
                    return "skipped";

                if (BuildingComplete)
                {
                    return _buildingController.Building.BuildingEnd.Value.Subtract(
                        _buildingController.Building.BuildingStart.Value).ToReadableString();
                }

                if (BuildingStarted)
                {
                    return $"{_buildingController.CompleteChunksCount} from {_buildingController.ChunksCount}";
                }


                return string.Empty;
            }
        }

        public bool IndexesStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.IndexesStarted;
            }
        }

        public bool IndexesWorking => IndexesStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool IndexesCreated
        {
            get
            {
                if (_buildingController == null) return false;
                return !IndexesSkipped && _buildingController.Building.IndexesCreated;
            }
        }

        public bool IndexesSkipped => _buildingController != null && IsSkipped(_buildingController.Building.CreateIndexesStart,
                                          _buildingController.Building.CreateIndexesEnd);

        public string IndexesInfo
        {
            get
            {
                if (IndexesSkipped)
                    return "skipped";

                if (IndexesCreated)
                {
                    return _buildingController.Building.CreateIndexesEnd.Value.Subtract(
                        _buildingController.Building.CreateIndexesStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }

        public bool VocabularyStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.VocabularyStarted;
            }
        }

        public bool VocabularyWorking => VocabularyStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool VocabularyCopied
        {
            get
            {
                if (_buildingController == null) return false;
                return !VocabularySkipped && _buildingController.Building.VocabularyCopied;
            }
        }

        public bool VocabularySkipped => _buildingController != null && IsSkipped(_buildingController.Building.CopyVocabularyStart,
                                             _buildingController.Building.CopyVocabularyEnd);

        public string VocabularyInfo
        {
            get
            {
                if (VocabularySkipped)
                    return "skipped";

                if (VocabularyCopied)
                {
                    return _buildingController.Building.CopyVocabularyEnd.Value.Subtract(
                        _buildingController.Building.CopyVocabularyStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }


        public bool PostprocessStarted
        {
            get
            {
                if (_buildingController == null) return false;
                return _buildingController.Building.PostprocessStarted;
            }
        }

        public bool PostprocessWorking => PostprocessStarted && _buildingController.Builder.State == BuilderState.Running;

        public bool PostprocessFinished
        {
            get
            {
                if (_buildingController == null) return false;
                return !PostprocessSkipped && _buildingController.Building.PostprocessFinished;
            }
        }

        public bool PostprocessSkipped => _buildingController != null && IsSkipped(_buildingController.Building.PostprocessStart,
                                              _buildingController.Building.PostprocessEnd);

        public string PostprocessInfo
        {
            get
            {
                if (PostprocessSkipped)
                    return "skipped";

                if (PostprocessFinished)
                {
                    return _buildingController.Building.PostprocessEnd.Value.Subtract(
                        _buildingController.Building.PostprocessStart.Value).ToReadableString();
                }

                return string.Empty;
            }
        }

        public string CurrentState
        {
            get
            {
                if (_buildingController == null) return " - Loading... Please wait";

                return $" - {_buildingController.Builder.State}";
            }
        }


        public string Errors
        {
            get
            {
                if (_buildingController == null) return string.Empty;
                var errors = _buildingController.GetErrors().ToList();
                //if (errors.Count == 0 && lastErrors != null)
                //{
                //   errors = lastErrors;
                //}

                _errorsCount = errors.Count;
                return string.Join(Environment.NewLine, errors.Take(100));
            }
        }

        public string ErrorsInfo
        {
            get
            {
                if (_errorsCount == 0)
                    return string.Empty;

                return $" - {_errorsCount}";
            }
        }

        public string OtherBuilderInfo
        {
            get
            {
                if (_buildingController == null) return "None";

                var otherBuilder = _buildingController.GetOtherBuilderInfo.ToArray();
                if (otherBuilder.Length == 0)
                    return "None";

                return string.Join(Environment.NewLine, otherBuilder);
            }
        }

        public bool PlayButtonChecked => _buildingController?.Builder.State == BuilderState.Running;

        public string Title
        {
            get
            {
                var title = "Building Manager";

                if (Settings.Current != null && Settings.Current.Builder != null && Settings.Current.Builder.IsLead)
                    return "Building Manager v." + Settings.Current.Builder.Version + " - Lead | Load Id " +
                           Settings.Current.Building.LoadId;

                if (Settings.Current != null && Settings.Current.Builder != null)
                    return "Building Manager v." + Settings.Current.Builder.Version + " | Load Id " +
                           Settings.Current.Building.LoadId;

                return title;
            }
        }

        public bool Reset => false;


        #region Commands

        public ICommand StartBuildingCommand => new DelegateCommand(Build);

        public ICommand SetBuildingCommand => new DelegateCommand(SetBuilding);

        public ICommand ResetCommand => new DelegateCommand(ResetSettings);

        public ICommand LoadSettingsCommand => new DelegateCommand(LoadSetting);

        public ICommand ResetErrorsCommand => new DelegateCommand(ResetErrors);

        public ICommand ResetAllCommand => new DelegateCommand(ResetAll);

        public ICommand TruncateTablesCommand => new DelegateCommand(TruncateTables);

        public ICommand TruncateWithoutLookupTablesCommand => new DelegateCommand(TruncateWithoutLookupTables);

        public ICommand CreateTablesStepCommand => new DelegateCommand(CreateTablesStep);

        public ICommand SkipDbCreationStepCommand => new DelegateCommand(SkipDbCreationStep);

        public ICommand FillPostBuildTableCommand => new DelegateCommand(FillPostBuildTable);

        public ICommand ResetDbCreationStepCommand => new DelegateCommand(ResetDbCreationStep);

        public ICommand SkipChunksCreationStepCommand => new DelegateCommand(SkipChunksCreationStep);

        public ICommand ResetChunksCreationStepCommand
        {
            get { return new DelegateCommand(() => ResetChunksCreationStep(true)); }
        }

        public ICommand SkipLookupCreationStepCommand => new DelegateCommand(SkipLookupCreationStep);

        public ICommand ResetLookupCreationStepCommand
        {
            get { return new DelegateCommand(() => ResetLookupCreationStep(true)); }
        }

        public ICommand ResetNotFinishedChunksCommand => new DelegateCommand(ResetNotFinishedChunks);

        public ICommand RestartChunksCreationStepCommand => new DelegateCommand(RestartChunksCreationStep);

        

        public ICommand SkipBuildingStepCommand => new DelegateCommand(SkipBuildingStep);

        public ICommand ResetBuildingStepCommand
        {
            get { return new DelegateCommand(() => ResetBuildingStep(true)); }
        }

        public ICommand ResetVocabularyStepCommand
        {
            get { return new DelegateCommand(() => ResetVocabularyStep(true)); }
        }

        public ICommand SkipVocabularyStepCommand => new DelegateCommand(SkipVocabularyStep);

        //public ICommand ResetIndexesStepCommand
        //{
        //   get { return new DelegateCommand(() => ResetIndexesStep(true)); }
        //}

        public ICommand SkipIndexesStepCommand => new DelegateCommand(SkipIndexesStep);

        public ICommand SkipPostprocessStepCommand => new DelegateCommand(SkipPostprocessStep);

        public ICommand ResetPostprocessStepCommand
        {
            get { return new DelegateCommand(() => ResetPostprocessStep(true)); }
        }

        #endregion

        #endregion

        #region Creation Step

        private void ResetDbCreationStep()
        {
            if (_buildingController == null) return;
            if (!DestinationCreated) return;
            if (DestinationSkipped) return;

            if (MessageBox.Show("All data will be lost, do you want to continue?", "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetDbCreationStep();
                ResetChunksCreationStep(false);
                ResetLookupCreationStep(false);
                ResetBuildingStep(false);
                ResetVocabularyStep(false);
                //ResetIndexesStep(false);
                ResetPostprocessStep(false);
            }
        }

        private void CreateTablesStep()
        {
            _buildingController?.CreateTablesStep();
        }

        private void SkipDbCreationStep()
        {
            if (_buildingController == null) return;
            if (DestinationCreated) return;

            _buildingController.SkipDbCreationStep();
        }

        private void FillPostBuildTable()
        {
            if (_buildingController == null) return;
            if (DestinationCreated) return;

            _buildingController.FillPostBuildTables();
        }

        #endregion

        #region Chunks step

        private void ResetChunksCreationStep(bool showWarningDialog)
        {
            if (_buildingController == null) return;
            if (!ChunksCreated) return;
            if (ChunksSkipped) return;

            const string message = "Chunk data will be lost, do you want to continue?";
            if (!showWarningDialog ||
                MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetChunksCreationStep();
            }
        }

        private void SkipChunksCreationStep()
        {
            if (_buildingController == null) return;
            if (ChunksCreated) return;

            _buildingController.SkipChunksCreationStep();
        }

        private void RestartChunksCreationStep()
        {
            if (_buildingController == null) return;
            if (ChunksCreated) return;

            _buildingController.RestartChunksCreationStep();
        }

        #endregion

        #region Lookup step

        private void ResetLookupCreationStep(bool showWarningDialog)
        {
            if (_buildingController == null) return;
            if (!LookupCreated) return;
            if (LookupSkipped) return;

            var message =
                "Following tables will be truncated: CARE_SITE, LOCATION, ORGANIZATION, PROVIDER, do you want to continue?";
            if (!showWarningDialog ||
                MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetLookupCreationStep(!showWarningDialog);
            }
        }

        private void SkipLookupCreationStep()
        {
            if (_buildingController == null) return;
            if (LookupCreated) return;

            _buildingController.SkipLookupCreationStep();
        }

        #endregion

        #region Building step



        private void ResetNotFinishedChunks()
        {
            if (_buildingController == null) return;
            if (!BuildingStarted) return;

            if (_buildingController.Builder.State == BuilderState.Running ||
                _buildingController.Builder.State == BuilderState.Stopping)
            {
                MessageBox.Show("Please wait until building will be stopped and try again.");
                return;
            }

            _buildingController.ResetNotFinishedChunks();
        }

        private void TruncateTables()
        {
            if (_buildingController == null) return;

            var message = "Following tables will be truncated: " + Environment.NewLine +
                          "PERSON" + Environment.NewLine +
                          "CONDITION_OCCURRENCE" + Environment.NewLine +
                          "DRUG_EXPOSURE" + Environment.NewLine +
                          "PROCEDURE_OCCURRENCE" + Environment.NewLine +
                          "CONDITION_ERA" + Environment.NewLine +
                          "DRUG_ERA" + Environment.NewLine +
                          "OBSERVATION_PERIOD" + Environment.NewLine +
                          "OBSERVATION" + Environment.NewLine +
                          "VISIT_OCCURRENCE" + Environment.NewLine +
                          "VISIT_DETAIL" + Environment.NewLine +
                          "LOCATION" + Environment.NewLine +
                          "ORGANIZATION" + Environment.NewLine +
                          "CARE_SITE" + Environment.NewLine +
                          "PROVIDER" + Environment.NewLine +
                          "PAYER_PLAN_PERIOD" + Environment.NewLine +
                          "DRUG_COST" + Environment.NewLine +
                          "PROCEDURE_COST" + Environment.NewLine +
                          "DEATH" + Environment.NewLine +
                          "COHORT" + Environment.NewLine +
                          "GetPregnancyEpisodes you want to continue?";
            if (MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.TruncateTables();
            }
        }

        private void TruncateWithoutLookupTables()
        {
            if (_buildingController == null) return;

            var message = "Following tables will be truncated: " + Environment.NewLine +
                          "PERSON" + Environment.NewLine +
                          "CONDITION_OCCURRENCE" + Environment.NewLine +
                          "DRUG_EXPOSURE" + Environment.NewLine +
                          "PROCEDURE_OCCURRENCE" + Environment.NewLine +
                          "CONDITION_ERA" + Environment.NewLine +
                          "DRUG_ERA" + Environment.NewLine +
                          "OBSERVATION_PERIOD" + Environment.NewLine +
                          "OBSERVATION" + Environment.NewLine +
                          "VISIT_OCCURRENCE" + Environment.NewLine +
                          "VISIT_DETAIL" + Environment.NewLine +
                          "PAYER_PLAN_PERIOD" + Environment.NewLine +
                          "DRUG_COST" + Environment.NewLine +
                          "PROCEDURE_COST" + Environment.NewLine +
                          "DEATH" + Environment.NewLine +
                          "COHORT" + Environment.NewLine +
                          "GetPregnancyEpisodes you want to continue?";
            if (MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.TruncateWithoutLookupTables();
            }
        }

        private void ResetBuildingStep(bool showWarningDialog)
        {
            if (_buildingController == null) return;
            if (!BuildingStarted) return;
            if (BuildingSkipped) return;

            var message = "All built data will be lost, do you want to continue?";
            if (!showWarningDialog ||
                MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetBuildingStep(!showWarningDialog);
            }
        }

        private void SkipBuildingStep()
        {
            if (_buildingController == null) return;
            if (BuildingComplete) return;

            _buildingController.SkipBuildingStep();
        }

        #endregion

        #region Vocabulary step

        private void ResetVocabularyStep(bool showWarningDialog)
        {
            if (_buildingController == null) return;
            if (!VocabularyCopied) return;
            if (VocabularySkipped) return;

            var message = "Following tables will be dropped: CONCEPT, CONCEPT_ANCESTOR, CONCEPT_RELATIONSHIP, " +
                          Environment.NewLine +
                          "CONCEPT_SYNONYM, RELATIONSHIP, SOURCE_TO_CONCEPT_MAP, VOCABULARY, do you want to continue?";

            if (!showWarningDialog ||
                MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetVocabularyStep(!showWarningDialog);
            }
        }

        private void SkipVocabularyStep()
        {
            if (_buildingController == null) return;
            if (VocabularyCopied) return;

            _buildingController.SkipVocabularyStep();
        }

        #endregion

        #region Indexes step

        //private void ResetIndexesStep(bool showWarningDialog)
        //{

        //}

        private void SkipIndexesStep()
        {
            if (_buildingController == null) return;
            if (IndexesCreated) return;

            _buildingController.SkipIndexesStep();
        }

        #endregion

        #region Postprocess step

        private void ResetPostprocessStep(bool showWarningDialog)
        {
            if (_buildingController == null) return;
            if (!PostprocessFinished) return;
            if (PostprocessSkipped) return;

            var message = "Postprocess results will be reset. Continue?";

            if (!showWarningDialog ||
                MessageBox.Show(message, "Warning", MessageBoxButton.YesNo,
                    MessageBoxImage.Warning) == MessageBoxResult.Yes)
            {
                _buildingController.ResetPostprocessStep();
            }
        }

        private void SkipPostprocessStep()
        {
            if (_buildingController == null) return;
            if (PostprocessFinished) return;

            _buildingController.SkipPostprocessStep();
        }

        #endregion

        private static bool IsSkipped(DateTime? start, DateTime? end)
        {
            return start.HasValue && end.HasValue && start.Value.Year == DateTime.MaxValue.Year &&
                   end.Value.Year == DateTime.MaxValue.Year;
        }

        public BuilderViewModel()
        {
            SetDefaultSettings();

            Settings.Initialize(Builder, Environment.MachineName);

            if (Settings.Current.Building.Id.HasValue)
            {
                Batches = Settings.Current.Building.Batches;
                BatchSize = Settings.Current.Building.BatchSize;

                Source = Settings.Current.Building.RawSourceConnectionString;
                Destination = Settings.Current.Building.RawDestinationConnectionString;
                Vocabulary = Settings.Current.Building.RawVocabularyConnectionString;
                Vendor = Settings.Current.Building.Vendor;
            }

            if (Settings.Current.Builder.Id.HasValue)
            {
                MaxDegreeOfParallelism = Settings.Current.Builder.MaxDegreeOfParallelism;
            }

            _timer.Elapsed += OnTimer;
            _timer.Start();

            _timerUi.Elapsed += timerUI_Elapsed;
            _timerUi.Start();
        }

        void timerUI_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            UpdateState();
        }

        private void SetDefaultSettings()
        {
            ConfigurationManager.RefreshSection("connectionStrings");

            Source = ConfigurationManager.ConnectionStrings["Source"].ConnectionString;
            Destination = ConfigurationManager.ConnectionStrings["Destination"].ConnectionString;
            Vocabulary = ConfigurationManager.ConnectionStrings["Vocabulary"].ConnectionString;
            Builder = ConfigurationManager.ConnectionStrings["Builder"].ConnectionString;

            Saver = "Db";
            Vendor = Vendors.Truven_CCAE;

            ButtonEnabled = true;
            SettingUnlocked = true;
            SetVendorDefaultSettings();
        }

        private void SetVendorDefaultSettings()
        {
            Batches = 0;

            switch (Vendor)
            {
                case Vendors.JMDCv5:
                    BatchSize = 500 * 1000;
                    MaxDegreeOfParallelism = 5;
                    break;
                case Vendors.SEER:
                    BatchSize = 500 * 1000;
                    MaxDegreeOfParallelism = 5;
                    break;
                case Vendors.OptumOncology:
                    BatchSize = 500 * 1000;
                    MaxDegreeOfParallelism = 6;
                    break;
                //case Vendors.OptumIntegrated:
                //    BatchSize = 500 * 1000;
                //    MaxDegreeOfParallelism = 6;
                //    break;
                case Vendors.Cerner:
                    BatchSize = 500 * 1000;
                    MaxDegreeOfParallelism = 6;
                    break;
                case Vendors.HCUPv5:
                    BatchSize = 50 * 1000;
                    MaxDegreeOfParallelism = 20;
                    break;
                case Vendors.NHANES:
                    BatchSize = 50 * 1000;
                    MaxDegreeOfParallelism = 20;
                    break;
                case Vendors.Truven_CCAE:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 15;
                    break;
                case Vendors.Truven_MDCR:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 10;
                    break;
                case Vendors.Truven_MDCD:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 13;
                    break;
                case Vendors.CprdV5:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 7;
                    break;
                case Vendors.PremierV5:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 15;
                    break;
                //case Vendors.ErasV5:
                //    BatchSize = 1000;
                //    MaxDegreeOfParallelism = 1;
                //    break;
                case Vendors.OptumExtendedSES:
                    MaxDegreeOfParallelism = 10;
                    BatchSize = 1000 * 1000;
                    break;
                case Vendors.OptumExtendedDOD:
                    BatchSize = 1000 * 1000;
                    MaxDegreeOfParallelism = 10;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private void UpdateState()
        {
            if (_buildingController == null) return;


            ButtonEnabled = _buildingController.Builder.State != BuilderState.Stopping;
            SettingUnlocked = !(_buildingController.Builder.State == BuilderState.Running ||
                                _buildingController.Builder.State == BuilderState.Stopping);

            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs("DestinationStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("DestinationWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("DestinationCreated"));
                PropertyChanged(this, new PropertyChangedEventArgs("DestinationInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("ChunksStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("ChunksWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("ChunksCreated"));
                PropertyChanged(this, new PropertyChangedEventArgs("ChunksInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("LookupStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("LookupWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("LookupCreated"));
                PropertyChanged(this, new PropertyChangedEventArgs("LookupInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("BuildingStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("BuildingWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("BuildingComplete"));
                PropertyChanged(this, new PropertyChangedEventArgs("BuildingInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("IndexesStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("IndexesWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("IndexesCreated"));
                PropertyChanged(this, new PropertyChangedEventArgs("IndexesInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("VocabularyStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("VocabularyWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("VocabularyCopied"));
                PropertyChanged(this, new PropertyChangedEventArgs("VocabularyInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("PostprocessStarted"));
                PropertyChanged(this, new PropertyChangedEventArgs("PostprocessWorking"));
                PropertyChanged(this, new PropertyChangedEventArgs("PostprocessFinished"));
                PropertyChanged(this, new PropertyChangedEventArgs("PostprocessInfo"));

                PropertyChanged(this, new PropertyChangedEventArgs("CurrentState"));
                PropertyChanged(this, new PropertyChangedEventArgs("PlayButtonChecked"));
                PropertyChanged(this, new PropertyChangedEventArgs("Errors"));
                PropertyChanged(this, new PropertyChangedEventArgs("ErrorsInfo"));
                PropertyChanged(this, new PropertyChangedEventArgs("OtherBuilderInfo"));
                PropertyChanged(this, new PropertyChangedEventArgs("Title"));
            }
        }

        private void SetBuilding()
        {
            if (_buildingController != null && (_buildingController.Builder.State == BuilderState.Running ||
                                               _buildingController.Builder.State == BuilderState.Stopping)) return;

            _timer.Stop();
            UpdateSettings();

            _buildingController = new BuildingController();
            //buildingController.Load();

            _timer.Start();
        }

        private void ResetSettings()
        {
            if (_buildingController == null)
                SetBuilding();

            SetDefaultSettings();
            UpdateState();
            _buildingController.ResetSettings();
            PropertyChanged(this, new PropertyChangedEventArgs("Reset"));
        }

        private void LoadSetting()
        {
            var settings = new SettingsWindow();
            var dialogResult = settings.ShowDialog();
            if (dialogResult.HasValue && dialogResult.Value)
            {
                if (settings.CurrentBuildingId.HasValue)
                {
                    Settings.Current.Building.Load(settings.CurrentBuildingId.Value);

                    Source = Settings.Current.Building.RawSourceConnectionString;
                    Destination = Settings.Current.Building.RawDestinationConnectionString;
                    Vocabulary = Settings.Current.Building.RawVocabularyConnectionString;
                    Vendor = Settings.Current.Building.Vendor;

                    BatchSize = Settings.Current.Building.Batches;
                }
            }
        }

        private void ResetAll()
        {
            ResetDbCreationStep();
            ResetChunksCreationStep(true);
            ResetLookupCreationStep(true);
            ResetBuildingStep(true);
            ResetVocabularyStep(true);
        }

        private void ResetErrors()
        {
            _buildingController.ResetErrors();
            PropertyChanged(this, new PropertyChangedEventArgs("Reset"));
        }

        private void Build()
        {
            _buildingController.Process();
        }

        public void Stop()
        {
            _buildingController?.Stop();
        }

        private void UpdateSettings()
        {
            Settings.Current.Builder.MaxDegreeOfParallelism = MaxDegreeOfParallelism;
            Settings.Current.Builder.Folder = AppDomain.CurrentDomain.BaseDirectory;

            Settings.Current.Building.BatchSize = BatchSize;
            Settings.Current.Building.RawSourceConnectionString = Source;
            Settings.Current.Building.RawDestinationConnectionString = Destination;
            Settings.Current.Building.RawVocabularyConnectionString = Vocabulary;
            Settings.Current.Building.Vendor = Vendor;
            Settings.Current.Building.Batches = Batches;

            Settings.Current.Save();
        }

        private void OnTimer(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (_buildingController == null) return;

            _timer.Stop();
            _buildingController.Refresh();
            _timer.Start();
        }
    }
}
