using org.ohdsi.cdm.framework.common.Lookups;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.framework.common.Definitions
{
    public class Mapper
    {
        private Condition1 _condition;

        public string Lookup { get; set; }
        public string File { get; set; }
        public string Condition { get; set; }


        public Field[] Fields { get; set; }

        public List<LookupValue> Map(IVocabulary vocabulary, string key, string source, DateTime eventDate)
        {
            if (!string.IsNullOrEmpty(Lookup))
            {
                return vocabulary.Lookup(source, Lookup, eventDate);
            }

            return [new LookupValue()];
        }

        public bool Match(IDataRecord reader)
        {
            _condition ??= new Condition1(Condition);

            return _condition.Match(reader);
        }
    }
}
