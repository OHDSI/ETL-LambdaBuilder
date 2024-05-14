--Optum Panther DDL

CREATE TABLE _version
(
   version_id    integer   NOT NULL,
   version_date  date      NOT NULL
);

CREATE TABLE allergy
(
   ptid          varchar(11)    NOT NULL,
   onset_date    date,
   allergentype  varchar(18),
   allergendesc  varchar(60),
   drug_class    varchar(150),
   ndc           varchar(11),
   ndc_source    varchar(7),
   sourceid      varchar(5)
);

CREATE TABLE care_area
(
   ptid           char(11)      NOT NULL,
   encid          varchar(17)   NOT NULL,
   carearea       varchar(60),
   carearea_date  date,
   carearea_time  varchar(8),
   sourceid       varchar(5)
);


CREATE TABLE cost_factor
(
   tos                 varchar(25),
   tos_desc            varchar(50),
   cdm_std_price_year  smallint,
   cumulative_factor   numeric(15,14)
);


CREATE TABLE diagnosis
(
   ptid                 char(11)      NOT NULL,
   encid                varchar(17),
   diag_date            date          NOT NULL,
   diag_time            varchar(8)    NOT NULL,
   diagnosis_cd         varchar(15),
   diagnosis_cd_type    varchar(10),
   diagnosis_status     varchar(24),
   poa                  char(1),
   admitting_diagnosis  char(1),
   discharge_diagnosis  char(1),
   primary_diagnosis    char(1),
   problem_list         char(1)       NOT NULL,
   sourceid             varchar(5)
);


CREATE TABLE encounter
(
   ptid                     char(11)      NOT NULL,
   visitid                  bigint,
   encid                    varchar(17)   NOT NULL,
   interaction_type         varchar(43)   NOT NULL,
   interaction_date         date          NOT NULL,
   interaction_time         varchar(8)    NOT NULL,
   academic_community_flag  varchar(3)    NOT NULL,
   sourceid                 varchar(5)
);


CREATE TABLE encounter_provider
(
   encid          varchar(17)   NOT NULL,
   provid         varchar(8)    NOT NULL,
   provider_role  varchar(15),
   sourceid       varchar(5)
);


CREATE TABLE immunizations
(
   ptid               char(11)       NOT NULL,
   immunization_date  date,
   immunization_desc  varchar(156),
   mapped_name        varchar(100),
   ndc                varchar(11),
   ndc_source         varchar(7),
   pt_reported        char(1),
   sourceid           varchar(5)
);


CREATE TABLE insurance
(
   ptid            char(11)      NOT NULL,
   encid           varchar(17)   NOT NULL,
   insurance_date  date          NOT NULL,
   insurance_time  varchar(8)    NOT NULL,
   ins_type        varchar(16),
   sourceid        varchar(5)
);


CREATE TABLE labs
(
   ptid                 char(11)       NOT NULL,
   encid                varchar(17),
   test_name            varchar(94)    NOT NULL,
   test_type            varchar(17)    NOT NULL,
   order_date           date,
   order_time           varchar(8),
   collected_date       date,
   collected_time       varchar(8),
   result_date          date,
   result_time          varchar(8),
   test_result          varchar(250),
   relative_indicator   varchar(2),
   result_unit          varchar(100),
   normal_range         varchar(300),
   evaluated_for_range  char(1)        NOT NULL,
   value_within_range   char(1)        NOT NULL,
   sourceid             varchar(5)
);


CREATE TABLE medication_administrations
(
   ptid                char(11)       NOT NULL,
   encid               varchar(17),
   orderid             varchar(16),
   drug_name           varchar(120),
   ndc                 varchar(11),
   ndc_source          varchar(7),
   order_date          date           NOT NULL,
   order_time          varchar(8)     NOT NULL,
   admin_date          date,
   admin_time          varchar(8),
   provid              varchar(8),
   route               varchar(25),
   quantity_of_dose    varchar(65),
   strength            varchar(90),
   strength_unit       varchar(40),
   dosage_form         varchar(110),
   dose_frequency      varchar(30),
   generic_desc        varchar(60),
   drug_class          varchar(150),
   discontinue_reason  varchar(46),
   sourceid            varchar(5)
);


