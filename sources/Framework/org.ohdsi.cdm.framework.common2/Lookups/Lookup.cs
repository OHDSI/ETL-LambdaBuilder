using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using Amazon.S3;
using Amazon.S3.Model;
using org.ohdsi.cdm.framework.common2.Extensions;
using org.ohdsi.cdm.framework.common2.Helpers;

namespace org.ohdsi.cdm.framework.common2.Lookups
{
    public class Lookup
    {
        //private readonly Dictionary<string, Dictionary<int, LookupValue>> _lookup = new Dictionary<string, Dictionary<int, LookupValue>>();
        //private readonly Dictionary<string, HashSet<string>> _lookupIgnoreCase = new Dictionary<string, HashSet<string>>(StringComparer.OrdinalIgnoreCase);

        private Dictionary<string, Dictionary<int, LookupValue>> _lookup;

        public Lookup(int capacity)
        {
            _lookup = new Dictionary<string, Dictionary<int, LookupValue>>(capacity, StringComparer.OrdinalIgnoreCase);
        }

        public Lookup()
        {
            _lookup = new Dictionary<string, Dictionary<int, LookupValue>>(StringComparer.OrdinalIgnoreCase);
        }

        public void Add(LookupValue lv)
        {
            if (!_lookup.ContainsKey(lv.SourceCode))
                _lookup.Add(lv.SourceCode, new Dictionary<int, LookupValue>());

            //if (!_lookupIgnoreCase.ContainsKey(lv.SourceCode))
            //    _lookupIgnoreCase.Add(lv.SourceCode, new HashSet<string>());

            //_lookupIgnoreCase[lv.SourceCode].Add(lv.SourceCode);


            if (!_lookup[lv.SourceCode].ContainsKey(lv.ConceptId.Value))
            {
                _lookup[lv.SourceCode].Add(lv.ConceptId.Value, lv);
            }

            if (lv.Ingredients != null && lv.Ingredients.Count > 0)
                _lookup[lv.SourceCode][lv.ConceptId.Value].Ingredients.Add(lv.Ingredients.First());
        }

        private string GetStringValue(string value)
        {
            if (value == null)
                return null;

            var v = value.Trim();
            if (v == "\0")
                return null;

            return string.Intern(v);
        }

        private bool IsNullOrEmpty(string value)
        {
            if (string.IsNullOrEmpty(value))
                return true;

            if (value.Trim() == "\0")
                return true;

            return false;
        }

        public void Fill(AmazonS3Client client, string bucket, string prefix)
        {
            //var prefix = $"Lookup/Truven/{fileName}.txt";
            var spliter = new StringSplitter(5);
            var result = new List<string>();

            var request = new ListObjectsV2Request
            {
                BucketName = bucket,
                Prefix = prefix
            };

            ListObjectsV2Response response;
            do
            {
                var responseTask = client.ListObjectsV2Async(request);
                responseTask.Wait();
                response = responseTask.Result;

                foreach (var entry in response.S3Objects)
                {
                    if (entry.Size > 20)
                    {
                        result.Add(entry.Key);
                    }
                }

                request.ContinuationToken = response.NextContinuationToken;
            } while (response.IsTruncated);

            var getObjectRequest = new GetObjectRequest
            {
                BucketName = bucket,
                Key = result[0]
            };
            var getObject = client.GetObjectAsync(getObjectRequest);
            getObject.Wait();

            using (var responseStream = getObject.Result.ResponseStream)
            using (var bufferedStream = new BufferedStream(responseStream))
            using (var gzipStream = new GZipStream(bufferedStream, CompressionMode.Decompress))
            using (var reader = new StreamReader(gzipStream, Encoding.Default))
            {
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    if (!string.IsNullOrEmpty(line))
                    {
                        spliter.SafeSplit(line, '\t');
                        var sourceCode = GetStringValue(spliter.Results[0]);

                        if (!_lookup.ContainsKey(sourceCode))
                            _lookup.Add(sourceCode, new Dictionary<int, LookupValue>());

                        //if (!_lookupIgnoreCase.ContainsKey(sourceCode))
                        //    _lookupIgnoreCase.Add(sourceCode, new HashSet<string>());

                        //_lookupIgnoreCase[sourceCode].Add(sourceCode);

                        int conceptId = -1;
                        if (int.TryParse(spliter.Results[1], out var cptId))
                            conceptId = cptId;

                        if (!_lookup[sourceCode].ContainsKey(conceptId))
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
                                ValidEndDate = validEndDate,
                                //Ingredients = new HashSet<int>()
                            };

                            if (spliter.Results.Length > 5)
                            {
                                //lv.SourceVocabularyId = GetStringValue(spliter.Results[5]);

                                lv.SourceConceptId = IsNullOrEmpty(spliter.Results[6])
                                    ? 0
                                    : int.Parse(spliter.Results[6]);


                                //if (!DateTime.TryParse(spliter.Results[7], out var validStartDate2))
                                //    validStartDate2 = DateTime.MinValue;

                                //if (!DateTime.TryParse(spliter.Results[8], out var validEndDate2))
                                //    validEndDate2 = DateTime.MaxValue;

                                //lv.SourceValidStartDate = validStartDate2;
                                //lv.SourceValidEndDate = validEndDate2;
                            }

                            _lookup[sourceCode].Add(conceptId, lv);
                        }

                        if (spliter.Results.Length > 5)
                        {
                            if (!IsNullOrEmpty(spliter.Results[9]) &&
                                int.TryParse(spliter.Results[9], out var ingredient))
                            {
                                if (_lookup[sourceCode][conceptId].Ingredients == null)
                                    _lookup[sourceCode][conceptId].Ingredients = new HashSet<int>();

                                _lookup[sourceCode][conceptId].Ingredients.Add(ingredient);
                            }
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
        }

        //public IEnumerable<LookupValue> LookupValues(string sourceCode, DateTime? eventDate, bool caseSensitive)
        //{
        //    if (_lookup.ContainsKey(sourceCode))
        //    {
        //        foreach (var lookupValue in GetValues(sourceCode, eventDate))
        //            yield return lookupValue;
        //    }
        //    else if (!caseSensitive && _lookupIgnoreCase.ContainsKey(sourceCode))
        //    {
        //        foreach (var code in _lookupIgnoreCase[sourceCode])
        //        {
        //            foreach (var lookupValue in GetValues(code, eventDate))
        //            {
        //                yield return lookupValue;
        //            }
        //        }
        //    }
        //    else
        //        yield return new LookupValue { ConceptId = null };
        //}

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
                var l = _lookup[sourceCode][conceptId];

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
