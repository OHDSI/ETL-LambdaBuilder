namespace org.ohdsi.cdm.framework.desktop3.Monitor
{
    enum ChunkState
    {
        RunningLambda,
        RunningLocal,
        Timeout,
        Validating,
        Valid,
        Ivalid,
        Error
    }
}