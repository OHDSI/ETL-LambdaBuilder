using System.Collections.Concurrent;

namespace org.ohdsi.cdm.framework.common.Builder
{
    public class KeyMasterOffsetManager(int chunkId, int prefix, int attempt)
    {
        private readonly ConcurrentDictionary<long, int> PersonIndexes = new();
        private readonly ConcurrentDictionary<int, KeyMasterOffset> KeyOffsets = new();
        private readonly int _chunkId = chunkId;
        private readonly int _prefix = prefix;
        private readonly int _attempt = attempt;
        private int _personIndex = 0;

        public KeyMasterOffset GetKeyOffset(long personId)
        {
            var personIndex = GetPersonIndex(personId);
            KeyOffsets.TryAdd(personIndex, new KeyMasterOffset());

            return KeyOffsets[personIndex];
        }

        public int GetPersonIndex(long personId)
        {
            if (PersonIndexes.TryAdd(personId, 0))
            {
                Interlocked.Increment(ref _personIndex);
                PersonIndexes[personId] = _personIndex;
            }
            else
            {

            }

            return PersonIndexes[personId];
        }

        public long GetId(long personId, long id)
        {
            // In the case when _chunkId >= 1000, id can intersect with _chunkId >= 100 (if it's not the first attempt)
            // workaround for such cases, increase by 100 _prefix (i.e. for chunkId=1000 _prefix = 100 + _prefix, chunkId=2000 _prefix = 200 + _prefix...)
            // Taking into account current experience, datasets with chunks count > 1000 has < 100 prefixes
            // Example: EHR, chunk size = 100k, chunk count ~ 2500, max prefix = 47

            // Id examples: 
            // Issue (ids intersected):
            //      attempt=1; chunkId=121; prefix=0
            //      1121000000000000001
            //      attempt = 0; chunkId = 1121; prefix=0
            //      1121000000000000001
            // Workaround
            //      attempt=1; chunkId=121; prefix=0
            //      1121000000000000001
            //      attempt = 0; chunkId = 1121; prefix=0
            //       121100000000000001 the same as for attempt = 0; chunkId = 112; prefix=100 (max prefix for real case was 47)

            // Note: duplicates will occur when chunks count > 1000 AND prefix count > 1000
            // such a case has never been encountered in practice

            // Max id count:  10,000,000 per person
            // Max person count:  100,000 per prefix
            // Max prefix count if chunks < 1000: 1000
            // Max prefix count if chunks >= 1000: 100
            // Max chunk count:  9,999
            // Max attempt count:  9
            // Max id = 9,223,372,036,854,775,807 (attempt=9, chunkId=223, prefix=372, personIndex=3685, id=4775807)

            var personIndex = GetPersonIndex(personId);

            var thousands = _chunkId / 1000;
            var newChunkId = _chunkId;
            var newPrefix = _prefix;

            if (thousands > 0)
            {
                newChunkId = _chunkId % 1000;
                newPrefix = thousands * 100 + _prefix;
            }

            return _attempt * 1000000000000000000 + newChunkId * 1000000000000000 + newPrefix * 1000000000000 + personIndex * 10000000L + id;
        }
    }
}