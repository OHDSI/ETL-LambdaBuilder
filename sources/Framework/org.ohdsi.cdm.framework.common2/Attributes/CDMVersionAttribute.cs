using System;
using org.ohdsi.cdm.framework.common2.Enums;

namespace org.ohdsi.cdm.framework.common2.Attributes
{
    public class CdmVersionAttribute : Attribute
    {
        public CdmVersionAttribute(CdmVersions value)
        {
            this.Value = value;
        }

        public CdmVersions Value { get; }
    }
}