CREATE TABLE microbiology
(
   ptid                      char(11)       NOT NULL,
   encid                     varchar(17),
   order_date                date,
   order_time                varchar(8),
   collect_date              date,
   collect_time              varchar(8),
   receive_date              date,
   receive_time              varchar(8),
   result_date               date           NOT NULL,
   result_time               varchar(8)     NOT NULL,
   result_status             varchar(11),
   specimen_source           varchar(30),
   organism                  varchar(300),
   mapped_organism_found     varchar(75),
   mapped_organism_excluded  varchar(75),
   culture_growth            varchar(15),
   culture_value             varchar(20),
   culture_unit              varchar(10),
   antibiotic                varchar(50),
   mapped_antibiotic         varchar(35),
   sensitivity               varchar(255),
   sourceid                  varchar(5)
);


CREATE TABLE nlp_biomarkers
(
   ptid              char(11)       NOT NULL,
   encid             varchar(17),
   note_date         date           NOT NULL,
   biomarker         varchar(25)    NOT NULL,
   variation_detail  varchar(100),
   biomarker_status  varchar(25)    NOT NULL,
   sourceid          varchar(5)
);


CREATE TABLE nlp_custom
(
   ptid                 char(11)      NOT NULL,
   encid                varchar(17),
   note_date            date          NOT NULL,
   nlp_term             varchar(27),
   nlp_term_attribute1  varchar(20),
   nlp_term_attribute2  varchar(74),
   nlp_term_qualifier   varchar(41),
   note_section         varchar(41)
);


CREATE TABLE nlp_drug_rationale
(
   ptid                     char(11)       NOT NULL,
   encid                    varchar(17),
   note_date                date           NOT NULL,
   note_section             varchar(60),
   drug_name                varchar(500),
   drug_action              varchar(19),
   drug_action_preposition  varchar(4),
   reason_general           varchar(12),
   sentiment                varchar(60),
   sentiment_who            varchar(24),
   sourceid                 varchar(5)
);


CREATE TABLE nlp_measurement
(
   ptid                   char(11)       NOT NULL,
   encid                  varchar(17),
   note_date              date           NOT NULL,
   measurement_type       varchar(300),
   measurement_value      varchar(150),
   measurement_detail     varchar(300),
   note_section           varchar(60),
   measurement_year       smallint,
   measurement_monthyear  varchar(7),
   measurement_date       date,
   sourceid               varchar(5)
);


CREATE TABLE nlp_sds
(
   ptid                  varchar(11)    NOT NULL,
   encid                 varchar(17),
   note_date             date           NOT NULL,
   sds_term              varchar(350),
   sds_location          varchar(320),
   sds_attribute         varchar(270),
   sds_sentiment         varchar(60),
   occurrence_year       smallint,
   occurrence_monthyear  varchar(7),
   occurrence_date       date,
   note_section          varchar(60),
   sds_concept           varchar(20),
   sds_timing            varchar(50),
   sds_severity          varchar(50),
   sds_extent            varchar(50),
   sds_duration          varchar(30),
   sds_change            varchar(60),
   sds_quality           varchar(50),
   sourceid              varchar(5)
);


CREATE TABLE nlp_sds_family
(
   ptid               char(11)       NOT NULL,
   encid              varchar(17),
   note_date          date           NOT NULL,
   sds_term           varchar(350),
   sds_location       varchar(320),
   sds_family_member  varchar(500),
   sds_sentiment      varchar(60),
   note_section       varchar(60),
   sourceid           varchar(5)
);


CREATE TABLE nlp_targeted
(
   ptid                      varchar(11),
   note_date                 date,
   concept_name              varchar(31),
   concept_value             varchar(14),
   concept_value_attribute1  varchar(15),
   concept_value_attribute2  varchar(9),
   concept_value_attribute3  varchar(38),
   concept_value_attribute4  varchar(21),
   concept_value_attribute5  varchar(14),
   concept_date_value        varchar(10),
   concept_date_type         varchar(10),
   sourceid                  varchar(5)
);


