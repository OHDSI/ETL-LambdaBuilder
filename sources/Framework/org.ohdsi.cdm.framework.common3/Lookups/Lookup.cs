using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Helpers;
using org.ohdsi.cdm.framework.common.Utility;
using System;
using System.Collections.Frozen;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class Lookup
    {
        private FrozenDictionary<string, FrozenDictionary<long, LookupValue>> _lookup = FrozenDictionary<string, FrozenDictionary<long, LookupValue>>.Empty;

        /// <summary>
        /// Fill must be called later at least once
        /// </summary>
        public Lookup()
        {
        }

        public Lookup(IEnumerable<LookupValue> lookupValues)
        {
            var lookupBuilder = new Dictionary<string, Dictionary<long, LookupValue>>(StringComparer.OrdinalIgnoreCase);

            foreach (var lv in lookupValues)
            {
                if (!lookupBuilder.TryGetValue(lv.SourceCode, out var innerDict))
                {
                    innerDict = new Dictionary<long, LookupValue>();
                    lookupBuilder[lv.SourceCode] = innerDict;
                }

                if (!innerDict.TryGetValue(lv.ConceptId.Value, out var value))
                {
                    value = lv;
                    innerDict[lv.ConceptId.Value] = value;
                }

                if (lv.Ingredients?.Count > 0)
                    value.Ingredients.Add(lv.Ingredients.First());
            }

            _lookup = lookupBuilder.ToDictionary(
                kvp => kvp.Key,
                kvp => kvp.Value.ToFrozenDictionary())
                .ToFrozenDictionary();

            lookupBuilder.Clear();
            lookupBuilder = null;
            GC.Collect();
        }

        public Lookup(AmazonS3Client client, string bucket, string prefix)
        {
            Fill(client, bucket, prefix);
        }

        public int KeysCount => _lookup?.Count ?? 0;


        string ToXML()
        {
            string lookupValues = string.Join("\r\n",
                this._lookup
                    .OrderBy(a => a.Key)
                    .Select(a =>
                        "<" + a.Key + ">"
                        + GetStableHashCode.GetHashCodeSha256(
                            string.Join("\r\n", a.Value.Keys
                                                .OrderBy(b => a.Value[b].ConceptId)
                                                .Select(b => "<" + b + ">"
                                                             + a.Value[b].GetHashCodeSha256()
                                                             + "</" + b + ">"))
                            )
                        + "</" + a.Key + ">"));
            string res = "<Lookup>"
                    + " \r\n" + "<_lookup>" + lookupValues + "</_lookup>"
                    + " \r\n" + "</Lookup>"
                    ;
            return res;
        }


        public int GetHashCodeSha256()
        {
            return GetStableHashCode.GetHashCodeSha256(this.ToXML());
        }

        public void Fill(AmazonS3Client client, string bucket, string prefix)
        {
            var lookupBuilder = _lookup.ToDictionary(
                kvp => kvp.Key,
                kvp => kvp.Value.ToDictionary(),
                StringComparer.OrdinalIgnoreCase);

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

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();
                if (string.IsNullOrEmpty(line))
                    continue;

                spliter.SafeSplit(line, '\t');
                var sourceCode = GetStringValue(spliter.Results[0]);

                if (string.IsNullOrEmpty(sourceCode))
                    continue;

                if (!lookupBuilder.ContainsKey(sourceCode))
                    lookupBuilder.Add(sourceCode, new Dictionary<long, LookupValue>());

                long conceptId = long.TryParse(spliter.Results[1], out long cptId) ? cptId : -1;

                if (!lookupBuilder[sourceCode].TryGetValue(conceptId, out var value))
                {
                    value = new LookupValue
                    {
                        ConceptId = conceptId,
                        SourceCode = sourceCode,
                        Domain = GetStringValue(spliter.Results[2]),
                        ValidStartDate = DateTime.TryParse(spliter.Results[3], out var validStartDate) ? validStartDate : DateTime.MinValue,
                        ValidEndDate = DateTime.TryParse(spliter.Results[4], out var validEndDate) ? validEndDate : DateTime.MaxValue
                    };
                    lookupBuilder[sourceCode][conceptId] = value;
                }

                if (spliter.Results.Length > 6)
                {
                    var sourceConceptId = IsNullOrEmpty(spliter.Results[6] ?? "") 
                        ? 0 
                        : long.Parse(spliter.Results[6]);
                    var sourceValidStartDate = spliter.Results.Length > 7 && DateTime.TryParse(spliter.Results[7], out var srcValidStart) 
                        ? srcValidStart 
                        : DateTime.MinValue;
                    var sourceValidEndDate = spliter.Results.Length > 8 && DateTime.TryParse(spliter.Results[8], out var srcValidEnd) 
                        ? srcValidEnd 
                        : DateTime.MaxValue;
                    var invalidReason = spliter.Results.Length > 11 && !IsNullOrEmpty(spliter.Results[11] ?? "") 
                        ? spliter.Results[11][0] 
                        : char.MinValue;

                    value.SourceConcepts.Add(new SourceConcepts
                    {
                        ConceptId = sourceConceptId,
                        ValidStartDate = sourceValidStartDate,
                        ValidEndDate = sourceValidEndDate,
                        InvalidReason = invalidReason
                    });

                    if (spliter.Results.Length > 9 &&
                        long.TryParse(spliter.Results[9], out var ingredient))
                    {
                        value.Ingredients ??= new HashSet<long>();
                        value.Ingredients.Add(ingredient);
                    }
                }

                if (spliter.Results.Length > 10 && !IsNullOrEmpty(spliter.Results[10]))
                    value.ValueAsConceptId = long.Parse(spliter.Results[10]);
            }

            foreach (var v1 in lookupBuilder.Values)
                foreach (var v2 in v1.Values)
                    v2.Ingredients?.TrimExcess();

            _lookup = lookupBuilder.ToDictionary(
                kvp => kvp.Key,
                kvp => kvp.Value.ToFrozenDictionary())
                .ToFrozenDictionary();

            lookupBuilder.Clear();
            lookupBuilder = null;
            GC.Collect();
        }

        public IEnumerable<LookupValue> LookupValues(string sourceCode, DateTime? eventDate)
        {
            if (_lookup.TryGetValue(sourceCode, out var values))
            {
                var result = values.Values
                .Select(a => new LookupValue
                {
                    ConceptId = (eventDate.HasValue
                                && eventDate.Value != DateTime.MinValue
                                && !eventDate.Value.Between(a.ValidStartDate, a.ValidEndDate)
                                && a.ConceptId.HasValue)
                                ? 0
                                : a.ConceptId,
                    Domain = a.Domain,
                    SourceCode = a.SourceCode,
                    //SourceConceptId = a.SourceConceptId,
                    Ingredients = a.Ingredients != null ? new HashSet<long>(a.Ingredients) : null,
                    ValidStartDate = a.ValidStartDate,
                    ValidEndDate = a.ValidEndDate,
                    ValueAsConceptId = a.ValueAsConceptId,
                    //SourceValidStartDate = a.SourceValidStartDate,
                    //SourceValidEndDate = a.SourceValidEndDate,
                    SourceConcepts = a.SourceConcepts != null ? new HashSet<SourceConcepts>(a.SourceConcepts) : null
                });

                return result;
            }

            return new List<LookupValue> { new LookupValue { ConceptId = null } };
        }


        private static bool IsNullOrEmpty(string value) => string.IsNullOrEmpty(value) || value.Trim() == "\0";


        private static string GetStringValue(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;
            var v = value.Trim();
            return v == "\0" ? null : string.Intern(v);
        }
    }
}
