using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;

namespace org.ohdsi.cdm.presentation.azurebuilder.Base
{
    public class AzureChunkBuilder
    {
        #region Variables
        private Func<IPersonBuilder> _createPersonBuilder ;
        //private readonly string _tmpFolder;
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
                        Console.WriteLine("WARN_EXC - ReadMetadata - throw");
                        Console.WriteLine(e.Message);
                        Console.WriteLine(e.StackTrace);
                        Console.WriteLine("[RestoreMetadataFromS3] fieldName duplication: " + fieldName + " - " + qd.FileName);
                        throw;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);
            }
        }

        //public long? Process(string s3Key, Dictionary<string, long> restorePoint)
        //{
        //    var chunkId = int.Parse(s3Key.Split('.')[2]);
        //    var prefix = s3Key.Split('.')[3].Trim();
        //    var attempt = 0;

        //    if (s3Key.Split('.').Length == 6)
        //    {
        //        attempt = int.Parse(s3Key.Split('.')[4]);
        //    }

        //    var folder = string.Format("{0}/{1}/raw", Settings.Current.Building.Vendor,
        //    Settings.Current.Building.Id);

        //    Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, qd => { ReadMetadata(qd, folder); });

        //    long? result;
        //    using (var part = new AzureChunkPart(chunkId, _createPersonBuilder, prefix, attempt))
        //    {
        //        result = part.Process(restorePoint);
        //        TotalPersonConverted = part.TotalPersonConverted;
        //    }

        //    _createPersonBuilder = null;

        //    GC.Collect();

        //    return result;
        //}

        public long? Process(int chunkId, string prefix, Dictionary<string, long> restorePoint, int attempt)
        {
            var folder = string.Format("{0}/{1}/raw", Settings.Current.Building.Vendor,
            Settings.Current.Building.Id);

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
