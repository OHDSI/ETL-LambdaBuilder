using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.framework.common.Utility
{
    public static class ReadResources
    {

        /// <summary>
        /// returns null in case the resource was not found
        /// </summary>
        /// <param name="assembly">Assembly which required resource belongs to</param>
        /// <param name="resourceName">Name of the resource file</param>
        /// <returns></returns>
        public static string TryReadResource(Assembly assembly, string resourceName)
        {
            using (Stream stream = assembly.GetManifestResourceStream(resourceName))
            {
                if (stream == null)
                    return null;

                using (StreamReader reader = new StreamReader(stream))
                {
                    var txt = reader.ReadToEnd();
                    if (!string.IsNullOrWhiteSpace(txt))
                        return txt;
                    return null;
                }
            }
        }
    }
}
