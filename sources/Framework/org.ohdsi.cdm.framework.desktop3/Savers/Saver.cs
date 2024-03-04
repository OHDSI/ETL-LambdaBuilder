using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v52;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v53;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Enums;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using cdm6 = org.ohdsi.cdm.framework.common.DataReaders.v6;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class Saver : ISaver
    {
        private KeyMasterOffsetManager _offsetManager;
        public virtual ISaver Create(string connectionString)
        {
            return this;
        }

        public void Save(ChunkData chunk, KeyMasterOffsetManager offsetManager)
        {
            _offsetManager = offsetManager;
            SaveSync(chunk);
        }

        protected IEnumerable<IDataReader> CreateDataReader(ChunkData chunk, string table)
        {
            if (Settings.Settings.Current.Building.Cdm == CdmVersions.V6)
            {
                switch (table)
                {
                    case "PERSON":
                        {
                            if (chunk.Persons.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Persons))
                                {
                                    yield return new cdm6.PersonDataReader(list);
                                }
                            }
                            break;
                        }

                    case "OBSERVATION_PERIOD":
                        {
                            if (chunk.ObservationPeriods.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.ObservationPeriods))
                                {
                                    yield return new cdm6.ObservationPeriodDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "PAYER_PLAN_PERIOD":
                        {
                            if (chunk.PayerPlanPeriods.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.PayerPlanPeriods))
                                {
                                    yield return new cdm6.PayerPlanPeriodDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "DRUG_EXPOSURE":
                        {
                            if (chunk.DrugExposures.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.DrugExposures))
                                {
                                    yield return new cdm6.DrugExposureDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "OBSERVATION":
                        {
                            if (chunk.Observations.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Observations))
                                {
                                    yield return new cdm6.ObservationDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "VISIT_OCCURRENCE":
                        {
                            if (chunk.VisitOccurrences.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.VisitOccurrences))
                                {
                                    yield return new cdm6.VisitOccurrenceDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "VISIT_DETAIL":
                        {
                            if (chunk.VisitDetails.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.VisitDetails))
                                {
                                    yield return new cdm6.VisitDetailDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "PROCEDURE_OCCURRENCE":
                        {
                            if (chunk.ProcedureOccurrences.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.ProcedureOccurrences))
                                {
                                    yield return new cdm6.ProcedureOccurrenceDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "DRUG_ERA":
                        {
                            if (chunk.DrugEra.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.DrugEra))
                                {
                                    yield return new cdm6.DrugEraDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "CONDITION_ERA":
                        {
                            if (chunk.ConditionEra.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.ConditionEra))
                                {
                                    yield return new cdm6.ConditionEraDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "DEVICE_EXPOSURE":
                        {
                            if (chunk.DeviceExposure.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.DeviceExposure))
                                {
                                    yield return new cdm6.DeviceExposureDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "MEASUREMENT":
                        {
                            if (chunk.Measurements.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Measurements))
                                {
                                    yield return new cdm6.MeasurementDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "COHORT":
                        {
                            if (chunk.Cohort.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Cohort))
                                {
                                    yield return new cdm6.CohortDataReader(list);
                                }
                            }
                            break;
                        }

                    case "CONDITION_OCCURRENCE":
                        {
                            if (chunk.ConditionOccurrences.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.ConditionOccurrences))
                                {
                                    yield return new cdm6.ConditionOccurrenceDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "COST":
                        {
                            if (chunk.Cost.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Cost))
                                {
                                    yield return new cdm6.CostDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "NOTE":
                        {
                            if (chunk.Note.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Note))
                                {
                                    yield return new cdm6.NoteDataReader(list, _offsetManager);
                                }
                            }
                            break;
                        }

                    case "METADATA_TMP":
                        {
                            if (chunk.Metadata.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.Metadata.Values.ToList()))
                                {
                                    yield return new cdm6.MetadataDataReader(list);
                                }
                            }
                            break;
                        }

                    case "FACT_RELATIONSHIP":
                        {
                            if (chunk.FactRelationships.Count > 0)
                            {
                                foreach (var list in SplitList(chunk.FactRelationships))
                                {
                                    yield return new cdm6.FactRelationshipDataReader(list);
                                }
                            }

                            break;
                        }

                    case "DEATH":
                        break;

                    default:
                        throw new Exception("CreateDataReader, unsupported table name: " + table);
                }
            }
            else
            {
                switch (table)
                {
                    case "PERSON":
                        foreach (var list in SplitList(chunk.Persons))
                        {
                            yield return new PersonDataReader(list);
                        }
                        break;

                    case "OBSERVATION_PERIOD":
                        {

                            foreach (var list in SplitList(chunk.ObservationPeriods))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new ObservationPeriodDataReader53(list, _offsetManager);
                                else
                                    yield return new ObservationPeriodDataReader52(list, _offsetManager);
                            }

                            break;
                        }

                    case "PAYER_PLAN_PERIOD":
                        {
                            foreach (var list in SplitList(chunk.PayerPlanPeriods))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new PayerPlanPeriodDataReader53(list, _offsetManager);
                                else
                                    yield return new PayerPlanPeriodDataReader(list, _offsetManager);
                            }
                            break;
                        }

                    case "DEATH":
                        {
                            foreach (var list in SplitList(chunk.Deaths))
                            {
                                yield return new DeathDataReader52(list);
                            }

                            break;
                        }

                    case "DRUG_EXPOSURE":
                        {
                            foreach (var list in SplitList(chunk.DrugExposures))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new DrugExposureDataReader53(list, _offsetManager);
                                else
                                    yield return new DrugExposureDataReader52(list, _offsetManager);
                            }
                            break;
                        }


                    case "OBSERVATION":
                        {
                            foreach (var list in SplitList(chunk.Observations))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new ObservationDataReader53(list, _offsetManager);
                                else
                                    yield return new ObservationDataReader(list, _offsetManager);
                            }
                            break;
                        }

                    case "VISIT_OCCURRENCE":
                        {
                            foreach (var list in SplitList(chunk.VisitOccurrences))
                            {
                                yield return new VisitOccurrenceDataReader52(list, _offsetManager);
                            }

                            break;
                        }

                    case "VISIT_DETAIL":
                        foreach (var list in SplitList(chunk.VisitDetails))
                        {
                            yield return new VisitDetailDataReader53(list, _offsetManager);
                        }

                        break;

                    case "PROCEDURE_OCCURRENCE":
                        {
                            foreach (var list in SplitList(chunk.ProcedureOccurrences))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new ProcedureOccurrenceDataReader53(list, _offsetManager);
                                else
                                    yield return new ProcedureOccurrenceDataReader52(list, _offsetManager);
                            }
                            break;
                        }

                    case "DRUG_ERA":
                        foreach (var list in SplitList(chunk.DrugEra))
                        {
                            yield return new DrugEraDataReader(list, _offsetManager);
                        }

                        break;

                    case "CONDITION_ERA":
                        foreach (var list in SplitList(chunk.ConditionEra))
                        {
                            yield return new ConditionEraDataReader(list, _offsetManager);
                        }
                        break;


                    case "DEVICE_EXPOSURE":
                        {
                            foreach (var list in SplitList(chunk.DeviceExposure))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new DeviceExposureDataReader53(list, _offsetManager);
                                else
                                    yield return new DeviceExposureDataReader52(list, _offsetManager);
                            }
                            break;

                        }


                    case "MEASUREMENT":
                        foreach (var list in SplitList(chunk.Measurements))
                        {
                            if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                yield return new MeasurementDataReader53(list, _offsetManager);
                            else
                                yield return new MeasurementDataReader(list, _offsetManager);
                        }
                        break;

                    case "COHORT":
                        foreach (var list in SplitList(chunk.Cohort))
                        {
                            yield return new CohortDataReader(list);
                        }
                        break;

                    case "CONDITION_OCCURRENCE":
                        {
                            foreach (var list in SplitList(chunk.ConditionOccurrences))
                            {
                                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                    yield return new ConditionOccurrenceDataReader53(list, _offsetManager);
                                else
                                    yield return new ConditionOccurrenceDataReader52(list, _offsetManager);
                            }
                            break;
                        }

                    case "COST":
                        {
                            foreach (var list in SplitList(chunk.Cost))
                            {
                                yield return new CostDataReader52(list, _offsetManager);
                            }
                            break;
                        }

                    case "NOTE":
                        foreach (var list in SplitList(chunk.Note))
                        {
                            if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                                yield return new NoteDataReader53(list, _offsetManager);
                            else
                                yield return new NoteDataReader52(list, _offsetManager);
                        }
                        break;

                    case "FACT_RELATIONSHIP":
                        {
                            foreach (var list in SplitList(chunk.FactRelationships))
                            {
                                yield return new FactRelationshipDataReader(list);
                            }
                            break;
                        }
                    default:
                        throw new Exception("CreateDataReader, unsupported table name: " + table);
                }
            }

        }

        public virtual void Write(ChunkData chunk, string table)
        {
            foreach (var reader in CreateDataReader(chunk, table))
            {
                Write(chunk.ChunkId, chunk.SubChunkId, reader, table);
            }
        }

        private void SaveSync(ChunkData chunk)
        {

            try
            {
                Write(chunk, "PERSON");
                Write(chunk, "OBSERVATION_PERIOD");
                Write(chunk, "PAYER_PLAN_PERIOD");
                Write(chunk, "DEATH");
                Write(chunk, "DRUG_EXPOSURE");
                Write(chunk, "OBSERVATION");
                Write(chunk, "VISIT_OCCURRENCE");
                Write(chunk, "PROCEDURE_OCCURRENCE");

                Write(chunk, "DRUG_ERA");
                Write(chunk, "CONDITION_ERA");
                Write(chunk, "DEVICE_EXPOSURE");
                Write(chunk, "MEASUREMENT");
                Write(chunk, "COHORT");

                Write(chunk, "CONDITION_OCCURRENCE");

                Write(chunk, "COST");
                Write(chunk, "NOTE");

                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53 || Settings.Settings.Current.Building.Cdm == CdmVersions.V6)
                {
                    Write(chunk, "VISIT_DETAIL");
                    Write(chunk.ChunkId, chunk.SubChunkId, new MetadataDataReader([.. chunk.Metadata.Values]), "METADATA_TMP");
                }

                Write(chunk, "FACT_RELATIONSHIP");

                Commit();
            }
            catch (Exception)
            {
                Rollback();
                throw;
            }
        }

        public virtual void SaveEntityLookup(CdmVersions cdmVersions, List<Location> location, List<CareSite> careSite, List<Provider> provider, List<CohortDefinition> cohortDefinition)
        {
            try
            {
                if (cdmVersions == CdmVersions.V6)
                {
                    if (location != null && location.Count > 0)
                        Write(null, null, new cdm6.LocationDataReader(location), "LOCATION");

                    if (careSite != null && careSite.Count > 0)
                        Write(null, null, new cdm6.CareSiteDataReader(careSite), "CARE_SITE");

                    if (provider != null && provider.Count > 0)
                        Write(null, null, new cdm6.ProviderDataReader(provider), "PROVIDER");
                }
                else
                {
                    if (location != null && location.Count > 0)
                        Write(null, null, new LocationDataReader(location), "LOCATION");

                    if (careSite != null && careSite.Count > 0)
                        Write(null, null, new CareSiteDataReader(careSite), "CARE_SITE");

                    if (provider != null && provider.Count > 0)
                    {
                        foreach (var chunk in SplitList(provider))
                        {
                            Write(null, null, new ProviderDataReader(chunk), "PROVIDER");
                        }
                    }
                }

                if (cohortDefinition != null && cohortDefinition.Count > 0)
                {
                    Write(null, null, new cdm6.CohortDefinitionDataReader(cohortDefinition), "COHORT_DEFINITION");
                }

                Commit();
            }
            catch (Exception)
            {
                Rollback();
                throw;
            }
        }

        private static IEnumerable<List<T>> SplitList<T>(List<T> list, int nSize = 10 * 1000)
        {
            if (Settings.Settings.Current.Building.DestinationEngine.Database == Database.MySql)
            {
                for (var i = 0; i < list.Count; i += nSize)
                {
                    yield return list.GetRange(i, Math.Min(nSize, list.Count - i));
                }
            }
            else
                yield return list;
        }

        public virtual void AddChunk(List<ChunkRecord> chunk, int index)
        {
            try
            {
                Write(null, null, new ChunkDataReader(chunk), "_chunks");
            }
            catch (Exception)
            {
                Rollback();
                throw;
            }
        }

        public virtual void Write(int? chunkId, int? subChunkId, IDataReader reader, string tableName)
        {
            throw new NotImplementedException();
        }

        public virtual void Commit()
        {

        }

        public virtual void Rollback()
        {

        }

        public virtual void CopyVocabulary()
        {
            throw new NotImplementedException();
        }

        public virtual void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}