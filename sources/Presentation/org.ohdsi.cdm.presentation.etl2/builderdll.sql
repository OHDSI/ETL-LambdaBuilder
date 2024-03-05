CREATE TABLE [Chunk](
	[Id] [int] NOT NULL,
	[BuildingId] [int] NOT NULL,
	[BuilderId] [int] NULL,
	[Created] [datetime] NULL,
	[Started] [datetime] NULL,
	[Ended] [datetime] NULL,
	[Failed] [datetime] NULL
);

CREATE TABLE [BuildingSettings](
	[BuildingId] INTEGER PRIMARY KEY AUTOINCREMENT,
	[SourceConnectionString] [nvarchar](250) NOT NULL,
	[DestinationConnectionString] [nvarchar](250) NOT NULL,
	[VocabularyConnectionString] [nvarchar](250) NOT NULL,
	[Vendor] [nvarchar](50) NOT NULL,
	[BatchSize] [int] NOT NULL
);

CREATE TABLE [Building](
	[Id] [int] NOT NULL,
	[CreateDestinationDbStart] [datetime] NULL,
	[CreateDestinationDbEnd] [datetime] NULL,
	[CreateChunksStart] [datetime] NULL,
	[CreateChunksEnd] [datetime] NULL,
	[CreateLookupStart] [datetime] NULL,
	[CreateLookupEnd] [datetime] NULL,
	[BuildingStart] [datetime] NULL,
	[BuildingEnd] [datetime] NULL,
	[CopyVocabularyStart] [datetime] NULL,
	[CopyVocabularyEnd] [datetime] NULL,
	[CreateIndexesStart] [datetime] NULL,
	[CreateIndexesEnd] [datetime] NULL
);

CREATE TABLE [Builder](
	[Id] INTEGER PRIMARY KEY AUTOINCREMENT,
	[Dsn] [varchar](50) NOT NULL,
	[Folder] [varchar](250) NULL,
	[MaxDegreeOfParallelism] [int] NULL,
	[BatchSize] [int] NULL,
	[StateId] [int] NULL,
	[BuildingId] [int] NULL,
	[Version] [varchar](50) NULL
);

CREATE TABLE [Log](
	[Id] INTEGER PRIMARY KEY AUTOINCREMENT,
	[ChunkId] [int] NULL,
	[BuilderId] [int] NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Time] [datetime] NOT NULL,
	[Message] [varchar](500) NOT NULL,
	[BuildingId] [int] NOT NULL
);