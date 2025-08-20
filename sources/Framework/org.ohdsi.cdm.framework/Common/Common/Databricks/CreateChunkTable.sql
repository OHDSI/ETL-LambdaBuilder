CREATE TABLE `{sc}`._chunks (ChunkId int, PartitionId int, PERSON_ID bigint NOT NULL, PERSON_SOURCE_VALUE varchar(50));
 
ALTER TABLE `{sc}`._chunks cluster by (ChunkId, PERSON_ID, PERSON_SOURCE_VALUE);

ALTER TABLE `{sc}`._chunks
set tblproperties (
    'delta.autoOptimize.optimizeWrite' = 'true',
    'delta.autoOptimize.autoCompact' = 'true',
    'delta.targetFileSize' = 134217728
);