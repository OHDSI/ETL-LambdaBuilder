using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Attributes
{
    public class CdmVersionAttribute(CdmVersions value) : Attribute
    {
        public CdmVersions Value { get; } = value;
    }
}
