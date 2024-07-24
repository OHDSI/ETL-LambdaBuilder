using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.lambdabuilder.Base
{
    public class LambdaChunkBuilder(Func<IPersonBuilder> createPersonBuilder, string tmpFolder)
    {
        #region Variables

        private Func<IPersonBuilder> _createPersonBuilder = createPersonBuilder;
        private readonly string _tmpFolder = tmpFolder;

        #endregion

        public int TotalPersonConverted { get; private set; }

        #region Constructors
        #endregion

        #region Methods

        private static void ReadMetadata(QueryDefinition qd, string folder)
        {
            if (qd.Providers != null) return;
            if (qd.Locations != null) return;
            if (qd.CareSites != null) return;

            var v = Settings.Current.Building.Vendor;

            //TMP
            //if (v is  EnumsEtl.OptumOncology)
            //    v = new EnumsEtl.OptumPantherFull();

            var sql = qd.GetSql(v);

            if (string.IsNullOrEmpty(sql)) return;

            qd.FieldHeaders = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

            try
            {
                var metadataKey = string.Format("{0}/metadata/{1}", folder, qd.FileName + ".txt");

                using var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId, Settings.Current.S3AwsSecretAccessKey, Amazon.RegionEndpoint.USEast1);

                using var stream = new MemoryStream();
                using var sr = new StreamReader(stream);
                var request = new GetObjectRequest { BucketName = Settings.Current.Bucket, Key = metadataKey };
                Task<GetObjectResponse> getObject = client.GetObjectAsync(request);
                getObject.Wait();
                using (var response = getObject.Result)
                {
                    response.ResponseStream.CopyTo(stream);
                }
                stream.Position = 0;
                var index = 0;
                foreach (var fieldName in sr.ReadLine().Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
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

        public long? Process(string s3Key, Dictionary<string, long> restorePoint)
        {
            var chunkId = int.Parse(s3Key.Split('.')[2]);
            var prefix = s3Key.Split('.')[3].Trim();
            var attempt = 0;

            if (s3Key.Split('.').Length == 6)
            {
                attempt = int.Parse(s3Key.Split('.')[4]);
            }

            var folder = string.Format("{0}/{1}/raw", Settings.Current.Building.Vendor,
            Settings.Current.Building.Id);

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, qd => { ReadMetadata(qd, folder); });

            long? result;
            using (var part = new LambdaChunkPart(chunkId, _createPersonBuilder, prefix, attempt, _tmpFolder))
            {
                result = part.Process(restorePoint);
                TotalPersonConverted = part.TotalPersonConverted;
            }

            _createPersonBuilder = null;

            GC.Collect();

            return result;
        }

        public long? Process(int chunkId, string prefix, Dictionary<string, long> restorePoint, int attempt)
        {
            var folder = string.Format("{0}/{1}/raw", Settings.Current.Building.Vendor,
            Settings.Current.Building.Id);

            Parallel.ForEach(Settings.Current.Building.SourceQueryDefinitions, qd => { ReadMetadata(qd, folder); });

            long? result;
            using (var part = new LambdaChunkPart(chunkId, _createPersonBuilder, prefix, attempt, _tmpFolder))
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
