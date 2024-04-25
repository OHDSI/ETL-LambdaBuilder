using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;

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
            if (v == "\0")
                return null;

            return string.Intern(v);
        }

        private static bool IsNullOrEmpty(string value)
        {
            if (string.IsNullOrEmpty(value))
                return true;

            if (value.Trim() == "\0")
                return true;

            return false;
        }

        public void Fill(AmazonS3Client client, string bucket, string prefix)
        {
            var spliter = new StringSplitter(5);
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
            using var reader = new StreamReader(gzipStream, Encoding.Default);
            string line;

            while ((line = reader.ReadLine()) != null)
            {
                if (!string.IsNullOrEmpty(line))
                {
                    spliter.SafeSplit(line, '\t');
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

                        if (spliter.Results.Length > 5)
                        {
                            lv.SourceConceptId = IsNullOrEmpty(spliter.Results[6])
                                ? 0
                                : long.Parse(spliter.Results[6]);

                        }

                        value = lv;
                        _lookup[sourceCode].Add(conceptId, value);
                    }

                    if (spliter.Results.Length > 5)
                    {
                        if (!IsNullOrEmpty(spliter.Results[9]) &&
                            long.TryParse(spliter.Results[9], out var ingredient))
                        {
                            value.Ingredients ??= [];
                            value.Ingredients.Add(ingredient);
                        }
                    }

                    if (spliter.Results.Length > 6)
                    {
                        if (!DateTime.TryParse(spliter.Results[7], out var sourceValidStartDate))
                            sourceValidStartDate = DateTime.MinValue;

                        if (!DateTime.TryParse(spliter.Results[8], out var sourceValidEndDate))
                            sourceValidEndDate = DateTime.MaxValue;

                        value.SourceValidStartDate = sourceValidStartDate;
                        value.SourceValidEndDate = sourceValidEndDate;
                    }

                    if (spliter.Results.Length > 10)
                    {
                        if (!IsNullOrEmpty(spliter.Results[10]))
                            value.ValueAsConceptId = long.Parse(spliter.Results[10]);
                    }
                }
            }

            foreach (var v1 in _lookup.Values)
            {
                foreach (var v2 in v1.Values)
                {
                    v2.Ingredients?.TrimExcess();
                }
            }

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
                    SourceConceptId = _lookup[sourceCode][conceptId].SourceConceptId,
                    Ingredients = _lookup[sourceCode][conceptId].Ingredients,
                    ValidStartDate = _lookup[sourceCode][conceptId].ValidStartDate,
                    ValidEndDate = _lookup[sourceCode][conceptId].ValidEndDate,
                    ValueAsConceptId = _lookup[sourceCode][conceptId].ValueAsConceptId,
                    SourceValidStartDate = _lookup[sourceCode][conceptId].SourceValidStartDate,
                    SourceValidEndDate = _lookup[sourceCode][conceptId].SourceValidEndDate,
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