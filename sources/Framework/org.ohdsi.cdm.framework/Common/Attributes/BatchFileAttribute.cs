namespace org.ohdsi.cdm.framework.common.Attributes
{
    public class BatchFileAttribute(string value) : Attribute
    {
        public string Value { get; } = value;
    }
}
