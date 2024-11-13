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
        public abstract DateTime? SourceReleaseDate { get; set; }

        #endregion

        #region Methods

        public override string ToString()
        {
            return this.Name;
        }

        public override bool Equals(object? obj)
        {
            if (obj is not Vendor other || other == null)
                return false;

            return this.Name == other.Name;
        }

        public override int GetHashCode()
        {
            return HashCode.Combine(this.Name);
        }

        #endregion
    }
}