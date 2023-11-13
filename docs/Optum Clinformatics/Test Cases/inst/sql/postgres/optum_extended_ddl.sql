/*Optum extended DDL including death and ses*/

CREATE TABLE optum_extended_native_test.death
(
   patid       bigint       NOT NULL,
   ymdod       varchar(6),
   extract_ym  varchar(6),
   version     varchar(6)
);

CREATE TABLE optum_extended_native_test.hra
(
   patid             bigint          NOT NULL,
   h_bmi             numeric(20,2),
   h_bsa             numeric(20,2),
   h_chronic_pain    char(1),
   h_height          numeric(20,2),
   h_smoking_status  char(1),
   h_weight          numeric(20,2),
   hra_compltd_dt    date,
   isa10008          varchar(50),
   isa1006           varchar(50),
   isa13021          varchar(50),
   isa13022          varchar(50),
   isa13023          varchar(50),
   isa13040          varchar(50),
   isa16010          varchar(50),
   isa16016          varchar(50),
   isa16040          varchar(50),
   isa17001          varchar(50),
   isa17015          varchar(50),
   isa17021          varchar(50),
   isa17023          varchar(50),
   isa18015          varchar(50),
   isa19004          varchar(50),
   isa19005          varchar(50),
   isa20061          varchar(50),
   isa20064          varchar(50),
   isa20069          varchar(50),
   isa20072          varchar(50),
   isa21001          varchar(50),
   isa21003          varchar(50),
   isa21009          varchar(50),
   isa21015          varchar(50),
   isa21020          varchar(50),
   isa21021          varchar(50),
   isa21025          varchar(50),
   isa3010           varchar(50),
   isa5001           varchar(50),
   isa5004           varchar(50),
   isa5010           varchar(50),
   isa5018           varchar(50),
   isa7018           varchar(50),
   isa8016           varchar(50),
   isa9009           varchar(50),
   isa9063           varchar(50),
   extract_ym        varchar(6),
   version           varchar(6)
);


CREATE TABLE optum_extended_native_test.inpatient_confinement
(
   patid          bigint          NOT NULL,
   pat_planid     bigint          NOT NULL,
   admit_date     date            NOT NULL,
   charge         numeric(11,2),
   coins          numeric(11,2),
   conf_id        varchar(21)     NOT NULL,
   copay          numeric(11,2),
   deduct         numeric(11,2),
   diag1          varchar(7),
   diag2          varchar(7),
   diag3          varchar(7),
   diag4          varchar(7),
   diag5          varchar(7),
   disch_date     date,
   drg            varchar(5),
   dstatus        varchar(2),
   icd_flag       varchar(2),
   ipstatus       char(1),
   los            integer,
   pos            varchar(5),
   proc1          varchar(7),
   proc2          varchar(7),
   proc3          varchar(7),
   proc4          varchar(7),
   proc5          varchar(7),
   prov           bigint,
   std_cost       numeric(15,2),
   std_cost_yr    varchar(4),
   tos_cd         varchar(13),
   extract_ym     varchar(6),
   version        varchar(6),
   icu_ind        varchar(1),
   icu_surg_ind   varchar(1),
   maj_surg_ind   varchar(1),
   maternity_ind  varchar(1),
   newborn_ind    varchar(1),
   tos_ext        varchar(34)
);


CREATE TABLE optum_extended_native_test.lab_results
(
   patid         bigint          NOT NULL,
   pat_planid    bigint          NOT NULL,
   abnl_cd       varchar(2),
   anlytseq      varchar(2),
   fst_dt        date            NOT NULL,
   hi_nrml       numeric(14,4),
   labclmid      varchar(19),
   loinc_cd      varchar(7),
   low_nrml      numeric(14,4),
   proc_cd       varchar(7),
   rslt_nbr      numeric(16,6),
   rslt_txt      varchar(18),
   rslt_unit_nm  varchar(18),
   source        varchar(2),
   tst_desc      varchar(30),
   tst_nbr       varchar(10),
   extract_ym    varchar(6),
   version       varchar(6)
);


CREATE TABLE optum_extended_native_test.med_diagnosis
(
   patid          bigint        NOT NULL,
   pat_planid     bigint        NOT NULL,
   clmid          varchar(19)   NOT NULL,
   diag           varchar(7),
   diag_position  varchar(3),
   icd_flag       varchar(2),
   loc_cd         varchar(1),
   poa            varchar(1),
   extract_ym     varchar(6),
   version        varchar(6),
   fst_dt         date
);


CREATE TABLE optum_extended_native_test.med_procedure
(
   patid          bigint        NOT NULL,
   pat_planid     bigint        NOT NULL,
   clmid          varchar(19)   NOT NULL,
   icd_flag       varchar(2),
   proc           varchar(7),
   proc_position  varchar(3),
   extract_ym     varchar(6),
   version        varchar(6),
   fst_dt         date
);


