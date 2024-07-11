using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace org.ohdsi.cdm.framework.common.Utility
{
    public static class GetStableHashCode
    {
        /// <summary>
        /// This method is for comparing hashes across different runs to ensure the data is the same before and after code changes
        /// </summary>
        /// <returns></returns>
        public static int GetHashCodeSha256(string source)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(source));
                return BitConverter.ToInt32(hashBytes, 0);
            }
        }
    }
}
