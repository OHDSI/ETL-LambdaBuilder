namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class UintExtensions
    {
        public static DateTime RecoverDate(this uint value)
        {
            int year = (int)(value / 10000);
            int month = (int)((value % 10000) / 100);
            int day = (int)(value % 100);

            return new DateTime(year, month, day);
        }
    }
}