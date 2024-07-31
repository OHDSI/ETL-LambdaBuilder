using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.desktop.DbLayer;
using org.ohdsi.cdm.framework.desktop.Enums;
using org.ohdsi.cdm.framework.desktop.Helpers;
using System.Diagnostics;

namespace org.ohdsi.cdm.framework.desktop.Base
{
    public class RedshiftChunkBuilder(int chunkId, Func<IPersonBuilder> createPersonBuilder) : IChunkBuilder
    {
        #region Variables

        private readonly int _chunkId = chunkId;
        private readonly Func<IPersonBuilder> _createPersonBuilder = createPersonBuilder;
        private static readonly char[] separator = [','];

        #endregion
        #region Constructors
        #endregion

        #region Methods


        private IEnumerable<string> GetParts()
        {
            var folder = $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw";

            var fileName = string.Empty;

            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                        qd.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName, Settings.Settings.Current.Building.SourceSchemaName), Settings.Settings.Current.Building.SourceSchemaName);

                if (qd.Persons == null) continue;
                if (string.IsNullOrEmpty(sql)) continue;

                fileName = qd.FileName;
                break;
            }

            if (string.IsNullOrEmpty(fileName))
                fileName = Settings.Settings.Current.Building.SourceQueryDefinitions[0].FileName;

            using var client = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId, Settings.Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
            var request = new ListObjectsV2Request
            {
                BucketName = Settings.Settings.Current.Bucket,
                Prefix = $"{folder}/{_chunkId}/{fileName}/{fileName}"
            };

            ListObjectsV2Response response;
            do
            {
                var responseTask = client.ListObjectsV2Async(request);
                responseTask.Wait();
                response = responseTask.Result;

                var partIndexes = new HashSet<string>();

                var fn = fileName;
                foreach (var entry in response.S3Objects)
                {
                    var end = entry.Key.LastIndexOf(fn, StringComparison.InvariantCultureIgnoreCase) + fn.Length;
                    var key = entry.Key.Replace(entry.Key[..end], "");
                    key = key[..key.IndexOf('_')];
                    partIndexes.Add(key);
                }

                foreach (var partIndex in partIndexes)
                {
                    yield return partIndex;
                }

                request.ContinuationToken = response.NextContinuationToken;
            } while (response.IsTruncated);
        }


        public void Process()
        {
            try
            {

                var dbChunk = new DbChunk(Settings.Settings.Current.Building.BuilderConnectionString);
                var timer = new Stopwatch();
                timer.Start();

                var folder = $"{Settings.Settings.Current.Building.Vendor}/{Settings.Settings.Current.Building.Id}/raw";

                Parallel.ForEach(Settings.Settings.Current.Building.SourceQueryDefinitions, qd =>
                {
                    if (qd.Providers != null) return;
                    if (qd.Locations != null) return;
                    if (qd.CareSites != null) return;

                    var sql = GetSqlHelper.GetSql(Settings.Settings.Current.Building.SourceEngine.Database,
                            qd.GetSql(Settings.Settings.Current.Building.Vendor, Settings.Settings.Current.Building.SourceSchemaName, Settings.Settings.Current.Building.SourceSchemaName), Settings.Settings.Current.Building.SourceSchemaName);


                    if (string.IsNullOrEmpty(sql)) return;

                    qd.FieldHeaders = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

                    var metadataKey = $"{folder}/metadata/{qd.FileName + ".txt"}";

                    using var client = new AmazonS3Client(Settings.Settings.Current.S3AwsAccessKeyId, Settings.Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);
                    using var stream = new MemoryStream();
                    using var sr = new StreamReader(stream);
                    var request = new GetObjectRequest { BucketName = Settings.Settings.Current.Bucket, Key = metadataKey };
                    var getObject = client.GetObjectAsync(request);
                    getObject.Wait();

                    using (var response = getObject.Result.ResponseStream)
                    {
                        response.CopyTo(stream);
                    }
                    stream.Position = 0;

                    var index = 0;
                    foreach (var fieldName in sr.ReadLine().Split(separator, StringSplitOptions.RemoveEmptyEntries))
                    {
                        try
                        {
                            qd.FieldHeaders.Add(fieldName, index);
                            index++;
                        }
                        catch (Exception)
                        {
                            throw new Exception("[RestoreMetadataFromS3] fieldName duplication: " + fieldName + " - " + qd.FileName);
                        }
                    }
                });

                Parallel.ForEach(GetParts(), new ParallelOptions { MaxDegreeOfParallelism = 2 }, p =>
                {
                    //Logger.Write(_chunkId, LogMessageTypes.Info, "load part=" + p);
                    Console.WriteLine("load part=" + p);
                    var part = new DatabaseChunkPart(_chunkId, _createPersonBuilder, p, 0);

                    LoadPart(part, p);

                    part.Build();

                    SavePart(part, p);
                });


                //Logger.Write(_chunkId, LogMessageTypes.Info,
                //    $"Loaded - {timer.ElapsedMilliseconds} ms | {(GC.GetTotalMemory(false) / 1024f) / 1024f} Mb");

                Console.WriteLine($"Loaded - {timer.ElapsedMilliseconds} ms | {(GC.GetTotalMemory(false) / 1024f) / 1024f} Mb");

                dbChunk.ChunkComplete(_chunkId, Settings.Settings.Current.Building.Id.Value);
            }
            catch (Exception e)
            {
                //Logger.WriteError(_chunkId, e);
                Console.WriteLine(Logger.CreateExceptionString(e));

               throw;
            }
        }

        private void LoadPart(DatabaseChunkPart part, string p)
        {
            var loadAttempt = 0;
            var loaded = false;
            while (!loaded)
            {
                try
                {
                    loadAttempt++;
                    part.Load();
                    loaded = true;

                }
                catch (Exception ex)
                {
                    if (loadAttempt <= 11)
                    {
                        //Logger.Write(_chunkId, LogMessageTypes.Warning,
                        //   p + ") load attempt=" + loadAttempt + ") " + Logger.CreateExceptionString(ex));

                        Console.WriteLine(p + ") load attempt=" + loadAttempt + ") " + Logger.CreateExceptionString(ex));
                        part.Reset();
                    }
                    else
                    {
                        throw;
                    }
                }
            }
        }

        private void SavePart(DatabaseChunkPart part, string p)
        {
            var saveAttempt = 0;
            var saved = false;
            while (!saved)
            {
                try
                {
                    saveAttempt++;
                    part.Save();
                    saved = true;
                }
                catch (Exception ex)
                {
                    if (saveAttempt <= 11)
                    {
                        //Logger.Write(_chunkId, LogMessageTypes.Warning,
                        //   p + ") save attempt=" + saveAttempt + ") " + Logger.CreateExceptionString(ex));

                        Console.WriteLine(p + ") save attempt=" + saveAttempt + ") " + Logger.CreateExceptionString(ex));
                    }
                    else
                    {
                        throw;
                    }
                }
            }

            part.Clean();
        }

        #endregion
    }
}