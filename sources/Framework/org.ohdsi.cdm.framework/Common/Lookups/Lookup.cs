using Amazon.S3;
using Amazon.S3.Model;
using nietras.SeparatedValues;
using org.ohdsi.cdm.framework.common.Extensions;
using System.IO.Compression;

namespace org.ohdsi.cdm.framework.common.Lookups
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
            if (v == "\\N")
                return null;

            return string.Intern(v);
        }

        private static bool IsNullOrEmpty(string value)
        {
            if (string.IsNullOrEmpty(value))
                return true;

            if (value.Trim() == "\\N")
                return true;

            return false;
        }

        public void Fill(AmazonS3Client client, string bucket, string prefix)
        {
            var result = new List<string>();

            Console.WriteLine(bucket);
            Console.WriteLine(prefix);

            if (prefix.Contains(".gz"))
                result.Add(prefix);
            else
                result.Add(prefix + ".gz");

            Console.WriteLine(bucket);
            Console.WriteLine(result[0]);

            var getObjectRequest = new GetObjectRequest
            {
                BucketName = bucket,
                Key = result[0]
            };
            var getObject = client.GetObjectAsync(getObjectRequest);
            getObject.Wait();

            Console.WriteLine("Done 2");

            using var responseStream = getObject.Result.ResponseStream;
            using var bufferedStream = new BufferedStream(responseStream);
            using var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress);
            using var reader = Sep.Reader(o => o with { 
                HasHeader = false, 
                Trim = SepTrim.All,
                Unescape = true
            }).From(gzipStream);
            foreach (var row in reader)
            {

                var sourceCode = GetStringValue(row[0].ToString());

                if (string.IsNullOrEmpty(sourceCode))
                    continue;

                if (!_lookup.ContainsKey(sourceCode))
                    _lookup.Add(sourceCode, []);

                long conceptId = -1;
                if (row[1].TryParse<long>(out var cptId))
                    conceptId = cptId;

                if (!_lookup[sourceCode].TryGetValue(conceptId, out LookupValue value))
                {
                    if (row.ColCount < 3 || !row[3].TryParse<DateTime>(out var validStartDate))
                        validStartDate = DateTime.MinValue;

                    if (row.ColCount < 4 || !row[4].TryParse<DateTime>(out var validEndDate))
                        validEndDate = DateTime.MaxValue;

                    string domain = null;
                    if (row.ColCount != 2)
                    {
                        domain = GetStringValue(row[2].ToString());
                    }

                    var lv = new LookupValue
                    {
                        ConceptId = conceptId,
                        SourceCode = sourceCode,
                        Domain = domain,
                        ValidStartDate = validStartDate,
                        ValidEndDate = validEndDate
                    };

                    value = lv;
                    _lookup[sourceCode].Add(conceptId, value);
                }

                if (row.ColCount > 5)
                {
                    var sourceConceptId = IsNullOrEmpty(row[6].ToString())
                           ? 0
                           : row[6].Parse<long>();

                    var sourceValidStartDate = DateTime.MinValue;
                    var sourceValidEndDate = DateTime.MaxValue;
                    var invalidReason = char.MinValue;

                    if (row.ColCount > 6)
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

                    value.SourceConcepts.Add(new SourceConcepts
                    {
                        ConceptId = sourceConceptId,
                        ValidStartDate = sourceValidStartDate,
                        ValidEndDate = sourceValidEndDate,
                        InvalidReason = invalidReason
                    });

                    if (!IsNullOrEmpty(row[9].ToString()) &&
                       row[9].TryParse<long>(out var ingredient))
                    {
                        value.Ingredients ??= [];
                        value.Ingredients.Add(ingredient);
                    }
                }

                if (row.ColCount > 10)
                {
                    if (!IsNullOrEmpty(row[10].ToString()) &&
                        row[10].TryParse<long>(out var valueAsConceptId))
                    {
                        value.ValueAsConceptIds ??= [];
                        value.ValueAsConceptIds.Add(valueAsConceptId);
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