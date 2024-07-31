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