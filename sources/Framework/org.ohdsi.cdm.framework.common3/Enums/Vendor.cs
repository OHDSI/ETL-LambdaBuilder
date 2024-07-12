using System;
using System.Linq;
using org.ohdsi.cdm.framework.common.Utility;

namespace org.ohdsi.cdm.framework.common.Enums
{
    public abstract class Vendor
    {

        #region Properties

        public abstract string Name { get; }
        public abstract string Folder { get; }
        public abstract string Description { get; }
        public abstract string CdmSource { get; }
        public abstract CdmVersions CdmVersion { get; }
        public abstract int PersonIdIndex { get; }
        public abstract string PersonTableName { get; }
        public abstract string Citation { get; }
        public abstract string Publication { get; }

        #endregion

        #region Methods

        public static Vendor CreateVendorInstanceByName(string name)
        {
            LoadReferencedAssemblies.DoIfNotLoadedAlready();

            var vendorTypes = AppDomain.CurrentDomain.GetAssemblies()
                .Where(a => a.ManifestModule.Name == "org.ohdsi.cdm.framework.etl.dll")
                .SelectMany(assembly => assembly.GetTypes())
                .Where(t => t.IsSubclassOf(typeof(Vendor))
                        && !t.IsAbstract);

            var vendorType = vendorTypes.FirstOrDefault(a => a.Name.Contains(name, StringComparison.CurrentCultureIgnoreCase));

            if (vendorType == null)
            {
                name = name.ToLower().Replace("v5", "").Replace("full", "");

                vendorType = vendorTypes.FirstOrDefault(a => a.Name.Contains(name, StringComparison.CurrentCultureIgnoreCase));
            }

            var handle = (Vendor)Activator.CreateInstance(vendorType);

            return handle;
        }

        public override string ToString()
        {
            return this.Name;
        }

        public string ToStringFull()
        {
            var res = string.Join(" - ", new string[]
               {
                this.Name,
                this.Folder,
                this.Description,
                this.CdmSource,
                this.CdmVersion.ToString(),
                this.PersonIdIndex.ToString(),
                this.PersonTableName,
                this.Citation,
                this.Publication
               });
            return res;
        }

        public override bool Equals(object obj)
        {
            var objCast = (Vendor)obj;
            return this.ToStringFull() == objCast.ToStringFull();
        }

        public override int GetHashCode()
        {
            return this.ToStringFull().GetHashCode();
        }

        #endregion
    }
}