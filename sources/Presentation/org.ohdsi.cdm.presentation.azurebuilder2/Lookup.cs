using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Lookups;
using System.IO.Compression;
using System.Text;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    public class Lookup
    {
        private readonly Dictionary<string, Dictionary<long, LookupValue>> _lookup;

        public int KeysCount
        {
            get
            {
                if (_lookup == null)
                    return 0;

                return _lookup.Keys.Count;
            }
        }

        public Lookup(int capacity)
        {
            _lookup = new Dictionary<string, Dictionary<long, LookupValue>>(capacity, StringComparer.OrdinalIgnoreCase);
        }

        public Lookup()
        {
            _lookup = new Dictionary<string, Dictionary<long, LookupValue>>(StringComparer.OrdinalIgnoreCase);
        }

        public void Add(LookupValue lv)
        {
            if (!_lookup.ContainsKey(lv.SourceCode))
                _lookup.Add(lv.SourceCode, []);

            if (!_lookup[lv.SourceCode].TryGetValue(lv.ConceptId.Value, out LookupValue value))
            {
                value = lv;
                _lookup[lv.SourceCode].Add(lv.ConceptId.Value, value);
            }

            if (lv.Ingredients != null && lv.Ingredients.Count > 0)
                value.Ingredients.Add(lv.Ingredients.First());
        }

        private static string GetStringValue(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            var v = value.Trim();
            
            if (v == @"\N")
                return null;

            return string.Intern(v);
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
            var spliter = new StringSplitter(5);

            using var responseStream = stream;
            using var bufferedStream = new BufferedStream(responseStream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            string line;

            while ((line = reader.ReadLine()) != null)
            {
                if (!string.IsNullOrEmpty(line))
                {
                    spliter.SafeSplit(line, ',');
                    var sourceCode = GetStringValue(spliter.Results[0]);

                    if (string.IsNullOrEmpty(sourceCode))
                        continue;

                    if (!_lookup.ContainsKey(sourceCode))
                        _lookup.Add(sourceCode, []);

                    long conceptId = -1;
                    if (long.TryParse(spliter.Results[1], out var cptId))
                        conceptId = cptId;

                    if (!_lookup[sourceCode].TryGetValue(conceptId, out LookupValue value))
                    {
                        if (!DateTime.TryParse(spliter.Results[3], out var validStartDate))
                            validStartDate = DateTime.MinValue;

                        if (!DateTime.TryParse(spliter.Results[4], out var validEndDate))
                            validEndDate = DateTime.MaxValue;

                        var lv = new LookupValue
                        {
                            ConceptId = conceptId,
                            SourceCode = sourceCode,
                            Domain = GetStringValue(spliter.Results[2]),
                            ValidStartDate = validStartDate,
                            ValidEndDate = validEndDate
                        };

                        value = lv;
                        _lookup[sourceCode].Add(conceptId, value);
                    }

                    if (spliter.Results.Length > 5)
                    {
                        var sourceConceptId = IsNullOrEmpty(spliter.Results[6])
                               ? 0
                               : long.Parse(spliter.Results[6]);

                        var sourceValidStartDate = DateTime.MinValue;
                        var sourceValidEndDate = DateTime.MaxValue;
                        var invalidReason = char.MinValue;

                        if (spliter.Results.Length > 6)
                        {
                            DateTime.TryParse(spliter.Results[7], out sourceValidStartDate);
                            DateTime.TryParse(spliter.Results[8], out sourceValidEndDate);
                        }

                        if (spliter.Results.Length > 11)
                        {
                            if (!IsNullOrEmpty(spliter.Results[11]))
                                invalidReason = spliter.Results[11][0];
                        }

                        value.SourceConcepts.Add(new SourceConcepts
                        {
                            ConceptId = sourceConceptId,
                            ValidStartDate = sourceValidStartDate,
                            ValidEndDate = sourceValidEndDate,
                            InvalidReason = invalidReason
                        });

                        if (!IsNullOrEmpty(spliter.Results[9]) &&
                            long.TryParse(spliter.Results[9], out var ingredient))
                        {
                            value.Ingredients ??= [];
                            value.Ingredients.Add(ingredient);
                        }
                    }

                     if (spliter.Results.Length > 10)
                    {

                        if (!IsNullOrEmpty(spliter.Results[10]) &&
                           long.TryParse(spliter.Results[10], out var valueAsConceptId))
                        {
                            value.ValueAsConceptIds ??= [];
                            value.ValueAsConceptIds.Add(valueAsConceptId);
                        }
                    }
                }
            }

            foreach (var v1 in _lookup.Values)
            {
                foreach (var v2 in v1.Values)
                {
                    v2.SourceConcepts?.TrimExcess();
                    v2.Ingredients?.TrimExcess();
                }

                v1.TrimExcess();
            }

            _lookup.TrimExcess();

            GC.Collect();
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
            foreach (var conceptId in _lookup[sourceCode].Keys)
            {
                var l = new LookupValue
                {
                    ConceptId = _lookup[sourceCode][conceptId].ConceptId,
                    Domain = _lookup[sourceCode][conceptId].Domain,
                    SourceCode = _lookup[sourceCode][conceptId].SourceCode,
                    //SourceConceptId = _lookup[sourceCode][conceptId].SourceConceptId,
                    Ingredients = _lookup[sourceCode][conceptId].Ingredients,
                    ValidStartDate = _lookup[sourceCode][conceptId].ValidStartDate,
                    ValidEndDate = _lookup[sourceCode][conceptId].ValidEndDate,
                    ValueAsConceptIds = _lookup[sourceCode][conceptId].ValueAsConceptIds,
                    //SourceValidStartDate = _lookup[sourceCode][conceptId].SourceValidStartDate,
                    //SourceValidEndDate = _lookup[sourceCode][conceptId].SourceValidEndDate,
                    SourceConcepts = _lookup[sourceCode][conceptId].SourceConcepts,
                };

                if (l.ConceptId == -1)
                    l.ConceptId = null;

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

    }
}