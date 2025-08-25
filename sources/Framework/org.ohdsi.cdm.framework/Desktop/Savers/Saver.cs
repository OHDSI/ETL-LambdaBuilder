using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.DataReaders.v5;
using org.ohdsi.cdm.framework.common.DataReaders.v5.v54;
using org.ohdsi.cdm.framework.desktop.DataReaders;
using org.ohdsi.cdm.framework.desktop.Enums;
using System.Data;


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
                            yield return new ObservationPeriodDataReader(list, _offsetManager);
                        }

                        break;
                    }

                case "PAYER_PLAN_PERIOD":
                    {
                        foreach (var list in SplitList(chunk.PayerPlanPeriods))
                        {
                            yield return new PayerPlanPeriodDataReader(list, _offsetManager);
                        }
                        break;
                    }

                case "DEATH":
                    {
                        foreach (var list in SplitList(chunk.Deaths))
                        {
                            yield return new DeathDataReader(list);
                        }

                        break;
                    }

                case "DRUG_EXPOSURE":
                    {
                        foreach (var list in SplitList(chunk.DrugExposures))
                        {
                            yield return new DrugExposureDataReader(list, _offsetManager);
                        }
                        break;
                    }


                case "OBSERVATION":
                    {
                        foreach (var list in SplitList(chunk.Observations))
                        {
                            yield return new ObservationDataReader(list, _offsetManager);
                        }
                        break;
                    }

                case "VISIT_OCCURRENCE":
                    {
                        foreach (var list in SplitList(chunk.VisitOccurrences))
                        {
                            yield return new VisitOccurrenceDataReader(list, _offsetManager);
                        }

                        break;
                    }

                case "VISIT_DETAIL":
                    foreach (var list in SplitList(chunk.VisitDetails))
                    {
                        yield return new VisitDetailDataReader(list, _offsetManager);
                    }

                    break;

                case "PROCEDURE_OCCURRENCE":
                    {
                        foreach (var list in SplitList(chunk.ProcedureOccurrences))
                        {
                            yield return new ProcedureOccurrenceDataReader(list, _offsetManager);
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
                            yield return new DeviceExposureDataReader(list, _offsetManager);
                        }
                        break;

                    }


                case "MEASUREMENT":
                    foreach (var list in SplitList(chunk.Measurements))
                    {
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
                            yield return new ConditionOccurrenceDataReader(list, _offsetManager);
                        }
                        break;
                    }

                case "COST":
                    {
                        foreach (var list in SplitList(chunk.Cost))
                        {
                            yield return new CostDataReader(list, _offsetManager);
                        }
                        break;
                    }

                case "NOTE":
                    foreach (var list in SplitList(chunk.Note))
                    {
                        yield return new NoteDataReader(list, _offsetManager);
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

                Write(chunk, "VISIT_DETAIL");
                Write(chunk.ChunkId, chunk.SubChunkId, new MetadataDataReader([.. chunk.Metadata.Values]), "METADATA_TMP");


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


                if (cohortDefinition != null && cohortDefinition.Count > 0)
                {
                    Write(null, null, new CohortDefinitionDataReader(cohortDefinition), "COHORT_DEFINITION");
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

        public virtual void AddChunk(List<ChunkRecord> chunk, int index, string schemaName)
        {
            try
            {
                Write(index, null, new ChunkDataReader(chunk), "_chunks");
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

        public virtual void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}