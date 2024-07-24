namespace org.ohdsi.cdm.framework.common.Attributes
{
    public class FolderAttribute(string value) : Attribute
    {
        public string Value { get; } = value;
    }
}