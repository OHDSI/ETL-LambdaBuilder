using org.ohdsi.cdm.framework.common.Attributes;
using System;
using System.ComponentModel;

namespace org.ohdsi.cdm.framework.common.Enums
{
    public class Vendor
    {
        public enum Vendors
        {
            [Description("None")]
            None,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Truven")]
            [Description("Truven CCAE v5.4")]
            [CdmSource("CdmSourceCCAE.sql")]
            Truven_CCAE = 3,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Truven")]
            [Description("Truven MDCR v5.4")]
            [CdmSource("CdmSourceMDCR.sql")]
            Truven_MDCR = 4,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Truven")]
            [Description("Truven MDCD v5.4")]
            [CdmSource("CdmSourceMDCD.sql")]
            Truven_MDCD = 5,

            [CdmVersion(CdmVersions.V54)]
            [Folder("CPRD")]
            [Description("Cprd v5.4")]
            CprdV5 = 2,

            [CdmVersion(CdmVersions.V54)]
            [Folder("CPRD")]
            [Description("Cprd v5.4")]
            CprdCovid = 200,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Premier")]
            [Description("Premier v5.4")]
            PremierV5 = 12345,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Premier")]
            [Description("Premier v5.4")]
            PremierFull = 1,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Premier")]
            [Description("Premier Covid v5.4")]
            PremierCovid = 100,

            [CdmVersion(CdmVersions.V54)]
            [Folder("JMDC")]
            [Description("JMDC v5.4")]
            JMDCv5 = 13,

            [CdmVersion(CdmVersions.V54)]
            [Folder("OptumExtended")]
            [Description("Optum Extended SES v5.4")]
            [CdmSource("CdmSourceSES.sql")]
            OptumExtendedSES = 29,

            [CdmVersion(CdmVersions.V54)]
            [Folder("OptumExtended")]
            [Description("Optum Extended DOD v5.4")]
            [CdmSource("CdmSourceDOD.sql")]
            OptumExtendedDOD = 27,

            [CdmVersion(CdmVersions.V54)]
            [Folder("OptumPanther")]
            [Description("Optum Panther v5.4")]
            OptumOncology = 231,

            [CdmVersion(CdmVersions.V54)]
            [Folder("OptumPanther")]
            [Description("Optum Panther v5.4")]
            OptumPantherFull = 23,

            [CdmVersion(CdmVersions.V54)]
            [Folder("OptumPanther")]
            [Description("Optum Panther Covid v5.4")]
            [BatchFile("OncoBatch.sql")]
            OptumPantherCovid = 230,

            [CdmVersion(CdmVersions.V54)]
            [Folder("CprdHES")]
            [Description("CPRD HES v5.4")]
            [CdmSource("CdmSource.sql")]
            CprdHES = 222,

            [CdmVersion(CdmVersions.V54)]
            [Folder("Era")]
            [Description("Era v5.4")]
            [CdmSource("CdmSource.sql")]
            Era = 444,

            [CdmVersion(CdmVersions.V54)]
            [Folder("PregnancyAlgorithm")]
            [Description("PregnancyAlgorithm v5.4")]
            [CdmSource("CdmSource.sql")]
            PregnancyAlgorithm,

            [CdmVersion(CdmVersions.V54)]
            [Folder("HealthVerity")]
            [Description("HealthVerity v5.4")]
            [CdmSource("CdmSource.sql")]
            HealthVerity,

            [CdmVersion(CdmVersions.V54)]
            [Folder("HealthVerity")]
            [Description("HealthVerity v5.4")]
            [CdmSource("CdmSource.sql")]
            HealthVerityCovid,

            [CdmVersion(CdmVersions.V54)]
            [Folder("CprdAurum")]
            [Description("CPRD Aurum v5.4")]
            [CdmSource("CdmSource.sql")]
            CprdAurum,

            [CdmVersion(CdmVersions.V54)]
            [Folder("CDM")]
            [Description("CDM v5.4")]
            [CdmSource("CdmSource.sql")]
            CDM,
        }

        public static Vendors GetVendorByName(string name)
        {
            if (name.Contains("ccae", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.Truven_CCAE;

            if (name.Contains("mdcr", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.Truven_MDCR;

            if (name.Contains("mdcd", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.Truven_MDCD;

            if (name.Contains("aurum", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.CprdAurum;

            if (name.Contains("hes", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.CprdHES;

            if (name.Contains("cprd", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.CprdV5;

            if (name.Contains("premier", StringComparison.CurrentCultureIgnoreCase) && name.Contains("covid", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.PremierCovid;

            if (name.Contains("premier", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.PremierFull;

            if (name.Contains("jmdc", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.JMDCv5;

            if (name.Contains("dod", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.OptumExtendedDOD;

            if (name.Contains("ses", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.OptumExtendedSES;

            if (name.Contains("panther", StringComparison.CurrentCultureIgnoreCase) && name.Contains("covid", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.OptumPantherCovid;

            if (name.Contains("panther", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.OptumPantherFull;

            if (name.Contains("healthverity", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.HealthVerityCovid;

            if (name.Contains("healthverity", StringComparison.CurrentCultureIgnoreCase) && name.Contains("covid", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.HealthVerity;

            if (name.Contains("pregnancyalgorithm", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.PregnancyAlgorithm;

            if (name.Contains("era", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.Era;

            if (name.Equals("cdm", StringComparison.CurrentCultureIgnoreCase))
                return Vendors.CDM;

            return Vendors.None;
        }

        public static int GetPersonIdIndex(Vendors vendor)
        {
            return vendor switch
            {
                Vendors.OptumPantherFull => 1,
                Vendors.OptumPantherCovid => 1,
                _ => 0,
            };
        }

        public static string GetPersonTableName(Vendors vendor)
        {
            return vendor switch
            {
                Vendors.Truven_CCAE => "ENROLLMENT_DETAIL",
                Vendors.Truven_MDCR => "ENROLLMENT_DETAIL",
                Vendors.Truven_MDCD => "ENROLLMENT_DETAIL",
                Vendors.CprdV5 => "Patient",
                Vendors.PremierFull or Vendors.PremierCovid => "pat",
                Vendors.JMDCv5 => "Enrollment",
                Vendors.OptumExtendedSES => "MEMBER_CONTINUOUS_ENROLLMENT",
                Vendors.OptumExtendedDOD => "MEMBER_CONTINUOUS_ENROLLMENT",
                Vendors.OptumPantherFull => "patient",
                Vendors.OptumPantherCovid => "patient",
                Vendors.CprdHES => "patient",
                Vendors.HealthVerity => "enrollment",
                Vendors.PregnancyAlgorithm => "Person",
                Vendors.CDM => "Person",
                Vendors.Era => "Person",
                _ => throw new Exception("GetPersonTableName Unknown Vendor"),
            };
        }
    }
}