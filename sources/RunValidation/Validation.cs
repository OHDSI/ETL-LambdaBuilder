using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Numerics;
using System.Runtime.InteropServices;

namespace RunValidation
{

    public class Validation(string awsAccessKeyId, string awsSecretAccessKey, string bucket, string tmpFolder, string cdmFolder)
    {
        #region Fields 

        private readonly string _awsAccessKeyId = awsAccessKeyId;
        private readonly string _awsSecretAccessKey = awsSecretAccessKey;
        private readonly string _bucket = bucket;
        private readonly string _tmpFolder = tmpFolder;
        private readonly string _cdmFolder = cdmFolder;

        #endregion

        #region Methods

        /// <summary>
        /// Method to check the correctness of person ids for specified groups of vendor + buildingId + chunkId + slices
        /// </summary>
        /// <param name="vendor"></param>
        /// <param name="buildingId"></param>
        /// <param name="chunkIds">If omitted or null, all chunkIds on S3 are checked</param>
        /// <param name="slices">Slices within a chunk to process</param>
        public void ValidateBuildingId(Vendor vendor, int buildingId, IEnumerable<int> chunkIds, IEnumerable<int> slices)
        {
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
                if (chunkIds != null && chunkIds.Any() && !chunkIds.Any(s => s == chunkId))
                {
                    Console.WriteLine("Skip chunkId " + chunkId);
                    continue;
                }

                #region var objects = new List<S3Object>(); from PERSON and METADATA_TMP
                var objects = new List<S3Object>();

                var slices2process = (slices == null || !slices.Any())
                    ? Enumerable.Range(1, 100).ToList()
                    : slices.Distinct().OrderBy(s => s).ToList()
                    ;

                foreach (var o in Helper.GetObjectsFromS3(vendor, buildingId, _awsAccessKeyId, _awsSecretAccessKey, _bucket,
                        _cdmFolder, "PERSON", chunkId, slices2process))
                {
                    objects.AddRange(o);
                }

                foreach (var o in Helper.GetObjectsFromS3(vendor, buildingId, _awsAccessKeyId, _awsSecretAccessKey, _bucket,
                    _cdmFolder, "METADATA_TMP", chunkId, slices2process, true))
                {
                    objects.AddRange(o);
                }
                #endregion

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
                            s.Add($@"done.Add(Process(vendor, buildingId, {chunkId}, ""{parseSliceIdFromKey(v):0000}"", true));");
                        }
                    }
                }

                if (missedPersonIds.Count > 0)
                {
                    foreach (var r in Helper.FindSlicesByPersonIds(_awsAccessKeyId, _awsSecretAccessKey, _bucket, vendor, buildingId, chunkId, vendor.PersonTableName, missedPersonIds, vendor.PersonIdIndex))
                    {
                        missed.Add(r);
                        var fileName = r.Replace(@"\", "_").Replace(@"/", "_");
                        File.Create($@"{_tmpFolder}\{fileName}.txt").Dispose();
                        Console.WriteLine(fileName);
                    }
                }

                Console.WriteLine();
                timer.Stop();
                Console.WriteLine($"Total={timer.ElapsedMilliseconds}ms");
                timer.Restart();
            }
        }

        int parseSliceIdFromKey(string key)
        {
            var parts = key.Split(new[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
            // assuming sliceId is at a specific position in the parts array
            if (parts.Length == 6 && int.TryParse(parts[1], out int sliceId))
            {
                return sliceId;
            }
            throw new FormatException($"Invalid S3 object key format: {key}");
        }

        #endregion

    }
}