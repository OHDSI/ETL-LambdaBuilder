drop table if exists {SOURCE_SCHEMA}.lkpregion;
drop table if exists {SOURCE_SCHEMA}.lkpjobcategory;
drop table if exists {SOURCE_SCHEMA}.lkpnumericunit;
drop table if exists {SOURCE_SCHEMA}.lkpquantityunit;
drop table if exists {SOURCE_SCHEMA}.lkpreferralservicetype;
drop table if exists {SOURCE_SCHEMA}.medicaldictionary;
drop table if exists {SOURCE_SCHEMA}.drugcode;

CREATE TABLE {SOURCE_SCHEMA}.lkpjobcategory
(
    jobcatid integer NOT NULL,
    description character varying(100) NOT NULL
);

CREATE TABLE {SOURCE_SCHEMA}.lkpnumericunit
(
    numunitid integer NOT NULL,
    description character varying(100) NOT NULL
);

CREATE TABLE {SOURCE_SCHEMA}.lkpquantityunit
(
    quantunitid integer NOT NULL,
    description character varying(50) NOT NULL
);

CREATE TABLE {SOURCE_SCHEMA}.lkpreferralservicetype
(
    refservicetypeid integer NOT NULL,
    description character varying(50) NOT NULL
);

CREATE TABLE {SOURCE_SCHEMA}.lkpregion
(
    regionid integer NOT NULL,
    description character varying(30) NOT NULL
);

CREATE TABLE {SOURCE_SCHEMA}.medicaldictionary
(
    medcodeid bigint NOT NULL,
    term character varying(265),
    originalreadcode character varying(25),
    cleansedreadcode character varying(10),
    snomedctconceptid character varying(20),
    snomedctdescriptionid character varying(20),
    release character varying(1),
    emiscodecategoryid smallint
);

CREATE TABLE {SOURCE_SCHEMA}.drugcode
(
    prodcodeid bigint NOT NULL,
    dmdid character varying(20),
    termfromemis character varying(250),
    productname character varying(250),
    formulation character varying(250),
    routeofadministration character varying(100),
    drugsubstancename character varying(1000),
    substancestrength character varying(650),
    bnfchapter character varying(30),
    release character varying(10)
);