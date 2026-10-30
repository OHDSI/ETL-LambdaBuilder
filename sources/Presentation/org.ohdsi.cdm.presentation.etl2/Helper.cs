using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Text;

namespace org.ohdsi.cdm.presentation.etl
{
    class Helper
    {
        public static IEnumerable<string> GetFiles(string prefix)
        {
            prefix = prefix.Replace("\\", "/");

            var request = new ListObjectsV2Request
            {
                BucketName = Settings.Current.CloudStorageName,
                Prefix = prefix
            };

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Current.CloudStorageKey,
                Settings.Current.CloudStorageSecret, config);
            using var listObjects = client.ListObjectsV2Async(request);
            listObjects.Wait();

            foreach (var entry in listObjects.Result.S3Objects)
            {
                if (!entry.Key.EndsWith(".xml"))
                    continue;

                yield return entry.Key;
            }
        }

        public static string S3ReadAllText(string key)
        {
            key = key.Replace("\\", "/");
            var fileName = $@"s3:\\{Settings.Current.CloudStorageName}\{key}";

            Console.Write($"loading {fileName}");

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                MaxErrorRetry = 20
            };

            using var client = new AmazonS3Client(Settings.Current.CloudStorageKey,
                Settings.Current.CloudStorageSecret, config);
            var getObjectRequest = new GetObjectRequest
            {
                BucketName = Settings.Current.CloudStorageName,
                Key = key
            };

            try
            {
                var getObject = client.GetObjectAsync(getObjectRequest);
                getObject.Wait();
                using var response = getObject.Result;
                using var responseStream = response.ResponseStream;
                using var reader = new StreamReader(responseStream, Encoding.Default);
                var content = reader.ReadToEnd();

                return content;

            }
            catch (Exception ex)
            {
                if (((Amazon.Runtime.AmazonServiceException)ex.InnerException).StatusCode ==
                    System.Net.HttpStatusCode.NotFound)
                {
                    Console.Write(" - not exists");
                    return null;
                }

                throw;
            }
        }

        public static IEnumerable<T> GetEntities<T>(QueryDefinition qd, EntityDefinition ed) where T : IEntity
        {
            var sql = GetSqlHelper.GetSql(Settings.Current.Building.SourceEngine.Database,
                qd.GetSql(Settings.Current.Building.Vendor, Settings.Current.Building.SourceSchemaName, Settings.Current.Building.SourceSchemaName), Settings.Current.Building.SourceSchemaName);
            var keys = new Dictionary<string, bool>();
            if (!string.IsNullOrEmpty(sql))
            {
                using var connection = new OdbcConnection(Settings.Current.Building.SourceConnectionString);
                connection.Open();
                using var c = new OdbcCommand(sql, connection);
                c.CommandTimeout = 30000;
                using var reader = c.ExecuteReader();
                while (reader.Read())
                {
                    Concept conceptDef = null;
                    if (ed.Concepts != null && ed.Concepts.Length != 0)
                        conceptDef = ed.Concepts[0];

                    var concept = (T)ed.GetConcepts(conceptDef, reader, null).ToList()[0];

                    var key = concept.GetKey();
                    if (key == null) continue;

                    if (keys.ContainsKey(key))
                        continue;

                    keys.Add(key, false);

                    yield return concept;
                }
            }
        }
    }
}