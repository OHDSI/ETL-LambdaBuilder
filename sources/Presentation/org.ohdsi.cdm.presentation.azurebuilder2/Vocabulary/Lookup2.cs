using nietras.SeparatedValues;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Lookups;
using System.IO.Compression;

namespace org.ohdsi.cdm.presentation.azurebuilder
{

    public class Lookup2
    {
        private Dictionary<string, LookupValue2[]> _lookup = [];
        private Dictionary<string, List<LookupValue2>> _lookupTmp = [];

        private Dictionary<string, SourceConcepts2[]> _sourceConcepts = [];
        private Dictionary<string, List<SourceConcepts2>> _sourceConceptsTmp = [];

        private Dictionary<string, List<long>> _ingredientsTmp = [];

        private readonly Dictionary<string, long[]> _ingredients = [];

        private Dictionary<string, List<long>> _valueAsConceptIdsTmp = [];
        private readonly Dictionary<string, long[]> _valueAsConceptIds = [];

        public int KeysCount
        {
            get
            {
                if (_lookup == null)
                    return 0;

                return _lookup.Keys.Count;
            }
        }

        private static string GetStringValue(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            var v = value.Trim();
            
            if (v == @"\N")
                return null;

            return v;
        }

        private static bool IsNullOrEmpty(string value)
        {
            if (string.IsNullOrEmpty(value))
                return true;

            if (value.Trim() == @"\N")
                return true;

            return false;
        }

