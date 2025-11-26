using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RunValidation.Domain
{
    class ChunkReport
    {
        public int BuildingId { get; set; }
        public int ChunkId { get; set; }
        public int OnlyInBatchIdsCount { get; set; }
        public List<int> AllSlicesWithOnlyInBatchIds { get; set; } = new List<int>();
        public List<Person> PersonsWithCalculatedSlice { get; set; } = new List<Person>();
        public List<SliceReport> SliceReports { get; set; } = new List<SliceReport>();
    }
}
