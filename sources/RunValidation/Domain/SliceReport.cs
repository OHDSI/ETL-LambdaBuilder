using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RunValidation.Domain
{
    public class SliceReport
    {
        public int BuildingId { get; set; }
        public int ChunkId { get; set; }
        public int SliceId { get; set; }
        public int WrongCount { get; set; }
        public int Duplicates { get; set; }
        public long ExampleWrongPersonId { get; set; }
    }
}
