﻿using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;
using System.Reflection;
using System.Text;

namespace org.ohdsi.cdm.framework.common.Lookups
{
    public class PregnancyConcepts
    {
        public int KeyCount
        {
            get { return _dictionary.Keys.Count; }
        }

        private readonly Dictionary<long, List<PregnancyConcept>> _dictionary;
        public PregnancyConcepts(string folder)
        {
            _dictionary = [];

            string[] resourceNames = Assembly.GetExecutingAssembly().GetManifestResourceNames();
            var pregnancyConceptsResource = resourceNames.First(a => a.EndsWith("npa_pregnancy_concepts.csv"));
            using var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(pregnancyConceptsResource);
            using var reader = new StreamReader(stream, Encoding.Default);
            using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = true,
                Delimiter = ",",
                Encoding = Encoding.UTF8
            });
            int cnt = 0;
            while (csv.Read())
            {
                cnt++;
                if (cnt == 1)
                    continue;

                var conceptId = long.Parse(csv.GetField(0));
                var category = csv.GetField(1).Trim();
                var dataValue = csv.GetField(2).Trim();
                int? gestValue = null;

                if (int.TryParse(csv.GetField(3), out int gv))
                {
                    gestValue = gv;
                }

                if (!_dictionary.ContainsKey(conceptId))
                    _dictionary.Add(conceptId, []);

                _dictionary[conceptId].Add(
                    new PregnancyConcept
                    {
                        ConceptId = conceptId,
                        Category = category,
                        DataValue = dataValue,
                        GestValue = gestValue
                    });
            }
            _dictionary.TrimExcess();
        }

        public IEnumerable<PregnancyConcept> GetConcepts(long conceptId)
        {
            if (_dictionary.TryGetValue(conceptId, out List<PregnancyConcept> value))
            {
                foreach (var pregnancyConcept in value)
                {
                    yield return pregnancyConcept;
                }
            }

            yield return null;
        }
    }
}