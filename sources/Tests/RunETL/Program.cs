using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using CommandLine;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace RunETL
{
    class Program
    {
        static void Main(string[] args)
        {
            int cnt = 0;
            var tasks = new List<Task>();
            Vendor vendor = null;
            int chunkscnt = 0;
            int slicescnt = 0;
            int buildingid = 0;

            var r = Parser.Default.ParseArguments<Options>(args)
                 .WithParsed<Options>(o =>
                 {
                     chunkscnt = o.ChunksCnt.Value;
                     slicescnt = o.SlicesCnt.Value;
                     vendor = Vendor.CreateVendorInstanceByName(o.Vendor);
                     buildingid = o.Buildingid.Value;
                 });

            if (r.Tag.ToString() != "Parsed")
                return;

            var config = new AmazonS3Config
            {
                Timeout = TimeSpan.FromMinutes(60),
                RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                BufferSize = 512 * 1024,
                MaxErrorRetry = 20
            };

            Console.WriteLine(DateTime.Now.ToShortTimeString());
            var total = 0;
            var timer = new Stopwatch();
            timer.Start();
            for (int i = 0; i <= chunkscnt; i++)
            {
                for (int j = 0; j <= slicescnt; j++)
                {
                    using var client = S3ClientFactory.CreateS3Client(config);
                    using var tu = new TransferUtility(client);
                    var t = tu.UploadAsync(new TransferUtilityUploadRequest
                    {
                        InputStream = new MemoryStream(),
                        BucketName = ConfigurationManager.AppSettings["BucketName"],
                        Key = $"{vendor}.{buildingid}.{i}.{j:0000}.txt",
                        ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                        StorageClass = S3StorageClass.Standard,
                    });

                    tasks.Add(t);
                    cnt++;

                    if (cnt == 950)
                    {
                        Task.WaitAll([.. tasks]);
                        tasks.Clear();
                        total += cnt;
                        cnt = 0;

                        var attempt = 0;
                        while (true)
                        {
                            var notFinished = GetNotFinishedCnt(vendor, buildingid, config, client);
                            Console.WriteLine(DateTime.Now.ToShortTimeString() + " Not finished: " + notFinished);
                            if (notFinished < 25)
                                break;
                            else
                            {
                                attempt++;
                                Thread.Sleep(TimeSpan.FromMinutes(1));
                            }

                            if (attempt > 25)
                                throw new Exception("Too many attempts");
                        }
                        Console.WriteLine("total: " + total);
                    }
                }
            }

            Task.WaitAll([.. tasks]);
            timer.Stop();

            Console.WriteLine("Elapsed.TotalMinutes=" + timer.Elapsed.TotalMinutes);

        }

        private static int GetNotFinishedCnt(Vendor vendor, int buildingid, AmazonS3Config config, AmazonS3Client client)
        {
            using var cl = S3ClientFactory.CreateS3Client(config);
            var request = new ListObjectsV2Request
            {
                BucketName = ConfigurationManager.AppSettings["BucketName"],
                Prefix = $"{vendor}.{buildingid}."
            };

            Task<ListObjectsV2Response> task = client.ListObjectsV2Async(request);
            task.Wait();
            return task.Result.S3Objects.Count;
        }       
    }
}