CREATE TABLE optum_extended_native_test.medical_claims
(
   patid         bigint          NOT NULL,
   pat_planid    bigint          NOT NULL,
   admit_chan    varchar(16),
   admit_type    char(1),
   bill_prov     bigint,
   charge        numeric(11,2),
   clmid         varchar(19)     NOT NULL,
   clmseq        varchar(5)      NOT NULL,
   cob           varchar(5),
   coins         numeric(11,2),
   conf_id       varchar(21),
   copay         numeric(11,2),
   deduct        numeric(11,2),
   drg           varchar(5),
   dstatus       varchar(2),
   enctr         varchar(2),
   fst_dt        date            NOT NULL,
   hccc          varchar(2),
   icd_flag      varchar(2),
   loc_cd        varchar(1),
   lst_dt        date,
   ndc           varchar(11),
   paid_dt       date,
   paid_status   char(2),
   pos           varchar(5),
   proc_cd       varchar(7),
   procmod       varchar(5),
   prov          bigint,
   prov_par      varchar(5),
   provcat       varchar(4),
   refer_prov    bigint,
   rvnu_cd       varchar(4),
   service_prov  bigint,
   std_cost      numeric(15,2),
   std_cost_yr   varchar(4),
   tos_cd        varchar(13),
   units         integer,
   extract_ym    varchar(6),
   version       varchar(6),
   alt_units     integer,
   bill_type     varchar(20),
   ndc_uom       varchar(2),
   ndc_qty       numeric(16,2),
   op_visit_id   integer,
   procmod2      varchar(5),
   procmod3      varchar(5),
   procmod4      varchar(5),
   tos_ext       varchar(34),
   _fst_dt       date,
   _lst_dt       date,
   _visittype    varchar(3)
);


CREATE TABLE optum_extended_native_test.member_continuous_enrollment
(
   patid       bigint       NOT NULL,
   eligeff     date         NOT NULL,
   eligend     date         NOT NULL,
   gdr_cd      char(1),
   yrdob       integer,
   extract_ym  varchar(6),
   ethnicity   varchar(20),
   version     varchar(6),
   race        varchar(20),
   race_source varchar(20)
);


CREATE TABLE optum_extended_native_test.member_enrollment
(
   patid        bigint        NOT NULL,
   pat_planid   bigint        NOT NULL,
   aso          char(1),
   bus          varchar(5),
   cdhp         char(1),
   eligeff      date          NOT NULL,
   eligend      date          NOT NULL,
   family_id    bigint,
   gdr_cd       char(1),
   group_nbr    varchar(20),
   health_exch  char(1),
   lis_dual     char(1),
   product      varchar(5),
   state        varchar(2),
   yrdob        integer,
   extract_ym   varchar(6),
   version      varchar(6)
);


CREATE TABLE optum_extended_native_test.provider
(
   prov_unique   bigint         NOT NULL,
   bed_sz_range  varchar(20),
   cred_type     varchar(100),
   grp_practice  bigint,
   hosp_affil    bigint,
   prov_state    varchar(2),
   prov_type     varchar(3),
   provcat       varchar(4),
   taxonomy1     varchar(10),
   taxonomy2     varchar(10),
   extract_ym    varchar(6)     NOT NULL,
   version       varchar(6)     NOT NULL
);

CREATE TABLE optum_extended_native_test.provider_bridge
(
   prov_unique  bigint        NOT NULL,
   dea          varchar(9),
   npi          varchar(10),
   prov         bigint,
   extract_ym   varchar(6)    NOT NULL,
   version      varchar(6)    NOT NULL
);


CREATE TABLE optum_extended_native_test.rx_claims
(
   patid            bigint          NOT NULL,
   pat_planid       bigint          NOT NULL,
   ahfsclss         varchar(8),
   avgwhlsl         numeric(11,2),
   brnd_nm          varchar(30),
   charge           numeric(11,2),
   chk_dt           date,
   clmid            varchar(19),
   copay            numeric(11,2),
   daw              char(1),
   days_sup         bigint,
   dea              varchar(9),
   deduct           numeric(11,2),
   dispfee          numeric(9,2),
   fill_dt          date            NOT NULL,
   form_ind         char(1),
   form_typ         varchar(2),
   fst_fill         char(1),
   gnrc_ind         char(1),
   gnrc_nm          varchar(50),
   mail_ind         char(1),
   ndc              varchar(11),
   npi              varchar(10),
   pharm            varchar(9),
   prc_typ          char(1),
   quantity         numeric(12,3),
   rfl_nbr          varchar(2),
   spclt_ind        char(1),
   specclss         varchar(3),
   std_cost         numeric(15,2),
   std_cost_yr      varchar(4),
   strength         varchar(10),
   extract_ym       varchar(6),
   version          varchar(6),
   prescriber_prov  bigint,
   prescript_id     varchar(20),
   _gpi             varchar(14)
);

CREATE TABLE optum_extended_native_test.ses
(
   patid                          bigint       NOT NULL,
   d_education_level_code         char(1),
   d_fed_poverty_status_code      char(1),
   d_home_ownership_code          char(1),
   d_household_income_range_code  char(1),
   d_networth_range_code          char(1),
   d_occupation_type_code         char(1),
   d_race_code                    char(2),
   num_adults                     integer,
   num_child                      integer,
   extract_ym                     varchar(6),
   version                        varchar(6)
);