CREATE TABLE observations
(
   ptid                 char(11)       NOT NULL,
   encid                varchar(17),
   obs_type             varchar(100)   NOT NULL,
   nlp                  char(1)        NOT NULL,
   obs_date             date           NOT NULL,
   obs_time             varchar(8)     NOT NULL,
   obs_result           varchar(200),
   obs_unit             varchar(20),
   evaluated_for_range  char(1)        NOT NULL,
   value_within_range   char(1)        NOT NULL,
   result_date          date,
   sourceid             varchar(5)
);


CREATE TABLE patient
(
   ptid                 char(11)      NOT NULL,
   birth_yr             varchar(16),
   gender               varchar(7),
   race                 varchar(16),
   ethnicity            varchar(12),
   region               varchar(13),
   division             varchar(30),
   avg_hh_income        float8,
   pct_college_educ     float8,
   deceased_indicator   varchar(1),
   date_of_death        char(6),
   provid_pcp           varchar(8),
   idn_indicator        char(1)       NOT NULL,
   first_month_active   varchar(6)    NOT NULL,
   last_month_active    varchar(6)    NOT NULL,
   notes_eligible       char(1)       NOT NULL,
   has_notes            char(1)       NOT NULL,
   sourceid             varchar(60)   NOT NULL,
   source_data_through  varchar(6)    NOT NULL,
   integrated           varchar(1)
);


CREATE TABLE patient_reported_medications
(
   ptid              char(11)       NOT NULL,
   reported_date     date           NOT NULL,
   drug_name         varchar(120),
   ndc               varchar(11),
   ndc_source        varchar(7),
   provid            varchar(8),
   route             varchar(25),
   quantity_of_dose  varchar(65),
   strength          varchar(90),
   strength_unit     varchar(40),
   dosage_form       varchar(110),
   dose_frequency    varchar(30),
   generic_desc      varchar(60),
   drug_class        varchar(150),
   sourceid          varchar(5)
);


CREATE TABLE prescriptions_written
(
   ptid                char(11)       NOT NULL,
   rxdate              date           NOT NULL,
   rxtime              varchar(8)     NOT NULL,
   drug_name           varchar(120),
   ndc                 varchar(11),
   ndc_source          varchar(7),
   provid              varchar(8),
   route               varchar(25),
   quantity_of_dose    varchar(65),
   strength            varchar(90),
   strength_unit       varchar(40),
   dosage_form         varchar(110),
   daily_dose          float8,
   dose_frequency      varchar(30),
   quantity_per_fill   varchar(160),
   num_refills         integer,
   days_supply         float8,
   generic_desc        varchar(60),
   drug_class          varchar(150),
   discontinue_reason  varchar(46),
   sourceid            varchar(5)
);


CREATE TABLE procedure
(
   ptid            char(11)       NOT NULL,
   encid           varchar(17),
   proc_date       date           NOT NULL,
   proc_time       varchar(8)     NOT NULL,
   proc_code       varchar(40),
   proc_desc       varchar(255),
   proc_code_type  varchar(12),
   provid_perform  varchar(8),
   provid_order    varchar(8),
   betos_code      varchar(3),
   betos_desc      varchar(60),
   sourceid        varchar(5)
);


CREATE TABLE provider
(
   provid         varchar(8)    NOT NULL,
   specialty      varchar(36),
   prim_spec_ind  char(1),
   sourceid       varchar(5)
);


CREATE TABLE visit
(
   ptid                   char(11)       NOT NULL,
   visitid                bigint         NOT NULL,
   visit_type             varchar(40)    NOT NULL,
   visit_start_date       date           NOT NULL,
   visit_start_time       varchar(8),
   visit_end_date         date,
   visit_end_time         varchar(8),
   discharge_disposition  varchar(100),
   admission_source       varchar(80),
   drg                    varchar(3),
   sourceid               varchar(5)
);


