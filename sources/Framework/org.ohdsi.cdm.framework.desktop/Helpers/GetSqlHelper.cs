﻿using System.Text.RegularExpressions;
using org.ohdsi.cdm.framework.desktop.Enums;

namespace org.ohdsi.cdm.framework.desktop.Helpers 
{
   public static class GetSqlHelper
   {
      public static string GetSql(Database sourceDatabase, string query, string schemaName)
      {
         if (string.IsNullOrEmpty(query)) return query;

         switch (sourceDatabase)
         {
            case Database.Mssql:
               query = query.Replace(schemaName + ".procedure ", schemaName + ".[procedure] ");
               query = query.Replace("chr(", "char(");

               foreach (Match match in Regex.Matches(query, @"\[(.*?)\]", RegexOptions.IgnoreCase))
               {
                  var originalValue = match.Value;
                  // Remove [ and ] and replace spaces as _
                  var forRedshift = originalValue.Replace(" ", "_").Replace("-", "_").Trim();
                  query = query.Replace(originalValue, forRedshift);
               }
               break;
            case Database.Redshift:
               foreach (Match match in Regex.Matches(query, @"\[(.*?)\]", RegexOptions.IgnoreCase))
               {
                  var originalValue = match.Value;
                  // Remove [ and ] and replace spaces as _
                  var forRedshift = originalValue.Replace("[", @"""").Replace("]", @"""").Replace(" ", "_").Replace("-", "_").Trim();
                  query = query.Replace(originalValue, forRedshift);
               }
               break;
         }

         return query;
      }
   }
}
