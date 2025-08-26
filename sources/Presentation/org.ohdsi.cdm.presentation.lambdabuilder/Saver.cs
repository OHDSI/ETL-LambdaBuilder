using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Enums;
using System;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public class Saver(KeyMasterOffsetManager offsetManager, string tmpFolder)
    {
        private readonly KeyMasterOffsetManager _offsetManager = offsetManager;
        private readonly string _tmpFolder = tmpFolder;

        public string TmpFolder
        {
            get
            {
                if (string.IsNullOrEmpty(_tmpFolder))
                    return "/tmp";

                return $"/tmp/{_tmpFolder}";
            }
        }
        protected Tuple<IDataReader, int> CreateDataReader(ChunkData chunk, string table)
        {
            var cdm = Settings.Current.Building.Vendor.CdmVersion;

            switch (table)
            {
                case "PERSON":
                    {
                        return chunk.Persons.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new PersonDataReader([.. chunk.Persons]),
                                chunk.Persons.Count);
                    }

                case "OBSERVATION_PERIOD":
                    {
                        return chunk.ObservationPeriods.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ObservationPeriodDataReader([.. chunk.ObservationPeriods], _offsetManager),
                                chunk.ObservationPeriods.Count);
                    }

                case "PAYER_PLAN_PERIOD":
                    {
                        return chunk.PayerPlanPeriods.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new PayerPlanPeriodDataReader([.. chunk.PayerPlanPeriods], _offsetManager),
                                chunk.PayerPlanPeriods.Count);
                    }

                case "DEATH":
                    {
                        return chunk.Deaths.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new DeathDataReader([.. chunk.Deaths]),
                                chunk.Deaths.Count);
                    }

                case "DRUG_EXPOSURE":
                    {
                        return chunk.DrugExposures.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new DrugExposureDataReader([.. chunk.DrugExposures], _offsetManager),
                                chunk.DrugExposures.Count);
                    }

                case "OBSERVATION":
                    {
                        return chunk.Observations.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new ObservationDataReader([.. chunk.Observations], _offsetManager),
                            chunk.Observations.Count);
                    }

                case "VISIT_OCCURRENCE":
                    {
                        return chunk.VisitOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                            new VisitOccurrenceDataReader([.. chunk.VisitOccurrences], _offsetManager),
                            chunk.VisitOccurrences.Count);
                    }

                case "VISIT_DETAIL":
                    {
                        if (cdm == CdmVersions.V54)
                        {
                            return chunk.VisitDetails.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new VisitDetailDataReader([.. chunk.VisitDetails], _offsetManager),
                                chunk.VisitDetails.Count);
                        }
                        else
                        {
                            return chunk.VisitDetails.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new VisitDetailDataReader([.. chunk.VisitDetails], _offsetManager),
                                chunk.VisitDetails.Count);
                        }
                    }

                case "PROCEDURE_OCCURRENCE":
                    {
                        if (cdm == CdmVersions.V54)
                        {
                            return chunk.ProcedureOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ProcedureOccurrenceDataReader([.. chunk.ProcedureOccurrences], _offsetManager),
                                chunk.ProcedureOccurrences.Count);
                        }
                        else
                        {
                            return chunk.ProcedureOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ProcedureOccurrenceDataReader([.. chunk.ProcedureOccurrences], _offsetManager),
                                chunk.ProcedureOccurrences.Count);
                        }
                    }

                case "DRUG_ERA":
                    {
                        return chunk.DrugEra.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new DrugEraDataReader([.. chunk.DrugEra], _offsetManager),
                                chunk.DrugEra.Count);
                    }

                case "CONDITION_ERA":
                    {
                        return chunk.ConditionEra.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ConditionEraDataReader([.. chunk.ConditionEra], _offsetManager),
                                chunk.ConditionEra.Count);
                    }

                case "DEVICE_EXPOSURE":
                    {
                        if (cdm == CdmVersions.V54)
                        {
                            return chunk.DeviceExposure.Count == 0
                              ? null
                              : new Tuple<IDataReader, int>(
                                  new DeviceExposureDataReader([.. chunk.DeviceExposure], _offsetManager),
                                  chunk.DeviceExposure.Count);
                        }
                        else
                        {
                            return chunk.DeviceExposure.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new DeviceExposureDataReader([.. chunk.DeviceExposure], _offsetManager),
                                chunk.DeviceExposure.Count);
                        }
                    }

                case "MEASUREMENT":
                    {
                        if (cdm == CdmVersions.V54)
                        {
                            return chunk.Measurements.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new MeasurementDataReader([.. chunk.Measurements], _offsetManager),
                                chunk.Measurements.Count);
                        }
                        else
                        {
                            return chunk.Measurements.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new MeasurementDataReader([.. chunk.Measurements], _offsetManager),
                                chunk.Measurements.Count);
                        }
                    }

                case "COHORT":
                    {
                        return chunk.Cohort.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new CohortDataReader([.. chunk.Cohort]),
                                chunk.Cohort.Count);
                    }

                case "CONDITION_OCCURRENCE":
                    {
                        return chunk.ConditionOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ConditionOccurrenceDataReader([.. chunk.ConditionOccurrences], _offsetManager),
                                chunk.ConditionOccurrences.Count);
                    }

                case "COST":
                    {
                        return chunk.Cost.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new CostDataReader([.. chunk.Cost], _offsetManager),
                                chunk.Cost.Count);
                    }

                case "NOTE":
                    {
                        return chunk.Note.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new NoteDataReader([.. chunk.Note], _offsetManager),
                            chunk.Note.Count);
                    }

                case "METADATA_TMP":
                    {
                        return chunk.Metadata.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new MetadataDataReader([.. chunk.Metadata.Values]),
                                chunk.Metadata.Values.Count);
                    }

                case "FACT_RELATIONSHIP":
                    {
                        return chunk.FactRelationships.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new FactRelationshipDataReader([.. chunk.FactRelationships]),
                                chunk.FactRelationships.Count);
                    }

                case "EPISODE":
                    {
                        return chunk.Episode.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new EpisodeDataReader([.. chunk.Episode], _offsetManager),
                            chunk.Episode.Count);
                    }

                case "EPISODE_EVENT":
                    {
                        return chunk.EpisodeEvent.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new EpisodeEventDataReader([.. chunk.EpisodeEvent], _offsetManager),
                            chunk.EpisodeEvent.Count);
                    }

            }

            throw new Exception("CreateDataReader, unsupported table name: " + table);
        }

        public void Write(ChunkData chunk, int chunkId, string subChunkId, string table)
        {
            try
            {
                var prefix = int.Parse(subChunkId.Split('.')[0]);
                var personIds = subChunkId.Split('.')[2];

                var tuple = CreateDataReader(chunk, table);

                if (tuple == null) return;

                var reader = tuple.Item1;
                var rowCount = tuple.Item2;

                var fileName = $"{table}.{chunkId}.{prefix}.{personIds}.{rowCount}.txt.gz";

                using var ms = framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
                using var fs = new FileStream($"{TmpFolder}/{fileName}", FileMode.OpenOrCreate);
                ms.WriteTo(fs);
            }
            catch (Exception e)
            {
                Console.WriteLine("WARN_EXC - Write2 - throw");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }
        }

        public void Save(ChunkData chunk, int chunkId, string subChunkId)
        {
            var timer = new Stopwatch();
            timer.Start();

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
                    "FACT_RELATIONSHIP",
                    "EPISODE_EVENT",
                    "EPISODE"
                };

                Parallel.ForEach(tables, t => { Write(chunk, chunkId, subChunkId, t); });
            }
            catch (Exception e)
            {
                Console.WriteLine("WARN_EXC - Save - throw");
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
                throw;
            }

            timer.Stop();
        }
    }
}