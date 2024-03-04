using System;

namespace org.ohdsi.cdm.framework.common.Attributes
{
    public class CdmSourceAttribute(string value) : Attribute
    {
        public string Value { get; } = value;
    }
}
