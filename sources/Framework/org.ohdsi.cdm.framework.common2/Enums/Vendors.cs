using System.ComponentModel;
using org.ohdsi.cdm.framework.common2.Attributes;

namespace org.ohdsi.cdm.framework.common2.Enums
{
    public enum Vendors
    {
        [CdmVersion(CdmVersions.V53)]
        [Folder("Truven")]
        [Description("Truven CCAE v5.3.1")]
        [CdmSource("CdmSourceCCAE.sql")]
        Truven_CCAE = 3,

        [CdmVersion(CdmVersions.V53)]
        [Folder("Truven")]
        [Description("Truven MDCR v5.3.1")]
        [CdmSource("CdmSourceMDCR.sql")]
        Truven_MDCR = 4,

        [CdmVersion(CdmVersions.V53)]
        [Folder("Truven")]
        [Description("Truven MDCD v5.3.1")]
        [CdmSource("CdmSourceMDCD.sql")]
        Truven_MDCD = 5,

        [CdmVersion(CdmVersions.V53)] [Folder("CPRD")]
        [Description("Cprd v5.3.1")]
        //[IngredientLevelFileAttribute("IngredientLevelV5_CPRD.sql")]
        CprdV5 = 2,

        [CdmVersion(CdmVersions.V53)] [Folder("Premier")]
        [Description("Premier v5.3.1")]
        PremierV5 = 1,

        //[CdmVersion(CdmVersions.V52)]
        //[Folder("ERAs")]
        //[Description("ERAs")]
        //ErasV5 = 9999, // vendor schema id?

        [CdmVersion(CdmVersions.V53)]
        [Folder("JMDC")]
        [Description("JMDC v5.3.1")]
        JMDCv5 = 13,

        [CdmVersion(CdmVersions.V52)]
        [Folder("SEER")]
        [Description("SEER v5.2")]
        SEER = 16,

        [CdmVersion(CdmVersions.V53)]
        [Folder("OptumExtended")]
        [Description("Optum Extended SES v5.3.1")]
        [CdmSource("CdmSourceSES.sql")]
        OptumExtendedSES = 29,

        [CdmVersion(CdmVersions.V53)]
        [Folder("OptumExtended")]
        [Description("Optum Extended DOD v5.3.1")]
        [CdmSource("CdmSourceDOD.sql")]
        OptumExtendedDOD = 27,

        [CdmVersion(CdmVersions.V53)]
        [Folder("OptumOncology")]
        [Description("Optum Panther v5.3.1")]
        OptumOncology = 23,

        //[CdmVersion(CdmVersions.V52)]
        //[Folder("OptumIntegrated")]
        //[Description("Optum Integrated v5.2")]
        //OptumIntegrated = 12,

        [CdmVersion(CdmVersions.V53)]
        [Folder("HCUP")]
        [Description("HCUP v5.3.1")]
        HCUPv5 = 26,

        [CdmVersion(CdmVersions.V52)]
        [Folder("Cerner")]
        [Description("Cerner v5.2")]
        Cerner = 555,

        [CdmVersion(CdmVersions.V52)]
        [Folder("NHANES")]
        [Description("NHANES v5.2")]
        NHANES = 333
    }
}

