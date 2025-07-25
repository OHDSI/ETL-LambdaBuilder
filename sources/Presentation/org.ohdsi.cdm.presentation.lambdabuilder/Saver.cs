﻿using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v52;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v53;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using System;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using cdm6 = org.ohdsi.cdm.framework.common.DataReaders.v6;

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
            if (cdm == CdmVersions.V6)
            {
                switch (table)
                {
                    case "PERSON":
                        {
                            return chunk.Persons.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new cdm6.PersonDataReader([.. chunk.Persons]),
                                    chunk.Persons.Count);
                        }

                    case "OBSERVATION_PERIOD":
                        {
                            return chunk.ObservationPeriods.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.ObservationPeriodDataReader([.. chunk.ObservationPeriods], _offsetManager),
                                    chunk.ObservationPeriods.Count);
                        }

                    case "PAYER_PLAN_PERIOD":
                        {
                            return chunk.PayerPlanPeriods.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.PayerPlanPeriodDataReader([.. chunk.PayerPlanPeriods], _offsetManager),
                                    chunk.PayerPlanPeriods.Count);
                        }

                    case "DRUG_EXPOSURE":
                        {
                            return chunk.DrugExposures.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new cdm6.DrugExposureDataReader([.. chunk.DrugExposures], _offsetManager),
                                    chunk.DrugExposures.Count);
                        }

                    case "OBSERVATION":
                        {
                            return chunk.Observations.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new cdm6.ObservationDataReader([.. chunk.Observations], _offsetManager),
                                    chunk.Observations.Count);
                        }

                    case "VISIT_OCCURRENCE":
                        {
                            return chunk.VisitOccurrences.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.VisitOccurrenceDataReader([.. chunk.VisitOccurrences], _offsetManager),
                                    chunk.VisitOccurrences.Count);
                        }

                    case "VISIT_DETAIL":
                        {
                            return chunk.VisitDetails.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new cdm6.VisitDetailDataReader([.. chunk.VisitDetails], _offsetManager),
                                    chunk.VisitDetails.Count);
                        }

                    case "PROCEDURE_OCCURRENCE":
                        {
                            return chunk.ProcedureOccurrences.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.ProcedureOccurrenceDataReader([.. chunk.ProcedureOccurrences], _offsetManager),
                                    chunk.ProcedureOccurrences.Count);
                        }

                    case "DRUG_ERA":
                        {
                            return chunk.DrugEra.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.DrugEraDataReader([.. chunk.DrugEra], _offsetManager),
                                    chunk.DrugEra.Count);
                        }

                    case "CONDITION_ERA":
                        {
                            return chunk.ConditionEra.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.ConditionEraDataReader([.. chunk.ConditionEra], _offsetManager),
                                    chunk.ConditionEra.Count);
                        }

                    case "DEVICE_EXPOSURE":
                        {
                            return chunk.DeviceExposure.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.DeviceExposureDataReader([.. chunk.DeviceExposure], _offsetManager),
                                    chunk.DeviceExposure.Count);
                        }

                    case "MEASUREMENT":
                        {
                            return chunk.Measurements.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.MeasurementDataReader([.. chunk.Measurements], _offsetManager),
                                    chunk.Measurements.Count);
                        }

                    case "COHORT":
                        {
                            return chunk.Cohort.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.CohortDataReader([.. chunk.Cohort]),
                                    chunk.Cohort.Count);
                        }

                    case "CONDITION_OCCURRENCE":
                        {
                            return chunk.ConditionOccurrences.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.ConditionOccurrenceDataReader([.. chunk.ConditionOccurrences], _offsetManager),
                                    chunk.ConditionOccurrences.Count);
                        }

                    case "COST":
                        {
                            return chunk.Cost.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.CostDataReader([.. chunk.Cost], _offsetManager),
                                    chunk.Cost.Count);
                        }

                    case "NOTE":
                        {
                            return chunk.Note.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.NoteDataReader([.. chunk.Note], _offsetManager),
                                    chunk.Note.Count);
                        }

                    case "METADATA_TMP":
                        {
                            return chunk.Metadata.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.MetadataDataReader([.. chunk.Metadata.Values]),
                                    chunk.Metadata.Values.Count);
                        }

                    case "FACT_RELATIONSHIP":
                        {
                            return chunk.FactRelationships.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new cdm6.FactRelationshipDataReader([.. chunk.FactRelationships]),
                                    chunk.FactRelationships.Count);
                        }

                    case "DEATH":
                        return null;
                }
            }
            else
            {
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
                                    new ObservationPeriodDataReader53([.. chunk.ObservationPeriods], _offsetManager),
                                    chunk.ObservationPeriods.Count);
                        }

                    case "PAYER_PLAN_PERIOD":
                        {
                            return chunk.PayerPlanPeriods.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new PayerPlanPeriodDataReader53([.. chunk.PayerPlanPeriods], _offsetManager),
                                    chunk.PayerPlanPeriods.Count);
                        }

                    case "DEATH":
                        {
                            return chunk.Deaths.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new DeathDataReader52([.. chunk.Deaths]),
                                    chunk.Deaths.Count);
                        }

                    case "DRUG_EXPOSURE":
                        {
                            return chunk.DrugExposures.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new DrugExposureDataReader53([.. chunk.DrugExposures], _offsetManager),
                                    chunk.DrugExposures.Count);
                        }

                    case "OBSERVATION":
                        {
                            if (cdm == CdmVersions.V54)
                            {
                                return chunk.Observations.Count == 0
                                    ? null
                                    : new Tuple<IDataReader, int>(new ObservationDataReader54([.. chunk.Observations], _offsetManager),
                                    chunk.Observations.Count);
                            }
                            else
                            {
                                return chunk.Observations.Count == 0
                                    ? null
                                    : new Tuple<IDataReader, int>(new ObservationDataReader53([.. chunk.Observations], _offsetManager),
                                    chunk.Observations.Count);
                            }
                        }

                    case "VISIT_OCCURRENCE":
                        {
                            if (cdm == CdmVersions.V54)
                            {
                                return chunk.VisitOccurrences.Count == 0
                                    ? null
                                    : new Tuple<IDataReader, int>(
                                    new VisitOccurrenceDataReader54([.. chunk.VisitOccurrences], _offsetManager),
                                    chunk.VisitOccurrences.Count);
                            }
                            else
                            {
                                return chunk.VisitOccurrences.Count == 0
                                    ? null
                                    : new Tuple<IDataReader, int>(
                                    new VisitOccurrenceDataReader52([.. chunk.VisitOccurrences], _offsetManager),
                                    chunk.VisitOccurrences.Count);
                            }
                        }

                    case "VISIT_DETAIL":
                        {
                            if (cdm == CdmVersions.V54)
                            {
                                return chunk.VisitDetails.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new VisitDetailDataReader54([.. chunk.VisitDetails], _offsetManager),
                                    chunk.VisitDetails.Count);
                            }
                            else
                            {
                                return chunk.VisitDetails.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(new VisitDetailDataReader53([.. chunk.VisitDetails], _offsetManager),
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
                                    new ProcedureOccurrenceDataReader54([.. chunk.ProcedureOccurrences], _offsetManager),
                                    chunk.ProcedureOccurrences.Count);
                            }
                            else
                            {
                                return chunk.ProcedureOccurrences.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new ProcedureOccurrenceDataReader53([.. chunk.ProcedureOccurrences], _offsetManager),
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
                                      new DeviceExposureDataReader54([.. chunk.DeviceExposure], _offsetManager),
                                      chunk.DeviceExposure.Count);
                            }
                            else
                            {
                                return chunk.DeviceExposure.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new DeviceExposureDataReader53([.. chunk.DeviceExposure], _offsetManager),
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
                                    new MeasurementDataReader54([.. chunk.Measurements], _offsetManager),
                                    chunk.Measurements.Count);
                            }
                            else
                            {
                                return chunk.Measurements.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new MeasurementDataReader53([.. chunk.Measurements], _offsetManager),
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
                                    new ConditionOccurrenceDataReader53([.. chunk.ConditionOccurrences], _offsetManager),
                                    chunk.ConditionOccurrences.Count);
                        }

                    case "COST":
                        {
                            return chunk.Cost.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new CostDataReader52([.. chunk.Cost], _offsetManager),
                                    chunk.Cost.Count);
                        }

                    case "NOTE":
                        {
                            if (cdm == CdmVersions.V54)
                            {
                                return chunk.Note.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new NoteDataReader54([.. chunk.Note], _offsetManager),
                                    chunk.Note.Count);
                            }
                            else
                            {
                                return chunk.Note.Count == 0
                                ? null
                                : new Tuple<IDataReader, int>(
                                    new NoteDataReader53([.. chunk.Note], _offsetManager),
                                    chunk.Note.Count);
                            }
                        }

                    case "NOTE_NLP":
                        {
                            return chunk.NoteNlp.Count == 0
                            ? null
                            : new Tuple<IDataReader, int>(
                                new NoteNlpDataReader54([.. chunk.NoteNlp], _offsetManager),
                                chunk.NoteNlp.Count);

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
                                new EpisodeDataReader54([.. chunk.Episode], _offsetManager),
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

                using var ms = reader.GetStream(S3StorageType.CSV);
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
                    "EPISODE",
                    "NOTE_NLP"
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