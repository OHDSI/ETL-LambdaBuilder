using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace RunLocal
{

    public class Validation(string awsAccessKeyId, string awsSecretAccessKey, string bucket, string tmpFolder)
    {
        private readonly string _awsAccessKeyId = awsAccessKeyId;
        private readonly string _awsSecretAccessKey = awsSecretAccessKey;
        private readonly string _bucket = bucket;
        private readonly string _tmpFolder = tmpFolder;
        private string _cdmFolder;

        public void Start(Vendors vendor, int buildingId, int slicesNum, string cdmFolder)
        {
            _cdmFolder = cdmFolder;

            Console.WriteLine($"{vendor}.{buildingId}");
            List<string> wrong = [];
            HashSet<string> missed = [];
            var cIds = new HashSet<int>();
            var pIds = new HashSet<long>();
            var f = new HashSet<string>();
            var s = new HashSet<string>();
            var timer = new Stopwatch();
            timer.Start();

            foreach (var chunk in Helper.GetChunksFromS3(_tmpFolder, vendor, buildingId, _awsAccessKeyId, _awsSecretAccessKey, _bucket))
            {
                var chunkId = chunk.Key;

                var objects = new List<S3Object>();
                foreach (var o in Helper.GetObjectsFromS3(vendor, buildingId, _awsAccessKeyId, _awsSecretAccessKey, _bucket,
                    _cdmFolder, "PERSON", chunkId, slicesNum))
                {
                    objects.AddRange(o);
                }

                foreach (var o in Helper.GetObjectsFromS3(vendor, buildingId, _awsAccessKeyId, _awsSecretAccessKey, _bucket,
                    _cdmFolder, "METADATA_TMP", chunkId, slicesNum))
                {
                    objects.AddRange(o);
                }

                if (objects.Count == 0)
                {
                    wrong.Add($"chunkId={chunkId} - MISSED");
                }

                Helper.CheckChunk(_tmpFolder, objects, _awsAccessKeyId, _awsSecretAccessKey, _bucket, chunk);

                int missedCnt = 0;
                var missedPersonIds = new Dictionary<long, bool>();

                foreach (var c in chunk.Value)
                {
                    if (c.Value.Count != 1)
                    {
                        missedCnt++;

                        if (missedCnt == 1 || missedCnt % 500 == 0)
                            missedPersonIds.Add(c.Key, false);
                    }

                    if (c.Value.Count != 1)
                    {
                        wrong.Add($"chunkId={chunkId};person_id={c.Key};filese={string.Join(',', [.. c.Value])}");
                        cIds.Add(chunkId);
                        pIds.Add(c.Key);

                        foreach (var v in c.Value)
                        {
                            f.Add(v);
                            s.Add($@"done.Add(Process(vendor, buildingId, {chunkId}, ""{Int32.Parse(v.Split('/')[4].Split('.')[1]):0000}"", true));");
                        }
                    }
                }

                if (missedPersonIds.Count > 0)
                {
                    foreach (var r in Helper.FindSlicesByPersonIds(_awsAccessKeyId, _awsSecretAccessKey, _bucket, vendor, buildingId, chunkId, Vendor.GetPersonTableName(vendor), missedPersonIds, GetPersonIdIndex(vendor)))
                    {
                        missed.Add(r);
                        var fileName = r.Replace(@"\", "_").Replace(@"/", "_");
                        File.Create($@"{_tmpFolder}\{fileName}.txt").Dispose();
                        Console.WriteLine(fileName);
                    }
                }
            }

            Console.WriteLine();
            timer.Stop();
            Console.WriteLine($"Total={timer.ElapsedMilliseconds}ms");
            timer.Restart();
        }
    }
}