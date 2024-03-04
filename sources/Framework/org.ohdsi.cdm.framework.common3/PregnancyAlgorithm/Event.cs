using System;

namespace org.ohdsi.cdm.framework.common.PregnancyAlgorithm
{
    public class Event : IEquatable<Event>
    {
        public int EventId { get; set; }
        public Guid Guid { get; set; }
        public long PersonId { get; set; }
        public string Category { get; set; }
        public DateTime Date { get; set; }
        public DateTime OriginalDate { get; set; }
        public decimal? GestValue { get; set; }

        public long ConceptId { get; set; }

        public DateTime EpisodeStartDate
        {
            get
            {
                switch (Category)
                {
                    case "LMP":
                    case "CONTRA":
                        return Date;

                    case "GEST":
                        {
                            try
                            {
                                var r = Date.AddDays(-1 * (double)GestValue.Value + 1);
                            }
                            catch (Exception)
                            {

                                throw;
                            }

                            return Date.AddDays(-1 * (double)GestValue.Value + 1);
                        }

                    case "OVUL":
                    case "OVUL2":
                        return Date.AddDays(-13);

                    case "NULS":
                        return Date.AddDays(-89);

                    case "AFP":
                        return Date.AddDays(-123);

                    case "AMEN":
                    case "UP":
                    case "PCONF":
                    case "AGP":
                    case "PCOMP":
                    case "TA":
                        return Date.AddDays(-55);

                    default:
                        return Date;
                }
            }
        }

        public int Rank
        {
            get
            {
                return Category switch
                {
                    "LMP" => 1,
                    "GEST" => 2,
                    "OVUL" => 3,
                    "OVUL2" => 4,
                    "NULS" => 5,
                    "AFP" => 6,
                    "AMEN" => 80,
                    "UP" => 90,
                    _ => 99,
                };
            }
        }

        public Event()
        {
            Guid = Guid.NewGuid();
        }

        public bool Equals(Event other)
        {
            return this.PersonId.Equals(other.PersonId) &&
                   this.Category == other.Category &&
                   this.Date == other.Date &&
                   this.GestValue == other.GestValue;
        }

        public override int GetHashCode()
        {
            return this.PersonId.GetHashCode() ^
                   this.Category.GetHashCode() ^
                   this.Date.GetHashCode() ^
                   this.GestValue.GetHashCode();
        }
    }
}