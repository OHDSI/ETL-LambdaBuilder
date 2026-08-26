namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class DateExtensions
    {
        public static bool Between(this DateTime input, DateTime date1, DateTime date2)
        {
            return (input >= date1 && input <= date2);
        }

        public static uint ToUint(this DateTime input)
        {
            return (uint)(input.Year * 10000 + input.Month * 100 + input.Day);
        }
    }
}
