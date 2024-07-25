using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Validators
{
    public class CodeValidator
    {
        public static bool IsValidIcd(string code, IcdVer ver)
        {
            return ver == IcdVer.Icd9 ? IsValidIcd9(code) : IsValidIcd10(code);
        }

        public static bool IsValidIcd10(string code)
        {
            return !string.IsNullOrWhiteSpace(code) && code.Length >= 3 && code.Length <= 7;
        }

        public static bool IsValidIcd9(string code)
        {
            if (string.IsNullOrWhiteSpace(code) || code.Length < 3 || code.Length > 5)
                return false;

            for (var i = 1; i < code.Length; i++)
            {
                if (!char.IsDigit(code[i]))
                    return false;
            }

            var firstChar = code[0];
            int.TryParse(firstChar.ToString(), out var firstDigit);

            if (firstChar == 'E' || firstChar == 'e')
            {
                return code.Length >= 4 && code.Length <= 5;
            }

            if (firstChar == 'V' || firstChar == 'v' || (char.IsDigit(firstChar) && firstDigit >= 0 && firstDigit <= 9))
            {
                return code.Length >= 3 && code.Length <= 5;
            }

            return false;
        }
    }
}
