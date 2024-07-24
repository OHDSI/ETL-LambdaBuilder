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
            var personIndex = GetPersonIndex(personId);

            return _attempt * 1000000000000000000 + _chunkId * 1000000000000000 + _prefix * 1000000000000 + personIndex * 10000000L + id;
            //subChunks > 99
            //return _attempt * 1000000000000000000 + _chunkId * 1000000000000000 + _prefix * 1000000000000 + personIndex * 10000000L + id;

            //_attempt > 99
            //return _attempt * 100000000000000000 +  _chunkId * 100000000000000 + _prefix *  1000000000000 + personIndex * 10000000L + id;
        }
    }
}