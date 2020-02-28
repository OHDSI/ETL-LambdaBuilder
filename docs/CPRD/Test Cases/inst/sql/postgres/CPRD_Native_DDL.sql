/*CPRD GOLD Native DDL*/
/*generated 11-Dec-2019*/

DROP TABLE IF EXISTS additional;
CREATE TABLE additional
(
   patid        bigint,
   enttype      smallint,
   adid         bigint,
   data1_value  numeric(15,3),
   data1_date   date,
   data2_value  numeric(15,3),
   data2_date   date,
   data3_value  numeric(15,3),
   data3_date   date,
   data4_value  integer,
   data4_date   date,
   data5_value  integer,
   data5_date   date,
   data6_value  integer,
   data6_date   date,
   data7_value  smallint,
   data7_date   date
);

DROP TABLE IF EXISTS batchnumbers;
CREATE TABLE batchnumbers
(
   batch         bigint,
   batch_number  varchar(200)
);

DROP TABLE IF EXISTS bnfcodes;
CREATE TABLE bnfcodes
(
   bnfcode        smallint,
   bnf            char(8),
   bnf_with_dots  varchar(11),
   description    varchar(500)
);

DROP TABLE IF EXISTS clinical;
CREATE TABLE clinical
(
   patid      bigint,
   eventdate  date,
   sysdate    date,
   constype   smallint,
   consid     bigint,
   medcode    bigint,
   staffid    bigint,
   episode    smallint,
   enttype    smallint,
   adid       bigint
);

DROP TABLE IF EXISTS commondosages;
CREATE TABLE commondosages
(
   dosageid          varchar(64),
   dosage_text       varchar(1000),
   daily_dose        numeric(15,3),
   dose_number       numeric(15,3),
   dose_unit         varchar(7),
   dose_frequency    numeric(15,3),
   dose_interval     numeric(15,3),
   choice_of_dose    smallint,
   dose_max_average  smallint,
   change_dose       smallint,
   dose_duration     numeric(15,3)
);

DROP TABLE IF EXISTS consultation;
CREATE TABLE consultation
(
   patid      bigint,
   eventdate  date,
   sysdate    date,
   constype   smallint,
   consid     bigint,
   staffid    bigint,
   duration   integer
);

DROP TABLE IF EXISTS daysupply_decodes;
CREATE TABLE daysupply_decodes
(
   prodcode    integer         NOT NULL,
   daily_dose  numeric(15,3),
   qty         numeric(9,2),
   numpacks    integer,
   numdays     smallint
);

DROP TABLE IF EXISTS daysupply_modes;
CREATE TABLE daysupply_modes
(
   prodcode  integer    NOT NULL,
   numdays   smallint
);

DROP TABLE IF EXISTS entity;
CREATE TABLE entity
(
   code         smallint,
   description  varchar(250),
   filetype     varchar(250),
   category     varchar(250),
   data_fields  smallint,
   data1        varchar(250),
   data1lkup    varchar(250),
   data2        varchar(250),
   data2lkup    varchar(250),
   data3        varchar(250),
   data3lkup    varchar(250),
   data4        varchar(250),
   data4lkup    varchar(250),
   data5        varchar(250),
   data5lkup    varchar(250),
   data6        varchar(250),
   data6lkup    varchar(250),
   data7        varchar(250),
   data7lkup    varchar(250),
   data8        varchar(250),
   data8lkup    varchar(250)
);

DROP TABLE IF EXISTS immunisation;
CREATE TABLE immunisation
(
   patid      bigint,
   eventdate  date,
   sysdate    date,
   constype   smallint,
   consid     bigint,
   medcode    bigint,
   staffid    bigint,
   immstype   smallint,
   stage      smallint,
   status     smallint,
   compound   smallint,
   source     smallint,
   reason     smallint,
   method     smallint,
   batch      bigint
);

DROP TABLE IF EXISTS lookup;
CREATE TABLE lookup
(
   lookup_id       integer        NOT NULL,
   lookup_type_id  smallint,
   code            smallint,
   text            varchar(250)
);

DROP TABLE IF EXISTS lookuptype;
CREATE TABLE lookuptype
(
   lookup_type_id  smallint,
   name            varchar(3),
   description     varchar(250)
);

DROP TABLE IF EXISTS medical;
CREATE TABLE medical
(
   medcode      bigint,
   read_code    varchar(10),
   description  varchar(200)
);

DROP TABLE IF EXISTS packtype;
CREATE TABLE packtype
(
   packtype       integer,
   packtype_desc  varchar(30)
);

DROP TABLE IF EXISTS patient;
CREATE TABLE patient
(
   patid       bigint,
   vmid        bigint,
   gender      smallint,
   yob         smallint,
   mob         smallint,
   marital     smallint,
   famnum      bigint,
   chsreg      smallint,
   chsdate     date,
   prescr      smallint,
   capsup      smallint,
   frd         date,
   crd         date,
   regstat     smallint,
   reggap      integer,
   internal    smallint,
   tod         date,
   toreason    smallint,
   deathdate   date,
   accept      smallint,
   pracid      smallint,
   birth_date  date,
   start_date  date,
   end_date    date
);

DROP TABLE IF EXISTS practice;
CREATE TABLE practice
(
   pracid  smallint,
   region  smallint,
   lcd     date,
   uts     date
);

DROP TABLE IF EXISTS product;
CREATE TABLE product
(
   prodcode       bigint,
   dmdcode        varchar(100),
   gemscriptcode  char(8),
   productname    varchar(500),
   drugsubstance  varchar(1500),
   strength       varchar(500),
   formulation    varchar(200),
   route          varchar(200),
   bnf            varchar(100),
   bnf_with_dots  varchar(300),
   bnfchapter     varchar(500)
);

DROP TABLE IF EXISTS referral;
CREATE TABLE referral
(
   patid       bigint,
   eventdate   date,
   sysdate     date,
   constype    smallint,
   consid      bigint,
   medcode     bigint,
   staffid     bigint,
   source      smallint,
   nhsspec     smallint,
   fhsaspec    smallint,
   inpatient   smallint,
   attendance  smallint,
   urgency     smallint
);

DROP TABLE IF EXISTS scoringmethod;
CREATE TABLE scoringmethod
(
   code            smallint,
   scoring_method  varchar(20)
);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
   staffid  bigint,
   gender   smallint,
   role     smallint
);

DROP TABLE IF EXISTS test;
CREATE TABLE test
(
   patid        bigint,
   eventdate    date,
   sysdate      date,
   constype     smallint,
   consid       bigint,
   medcode      bigint,
   staffid      bigint,
   enttype      smallint,
   data1        smallint,
   data2        numeric(16,3),
   data3        numeric(16,3),
   data4        numeric(16,3),
   data5        numeric(16,3),
   data6        numeric(16,3),
   data7        smallint,
   data8_value  integer,
   data8_date   date
);

DROP TABLE IF EXISTS therapy;
CREATE TABLE therapy
(
   patid      bigint,
   eventdate  date,
   sysdate    date,
   consid     bigint,
   prodcode   bigint,
   staffid    bigint,
   dosageid   varchar(64),
   bnfcode    smallint,
   qty        numeric(19,2),
   numdays    bigint,
   numpacks   numeric(19,2),
   packtype   integer,
   issueseq   bigint
);