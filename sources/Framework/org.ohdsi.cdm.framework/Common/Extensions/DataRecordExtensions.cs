using System.Data;

namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class DataRecordExtensions
    {
        private static string GetErrorMeassge(IDataRecord reader, string fieldName, string methodName)
        {
            return $"DataRecordExtensions.{methodName} | {fieldName}={GetValueString(reader, fieldName)}";
        }

        public static string GetString(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);

                if (value is null)
                    return null;

                //return value;
                return string.Intern(value);
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetString()"), e);
            }
        }

        public static int? GetIntSafe(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);
                if (value is null)
                    return null;

                if (int.TryParse(value, out var result))
                    return result;

                return null;
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetInt()"), e);
            }
        }

        public static int? GetInt(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);
                
                if (string.IsNullOrEmpty(value))
                    return null;

                return Convert.ToInt32(value);
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetInt()"), e);
            }
        }

        public static int? GetInt2(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);
                if (value is null)
                    return null;

                int.TryParse(value, out var res);

                return res;
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetInt()"), e);
            }
        }

        public static decimal? GetDecimal(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);

                if (value is null)
                    return null;

                decimal.TryParse(value, out var res);

                return res;
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetDecimal()"), e);
            }
        }

        public static DateTime GetDateTime(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return DateTime.MinValue;

                var result = reader[fieldName] as DateTime?;

                if (!result.HasValue)
                {
                    var dateTimeString = GetValueString(reader, fieldName);

                    if (!string.IsNullOrEmpty(dateTimeString) && DateTime.TryParse(dateTimeString, out var dateTime))
                    {
                        return dateTime.Date;
                    }
                }
                else
                {
                    return result.Value.Date;
                }

                return DateTime.MinValue;
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetDateTime()"), e);
            }
        }

        public static long? GetLong(this IDataRecord reader, string fieldName)
        {
            try
            {
                if (string.IsNullOrEmpty(fieldName))
                    return null;

                var value = GetValueString(reader, fieldName);

                if (string.IsNullOrEmpty(value))
                    return null;

                return Convert.ToInt64(value);
            }
            catch (Exception e)
            {
                throw new Exception(GetErrorMeassge(reader, fieldName, "GetLong()"), e);
            }
        }

        private static string GetValueString(IDataRecord reader, string fieldName)
        {
            try
            {
                var value = reader[fieldName];

                if (value is DBNull || value is null)
                    return null;

                var valStr = value.ToString().Trim();
                if (valStr == "\\N")
                    return null;

                return valStr;
            }
            catch (Exception e)
            {
                throw new Exception($"DataRecordExtensions.{"GetValue()"} | {fieldName}", e);
            }
        }
    }
}
