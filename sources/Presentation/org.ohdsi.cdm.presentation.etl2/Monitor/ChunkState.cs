namespace org.ohdsi.cdm.presentation.etl.Monitor
{
    enum ChunkState
    {
        Running,
        //RunningLocal,
        Timeout,
        Validating,
        Valid,
        Invalid,
        Error
    }
}