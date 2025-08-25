using org.ohdsi.cdm.framework.common.Base;
using org.ohdsi.cdm.framework.common.Definitions;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Extensions;
using org.ohdsi.cdm.framework.common.Base;
using System.Linq;
using System.Reflection;

namespace org.ohdsi.cdm.framework.common.Utility
{
    public class Resource(string name, string value)
    {
        public string Name { get; set; } = name;
        public string Value { get; set; } = value;
    }

    public static class EtlLibrary
    {
        private static IEnumerable<Assembly> GetETLAssemblies(string path)
        {
            foreach (var assemblyFile in Directory.GetFiles(path, "*.dll"))
            {
                yield return Assembly.LoadFile(assemblyFile);
            }
        }

        private static IEnumerable<Tuple<Assembly, string>> FindAssemblyAndResource(string etlLibraryPath, string name)
        {
            foreach (var assembly in GetETLAssemblies(etlLibraryPath))
            {
                foreach (var resourceName in assembly.GetManifestResourceNames())
                {
                    if (resourceName.Contains(name, StringComparison.OrdinalIgnoreCase))
                        yield return new Tuple<Assembly, string>(assembly, resourceName);
                }
            }
        }

        private static Resource ReadResource(Assembly assembly, string resourceName)
        {
            using Stream stream = assembly.GetManifestResourceStream(resourceName);
            using StreamReader reader = new(stream);

            Console.WriteLine($"ReadResource | assembly: {assembly.GetName().Name}; resourceName: {resourceName} - successfully read");
            var value = reader.ReadToEnd();
            
            return new Resource(resourceName.Split('.').TakeLast(2).First(), value);
        }

        private static Resource GetResource(string etlLibraryPath, string name)
        {
            Console.WriteLine("GetResource: " + name);

            var result = FindAssemblyAndResource(etlLibraryPath, name).FirstOrDefault();
            if (result != null)
            {
                var resource = ReadResource(result.Item1, result.Item2);
                if (resource != null)
                    return resource;
            }

            throw new KeyNotFoundException($"GetResource | Resource: {name}; LibraryPath: {etlLibraryPath} - not exists");
        }

        private static IEnumerable<Resource> GetResources(string etlLibraryPath, string name)
        {
            Console.WriteLine("GetResources: " + name);

            foreach (var ar in FindAssemblyAndResource(etlLibraryPath, name))
            {
                var resource = ReadResource(ar.Item1, ar.Item2);
                if (resource != null)
                    yield return resource;
            }
        }

        private static string NormalizeVendorName(string vendorName)
        {
            string result = vendorName
                .ToLower()
                .Replace("optumPantherFull".ToLower(), "OptumOncology".ToLower())
                .Replace("PersonBuilder".ToLower(), "");
            return result;
        }

        public static void LoadVendorSettings(string etlLibraryPath, IVendorSettings settings)
        {
            Console.WriteLine("LoadVendorSettings | Vendor: " + settings.Vendor);

            var vendorFolder = settings.Vendor.Folder;

            var batch = "Batch.sql";
            Console.WriteLine(vendorFolder + ";" + batch + ";" + settings.Vendor.ToString());

            settings.SourceQueryDefinitions = [];
            settings.CombinedLookupDefinitions = [];
            settings.BatchScript ??= EtlLibrary.GetResource(etlLibraryPath, vendorFolder + "." + batch).Value;

            foreach (var definition in GetResources(etlLibraryPath, vendorFolder + ".Definitions."))
            {
                var qd = new QueryDefinition().DeserializeFromXml(definition.Value);
                qd.FileName = definition.Name;
                settings.SourceQueryDefinitions.Add(qd);
            }

            foreach (var lookup in GetResources(etlLibraryPath, vendorFolder + ".CombinedLookups."))
            {
                var ld = new LookupDefinition().DeserializeFromXml(lookup.Value);
                ld.FileName = lookup.Name;
                settings.CombinedLookupDefinitions.Add(ld);
            }
        }

        public static Vendor CreateVendorInstance(string etlLibraryPath, string name)
        {
            foreach (var assembly in GetETLAssemblies(etlLibraryPath))
            {
                var vendorTypes = assembly.GetTypes().Where(t => t.IsSubclassOf(typeof(Vendor)) && !t.IsAbstract);
                var vendorType = vendorTypes.FirstOrDefault(a => a.Name.Contains(name, StringComparison.CurrentCultureIgnoreCase));

                if (vendorType == null)
                {
                    name = name.ToLower().Replace("v5", "").Replace("full", "");

                    vendorType = vendorTypes.FirstOrDefault(a => a.Name.Contains(name, StringComparison.CurrentCultureIgnoreCase));
                }

                if (vendorType != null)
                {
                    Console.WriteLine("CreateVendorInstance | assembly: " + assembly.GetName().Name);
                    Console.WriteLine("CreateVendorInstance | vendorType: " + vendorType);
                    Console.WriteLine();

                    return Activator.CreateInstance(vendorType) as Vendor;
                }
            }

            throw new KeyNotFoundException($"CreateVendorInstance | Vendor: {name}; LibraryPath: {etlLibraryPath} - not exists");
        }

        public static ConstructorInfo GetBuilderConstructor(string etlLibraryPath, Vendor vendor)
        {
            foreach (var assembly in GetETLAssemblies(etlLibraryPath))
            {
                var builderTypes = assembly.GetTypes().
                    Where(t => t.IsSubclassOf(typeof(PersonBuilder)) && !t.IsAbstract);

                var vendorTypePersonBuilder = builderTypes.FirstOrDefault(a => NormalizeVendorName(a.Name).Contains(NormalizeVendorName(vendor.Name), StringComparison.CurrentCultureIgnoreCase));

                if (vendorTypePersonBuilder != null)
                {
                    return vendorTypePersonBuilder.GetConstructor([typeof(Vendor)]) ?? throw new InvalidOperationException($"No suitable constructor found for type {vendorTypePersonBuilder.Name}");
                }
            }

            throw new KeyNotFoundException($"GetBuilderConstructor | Vendor: {vendor}; LibraryPath: {etlLibraryPath} - not exists");
        }        
    }
}