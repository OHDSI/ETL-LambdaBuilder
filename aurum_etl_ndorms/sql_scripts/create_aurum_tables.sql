drop table if exists {SOURCE_SCHEMA}.patient;
drop table if exists {SOURCE_SCHEMA}.practice;
drop table if exists {SOURCE_SCHEMA}.staff;
drop table if exists {SOURCE_SCHEMA}.consultation;
drop table if exists {SOURCE_SCHEMA}.observation;
drop table if exists {SOURCE_SCHEMA}.problem;
drop table if exists {SOURCE_SCHEMA}.drugissue;
drop table if exists {SOURCE_SCHEMA}.referral;

create table {SOURCE_SCHEMA}.patient (
	patid bigint,
	pracid int,
	usualgpstaffid varchar(10),
	gender int,
	yob int,
	mob int,
	emis_ddate date,
	regstartdate date,
	patienttypeid int,
	regenddate date,
	acceptable smallint,
	cprd_ddate date
);

create table {SOURCE_SCHEMA}.practice (
	pracid int,
	lcd date,
	uts date,
	region int
);

create table {SOURCE_SCHEMA}.staff (
	staffid bigint,
	pracid int,
	jobcatid int
);

create table {SOURCE_SCHEMA}.consultation (
	patid bigint,
	consid bigint,
	pracid int,
	consdate date,
	enterdate date,
	staffid bigint,
	conssourceid varchar(10),
	cprdconstype int,
	consmedcodeid bigint
);

create table {SOURCE_SCHEMA}.observation (
	patid bigint,
	consid bigint,
	pracid int,
	obsid bigint,
	obsdate date,
	enterdate date,
	staffid bigint,
	parentobsid bigint,
	medcodeid bigint,
	value real,
	numunitid int,
	obstypeid int,
	numrangelow real,
	numrangehigh real,
	probobsid bigint
);

create table {SOURCE_SCHEMA}.problem (
	patid bigint,
	obsid bigint,
	pracid int,
	parentprobobsid bigint,
	probenddate date,
	expduration int,
	lastrevdate date,
	lastrevstaffid bigint,
	parentprobrelid int,
	probstatusid int,
	signid int
);

create table {SOURCE_SCHEMA}.drugissue (
	patid bigint,
	issueid bigint,
	pracid int,
	probobsid bigint,
	drugrecid varchar(20),
	issuedate date,
	enterdate date,
	staffid bigint,
	prodcodeid bigint,
	dosageid varchar(64),
	quantity real,
	quantunitid smallint,
	duration int,
	estnhscost real
);

create table {SOURCE_SCHEMA}.referral (
	patid bigint,
	obsid bigint,
	pracid int,
	refsourceorgid int,
	reftargetorgid int,
	refurgencyid smallint,
	refservicetypeid smallint,
	refmodeid smallint
);