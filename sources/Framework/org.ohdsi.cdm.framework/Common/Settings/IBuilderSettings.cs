namespace org.ohdsi.cdm.framework.common.Settings
{
    public interface IBuilderSettings
    {
        int? Id { get; set; }

        int? BuildingId { get; set; }

        int MaxDegreeOfParallelism { get; set; }

        int BatchSize { get; set; }

        string Folder { get; set; }

        string MachineName { get; }

        bool IsLead { get; }

        bool IsNew { get; set; }

        string Version { get; }
    }
}
