using System;
using System.Collections.Generic;

namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class DictionaryExtensions
    {
        public static TValue GetOrAdd<TKey, TValue>(
            this Dictionary<TKey, TValue> dict,
            TKey key, Func<TKey, TValue> generator,
            out bool added)
        {
            while (true)
            {
                if (dict.TryGetValue(key, out TValue value))
                {
                    added = false;
                    return value;
                }

                value = generator(key);
                if (dict.TryAdd(key, value))
                {
                    added = true;
                    return value;
                }
            }
        }
    }
}
