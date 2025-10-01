using Microsoft.Extensions.Logging;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;

namespace org.ohdsi.cdm.presentation.azurebuilder.Base
{
    public class AzureChunkBuilder
    {
        #region Variables
        private Func<IPersonBuilder> _createPersonBuilder ;
        #endregion

        public int TotalPersonConverted { get; private set; }

        #region Constructors
        public AzureChunkBuilder(Func<PersonBuilder> createPersonBuilder)
        {
            _createPersonBuilder = createPersonBuilder;
        }
        #endregion

        #region Methods

        private static void ReadMetadata(QueryDefinition qd, string folder)
        {
            if (qd.Providers != null) return;
            if (qd.Locations != null) return;
            if (qd.CareSites != null) return;

            var v = Settings.Current.Building.Vendor;

            var sql = qd.GetSql(v);

            if (string.IsNullOrEmpty(sql)) return;

            qd.FieldHeaders = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

            try
            {
                var metadataKey = string.Format("{0}/metadata/{1}", folder, qd.FileName + ".txt");

                using var stream = AzureHelper.OpenStream(metadataKey);
                using var sr = new StreamReader(stream);

                stream.Position = 0;
                var index = 0;
                foreach (var fieldName in sr.ReadLine().Split([','], StringSplitOptions.RemoveEmptyEntries))
                {
                    try
                    {
                        qd.FieldHeaders.Add(fieldName, index);
                        index++;
                    }
                    catch (Exception e)
                    {
                        Settings.Current.Logger.LogInformation("WARN_EXC - ReadMetadata - throw");
                        Settings.Current.Logger.LogInformation(e.Message);
                        Settings.Current.Logger.LogInformation(e.StackTrace);
                        Settings.Current.Logger.LogInformation("[RestoreMetadataFromS3] fieldName duplication: " + fieldName + " - " + qd.FileName);
                        throw;
                    }
                }
            }
            catch (Exception ex)
            {
                Settings.Current.Logger.LogInformation(ex.Message);
                Settings.Current.Logger.LogInformation(ex.StackTrace);
            }
        }

        public long? Process(int chunkId, string prefix, Dictionary<string, long> restorePoint, int attempt)
        {
            var folder = string.Format("{0}/raw", AzureHelper.Path);

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, qd => { ReadMetadata(qd, folder); });

            long? result;
            using (var part = new AzureChunkPart(chunkId, _createPersonBuilder, prefix, attempt))
            {
                result = part.Process(restorePoint);
                TotalPersonConverted = part.TotalPersonConverted;
            }

            _createPersonBuilder = null;

            GC.Collect();

            return result;
        }

        #endregion
    }
}
