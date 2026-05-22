using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using System.Data;
using System.Diagnostics;


namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class Saver(KeyMasterOffsetManager offsetManager)
    {
        private readonly KeyMasterOffsetManager _offsetManager = offsetManager;

        protected Tuple<IDataReader, int>? CreateDataReader(ChunkData chunk, string table)
        {
            switch (table)
            {
                case "person":
                    {
                        return chunk.Persons.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new PersonDataReader([.. chunk.Persons]),
                                chunk.Persons.Count);
                    }

                case "observation_period":
                    {
                        return chunk.ObservationPeriods.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ObservationPeriodDataReader([.. chunk.ObservationPeriods], _offsetManager),
                                chunk.ObservationPeriods.Count);
                    }

                case "payer_plan_period":
                    {
                        return chunk.PayerPlanPeriods.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new PayerPlanPeriodDataReader([.. chunk.PayerPlanPeriods], _offsetManager),
                                chunk.PayerPlanPeriods.Count);
                    }

                case "death":
                    {
                        return chunk.Deaths.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new DeathDataReader([.. chunk.Deaths]),
                                chunk.Deaths.Count);
                    }

                case "drug_exposure":
                    {
                        return chunk.DrugExposures.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new DrugExposureDataReader([.. chunk.DrugExposures], _offsetManager),
                                chunk.DrugExposures.Count);
                    }

                case "observation":
                    {
                        return chunk.Observations.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(new ObservationDataReader([.. chunk.Observations], _offsetManager),
                            chunk.Observations.Count);
                    }

                case "visit_occurrence":
                    {
                        return chunk.VisitOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                            new VisitOccurrenceDataReader([.. chunk.VisitOccurrences], _offsetManager),
                            chunk.VisitOccurrences.Count);
                    }

                case "visit_detail":
                    {
                        return chunk.VisitDetails.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(new VisitDetailDataReader([.. chunk.VisitDetails], _offsetManager),
                            chunk.VisitDetails.Count);
                    }

                case "procedure_occurrence":
                    {
                        return chunk.ProcedureOccurrences.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new ProcedureOccurrenceDataReader([.. chunk.ProcedureOccurrences], _offsetManager),
                            chunk.ProcedureOccurrences.Count);
                    }

                case "drug_era":
                    {
                        return chunk.DrugEra.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new DrugEraDataReader([.. chunk.DrugEra], _offsetManager),
                                chunk.DrugEra.Count);
                    }

                case "condition_era":
                    {
                        return chunk.ConditionEra.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ConditionEraDataReader([.. chunk.ConditionEra], _offsetManager),
                                chunk.ConditionEra.Count);
                    }

                case "device_exposure":
                    {
                        return chunk.DeviceExposure.Count == 0
                          ? null
                          : new Tuple<IDataReader, int>(
                              new DeviceExposureDataReader([.. chunk.DeviceExposure], _offsetManager),
                              chunk.DeviceExposure.Count);
                    }

                case "measurement":
                    {
                        return chunk.Measurements.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new MeasurementDataReader([.. chunk.Measurements], _offsetManager),
                            chunk.Measurements.Count);
                    }

                case "cohort":
                    {
                        return chunk.Cohort.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new CohortDataReader([.. chunk.Cohort]),
                                chunk.Cohort.Count);
                    }

                case "condition_occurrence":
                    {
                        return chunk.ConditionOccurrences.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new ConditionOccurrenceDataReader([.. chunk.ConditionOccurrences], _offsetManager),
                                chunk.ConditionOccurrences.Count);
                    }

                case "cost":
                    {
                        return chunk.Cost.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new CostDataReader([.. chunk.Cost], _offsetManager),
                                chunk.Cost.Count);
                    }

                case "note":
                    {
                        return chunk.Note.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new NoteDataReader([.. chunk.Note], _offsetManager),
                            chunk.Note.Count);
                    }

                case "metadata_tmp":
                    {
                        return chunk.Metadata.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new MetadataDataReader([.. chunk.Metadata.Values]),
                                chunk.Metadata.Values.Count);
                    }

                case "fact_relationship":
                    {
                        return chunk.FactRelationships.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new FactRelationshipDataReader([.. chunk.FactRelationships]),
                                chunk.FactRelationships.Count);
                    }

                case "episode":
                    {
                        return chunk.Episode.Count == 0
                        ? null
                        : new Tuple<IDataReader, int>(
                            new EpisodeDataReader([.. chunk.Episode], _offsetManager),
                            chunk.Episode.Count);
                    }

                case "episode_event":
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
                var prefix = subChunkId.Split('.')[0];
                var personIds = subChunkId.Split('.')[2];

                var tuple = CreateDataReader(chunk, table);

                if (tuple == null) return;

                var reader = tuple.Item1;
                var rowCount = tuple.Item2;

                var fileName = $"{AzureHelper.Path}/{Settings.Current.CDMFolder}/{table}/{table}.{chunkId}.{prefix}.{personIds}.{rowCount}.txt.gz";

                using var ms = framework.common.Helpers.CsvHelper.GetStreamCsv(reader).First();
                AzureHelper.UploadStream(fileName, ms);
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
                    "person",
                    "observation_period",
                    "payer_plan_period",
                    "death",
                    "drug_exposure",
                    "observation",
                    "visit_occurrence",
                    "visit_detail",
                    "procedure_occurrence",
                    "drug_era",
                    "condition_era",
                    "device_exposure",
                    "measurement",
                    "cohort",
                    "condition_occurrence",
                    "cost",
                    "note",
                    "metadata_tmp",
                    "fact_relationship",
                    "episode_event",
                    "episode"
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