        public void Fill(Stream stream)
        {
            using var bufferedStream = new BufferedStream(stream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = Sep.Reader(o => o with
            {
                HasHeader = false,
                Trim = SepTrim.All,
                Unescape = true
            }).From(gzipStream);
            foreach (var row in reader)
            {
                var sourceCode = GetStringValue(row[0].ToString());
                if (string.IsNullOrEmpty(sourceCode))
                    continue;

                long conceptId = -1;
                if (row[1].TryParse<long>(out var cptId))
                    conceptId = cptId;

                if (row.ColCount < 3 || !row[3].TryParse<DateTime>(out var validStartDate))
                    validStartDate = DateTime.MinValue;

                if (row.ColCount < 4 || !row[4].TryParse<DateTime>(out var validEndDate))
                    validEndDate = DateTime.MaxValue;

                string domain = null;
                if (row.ColCount != 2)
                {
                    domain = GetStringValue(row[2].ToString());
                }

                var lv = new LookupValue2
                {
                    ConceptId = conceptId,
                    SourceCode = sourceCode,
                    Domain = domain != null ? string.Intern(domain) : null,
                    ValidStartDate = (uint)(validStartDate.Year * 10000 + validStartDate.Month * 100 + validStartDate.Day),
                    ValidEndDate = (uint)(validEndDate.Year * 10000 + validEndDate.Month * 100 + validEndDate.Day),
                };

                try
                {
                    if (!_lookupTmp.ContainsKey(sourceCode))
                        _lookupTmp.Add(sourceCode, []);
                }
                catch (Exception e)
                {
                    Console.WriteLine("sourceCode" + sourceCode);
                    Console.WriteLine("Keys.Count" + _lookupTmp.Keys.Count);
                    throw e;
                }

                _lookupTmp[sourceCode].Add(lv);

                if (row.ColCount > 6)
                {
                    var sourceConceptId = IsNullOrEmpty(row[6].ToString())
                        ? 0
                        : row[6].Parse<long>();

                    var sourceValidStartDate = DateTime.MinValue;
                    var sourceValidEndDate = DateTime.MaxValue;
                    var invalidReason = char.MinValue;

                    if (row.ColCount > 7)
                    {
                        row[7].TryParse<DateTime>(out sourceValidStartDate);
                        row[8].TryParse<DateTime>(out sourceValidEndDate);
                    }

                    if (row.ColCount > 11)
                    {
                        if (!IsNullOrEmpty(row[11].ToString()))
                        {
                            invalidReason = row[11].Span[0];
                        }
                    }

                    if (!_sourceConceptsTmp.ContainsKey(sourceCode))
                        _sourceConceptsTmp.Add(sourceCode, []);

                    _sourceConceptsTmp[sourceCode].Add(new SourceConcepts2
                    {
                        ConceptId = sourceConceptId,
                        ValidStartDate = sourceValidStartDate.ToUint(),
                        ValidEndDate = sourceValidEndDate.ToUint(),
                        InvalidReason = invalidReason
                    });

                    if (!IsNullOrEmpty(row[9].ToString()) && row[9].TryParse<long>(out var ingredient))
                    {
                        if (!_ingredientsTmp.ContainsKey(sourceCode))
                            _ingredientsTmp.Add(sourceCode, []);

                        _ingredientsTmp[sourceCode].Add(ingredient);
                    }
                }

                if (row.ColCount > 10)
                {
                    if (!IsNullOrEmpty(row[10].ToString()) &&
                        row[10].TryParse<long>(out var valueAsConceptId))
                    {
                        if (!_valueAsConceptIdsTmp.ContainsKey(sourceCode))
                            _valueAsConceptIdsTmp.Add(sourceCode, []);

                        _valueAsConceptIdsTmp[sourceCode].Add(valueAsConceptId);
                    }
                }
            }

            Compress();
        }

        private void Compress()
        {
            foreach (var key in _ingredientsTmp.Keys)
            {
                _ingredients.Add(key, [.. _ingredientsTmp[key].Distinct()]);
            }
            _ingredientsTmp.Clear();
            _ingredientsTmp = null;

            foreach (var key in _valueAsConceptIdsTmp.Keys)
            {
                _valueAsConceptIds.Add(key, [.. _valueAsConceptIdsTmp[key].Distinct()]);
            }
            _valueAsConceptIdsTmp.Clear();
            _valueAsConceptIdsTmp = null;

            _ingredients.TrimExcess();
            _valueAsConceptIds.TrimExcess();

            _lookup = new Dictionary<string, LookupValue2[]>();
            foreach (var key in _lookupTmp.Keys)
            {
                _lookup.Add(key, _lookupTmp[key].Distinct().ToArray());
            }
            _lookup.TrimExcess();

            _lookupTmp.Clear();
            _lookupTmp.TrimExcess();
            _lookupTmp = null;

            _sourceConcepts = new Dictionary<string, SourceConcepts2[]>();
            foreach (var key in _sourceConceptsTmp.Keys)
            {
                _sourceConcepts.Add(key, _sourceConceptsTmp[key].Distinct().ToArray());
            }
            _sourceConcepts.TrimExcess();

            _sourceConceptsTmp.Clear();
            _sourceConceptsTmp.TrimExcess();
            _sourceConceptsTmp = null;
        }

        public IEnumerable<LookupValue> LookupValues(string sourceCode, DateTime? eventDate)
        {
            if (_lookup.ContainsKey(sourceCode))
            {
                foreach (var lookupValue in GetValues(sourceCode, eventDate))
                    yield return lookupValue;
            }
            else
                yield return new LookupValue { ConceptId = null };
        }

        private IEnumerable<LookupValue> GetValues(string sourceCode, DateTime? eventDate)
        {
            foreach (var lv in _lookup[sourceCode])
            {
                var l = new LookupValue
                {
                    ConceptId = GetConceptId(lv),
                    Domain = lv.Domain,
                    SourceCode = lv.SourceCode,
                    ValidStartDate = GetDate(lv.ValidStartDate, DateTime.MinValue),
                    ValidEndDate = GetDate(lv.ValidEndDate, DateTime.MaxValue),

                    Ingredients = GetIngredients(sourceCode),
                    ValueAsConceptIds = GetValueAsConceptIds(sourceCode),
                    SourceConcepts = GetSourceConcepts(sourceCode),
                };

                if (!eventDate.HasValue || eventDate.Value == DateTime.MinValue)
                {
                    yield return l;
                }
                else
                {
                    if (eventDate.Value.Between(l.ValidStartDate, l.ValidEndDate))
                    {
                        yield return l;
                    }
                    else
                    {
                        if (l.ConceptId.HasValue)
                            l.ConceptId = 0;

                        yield return l;
                    }
                }
            }
        }

        private static long? GetConceptId(LookupValue2 lv)
        {
            long? conceptId = lv.ConceptId;
            if (lv.ConceptId == -1)
                conceptId = null;
            return conceptId;
        }

        private HashSet<SourceConcepts> GetSourceConcepts(string sourceCode)
        {
            HashSet<SourceConcepts> sourceConcepts;
            if (!string.IsNullOrEmpty(sourceCode) && _sourceConcepts.ContainsKey(sourceCode))
            {
                sourceConcepts = new HashSet<SourceConcepts>(_sourceConcepts[sourceCode].Length);
                foreach (var sc2 in _sourceConcepts[sourceCode])
                {
                    var sc = new SourceConcepts()
                    {
                        ConceptId = sc2.ConceptId,
                        ValidStartDate = GetDate(sc2.ValidStartDate, DateTime.MinValue),
                        ValidEndDate = GetDate(sc2.ValidEndDate, DateTime.MaxValue),
                        InvalidReason = sc2.InvalidReason
                    };

                    sourceConcepts.Add(sc);
                }
            }
            else
                sourceConcepts = new HashSet<SourceConcepts>(0);

            return sourceConcepts;
        }

        private static DateTime GetDate(uint date, DateTime defaultValue)
        {
            DateTime result = defaultValue;
            if (date > 0)
            {
                result = date.RecoverDate();
            }

            return result;
        }

        private HashSet<long> GetValueAsConceptIds(string sourceCode)
        {
            HashSet<long> valueAsConceptIds;
            if (!string.IsNullOrEmpty(sourceCode) && _valueAsConceptIds.ContainsKey(sourceCode))
            {
                valueAsConceptIds = [.. _valueAsConceptIds[sourceCode]];
            }
            else
                valueAsConceptIds = new HashSet<long>(0);
            return valueAsConceptIds;
        }

        private HashSet<long> GetIngredients(string sourceCode)
        {
            HashSet<long> ingredients;
            if (!string.IsNullOrEmpty(sourceCode) && _ingredients.ContainsKey(sourceCode))
            {
                ingredients = [.. _ingredients[sourceCode]];
            }
            else
                ingredients = new HashSet<long>(0);
            return ingredients;
        }
    }
}