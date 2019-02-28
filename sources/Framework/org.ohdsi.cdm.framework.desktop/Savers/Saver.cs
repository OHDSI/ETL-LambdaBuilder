using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using org.ohdsi.cdm.framework.common2.Builder;
using org.ohdsi.cdm.framework.common2.DataReaders.v5;
using org.ohdsi.cdm.framework.common2.DataReaders.v5.v501;
using org.ohdsi.cdm.framework.common2.DataReaders.v5.v52;
using org.ohdsi.cdm.framework.common2.DataReaders.v5.v53;
using org.ohdsi.cdm.framework.common2.Enums;
using org.ohdsi.cdm.framework.common2.Omop;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop.Savers
{
    public class Saver : ISaver
    {
        public virtual ISaver Create(string connectionString)
        {
            return this;
        }

        public void Save(ChunkData chunk)
        {
            SaveSync(chunk);
        }

        protected IDataReader CreateDataReader(ChunkData chunk, string table)
        {
            switch (table)
            {
                case "PERSON":
                    return new PersonDataReader(chunk.Persons.ToList());

                case "OBSERVATION_PERIOD":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                        {
                            return new ObservationPeriodDataReader53(chunk.ObservationPeriods.ToList());
                        }

                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V52)
                        {
                            return new ObservationPeriodDataReader52(chunk.ObservationPeriods.ToList());
                        }

                        return new ObservationPeriodDataReader(chunk.ObservationPeriods.ToList());
                    }

                case "PAYER_PLAN_PERIOD":
                {
                    if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                    {
                        return new PayerPlanPeriodDataReader53(chunk.PayerPlanPeriods.ToList());
                    }

                    return new PayerPlanPeriodDataReader(chunk.PayerPlanPeriods.ToList());
                }

                case "DEATH":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V5)
                        {
                            return new DeathDataReader(chunk.Deaths.ToList());
                        }

                        return new DeathDataReader52(chunk.Deaths.ToList());
                        
                    }

                case "DRUG_EXPOSURE":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                        {
                            return new DrugExposureDataReader53(chunk.DrugExposures.ToList());
                        }

                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V52)
                        {
                            return new DrugExposureDataReader52(chunk.DrugExposures.ToList());
                        }

                        return new DrugExposureDataReader(chunk.DrugExposures.ToList());
                    }


                case "OBSERVATION":
                {
                    if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                    {
                        return new ObservationDataReader53(chunk.Observations.ToList());
                    }

                    return new ObservationDataReader(chunk.Observations.ToList());
                }

                case "VISIT_OCCURRENCE":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V5)
                        {
                            return new VisitOccurrenceDataReader(chunk.VisitOccurrences.ToList());
                        }

                        return new VisitOccurrenceDataReader52(chunk.VisitOccurrences.ToList());
                    }

                case "VISIT_DETAIL":
                    return new VisitDetailDataReader53(chunk.VisitDetails.ToList());

                case "PROCEDURE_OCCURRENCE":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                        {
                            return new ProcedureOccurrenceDataReader53(chunk.ProcedureOccurrences.ToList());
                        }

                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V52)
                        {
                            return new ProcedureOccurrenceDataReader52(chunk.ProcedureOccurrences.ToList());
                        }

                        return new ProcedureOccurrenceDataReader(chunk.ProcedureOccurrences.ToList());
                    }

                case "DRUG_ERA":
                    return new DrugEraDataReader(chunk.DrugEra.ToList());

                case "CONDITION_ERA":
                    return new ConditionEraDataReader(chunk.ConditionEra.ToList());

                case "DEVICE_EXPOSURE":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                        {
                            return new DeviceExposureDataReader53(chunk.DeviceExposure.ToList());
                        }

                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V52)
                        {
                            return new DeviceExposureDataReader52(chunk.DeviceExposure.ToList());
                        }

                        return new DeviceExposureDataReader(chunk.DeviceExposure.ToList());
                    }


                case "MEASUREMENT":
                    if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                    {
                        return new MeasurementDataReader53(chunk.Measurements.ToList());
                    }
                    else
                        return new MeasurementDataReader(chunk.Measurements.ToList());

                case "COHORT":
                    return new CohortDataReader(chunk.Cohort.ToList());

                case "CONDITION_OCCURRENCE":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V5)
                        {
                            return new ConditionOccurrenceDataReader(chunk.ConditionOccurrences.ToList());
                        }
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V501)
                        {
                            return new ConditionOccurrenceDataReader501(chunk.ConditionOccurrences.ToList());
                        }
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V52)
                        {
                            return new ConditionOccurrenceDataReader52(chunk.ConditionOccurrences.ToList());
                        }
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                        {
                            return new ConditionOccurrenceDataReader53(chunk.ConditionOccurrences.ToList());
                        }
                        break;
                    }

                //case "DRUG_COST":
                //    return new DrugCostDataReader(chunk.DrugCost.ToList());

                //case "DEVICE_COST":
                //    return new DeviceCostDataReader(chunk.DeviceCost.ToList());

                //case "PROCEDURE_COST":
                //    return new ProcedureCostDataReader(chunk.ProcedureCost.ToList());

                //case "VISIT_COST":
                //    return new VisitCostDataReader(chunk.VisitCost.ToList());

                case "COST":
                    {
                        if (Settings.Settings.Current.Building.Cdm == CdmVersions.V5)
                        {
                            return new CostDataReader(chunk.Cost.ToList());
                        }

                        return new CostDataReader52(chunk.Cost.ToList());
                    }

                case "NOTE":
                    if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                    {
                        return new NoteDataReader53(chunk.Note.ToList());
                    }
                    else
                        return new NoteDataReader52(chunk.Note.ToList());

                case "FACT_RELATIONSHIP":
                {
                    return new FactRelationshipDataReader(chunk.FactRelationships.ToList());
                }
            }

            throw new Exception("CreateDataReader, unsupported table name: " + table);
        }

        public virtual void Write(ChunkData chunk, string table)
        {
            Write(chunk.ChunkId, chunk.SubChunkId, CreateDataReader(chunk, table), table);
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

                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V5)
                {
                    Write(chunk, "DRUG_COST");
                    Write(chunk, "DEVICE_COST");
                    Write(chunk, "PROCEDURE_COST");
                    Write(chunk, "VISIT_COST");
                }
                else
                {
                    Write(chunk, "COST");
                    Write(chunk, "NOTE");
                }

                if (Settings.Settings.Current.Building.Cdm == CdmVersions.V53)
                {
                    Write(chunk, "VISIT_DETAIL");
                    Write(chunk.ChunkId, chunk.SubChunkId, new MetadataDataReader(chunk.Metadata), "METADATA_TMP");
                }

                Write(chunk, "FACT_RELATIONSHIP");

                Commit();
            }
            catch (Exception e)
            {
                Logger.WriteError(chunk.ChunkId, e);
                Rollback();
                Logger.Write(chunk.ChunkId, LogMessageTypes.Debug, "Rollback - Complete");
                throw;
            }
        }

        public virtual void SaveEntityLookup(List<Location> location, List<CareSite> careSite, List<Provider> provider)
        {
            try
            {
                if (location != null && location.Count > 0)
                    Write(null, null, new LocationDataReader(location), "LOCATION");

                if (careSite != null && careSite.Count > 0)
                    Write(null, null, new CareSiteDataReader(careSite), "CARE_SITE");

                if (provider != null && provider.Count > 0)
                    Write(null, null, new ProviderDataReader(provider), "PROVIDER");

                Commit();
            }
            catch (Exception e)
            {
                Logger.WriteError(e);
                Rollback();
            }
        }

        public virtual void AddChunk(List<ChunkRecord> chunk, int index)
        {
            try
            {
                Write(null, null, new ChunkDataReader(chunk), "_chunks");
            }
            catch (Exception e)
            {
                Logger.WriteError(e);
                Rollback();
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

        }
    }
}

   
   
