﻿using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class DeviceExposure : Entity, IEquatable<DeviceExposure>
    {
        public string ProductionId { get; set; }

        public long? UnitConceptId { get; set; }
        public long? UnitSourceConceptId { get; set; }
        public string UnitSourceValue { get; set; }

        public string UniqueDeviceId { get; set; }
        public int? Quantity { get; set; }

        public List<DeviceCost> DeviceCosts { get; set; }

        public DeviceExposure(IEntity ent)
        {
            var drg = ent as DrugExposure;
            if (drg != null && drg.Quantity.HasValue && drg.Quantity < int.MaxValue)
            {
                Quantity = Convert.ToInt32(drg.Quantity);
            }

            Init(ent);
        }

        public bool Equals(DeviceExposure other)
        {
            return this.PersonId.Equals(other.PersonId) &&
                   this.ConceptId == other.ConceptId &&
                   this.TypeConceptId == other.TypeConceptId &&
                   this.SourceValue == other.SourceValue &&
                   this.StartDate == other.StartDate &&
                   this.SourceConceptId == other.SourceConceptId &&
                   this.UniqueDeviceId == other.UniqueDeviceId &&
                   this.Quantity == other.Quantity &&
                   this.ProviderId == other.ProviderId &&
                   this.ValueAsConceptId == other.ValueAsConceptId &&
                   this.EndDate == other.EndDate;

        }

        public override int GetHashCode()
        {
            return PersonId.GetHashCode() ^
                   ConceptId.GetHashCode() ^
                   TypeConceptId.GetHashCode() ^
                   ProviderId.GetHashCode() ^
                   Quantity.GetHashCode() ^
                   (SourceValue != null ? SourceValue.GetHashCode() : 0) ^
                   SourceConceptId.GetHashCode() ^
                   (UniqueDeviceId != null ? UniqueDeviceId.GetHashCode() : 0) ^
                   ValueAsConceptId.GetHashCode() ^
                   (StartDate.GetHashCode()) ^
                   (EndDate.GetHashCode());
        }

        public override EntityType GeEntityType()
        {
            return EntityType.DeviceExposure;
        }
    }
}