using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RunValidation.Domain
{
    public class Person(int ChunkId, long PersonId, string? PersonSourceValue = null)
    {
        public int ChunkId { get; set; } = ChunkId;
        public long PersonId { get; set; } = PersonId;
        public string PersonSourceValue { get; set; } = PersonSourceValue;

        public int? SliceId { get; set; }
        public int? InPersonFilesCount { get; set; } = 0;
        public int? InMetadataFilesCount { get; set; } = 0;

        public override string ToString()
        {
            return $"{ChunkId} - {PersonId} - {PersonSourceValue} - {SliceId?.ToString() ?? "???"}";
        }

        public override bool Equals(object? obj)
        {
            if (obj is not Person other || other == null)
                return false;

            return ToString() == other.ToString();
        }

        public override int GetHashCode()
        {
            return ToString().GetHashCode();
        }
    }
}
