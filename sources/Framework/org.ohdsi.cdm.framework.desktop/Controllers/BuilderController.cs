using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop.Controllers
{
    public class BuilderController
    {
        #region Variables

        private readonly DbBuilder _dbBuilder;
        private readonly ChunkController _chunkController;
        private int _chunkCount;

        #endregion

        #region Properties

        public Builder Builder { get; private set; }

        public bool AllChunksComplete => _chunkController.AllChunksComplete();

        public bool AllChunksStarted => _chunkController.AllChunksStarted();

        public int ChunksCount
        {
            get
            {
                if (_chunkCount == 0)
                    _chunkCount = _chunkController.GetChunksCount();

                return _chunkCount;
            }
        }

        public int CompleteChunksCount => _chunkController.GetCompleteChunksCount();

        #endregion

        #region Constructor

        public BuilderController()
        {
            _chunkController = new ChunkController();
            _dbBuilder = new DbBuilder(Settings.Settings.Current.Building.BuilderConnectionString);
            Builder = new Builder();

            RefreshState();
        }

        #endregion

        #region Methods

        private void PerformAction(Action act)
        {
            if (Builder.State == BuilderState.Error)
                return;

            try
            {
                act();
            }
            catch (Exception e)
            {
                UpdateState(BuilderState.Error);
                Logger.WriteError(e);
            }
            finally
            {
            }
        }

        public void RefreshState()
        {
            var attempt = 0;

            while (true)
            {
                try
                {
                    foreach (var dataReader in _dbBuilder.Load(Environment.MachineName,
                        Settings.Settings.Current.Builder.Version))
                    {
                        Builder.SetFrom(dataReader);
                    }

                    break;
                }
                catch (Exception e)
                {
                    attempt++;

                    if (attempt == 10)
                        throw;
                }
            }
        }

        public void UpdateState(BuilderState state)
        {
            Builder.State = state;
            _dbBuilder.UpdateState(Builder.Id, state);
        }

        public void CreateDestination()
        {
            PerformAction(() =>
            {
                var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                    Settings.Settings.Current.Building.DestinationSchemaName);


                if (Settings.Settings.Current.Building.DestinationEngine.Database != Database.Redshift)
                    dbDestination.CreateDatabase(Settings.Settings.Current.CreateCdmDatabaseScript);

                dbDestination.ExecuteQuery(Settings.Settings.Current.CreateCdmTablesScript);
            });
        }

        public void CreateTablesStep()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.CreateCdmTablesScript);
        }

        public void DropDestination()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.DropTablesScript);
            //dbDestination.DropDatabase();
        }

        public void TruncateLookup()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.TruncateLookupScript);
        }
        
        public void TruncateTables()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.TruncateTablesScript);
        }

        public void TruncateWithoutLookupTables()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.TruncateWithoutLookupTablesScript);
        }

        public void ResetChunk()
        {
            _chunkController.ResetChunks();
        }

        public void ResetVocabularyStep()
        {
            var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                Settings.Settings.Current.Building.DestinationSchemaName);

            dbDestination.ExecuteQuery(Settings.Settings.Current.DropVocabularyTablesScript);
        }

        public void CreateChunks(bool restart)
        {
            PerformAction(() =>
            {
                var arguments =
                    string.Format(@"<{0}>{1}</{0}>", "restart",
                        restart) +
                    string.Format(@"<{0}>{1}</{0}>", "cs",
                        Settings.Settings.Current.Building.BuilderConnectionString) +
                    string.Format(@"<{0}>{1}</{0}>", "s3keyid", Settings.Settings.Current.S3AwsAccessKeyId) +
                    string.Format(@"<{0}>{1}</{0}>", "s3accesskey",
                        Settings.Settings.Current.S3AwsSecretAccessKey) +
                    string.Format(@"<{0}>{1}</{0}>", "ec2keyid", Settings.Settings.Current.Ec2AwsAccessKeyId) +
                    string.Format(@"<{0}>{1}</{0}>", "ec2accesskey",
                        Settings.Settings.Current.Ec2AwsSecretAccessKey) +
                    string.Format(@"<{0}>{1}</{0}>", "bucket", Settings.Settings.Current.Bucket) +
                    string.Format(@"<{0}>{1}</{0}>", "cdmFolder", Settings.Settings.Current.CDMFolder) +
                    string.Format(@"<{0}>{1}</{0}>", "saveOnlyToS3", Settings.Settings.Current.SaveOnlyToS3) +
                    string.Format(@"<{0}>{1}</{0}>", "storageType", Settings.Settings.Current.StorageType);


                var psi =
                    new ProcessStartInfo(Path.Combine(Settings.Settings.Current.Builder.Folder, "Core", "org.ohdsi.cdm.presentation.chunker.exe"))
                    {
                        Arguments = arguments,
                        CreateNoWindow = true
                    };

                Thread.Sleep(1000);

                using (var p = Process.Start(psi))
                {
                    p.WaitForExit();

                    if (p.ExitCode != 0)
                        UpdateState(BuilderState.Error);

                    p.Close();
                }
            });
        }

        public void ClenupChunks()
        {
            if (Settings.Settings.Current.Building.DestinationEngine.Database == Database.Redshift)
            {
                PerformAction(_chunkController.ClenupChunks);
            }
        }

        public void PopulateMetadata()
        {
            if (Settings.Settings.Current.Building.DestinationEngine.Database == Database.Mssql &&
                Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
            {
                var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                    Settings.Settings.Current.Building.DestinationSchemaName);

                dbDestination.PopulateMetadata();
            }
        }

        public void CopyVocabulary()
        {
            PerformAction(() =>
            {
                var saver = Settings.Settings.Current.Building.DestinationEngine.GetSaver()
                    .Create(Settings.Settings.Current.Building.DestinationConnectionString);
                saver.CopyVocabulary();
            });
        }

        public void CreateIndexes()
        {
            PerformAction(() =>
            {
                var dbDestination = new DbDestination(Settings.Settings.Current.Building.DestinationConnectionString,
                    Settings.Settings.Current.Building.DestinationSchemaName);

                dbDestination.CreateIndexes(Settings.Settings.Current.CreateIndexesScript);
            });
        }

        public void CreateLookup()
        {
            PerformAction(() =>
            {
                var arguments =
                    string.Format(@"<{0}>{1}</{0}>", "cs",
                        Settings.Settings.Current.Building.BuilderConnectionString) +
                    string.Format(@"<{0}>{1}</{0}>", "s3keyid", Settings.Settings.Current.S3AwsAccessKeyId) +
                    string.Format(@"<{0}>{1}</{0}>", "s3accesskey",
                        Settings.Settings.Current.S3AwsSecretAccessKey) +
                    string.Format(@"<{0}>{1}</{0}>", "ec2keyid", Settings.Settings.Current.Ec2AwsAccessKeyId) +
                    string.Format(@"<{0}>{1}</{0}>", "ec2accesskey",
                        Settings.Settings.Current.Ec2AwsSecretAccessKey) +
                    string.Format(@"<{0}>{1}</{0}>", "bucket", Settings.Settings.Current.Bucket) +
                    string.Format(@"<{0}>{1}</{0}>", "cdmFolder", Settings.Settings.Current.CDMFolder) +
                    string.Format(@"<{0}>{1}</{0}>", "saveOnlyToS3", Settings.Settings.Current.SaveOnlyToS3) +
                    string.Format(@"<{0}>{1}</{0}>", "storageType", Settings.Settings.Current.StorageType);

                var psi =
                    new ProcessStartInfo(Path.Combine(Settings.Settings.Current.Builder.Folder, "Core", "org.ohdsi.cdm.presentation.lookup.exe"))
                    {
                        Arguments = arguments,
                        CreateNoWindow = true
                    };

                Thread.Sleep(1000);

                using (var p = Process.Start(psi))
                {
                    p.WaitForExit();

                    if (p.ExitCode != 0)
                        UpdateState(BuilderState.Error);

                    p.Close();
                }
            });
        }

        public void Build()
        {
            var dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
            dbChunk.MarkUncompletedChunks(Settings.Settings.Current.Building.Id.Value,
                Settings.Settings.Current.Builder.Id.Value);

            PerformAction(() =>
            {
                Parallel.For(0, Settings.Settings.Current.Builder.MaxDegreeOfParallelism, i =>
                {
                    while (!_chunkController.AllChunksStarted())
                    {
                        var arguments =
                            string.Format(@"<{0}>{1}</{0}>", "cs",
                                Settings.Settings.Current.Building.BuilderConnectionString) +
                            string.Format(@"<{0}>{1}</{0}>", "s3keyid", Settings.Settings.Current.S3AwsAccessKeyId) +
                            string.Format(@"<{0}>{1}</{0}>", "s3accesskey",
                                Settings.Settings.Current.S3AwsSecretAccessKey) +
                            string.Format(@"<{0}>{1}</{0}>", "ec2keyid", Settings.Settings.Current.Ec2AwsAccessKeyId) +
                            string.Format(@"<{0}>{1}</{0}>", "ec2accesskey",
                                Settings.Settings.Current.Ec2AwsSecretAccessKey) +
                            string.Format(@"<{0}>{1}</{0}>", "bucket", Settings.Settings.Current.Bucket) +
                            string.Format(@"<{0}>{1}</{0}>", "cdmFolder", Settings.Settings.Current.CDMFolder) +
                            string.Format(@"<{0}>{1}</{0}>", "saveOnlyToS3", Settings.Settings.Current.SaveOnlyToS3) +
                            string.Format(@"<{0}>{1}</{0}>", "storageType", Settings.Settings.Current.StorageType);

                        var psi =
                            new ProcessStartInfo(Path.Combine(Settings.Settings.Current.Builder.Folder, "Core", "org.ohdsi.cdm.presentation.builderprocess2.exe"))
                            {
                                Arguments = arguments,
                                CreateNoWindow = true
                            };


                        Thread.Sleep(1000);

                        using (var p = Process.Start(psi))
                        {
                            if (p != null)
                            {
                                p.WaitForExit();

                                if (p.ExitCode != 0)
                                    UpdateState(BuilderState.Error);

                                p.Close();
                            }
                        }

                        RefreshState();
                        if (Builder.State != BuilderState.Running)
                        {
                            break;
                        }
                    }
                });
            });
        }

        public IEnumerable<string> GetOtherBuilderInfo()
        {
            return _dbBuilder.GetOtherBuilderInfo(Settings.Settings.Current.Builder.Id.Value,
                Settings.Settings.Current.Building.Id.Value);
        }

        public void ResetNotFinishedChunks()
        {
            _chunkController.ResetNotFinishedChunks();
        }

        #endregion
    }
}
