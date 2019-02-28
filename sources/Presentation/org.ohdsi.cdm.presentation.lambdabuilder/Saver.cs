using System;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.DataReaders.v5;
using org.ohdsi.cdm.framework.common2.DataReaders.v5.v52;
using org.ohdsi.cdm.framework.common2.DataReaders.v5.v53;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Extensions;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Saver
    {
        private readonly int _chunkId;
        private readonly string _subChunkId;

        public Saver(int chunkId, string subChunkId)
        {
            _chunkId = chunkId;
            _subChunkId = subChunkId;
        }

        protected IDataReader CreateDataReader(ChunkData chunk, string table)
        {
            switch (table)
            {
                case "PERSON":
                {
                    return chunk.Persons.Count == 0 ? null : new PersonDataReader(chunk.Persons.ToList());
                }

                case "OBSERVATION_PERIOD":
                {
                    return chunk.ObservationPeriods.Count == 0
                        ? null
                        : new ObservationPeriodDataReader53(chunk.ObservationPeriods.ToList());
                }

                case "PAYER_PLAN_PERIOD":
                {
                    return chunk.PayerPlanPeriods.Count == 0
                        ? null
                        : new PayerPlanPeriodDataReader53(chunk.PayerPlanPeriods.ToList());
                }

                case "DEATH":
                {
                    return chunk.Deaths.Count == 0 ? null : new DeathDataReader52(chunk.Deaths.ToList());
                }

                case "DRUG_EXPOSURE":
                {
                    return chunk.DrugExposures.Count == 0
                        ? null
                        : new DrugExposureDataReader53(chunk.DrugExposures.ToList());
                }


                case "OBSERVATION":
                {
                    return chunk.Observations.Count == 0
                        ? null
                        : new ObservationDataReader53(chunk.Observations.ToList());
                }

                case "VISIT_OCCURRENCE":
                {
                    return chunk.VisitOccurrences.Count == 0
                        ? null
                        : new VisitOccurrenceDataReader52(chunk.VisitOccurrences.ToList());
                }

                case "VISIT_DETAIL":
                {
                    return chunk.VisitDetails.Count == 0
                        ? null
                        : new VisitDetailDataReader53(chunk.VisitDetails.ToList());
                }

                case "PROCEDURE_OCCURRENCE":
                {
                    return chunk.ProcedureOccurrences.Count == 0
                        ? null
                        : new ProcedureOccurrenceDataReader53(chunk.ProcedureOccurrences.ToList());
                }

                case "DRUG_ERA":
                {
                    return chunk.DrugEra.Count == 0 ? null : new DrugEraDataReader(chunk.DrugEra.ToList());
                }

                case "CONDITION_ERA":
                {
                    return chunk.ConditionEra.Count == 0 
                        ? null
                        : new ConditionEraDataReader(chunk.ConditionEra); 
                }

                case "DEVICE_EXPOSURE":
                {
                    return chunk.DeviceExposure.Count == 0
                        ? null
                        : new DeviceExposureDataReader53(chunk.DeviceExposure.ToList());
                }

                case "MEASUREMENT":
                {
                    return chunk.Measurements.Count == 0
                        ? null
                        : new MeasurementDataReader53(chunk.Measurements.ToList());
                }

                case "COHORT":
                {
                    return chunk.Cohort.Count == 0 ? null : new CohortDataReader(chunk.Cohort.ToList());
                }

                case "CONDITION_OCCURRENCE":
                {
                    return chunk.ConditionOccurrences.Count == 0
                        ? null
                        : new ConditionOccurrenceDataReader53(chunk.ConditionOccurrences.ToList());
                }

                case "COST":
                {
                    return chunk.Cost.Count == 0 ? null : new CostDataReader52(chunk.Cost.ToList());
                }

                case "NOTE":
                {
                    return chunk.Note.Count == 0 ? null : new NoteDataReader53(chunk.Note.ToList());
                }

                case "METADATA_TMP":
                {
                    return chunk.Metadata.Count == 0 ? null : new MetadataDataReader(chunk.Metadata.ToList());
                }

                case "FACT_RELATIONSHIP":
                {
                    return chunk.FactRelationships.Count == 0
                        ? null
                        : new FactRelationshipDataReader(chunk.FactRelationships.ToList());
                }
            }

            throw new Exception("CreateDataReader, unsupported table name: " + table);
        }


        public void Write(ChunkData chunk, string table)
        {
            try
            {
                var prefix = int.Parse(_subChunkId.Split('.')[0]);
                var personIds = _subChunkId.Split('.')[2];
                var personCount = int.Parse(_subChunkId.Split('.')[3]);

                if (table == "METADATA_TMP" && chunk.Metadata.Count > 0)
                {
                    personCount = chunk.Metadata.Count;
                }

                var fileName = $"{table}/{table}.{_chunkId}.{prefix}.{personIds}.{personCount}.snappy";
                if(Settings.Current.StorageType == S3StorageType.CSV)
                    fileName = $"{table}/{table}.{_chunkId}.{prefix}.{personIds}.{personCount}.txt.gz";

                var bucket = $"{Settings.Current.Bucket}/{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id}/{Settings.Current.CDMFolder}";

                var config = new AmazonS3Config
                {
                    Timeout = TimeSpan.FromMinutes(60),
                    ReadWriteTimeout = TimeSpan.FromMinutes(60),
                    RegionEndpoint = Amazon.RegionEndpoint.USEast1,
                    BufferSize = 512 * 1024,
                    MaxErrorRetry = 20
                };

                var attempt = 0;

                while (true)
                {
                    if (attempt > 0)
                    {
                        Console.WriteLine($"[SAVE] {fileName} saving... attempt={attempt}");
                    }

                    var reader = CreateDataReader(chunk, table);
                    if (reader == null) return;

                    using (var client = new AmazonS3Client(Settings.Current.S3AwsAccessKeyId,
                        Settings.Current.S3AwsSecretAccessKey, config))
                    using (var stream = reader.GetStream(Settings.Current.StorageType))
                    {
                        var putObject = client.PutObjectAsync(new PutObjectRequest
                        {
                            BucketName = bucket,
                            Key = fileName,
                            ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256,
                            StorageClass = S3StorageClass.Standard,
                            InputStream = stream
                        });
                        putObject.Wait();


                        var response = putObject.Result;

                        if (string.IsNullOrEmpty(response.ETag))
                        {
                            var responseMetadata = string.Empty;
                            if (response.ResponseMetadata?.Metadata != null &&
                                response.ResponseMetadata.Metadata.Keys.Count > 0)
                            {
                                responseMetadata = string.Join('|',
                                    response.ResponseMetadata.Metadata.Select(m => m.Key + "=" + m.Value));
                            }

                            Console.WriteLine(
                                $"[SAVE] {fileName} - ETag is empty, file was not saved; {responseMetadata}");
                            attempt++;
                        }
                        else
                        {
                            if (attempt > 0)
                            {
                                Console.WriteLine($"[SAVE] {fileName} saved... attempt={attempt}");
                            }

                            break;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("WARN_EXC - Write2 - throw");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }
        }


        public void Save(ChunkData chunk)
        {
            try
            {
                var tables = new[]
                {
                    "PERSON",
                    "OBSERVATION_PERIOD",
                    "PAYER_PLAN_PERIOD",
                    "DEATH",
                    "DRUG_EXPOSURE",
                    "OBSERVATION",
                    "VISIT_OCCURRENCE",
                    "VISIT_DETAIL",
                    "PROCEDURE_OCCURRENCE",
                    "DRUG_ERA",
                    "CONDITION_ERA",
                    "DEVICE_EXPOSURE",
                    "MEASUREMENT",
                    "COHORT",
                    "CONDITION_OCCURRENCE",
                    "COST",
                    "NOTE",
                    "METADATA_TMP",
                    "FACT_RELATIONSHIP"
                };

                Parallel.ForEach(tables, new ParallelOptions { MaxDegreeOfParallelism = 1 }, t => { Write(chunk, t); });
                //Parallel.ForEach(tables, t => { Write(chunk, t); });
            }
            catch (Exception e)
            {
                Console.WriteLine("WARN_EXC - Save - throw");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }
        }
    }
}
