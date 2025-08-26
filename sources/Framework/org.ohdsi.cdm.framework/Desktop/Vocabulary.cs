using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.desktop.Helpers;
using org.ohdsi.cdm.framework.Desktop.DataReaders;
using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop
{
    public class Vocabulary : IVocabulary
    {
        private readonly Dictionary<string, Lookup> _lookups = [];
        private GenderLookup _genderConcepts;
        private PregnancyConcepts _pregnancyConcepts;

        private static LookupValue CreateLookupValue(IDataRecord reader)
        {
            //source_code,	target_concept_id,	target_domain_id,	validstartdate,	validenddate,	source_vocabulary_id,	source_target_concept_id,	source_validstartdate,	source_validenddate,	ingredient_concept_id
            //    1                       2                 3                  4               5               6                       7                                 8                    9                        10


            //source_code,	target_concept_id,	target_domain_id,	validstartdate,	validenddate
            //    1                       2                 3                  4               5

            var sourceCode = string.Intern(reader[0].ToString().Trim());
            int conceptId = -1;
            if (int.TryParse(reader[1].ToString(), out var cptId))
                conceptId = cptId;

            if (reader.FieldCount == 2)
            {
                return new LookupValue
                {
                    ConceptId = conceptId,
                    SourceCode = sourceCode,
                    ValidStartDate = DateTime.MinValue,
                    ValidEndDate = DateTime.MaxValue,
                    Ingredients = []
                };
            }

            if (!DateTime.TryParse(reader[3].ToString(), out var validStartDate))
                validStartDate = DateTime.MinValue;

            if (!DateTime.TryParse(reader[4].ToString(), out var validEndDate))
                validEndDate = DateTime.MaxValue;

            var lv = new LookupValue
            {
                ConceptId = conceptId,
                SourceCode = sourceCode,
                Domain = string.Intern(reader[2].ToString().Trim()),
                ValidStartDate = validStartDate,
                ValidEndDate = validEndDate,
                Ingredients = []
            };

            if (reader.FieldCount > 5)
            {
                //lv.SourceConceptId = int.TryParse(reader[6].ToString(), out var scptId) ? scptId : 0;
                var sourceConceptId = int.TryParse(reader[6].ToString(), out var scptId) ? scptId : 0;
                lv.SourceConcepts.Add(new SourceConcepts { ConceptId = sourceConceptId });

                if (int.TryParse(reader[9].ToString(), out var ingredient))
                    lv.Ingredients.Add(ingredient);
            }


            return lv;
        }

        public IEnumerable<Tuple<IDataReader, string>> GetCombinedLookups()
        {
            if (Settings.Settings.Current.Building.CombinedLookupDefinitions == null || Settings.Settings.Current.Building.CombinedLookupDefinitions.Count == 0)
            {
                Console.WriteLine("CombinedLookups - empty");
                yield break;
            }

            Console.WriteLine("CombinedLookups - Loading...");
            var baseSql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Folder,
                    @"Core\Lookups\Base.sql"));

            foreach (var lookup in Settings.Settings.Current.Building.CombinedLookupDefinitions)
            {
                var sourceQuery = lookup.SourceLookup.Query.Replace("{sc}", Settings.Settings.Current.Building.SourceSchemaName);
                var vocabularyQuery = lookup.VocabularyLookup.Query;

                vocabularyQuery = vocabularyQuery.Replace("{base}", baseSql);
                vocabularyQuery = vocabularyQuery.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);
                var finalLookup = new Dictionary<string, string>();

                try
                {
                    var sourceLookup = new Dictionary<string, List<string>>();
                    var vocabularyLookup = new Dictionary<string, List<string>>();
                    var combinedLookup = new Dictionary<string, List<string>>();

                    Console.WriteLine(sourceQuery);
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.SourceConnectionString))
                    using (var command = new OdbcCommand(sourceQuery, connection) { CommandTimeout = 600 })
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var key1 = reader[lookup.SourceLookup.Key1].ToString().Trim();
                            if (!sourceLookup.ContainsKey(key1))
                                sourceLookup.Add(key1, []);

                            sourceLookup[key1].Add(reader[lookup.SourceLookup.Value1].ToString().Trim());
                        }
                    }

                    Console.WriteLine(sourceLookup.Keys.Count);

                    Console.WriteLine(vocabularyQuery);
                    using (var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString))
                    using (var command = new OdbcCommand(vocabularyQuery, connection) { CommandTimeout = 600 })
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var key1 = reader[lookup.VocabularyLookup.Key1].ToString().Trim();
                            if (!vocabularyLookup.ContainsKey(key1))
                                vocabularyLookup.Add(key1, []);

                            var value1 = reader[lookup.VocabularyLookup.Value1].ToString().Trim();
                            vocabularyLookup[key1].Add(value1);
                        }
                    }
                    Console.WriteLine(vocabularyLookup.Keys.Count);

                    foreach (var source in sourceLookup)
                    {
                        if (!vocabularyLookup.ContainsKey(source.Key))
                            continue;

                        foreach (var vocabValue in vocabularyLookup[source.Key])
                        {
                            if (!combinedLookup.ContainsKey(vocabValue))
                                combinedLookup.Add(vocabValue, []);

                            foreach (var sourceValue in source.Value)
                            {
                                combinedLookup[vocabValue].Add(sourceValue);
                            }
                        }
                    }

                    foreach (var item in combinedLookup)
                    {
                        var mostFrequent = item.Value.GroupBy(i => i).OrderByDescending(grp => grp.Count()).Select(grp => grp.Key).First();

                        finalLookup.Add(item.Key, mostFrequent);
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("LoadCombinedLookups " + e.Message);
                    throw;
                }

                yield return new Tuple<IDataReader, string>(new DictionaryDataReader(finalLookup), lookup.FileName);
            }
        }


        private void FillCombinedLookups()
        {
            foreach (var cl in GetCombinedLookups())
            {
                var reader = cl.Item1;
                var name = cl.Item2;
                Console.WriteLine(name + " - filling");

                var lookup = new Lookup();
                while (reader.Read())
                {
                    lookup.Add(new LookupValue
                    {
                        ConceptId = int.Parse(reader[0].ToString()),
                        SourceCode = reader[1].ToString(),
                        ValidStartDate = DateTime.MinValue,
                        ValidEndDate = DateTime.MaxValue,
                        Ingredients = []
                    });
                }

                _lookups.Add(name, lookup);
                Console.WriteLine(name + " - Done (" + _lookups[name].KeysCount + ")");
            }
        }

        public DataReaderInfo GetPregnancyDrug()
        {
            var sql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Folder,
                    @"Core\Lookups\PregnancyDrug.sql"));

            sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

            Console.WriteLine("PregnancyDrug - Loading...");
            var connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString);
            var command = new OdbcCommand(sql, connection) { CommandTimeout = 0 };
            var reader = command.ExecuteReader();

            return new DataReaderInfo(connection, command, reader, "PregnancyDrug");
        }

        private void FillPregnancyDrug()
        {
            using (var ri = GetPregnancyDrug())
            {
                Console.WriteLine("PregnancyDrug - filling");
                var lookup = new Lookup();
                while (ri.DataReader.Read())
                {
                    lookup.Add(new LookupValue
                    {
                        ConceptId = int.Parse(ri.DataReader[0].ToString()),
                        SourceCode = ri.DataReader[0].ToString()
                    });
                }
                _lookups.Add("PregnancyDrug", lookup);
            }
            Console.WriteLine("PregnancyDrug - Done");
        }

        private IEnumerable<DataReaderInfo> GetDataReaders(IEnumerable<EntityDefinition> definitions)
        {
            if (definitions != null)
            {
                foreach (var ed in definitions)
                {
                    ed.Vocabulary = this;

                    if (ed.Concepts == null) continue;

                    foreach (var c in ed.Concepts)
                    {
                        if (c.ConceptIdMappers == null) continue;

                        foreach (var conceptIdMapper in c.ConceptIdMappers)
                        {
                            if (!string.IsNullOrEmpty(conceptIdMapper.Lookup))
                            {
                                if (!_lookups.ContainsKey(conceptIdMapper.Lookup))
                                {
                                    string sql = string.Empty;
                                    var vendorFolder = Settings.Settings.Current.Building.Vendor.Folder;

                                    var baseSql = string.Empty;
                                    var sqlFileDestination = string.Empty;


                                    baseSql = File.ReadAllText(Path.Combine(Settings.Settings.Current.Folder,
                                        @"Core\Lookups\Base.sql"));

                                    sqlFileDestination = Path.Combine(Settings.Settings.Current.Folder, "Core", "Transformation",
                                        vendorFolder, "Lookups", conceptIdMapper.Lookup + ".sql");

                                    sql = File.ReadAllText(sqlFileDestination);


                                    sql = sql.Replace("{base}", baseSql);
                                    sql = sql.Replace("{sc}", Settings.Settings.Current.Building.VocabularySchemaName);

                                    OdbcConnection connection;
                                    OdbcCommand command;
                                    IDataReader reader;
                                    try
                                    {
                                        Console.WriteLine(conceptIdMapper.Lookup + " - Loading...");
                                        connection = SqlConnectionHelper.OpenOdbcConnection(Settings.Settings.Current.Building.VocabularyConnectionString);
                                        command = new OdbcCommand(sql, connection) { CommandTimeout = 0 };
                                        reader = command.ExecuteReader();

                                    }
                                    catch (Exception)
                                    {
                                        Console.WriteLine("Lookup error [file]: " + sqlFileDestination);
                                        Console.WriteLine("Lookup error [query]: " + sql);
                                        throw;
                                    }

                                    yield return new DataReaderInfo(connection, command, reader, conceptIdMapper.Lookup);
                                }
                            }
                        }
                    }
                }
            }
        }

        public IEnumerable<DataReaderInfo> GetHealthSystemDataReaders()
        {
            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                foreach (var item in GetDataReaders(qd.CareSites))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.Providers))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.Locations))
                {
                    yield return item;
                }
            }
        }

        public IEnumerable<DataReaderInfo> GetClinicalDataReaders()
        {
            foreach (var qd in Settings.Settings.Current.Building.SourceQueryDefinitions)
            {
                foreach (var item in GetDataReaders(qd.Persons))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.ConditionOccurrence))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.DrugExposure))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.ProcedureOccurrence))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.Observation))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.VisitOccurrence))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.VisitDetail))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.Death))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.Measurement))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.DeviceExposure))
                {
                    yield return item;
                }


                foreach (var item in GetDataReaders(qd.Note))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.VisitCost))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.ProcedureCost))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.DeviceCost))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.ObservationCost))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.MeasurementCost))
                {
                    yield return item;
                }

                foreach (var item in GetDataReaders(qd.DrugCost))
                {
                    yield return item;
                }
            }
        }

        private void Fill(IEnumerable<DataReaderInfo> readers)
        {
            foreach (var dr in readers)
            {
                using (dr)
                {
                    Console.WriteLine(dr.Name + " - filling");
                    var lookup = new Lookup();
                    while (dr.DataReader.Read())
                    {
                        var lv = CreateLookupValue(dr.DataReader);
                        lookup.Add(lv);
                    }

                    _lookups.Add(dr.Name, lookup);
                    Console.WriteLine(dr.Name + " - Done (" + _lookups[dr.Name].KeysCount + ")");
                }
            }
        }
        

        /// <summary>
        /// Fill vocabulary for source to conceptId mapping
        /// </summary>
        /// <param name="forLookup">true - fill vocab. for: CareSites, Providers, Locations; false - rest of us</param>
        public void Fill(bool forLookup)
        {
            _genderConcepts = new GenderLookup();
            _genderConcepts.Load();

            _pregnancyConcepts = new PregnancyConcepts(Settings.Settings.Current.Folder);

            FillCombinedLookups();

            if (forLookup)
            {
                Fill(GetHealthSystemDataReaders());
            }
            else
            {
                Fill(GetClinicalDataReaders());
            }

            FillPregnancyDrug();
        }

        public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
        {
            if (!_lookups.TryGetValue(key, out Lookup value))
                return [];

            return value.LookupValues(sourceValue, eventDate).ToList();
        }

        public int? LookupGender(string genderSourceValue)
        {
            var res = _genderConcepts.LookupValue(genderSourceValue);
            if (!res.HasValue || res.Value == 0)
                return 8551; // UNKNOWN

            return res;
        }

        public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId)
        {
            return _pregnancyConcepts.GetConcepts(conceptId);
        }

        public string GetSourceVocabularyId(long conceptId)
        {
            throw new NotImplementedException();
        }

        public string GetSourceDomain(long conceptId)
        {
            throw new NotImplementedException();
        }
    }
}