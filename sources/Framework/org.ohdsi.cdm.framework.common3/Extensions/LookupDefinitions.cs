using org.ohdsi.cdm.framework.common.Definitions;
using System.IO;
using System.Xml.Serialization;

namespace org.ohdsi.cdm.framework.common.Extensions
{
    public static class LookupDefinitionExtensions
    {
        public static LookupDefinition DeserializeFromXml(this LookupDefinition ld, string xml)
        {
            var ser = new XmlSerializer(ld.GetType());
            using var tr = new StringReader(xml);
            return (LookupDefinition)ser.Deserialize(tr);
        }
    }
}
