-- DROP SCHEMA ccae_tests_cdm;

CREATE SCHEMA ccae_tests_cdm;
-- ccae_tests_cdm."_version" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."_version";

--DROP TABLE ccae_tests_cdm._version;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm._version
(
	version_id INTEGER NOT NULL  ENCODE az64
	,version_date DATE NOT NULL  ENCODE az64
)
DISTSTYLE EVEN
;
ALTER TABLE ccae_tests_cdm._version owner to rhealth_etl;


-- ccae_tests_cdm.care_site definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.care_site;

--DROP TABLE ccae_tests_cdm.care_site;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.care_site
(
	care_site_id BIGINT NOT NULL  ENCODE delta
	,care_site_name VARCHAR(255)   ENCODE zstd
	,place_of_service_concept_id BIGINT   ENCODE zstd
	,location_id BIGINT   ENCODE zstd
	,care_site_source_value VARCHAR(150)   ENCODE zstd
	,place_of_service_source_value VARCHAR(150)   ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.care_site owner to rhealth_etl;


-- ccae_tests_cdm.cdm_source definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cdm_source;

--DROP TABLE ccae_tests_cdm.cdm_source;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cdm_source
(
	cdm_source_name VARCHAR(255) NOT NULL  ENCODE lzo
	,cdm_source_abbreviation VARCHAR(30)   ENCODE lzo
	,cdm_holder VARCHAR(255)   ENCODE lzo
	,source_description VARCHAR(65535)   ENCODE lzo
	,source_documentation_reference VARCHAR(255)   ENCODE lzo
	,cdm_etl_reference VARCHAR(255)   ENCODE lzo
	,source_release_date DATE   ENCODE az64
	,cdm_release_date DATE   ENCODE az64
	,cdm_version VARCHAR(10)   ENCODE lzo
	,cdm_version_concept_id BIGINT NOT NULL  ENCODE az64
	,vocabulary_version VARCHAR(20)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.cdm_source owner to rhealth_etl;


-- ccae_tests_cdm.cohort definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cohort;

--DROP TABLE ccae_tests_cdm.cohort;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cohort
(
	cohort_definition_id BIGINT NOT NULL  ENCODE az64
	,subject_id BIGINT NOT NULL  ENCODE RAW
	,cohort_start_date DATE NOT NULL  ENCODE az64
	,cohort_end_date DATE NOT NULL  ENCODE az64
)
DISTSTYLE KEY
 DISTKEY (subject_id)
 SORTKEY (
	subject_id
	)
;
ALTER TABLE ccae_tests_cdm.cohort owner to rhealth_etl;


-- ccae_tests_cdm.cohort_definition definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cohort_definition;

--DROP TABLE ccae_tests_cdm.cohort_definition;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cohort_definition
(
	cohort_definition_id BIGINT NOT NULL  ENCODE az64
	,cohort_definition_name VARCHAR(255) NOT NULL  ENCODE lzo
	,cohort_definition_description VARCHAR(65535)   ENCODE lzo
	,definition_type_concept_id BIGINT NOT NULL  ENCODE az64
	,cohort_definition_syntax VARCHAR(65535)   ENCODE lzo
	,subject_concept_id BIGINT NOT NULL  ENCODE az64
	,cohort_initiation_date DATE   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.cohort_definition owner to rhealth_etl;


-- ccae_tests_cdm.concept definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept;

--DROP TABLE ccae_tests_cdm.concept;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept
(
	concept_id BIGINT NOT NULL  ENCODE RAW
	,concept_name VARCHAR(500) NOT NULL  ENCODE zstd
	,domain_id VARCHAR(20) NOT NULL  ENCODE zstd
	,vocabulary_id VARCHAR(200) NOT NULL  ENCODE zstd
	,concept_class_id VARCHAR(20) NOT NULL  ENCODE bytedict
	,standard_concept VARCHAR(1)   ENCODE zstd
	,concept_code VARCHAR(100) NOT NULL  ENCODE zstd
	,valid_start_date DATE NOT NULL  ENCODE zstd
	,valid_end_date DATE NOT NULL  ENCODE zstd
	,invalid_reason VARCHAR(1)   ENCODE zstd
	,PRIMARY KEY (concept_id)
)
DISTSTYLE KEY
 DISTKEY (concept_id)
 SORTKEY (
	concept_id
	)
;
ALTER TABLE ccae_tests_cdm.concept owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110006" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110006" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.concept_relationship not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('concept_relationship_concept_id_1_fkey', 'concept_relationship', 'concept', 'UNSPECIFIED', 'concept_id_1', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110007" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110007" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.concept_relationship not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('concept_relationship_concept_id_1_fkey', 'concept_relationship', 'concept', 'UNSPECIFIED', 'concept_id_1', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110046" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110046" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.specimen not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('specimen_specimen_concept_id_fkey', 'specimen', 'concept', 'UNSPECIFIED', 'specimen_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110047" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110047" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.specimen not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('specimen_specimen_concept_id_fkey', 'specimen', 'concept', 'UNSPECIFIED', 'specimen_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110057" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110057" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.death not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('death_death_type_concept_id_fkey', 'death', 'concept', 'UNSPECIFIED', 'death_type_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110058" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110058" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.death not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('death_death_type_concept_id_fkey', 'death', 'concept', 'UNSPECIFIED', 'death_type_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110068" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110068" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.visit_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('visit_occurrence_visit_concept_id_fkey', 'visit_occurrence', 'concept', 'UNSPECIFIED', 'visit_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110069" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110069" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.visit_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('visit_occurrence_visit_concept_id_fkey', 'visit_occurrence', 'concept', 'UNSPECIFIED', 'visit_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110079" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110079" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.visit_detail not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('visit_detail_visit_detail_concept_id_fkey', 'visit_detail', 'concept', 'UNSPECIFIED', 'visit_detail_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110080" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110080" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.visit_detail not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('visit_detail_visit_detail_concept_id_fkey', 'visit_detail', 'concept', 'UNSPECIFIED', 'visit_detail_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110090" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110090" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.procedure_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('procedure_occurrence_procedure_concept_id_fkey', 'procedure_occurrence', 'concept', 'UNSPECIFIED', 'procedure_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110091" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110091" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.procedure_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('procedure_occurrence_procedure_concept_id_fkey', 'procedure_occurrence', 'concept', 'UNSPECIFIED', 'procedure_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110101" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110101" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.drug_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('drug_exposure_drug_concept_id_fkey', 'drug_exposure', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110102" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110102" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.drug_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('drug_exposure_drug_concept_id_fkey', 'drug_exposure', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110112" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110112" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.device_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('device_exposure_device_concept_id_fkey', 'device_exposure', 'concept', 'UNSPECIFIED', 'device_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110113" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110113" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.device_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('device_exposure_device_concept_id_fkey', 'device_exposure', 'concept', 'UNSPECIFIED', 'device_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110123" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110123" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.condition_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('condition_occurrence_condition_concept_id_fkey', 'condition_occurrence', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110124" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110124" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.condition_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('condition_occurrence_condition_concept_id_fkey', 'condition_occurrence', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110134" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110134" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.measurement not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('measurement_measurement_concept_id_fkey', 'measurement', 'concept', 'UNSPECIFIED', 'measurement_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110135" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110135" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.measurement not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('measurement_measurement_concept_id_fkey', 'measurement', 'concept', 'UNSPECIFIED', 'measurement_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110155" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110155" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.observation not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('observation_observation_concept_id_fkey', 'observation', 'concept', 'UNSPECIFIED', 'observation_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110156" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110156" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.observation not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('observation_observation_concept_id_fkey', 'observation', 'concept', 'UNSPECIFIED', 'observation_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110178" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110178" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.payer_plan_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('payer_plan_period_payer_concept_id_fkey', 'payer_plan_period', 'concept', 'UNSPECIFIED', 'payer_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110179" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110179" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.payer_plan_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('payer_plan_period_payer_concept_id_fkey', 'payer_plan_period', 'concept', 'UNSPECIFIED', 'payer_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110198" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110198" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.drug_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('drug_era_drug_concept_id_fkey', 'drug_era', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110199" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110199" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.drug_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('drug_era_drug_concept_id_fkey', 'drug_era', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110216" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110216" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.condition_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('condition_era_condition_concept_id_fkey', 'condition_era', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110217" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110217" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.condition_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('condition_era_condition_concept_id_fkey', 'condition_era', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110229" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110229" after
delete
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.episode not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('episode_episode_concept_id_fkey', 'episode', 'concept', 'UNSPECIFIED', 'episode_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110230" ON ccae_tests_cdm.concept;

create constraint trigger "RI_ConstraintTrigger_67110230" after
update
    on
    ccae_tests_cdm.concept
from
    ccae_tests_cdm.episode not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('episode_episode_concept_id_fkey', 'episode', 'concept', 'UNSPECIFIED', 'episode_concept_id', 'concept_id');


-- ccae_tests_cdm.concept_ancestor definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_ancestor;

--DROP TABLE ccae_tests_cdm.concept_ancestor;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_ancestor
(
	ancestor_concept_id BIGINT NOT NULL  ENCODE RAW
	,descendant_concept_id BIGINT NOT NULL  ENCODE RAW
	,min_levels_of_separation INTEGER NOT NULL  ENCODE zstd
	,max_levels_of_separation INTEGER NOT NULL  ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (ancestor_concept_id)
 SORTKEY (
	ancestor_concept_id
	, descendant_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.concept_ancestor owner to rhealth_etl;


-- ccae_tests_cdm.concept_class definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_class;

--DROP TABLE ccae_tests_cdm.concept_class;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_class
(
	concept_class_id VARCHAR(20) NOT NULL  ENCODE zstd
	,concept_class_name VARCHAR(255) NOT NULL  ENCODE zstd
	,concept_class_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.concept_class owner to rhealth_etl;


-- ccae_tests_cdm.concept_synonym definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_synonym;

--DROP TABLE ccae_tests_cdm.concept_synonym;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_synonym
(
	concept_id BIGINT NOT NULL  ENCODE zstd
	,concept_synonym_name VARCHAR(1500) NOT NULL  ENCODE zstd
	,language_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.concept_synonym owner to rhealth_etl;


-- ccae_tests_cdm.cost definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cost;

--DROP TABLE ccae_tests_cdm.cost;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cost
(
	cost_id BIGINT NOT NULL  ENCODE delta
	,cost_event_id BIGINT NOT NULL  ENCODE RAW
	,cost_domain_id VARCHAR(20) NOT NULL  ENCODE zstd
	,cost_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,currency_concept_id BIGINT   ENCODE zstd
	,total_charge NUMERIC(38,2)   ENCODE zstd
	,total_cost NUMERIC(38,2)   ENCODE zstd
	,total_paid NUMERIC(38,2)   ENCODE zstd
	,paid_by_payer NUMERIC(38,2)   ENCODE zstd
	,paid_by_patient NUMERIC(38,2)   ENCODE zstd
	,paid_patient_copay NUMERIC(38,2)   ENCODE zstd
	,paid_patient_coinsurance NUMERIC(38,2)   ENCODE zstd
	,paid_patient_deductible NUMERIC(38,2)   ENCODE zstd
	,paid_by_primary NUMERIC(38,2)   ENCODE zstd
	,paid_ingredient_cost NUMERIC(38,2)   ENCODE zstd
	,paid_dispensing_fee NUMERIC(38,2)   ENCODE zstd
	,payer_plan_period_id BIGINT   ENCODE zstd
	,amount_allowed NUMERIC(38,2)   ENCODE zstd
	,revenue_code_concept_id BIGINT   ENCODE zstd
	,revenue_code_source_value VARCHAR(50)   ENCODE zstd
	,drg_concept_id BIGINT   ENCODE zstd
	,drg_source_value VARCHAR(3)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (cost_event_id)
 SORTKEY (
	cost_event_id
	)
;
ALTER TABLE ccae_tests_cdm.cost owner to rhealth_etl;


-- ccae_tests_cdm."domain" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."domain";

--DROP TABLE ccae_tests_cdm."domain";
CREATE TABLE IF NOT EXISTS ccae_tests_cdm."domain"
(
	domain_id VARCHAR(20) NOT NULL  ENCODE zstd
	,domain_name VARCHAR(255) NOT NULL  ENCODE zstd
	,domain_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm."domain" owner to rhealth_etl;


-- ccae_tests_cdm.drug_strength definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.drug_strength;

--DROP TABLE ccae_tests_cdm.drug_strength;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.drug_strength
(
	drug_concept_id BIGINT NOT NULL  ENCODE zstd
	,ingredient_concept_id BIGINT NOT NULL  ENCODE zstd
	,amount_value DOUBLE PRECISION   ENCODE zstd
	,amount_unit_concept_id BIGINT   ENCODE zstd
	,numerator_value DOUBLE PRECISION   ENCODE zstd
	,numerator_unit_concept_id BIGINT   ENCODE zstd
	,denominator_value DOUBLE PRECISION   ENCODE zstd
	,denominator_unit_concept_id BIGINT   ENCODE zstd
	,box_size INTEGER   ENCODE zstd
	,valid_start_date DATE NOT NULL  ENCODE zstd
	,valid_end_date DATE NOT NULL  ENCODE zstd
	,invalid_reason VARCHAR(1)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.drug_strength owner to rhealth_etl;


-- ccae_tests_cdm.fact_relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.fact_relationship;

--DROP TABLE ccae_tests_cdm.fact_relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.fact_relationship
(
	domain_concept_id_1 BIGINT NOT NULL  ENCODE zstd
	,fact_id_1 BIGINT NOT NULL  ENCODE zstd
	,domain_concept_id_2 BIGINT NOT NULL  ENCODE zstd
	,fact_id_2 BIGINT NOT NULL  ENCODE zstd
	,relationship_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE EVEN
;
ALTER TABLE ccae_tests_cdm.fact_relationship owner to rhealth_etl;


-- ccae_tests_cdm."location" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."location";

--DROP TABLE ccae_tests_cdm."location";
CREATE TABLE IF NOT EXISTS ccae_tests_cdm."location"
(
	location_id BIGINT NOT NULL  ENCODE az64
	,address_1 VARCHAR(50)   ENCODE lzo
	,address_2 VARCHAR(50)   ENCODE lzo
	,city VARCHAR(50)   ENCODE lzo
	,state VARCHAR(25)   ENCODE lzo
	,zip VARCHAR(9)   ENCODE lzo
	,county VARCHAR(20)   ENCODE lzo
	,location_source_value VARCHAR(50)   ENCODE lzo
	,country_concept_id BIGINT   ENCODE az64
	,country_source_value VARCHAR(150)   ENCODE lzo
	,latitude NUMERIC(38,2)   ENCODE az64
	,longitude NUMERIC(38,2)   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm."location" owner to rhealth_etl;


-- ccae_tests_cdm.metadata definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.metadata;

--DROP TABLE ccae_tests_cdm.metadata;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.metadata
(
	metadata_id BIGINT NOT NULL  ENCODE az64
	,metadata_concept_id BIGINT NOT NULL  ENCODE az64
	,metadata_type_concept_id BIGINT NOT NULL  ENCODE az64
	,name VARCHAR(250) NOT NULL  ENCODE lzo
	,value_as_string VARCHAR(65535)   ENCODE lzo
	,value_as_concept_id BIGINT   ENCODE az64
	,value_as_number NUMERIC(38,2)   ENCODE az64
	,metadata_date DATE   ENCODE az64
	,metadata_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.metadata owner to rhealth_etl;


-- ccae_tests_cdm.note_nlp definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.note_nlp;

--DROP TABLE ccae_tests_cdm.note_nlp;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.note_nlp
(
	note_nlp_id BIGINT NOT NULL  ENCODE az64
	,note_id BIGINT NOT NULL  ENCODE az64
	,section_concept_id BIGINT   ENCODE az64
	,snippet VARCHAR(250)   ENCODE lzo
	,"offset" VARCHAR(250)   ENCODE lzo
	,lexical_variant VARCHAR(250) NOT NULL  ENCODE lzo
	,note_nlp_concept_id BIGINT   ENCODE az64
	,note_nlp_source_concept_id BIGINT   ENCODE az64
	,nlp_system VARCHAR(250)   ENCODE lzo
	,nlp_date DATE NOT NULL  ENCODE az64
	,nlp_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE az64
	,term_exists VARCHAR(1)   ENCODE lzo
	,term_temporal VARCHAR(50)   ENCODE lzo
	,term_modifiers VARCHAR(2000)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.note_nlp owner to rhealth_etl;


-- ccae_tests_cdm.person definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.person;

--DROP TABLE ccae_tests_cdm.person;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.person
(
	person_id BIGINT NOT NULL  ENCODE RAW
	,gender_concept_id BIGINT NOT NULL  ENCODE zstd
	,year_of_birth INTEGER NOT NULL  ENCODE delta
	,month_of_birth INTEGER   ENCODE zstd
	,day_of_birth INTEGER   ENCODE zstd
	,birth_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,race_concept_id BIGINT NOT NULL  ENCODE zstd
	,ethnicity_concept_id BIGINT NOT NULL  ENCODE zstd
	,location_id BIGINT   ENCODE zstd
	,provider_id BIGINT   ENCODE lzo
	,care_site_id BIGINT   ENCODE lzo
	,person_source_value VARCHAR(50)   ENCODE zstd
	,gender_source_value VARCHAR(50)   ENCODE zstd
	,gender_source_concept_id BIGINT   ENCODE zstd
	,race_source_value VARCHAR(50)   ENCODE zstd
	,race_source_concept_id BIGINT   ENCODE zstd
	,ethnicity_source_value VARCHAR(50)   ENCODE zstd
	,ethnicity_source_concept_id BIGINT   ENCODE zstd
	,PRIMARY KEY (person_id)
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	)
;
ALTER TABLE ccae_tests_cdm.person owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110039" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110039" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.observation_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('observation_period_person_id_fkey', 'observation_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110040" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110040" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.observation_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('observation_period_person_id_fkey', 'observation_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110050" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110050" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.specimen not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('specimen_person_id_fkey', 'specimen', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110051" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110051" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.specimen not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('specimen_person_id_fkey', 'specimen', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110061" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110061" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.death not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('death_person_id_fkey', 'death', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110062" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110062" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.death not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('death_person_id_fkey', 'death', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110072" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110072" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.visit_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('visit_occurrence_person_id_fkey', 'visit_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110073" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110073" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.visit_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('visit_occurrence_person_id_fkey', 'visit_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110083" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110083" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.visit_detail not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('visit_detail_person_id_fkey', 'visit_detail', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110084" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110084" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.visit_detail not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('visit_detail_person_id_fkey', 'visit_detail', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110094" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110094" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.procedure_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('procedure_occurrence_person_id_fkey', 'procedure_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110095" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110095" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.procedure_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('procedure_occurrence_person_id_fkey', 'procedure_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110105" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110105" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.drug_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('drug_exposure_person_id_fkey', 'drug_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110106" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110106" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.drug_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('drug_exposure_person_id_fkey', 'drug_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110116" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110116" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.device_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('device_exposure_person_id_fkey', 'device_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110117" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110117" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.device_exposure not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('device_exposure_person_id_fkey', 'device_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110127" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110127" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.condition_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('condition_occurrence_person_id_fkey', 'condition_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110128" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110128" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.condition_occurrence not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('condition_occurrence_person_id_fkey', 'condition_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110138" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110138" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.measurement not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('measurement_person_id_fkey', 'measurement', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110139" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110139" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.measurement not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('measurement_person_id_fkey', 'measurement', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110145" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110145" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.note not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('note_person_id_fkey', 'note', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110146" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110146" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.note not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('note_person_id_fkey', 'note', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110159" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110159" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.observation not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('observation_person_id_fkey', 'observation', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110160" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110160" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.observation not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('observation_person_id_fkey', 'observation', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110182" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110182" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.payer_plan_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('payer_plan_period_person_id_fkey', 'payer_plan_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110183" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110183" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.payer_plan_period not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('payer_plan_period_person_id_fkey', 'payer_plan_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110202" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110202" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.drug_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('drug_era_person_id_fkey', 'drug_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110203" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110203" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.drug_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('drug_era_person_id_fkey', 'drug_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110209" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110209" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.dose_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('dose_era_person_id_fkey', 'dose_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110210" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110210" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.dose_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('dose_era_person_id_fkey', 'dose_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110220" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110220" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.condition_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('condition_era_person_id_fkey', 'condition_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110221" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110221" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.condition_era not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('condition_era_person_id_fkey', 'condition_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110233" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110233" after
delete
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.episode not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('episode_person_id_fkey', 'episode', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110234" ON ccae_tests_cdm.person;

create constraint trigger "RI_ConstraintTrigger_67110234" after
update
    on
    ccae_tests_cdm.person
from
    ccae_tests_cdm.episode not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('episode_person_id_fkey', 'episode', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.provider definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.provider;

--DROP TABLE ccae_tests_cdm."provider";
CREATE TABLE IF NOT EXISTS ccae_tests_cdm."provider"
(
	provider_id BIGINT NOT NULL  ENCODE delta
	,provider_name VARCHAR(255)   ENCODE lzo
	,npi VARCHAR(25)   ENCODE lzo
	,dea VARCHAR(20)   ENCODE lzo
	,specialty_concept_id BIGINT   ENCODE zstd
	,care_site_id BIGINT   ENCODE zstd
	,year_of_birth INTEGER   ENCODE zstd
	,gender_concept_id BIGINT   ENCODE zstd
	,provider_source_value VARCHAR(100)   ENCODE zstd
	,specialty_source_value VARCHAR(100)   ENCODE zstd
	,specialty_source_concept_id BIGINT   ENCODE zstd
	,gender_source_value VARCHAR(50)   ENCODE lzo
	,gender_source_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm."provider" owner to rhealth_etl;


-- ccae_tests_cdm.relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.relationship;

--DROP TABLE ccae_tests_cdm.relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.relationship
(
	relationship_id VARCHAR(20) NOT NULL  ENCODE zstd
	,relationship_name VARCHAR(255) NOT NULL  ENCODE zstd
	,is_hierarchical VARCHAR(1) NOT NULL  ENCODE zstd
	,defines_ancestry VARCHAR(1) NOT NULL  ENCODE zstd
	,reverse_relationship_id VARCHAR(20) NOT NULL  ENCODE zstd
	,relationship_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.relationship owner to rhealth_etl;


-- ccae_tests_cdm.source_to_concept_map definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.source_to_concept_map;

--DROP TABLE ccae_tests_cdm.source_to_concept_map;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.source_to_concept_map
(
	source_code VARCHAR(255)   ENCODE zstd
	,source_concept_id BIGINT NOT NULL  ENCODE zstd
	,source_vocabulary_id VARCHAR(50) NOT NULL  ENCODE zstd
	,source_code_description VARCHAR(255)   ENCODE zstd
	,target_concept_id BIGINT NOT NULL  ENCODE zstd
	,target_vocabulary_id VARCHAR(50)   ENCODE zstd
	,valid_start_date DATE NOT NULL  ENCODE zstd
	,valid_end_date DATE NOT NULL  ENCODE zstd
	,invalid_reason VARCHAR(1)   ENCODE RAW
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.source_to_concept_map owner to rhealth_etl;


-- ccae_tests_cdm.test_results definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.test_results;

--DROP TABLE ccae_tests_cdm.test_results;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.test_results
(
	id INTEGER   ENCODE az64
	,description VARCHAR(512)   ENCODE lzo
	,test VARCHAR(256)   ENCODE lzo
	,status VARCHAR(5)   ENCODE lzo
)
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_cdm.test_results owner to rhealth_etl;


-- ccae_tests_cdm.vocabulary definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.vocabulary;

--DROP TABLE ccae_tests_cdm.vocabulary;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.vocabulary
(
	vocabulary_id VARCHAR(20) NOT NULL  ENCODE zstd
	,vocabulary_name VARCHAR(255) NOT NULL  ENCODE zstd
	,vocabulary_reference VARCHAR(255)   ENCODE zstd
	,vocabulary_version VARCHAR(255)   ENCODE zstd
	,vocabulary_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_cdm.vocabulary owner to rhealth_etl;


-- ccae_tests_cdm.concept_relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_relationship;

--DROP TABLE ccae_tests_cdm.concept_relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_relationship
(
	concept_id_1 BIGINT NOT NULL  ENCODE RAW
	,concept_id_2 BIGINT NOT NULL  ENCODE RAW
	,relationship_id VARCHAR(20) NOT NULL  ENCODE bytedict
	,valid_start_date DATE NOT NULL  ENCODE zstd
	,valid_end_date DATE NOT NULL  ENCODE zstd
	,invalid_reason VARCHAR(1)   ENCODE RAW
)
DISTSTYLE KEY
 DISTKEY (concept_id_1)
 SORTKEY (
	concept_id_1
	, concept_id_2
	)
;
ALTER TABLE ccae_tests_cdm.concept_relationship owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110005" ON ccae_tests_cdm.concept_relationship;

create constraint trigger "RI_ConstraintTrigger_67110005" after
insert
    or
update
    on
    ccae_tests_cdm.concept_relationship
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('concept_relationship_concept_id_1_fkey', 'concept_relationship', 'concept', 'UNSPECIFIED', 'concept_id_1', 'concept_id');


-- ccae_tests_cdm.condition_era definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.condition_era;

--DROP TABLE ccae_tests_cdm.condition_era;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.condition_era
(
	condition_era_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE az64
	,condition_concept_id BIGINT NOT NULL  ENCODE RAW
	,condition_era_start_date DATE NOT NULL  ENCODE zstd
	,condition_era_end_date DATE NOT NULL  ENCODE zstd
	,condition_occurrence_count INTEGER   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	condition_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.condition_era owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110215" ON ccae_tests_cdm.condition_era;

create constraint trigger "RI_ConstraintTrigger_67110215" after
insert
    or
update
    on
    ccae_tests_cdm.condition_era
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('condition_era_condition_concept_id_fkey', 'condition_era', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110219" ON ccae_tests_cdm.condition_era;

create constraint trigger "RI_ConstraintTrigger_67110219" after
insert
    or
update
    on
    ccae_tests_cdm.condition_era
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('condition_era_person_id_fkey', 'condition_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.condition_occurrence definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.condition_occurrence;

--DROP TABLE ccae_tests_cdm.condition_occurrence;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.condition_occurrence
(
	condition_occurrence_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,condition_concept_id BIGINT NOT NULL  ENCODE RAW
	,condition_start_date DATE NOT NULL  ENCODE zstd
	,condition_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,condition_end_date DATE   ENCODE lzo
	,condition_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,condition_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,stop_reason VARCHAR(20)   ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE zstd
	,condition_status_concept_id BIGINT   ENCODE zstd
	,condition_source_value VARCHAR(65535)   ENCODE zstd
	,condition_source_concept_id BIGINT   ENCODE zstd
	,condition_status_source_value VARCHAR(65535)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	condition_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.condition_occurrence owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110122" ON ccae_tests_cdm.condition_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110122" after
insert
    or
update
    on
    ccae_tests_cdm.condition_occurrence
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('condition_occurrence_condition_concept_id_fkey', 'condition_occurrence', 'concept', 'UNSPECIFIED', 'condition_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110126" ON ccae_tests_cdm.condition_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110126" after
insert
    or
update
    on
    ccae_tests_cdm.condition_occurrence
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('condition_occurrence_person_id_fkey', 'condition_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.death definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.death;

--DROP TABLE ccae_tests_cdm.death;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.death
(
	person_id BIGINT NOT NULL  ENCODE RAW
	,death_date DATE NOT NULL  ENCODE delta32k
	,death_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,death_type_concept_id BIGINT NOT NULL  ENCODE RAW
	,cause_concept_id BIGINT   ENCODE zstd
	,cause_source_value VARCHAR(50)   ENCODE zstd
	,cause_source_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, death_type_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.death owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110056" ON ccae_tests_cdm.death;

create constraint trigger "RI_ConstraintTrigger_67110056" after
insert
    or
update
    on
    ccae_tests_cdm.death
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('death_death_type_concept_id_fkey', 'death', 'concept', 'UNSPECIFIED', 'death_type_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110060" ON ccae_tests_cdm.death;

create constraint trigger "RI_ConstraintTrigger_67110060" after
insert
    or
update
    on
    ccae_tests_cdm.death
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('death_person_id_fkey', 'death', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.device_exposure definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.device_exposure;

--DROP TABLE ccae_tests_cdm.device_exposure;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.device_exposure
(
	device_exposure_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,device_concept_id BIGINT NOT NULL  ENCODE RAW
	,device_exposure_start_date DATE NOT NULL  ENCODE delta32k
	,device_exposure_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,device_exposure_end_date DATE   ENCODE delta32k
	,device_exposure_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,device_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,unique_device_id VARCHAR(50)   ENCODE zstd
	,production_id VARCHAR(255)   ENCODE zstd
	,quantity INTEGER   ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE zstd
	,device_source_value VARCHAR(255)   ENCODE zstd
	,device_source_concept_id BIGINT   ENCODE zstd
	,unit_concept_id BIGINT   ENCODE zstd
	,unit_source_value VARCHAR(255)   ENCODE zstd
	,unit_source_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	device_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.device_exposure owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110111" ON ccae_tests_cdm.device_exposure;

create constraint trigger "RI_ConstraintTrigger_67110111" after
insert
    or
update
    on
    ccae_tests_cdm.device_exposure
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('device_exposure_device_concept_id_fkey', 'device_exposure', 'concept', 'UNSPECIFIED', 'device_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110115" ON ccae_tests_cdm.device_exposure;

create constraint trigger "RI_ConstraintTrigger_67110115" after
insert
    or
update
    on
    ccae_tests_cdm.device_exposure
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('device_exposure_person_id_fkey', 'device_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.dose_era definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.dose_era;

--DROP TABLE ccae_tests_cdm.dose_era;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.dose_era
(
	dose_era_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE RAW
	,drug_concept_id BIGINT NOT NULL  ENCODE RAW
	,unit_concept_id BIGINT NOT NULL  ENCODE zstd
	,dose_value NUMERIC(38,2) NOT NULL  ENCODE zstd
	,dose_era_start_date DATE NOT NULL  ENCODE zstd
	,dose_era_end_date DATE NOT NULL  ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, drug_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.dose_era owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110208" ON ccae_tests_cdm.dose_era;

create constraint trigger "RI_ConstraintTrigger_67110208" after
insert
    or
update
    on
    ccae_tests_cdm.dose_era
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('dose_era_person_id_fkey', 'dose_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.drug_era definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.drug_era;

--DROP TABLE ccae_tests_cdm.drug_era;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.drug_era
(
	drug_era_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE az64
	,drug_concept_id BIGINT NOT NULL  ENCODE RAW
	,drug_era_start_date DATE NOT NULL  ENCODE zstd
	,drug_era_end_date DATE NOT NULL  ENCODE zstd
	,drug_exposure_count INTEGER   ENCODE zstd
	,gap_days INTEGER   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	drug_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.drug_era owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110197" ON ccae_tests_cdm.drug_era;

create constraint trigger "RI_ConstraintTrigger_67110197" after
insert
    or
update
    on
    ccae_tests_cdm.drug_era
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('drug_era_drug_concept_id_fkey', 'drug_era', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110201" ON ccae_tests_cdm.drug_era;

create constraint trigger "RI_ConstraintTrigger_67110201" after
insert
    or
update
    on
    ccae_tests_cdm.drug_era
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('drug_era_person_id_fkey', 'drug_era', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.drug_exposure definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.drug_exposure;

--DROP TABLE ccae_tests_cdm.drug_exposure;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.drug_exposure
(
	drug_exposure_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,drug_concept_id BIGINT NOT NULL  ENCODE RAW
	,drug_exposure_start_date DATE NOT NULL  ENCODE delta32k
	,drug_exposure_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,drug_exposure_end_date DATE   ENCODE delta32k
	,drug_exposure_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,verbatim_end_date DATE   ENCODE zstd
	,drug_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,stop_reason VARCHAR(20)   ENCODE lzo
	,refills INTEGER   ENCODE zstd
	,quantity NUMERIC(38,2)   ENCODE bytedict
	,days_supply INTEGER   ENCODE zstd
	,sig VARCHAR(65535)   ENCODE lzo
	,route_concept_id BIGINT   ENCODE zstd
	,lot_number VARCHAR(65535)   ENCODE lzo
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE lzo
	,drug_source_value VARCHAR(65535)   ENCODE zstd
	,drug_source_concept_id BIGINT   ENCODE zstd
	,route_source_value VARCHAR(65535)   ENCODE lzo
	,dose_unit_source_value VARCHAR(65535)   ENCODE lzo
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	drug_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.drug_exposure owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110100" ON ccae_tests_cdm.drug_exposure;

create constraint trigger "RI_ConstraintTrigger_67110100" after
insert
    or
update
    on
    ccae_tests_cdm.drug_exposure
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('drug_exposure_drug_concept_id_fkey', 'drug_exposure', 'concept', 'UNSPECIFIED', 'drug_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110104" ON ccae_tests_cdm.drug_exposure;

create constraint trigger "RI_ConstraintTrigger_67110104" after
insert
    or
update
    on
    ccae_tests_cdm.drug_exposure
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('drug_exposure_person_id_fkey', 'drug_exposure', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.episode definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.episode;

--DROP TABLE ccae_tests_cdm.episode;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.episode
(
	episode_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE RAW
	,episode_concept_id BIGINT NOT NULL  ENCODE RAW
	,episode_start_date DATE NOT NULL  ENCODE zstd
	,episode_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,episode_end_date DATE   ENCODE zstd
	,episode_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,episode_parent_id BIGINT   ENCODE zstd
	,episode_number INTEGER   ENCODE zstd
	,episode_object_concept_id BIGINT NOT NULL  ENCODE zstd
	,episode_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,episode_source_value VARCHAR(250)   ENCODE zstd
	,episode_source_concept_id BIGINT   ENCODE zstd
	,PRIMARY KEY (episode_id)
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, episode_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.episode owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110228" ON ccae_tests_cdm.episode;

create constraint trigger "RI_ConstraintTrigger_67110228" after
insert
    or
update
    on
    ccae_tests_cdm.episode
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('episode_episode_concept_id_fkey', 'episode', 'concept', 'UNSPECIFIED', 'episode_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110232" ON ccae_tests_cdm.episode;

create constraint trigger "RI_ConstraintTrigger_67110232" after
insert
    or
update
    on
    ccae_tests_cdm.episode
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('episode_person_id_fkey', 'episode', 'person', 'UNSPECIFIED', 'person_id', 'person_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110240" ON ccae_tests_cdm.episode;

create constraint trigger "RI_ConstraintTrigger_67110240" after
delete
    on
    ccae_tests_cdm.episode
from
    ccae_tests_cdm.episode_event not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('episode_event_episode_id_fkey', 'episode_event', 'episode', 'UNSPECIFIED', 'episode_id', 'episode_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110241" ON ccae_tests_cdm.episode;

create constraint trigger "RI_ConstraintTrigger_67110241" after
update
    on
    ccae_tests_cdm.episode
from
    ccae_tests_cdm.episode_event not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('episode_event_episode_id_fkey', 'episode_event', 'episode', 'UNSPECIFIED', 'episode_id', 'episode_id');


-- ccae_tests_cdm.episode_event definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.episode_event;

--DROP TABLE ccae_tests_cdm.episode_event;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.episode_event
(
	episode_id BIGINT NOT NULL  ENCODE RAW
	,event_id BIGINT NOT NULL  ENCODE zstd
	,episode_event_field_concept_id BIGINT NOT NULL  ENCODE RAW
)
DISTSTYLE AUTO
 SORTKEY (
	episode_id
	, episode_event_field_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.episode_event owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110239" ON ccae_tests_cdm.episode_event;

create constraint trigger "RI_ConstraintTrigger_67110239" after
insert
    or
update
    on
    ccae_tests_cdm.episode_event
from
    ccae_tests_cdm.episode not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('episode_event_episode_id_fkey', 'episode_event', 'episode', 'UNSPECIFIED', 'episode_id', 'episode_id');


-- ccae_tests_cdm.measurement definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.measurement;

--DROP TABLE ccae_tests_cdm.measurement;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.measurement
(
	measurement_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,measurement_concept_id BIGINT NOT NULL  ENCODE RAW
	,measurement_date DATE NOT NULL  ENCODE delta32k
	,measurement_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,measurement_time VARCHAR(50)   ENCODE zstd
	,measurement_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,operator_concept_id BIGINT   ENCODE zstd
	,value_as_number NUMERIC(38,2)   ENCODE zstd
	,value_as_concept_id BIGINT   ENCODE zstd
	,unit_concept_id BIGINT   ENCODE zstd
	,range_low NUMERIC(38,2)   ENCODE zstd
	,range_high NUMERIC(38,2)   ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE zstd
	,measurement_source_value VARCHAR(65535)   ENCODE zstd
	,measurement_source_concept_id BIGINT   ENCODE zstd
	,unit_source_value VARCHAR(65535)   ENCODE zstd
	,unit_source_concept_id BIGINT   ENCODE zstd
	,value_source_value VARCHAR(65535)   ENCODE zstd
	,measurement_event_id BIGINT   ENCODE zstd
	,meas_event_field_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	measurement_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.measurement owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110133" ON ccae_tests_cdm.measurement;

create constraint trigger "RI_ConstraintTrigger_67110133" after
insert
    or
update
    on
    ccae_tests_cdm.measurement
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('measurement_measurement_concept_id_fkey', 'measurement', 'concept', 'UNSPECIFIED', 'measurement_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110137" ON ccae_tests_cdm.measurement;

create constraint trigger "RI_ConstraintTrigger_67110137" after
insert
    or
update
    on
    ccae_tests_cdm.measurement
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('measurement_person_id_fkey', 'measurement', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.note definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.note;

--DROP TABLE ccae_tests_cdm.note;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.note
(
	note_id BIGINT NOT NULL  ENCODE az64
	,person_id BIGINT NOT NULL  ENCODE RAW
	,note_date DATE NOT NULL  ENCODE az64
	,note_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE az64
	,note_type_concept_id BIGINT NOT NULL  ENCODE az64
	,note_text VARCHAR(65535)   ENCODE lzo
	,provider_id BIGINT   ENCODE az64
	,visit_occurrence_id BIGINT   ENCODE az64
	,visit_detail_id BIGINT   ENCODE az64
	,note_source_value VARCHAR(50)   ENCODE lzo
	,note_class_concept_id BIGINT NOT NULL  ENCODE az64
	,note_title VARCHAR(250)   ENCODE lzo
	,encoding_concept_id BIGINT NOT NULL  ENCODE az64
	,language_concept_id BIGINT NOT NULL  ENCODE az64
	,note_event_id BIGINT   ENCODE az64
	,note_event_field_concept_id BIGINT   ENCODE az64
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	)
;
ALTER TABLE ccae_tests_cdm.note owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110144" ON ccae_tests_cdm.note;

create constraint trigger "RI_ConstraintTrigger_67110144" after
insert
    or
update
    on
    ccae_tests_cdm.note
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('note_person_id_fkey', 'note', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.observation definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.observation;

--DROP TABLE ccae_tests_cdm.observation;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.observation
(
	observation_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,observation_concept_id BIGINT NOT NULL  ENCODE RAW
	,observation_date DATE NOT NULL  ENCODE delta32k
	,observation_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,observation_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,value_as_number NUMERIC(38,2)   ENCODE zstd
	,value_as_string VARCHAR(65535)   ENCODE zstd
	,value_as_concept_id BIGINT   ENCODE zstd
	,qualifier_concept_id BIGINT   ENCODE zstd
	,unit_concept_id BIGINT   ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE lzo
	,observation_source_value VARCHAR(65535)   ENCODE zstd
	,observation_source_concept_id BIGINT   ENCODE zstd
	,unit_source_value VARCHAR(65535)   ENCODE zstd
	,qualifier_source_value VARCHAR(65535)   ENCODE lzo
	,value_source_value VARCHAR(700)   ENCODE zstd
	,observation_event_id BIGINT   ENCODE zstd
	,obs_event_field_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	observation_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.observation owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110154" ON ccae_tests_cdm.observation;

create constraint trigger "RI_ConstraintTrigger_67110154" after
insert
    or
update
    on
    ccae_tests_cdm.observation
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('observation_observation_concept_id_fkey', 'observation', 'concept', 'UNSPECIFIED', 'observation_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110158" ON ccae_tests_cdm.observation;

create constraint trigger "RI_ConstraintTrigger_67110158" after
insert
    or
update
    on
    ccae_tests_cdm.observation
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('observation_person_id_fkey', 'observation', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.observation_period definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.observation_period;

--DROP TABLE ccae_tests_cdm.observation_period;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.observation_period
(
	observation_period_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE RAW
	,observation_period_start_date DATE NOT NULL  ENCODE bytedict
	,observation_period_end_date DATE NOT NULL  ENCODE bytedict
	,period_type_concept_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	)
;
ALTER TABLE ccae_tests_cdm.observation_period owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110038" ON ccae_tests_cdm.observation_period;

create constraint trigger "RI_ConstraintTrigger_67110038" after
insert
    or
update
    on
    ccae_tests_cdm.observation_period
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('observation_period_person_id_fkey', 'observation_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.payer_plan_period definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.payer_plan_period;

--DROP TABLE ccae_tests_cdm.payer_plan_period;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.payer_plan_period
(
	payer_plan_period_id BIGINT NOT NULL  ENCODE delta
	,person_id BIGINT NOT NULL  ENCODE RAW
	,payer_plan_period_start_date DATE NOT NULL  ENCODE zstd
	,payer_plan_period_end_date DATE NOT NULL  ENCODE bytedict
	,payer_concept_id BIGINT   ENCODE RAW
	,payer_source_value VARCHAR(150)   ENCODE zstd
	,payer_source_concept_id BIGINT   ENCODE zstd
	,plan_concept_id BIGINT   ENCODE zstd
	,plan_source_value VARCHAR(150)   ENCODE zstd
	,plan_source_concept_id BIGINT   ENCODE zstd
	,sponsor_concept_id BIGINT   ENCODE zstd
	,sponsor_source_value VARCHAR(150)   ENCODE zstd
	,sponsor_source_concept_id BIGINT   ENCODE zstd
	,family_source_value VARCHAR(150)   ENCODE zstd
	,stop_reason_concept_id BIGINT   ENCODE zstd
	,stop_reason_source_value VARCHAR(150)   ENCODE zstd
	,stop_reason_source_concept_id BIGINT   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, payer_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.payer_plan_period owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110177" ON ccae_tests_cdm.payer_plan_period;

create constraint trigger "RI_ConstraintTrigger_67110177" after
insert
    or
update
    on
    ccae_tests_cdm.payer_plan_period
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('payer_plan_period_payer_concept_id_fkey', 'payer_plan_period', 'concept', 'UNSPECIFIED', 'payer_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110181" ON ccae_tests_cdm.payer_plan_period;

create constraint trigger "RI_ConstraintTrigger_67110181" after
insert
    or
update
    on
    ccae_tests_cdm.payer_plan_period
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('payer_plan_period_person_id_fkey', 'payer_plan_period', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.procedure_occurrence definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.procedure_occurrence;

--DROP TABLE ccae_tests_cdm.procedure_occurrence;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.procedure_occurrence
(
	procedure_occurrence_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE az64
	,procedure_concept_id BIGINT NOT NULL  ENCODE RAW
	,procedure_date DATE NOT NULL  ENCODE zstd
	,procedure_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,procedure_end_date DATE   ENCODE zstd
	,procedure_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,procedure_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,modifier_concept_id BIGINT   ENCODE zstd
	,quantity INTEGER   ENCODE lzo
	,provider_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT   ENCODE zstd
	,visit_detail_id BIGINT   ENCODE lzo
	,procedure_source_value VARCHAR(500)   ENCODE zstd
	,procedure_source_concept_id BIGINT   ENCODE zstd
	,modifier_source_value VARCHAR(50)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	procedure_concept_id
	, person_id
	)
;
ALTER TABLE ccae_tests_cdm.procedure_occurrence owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110089" ON ccae_tests_cdm.procedure_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110089" after
insert
    or
update
    on
    ccae_tests_cdm.procedure_occurrence
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('procedure_occurrence_procedure_concept_id_fkey', 'procedure_occurrence', 'concept', 'UNSPECIFIED', 'procedure_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110093" ON ccae_tests_cdm.procedure_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110093" after
insert
    or
update
    on
    ccae_tests_cdm.procedure_occurrence
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('procedure_occurrence_person_id_fkey', 'procedure_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.specimen definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.specimen;

--DROP TABLE ccae_tests_cdm.specimen;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.specimen
(
	specimen_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE RAW
	,specimen_concept_id BIGINT NOT NULL  ENCODE RAW
	,specimen_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,specimen_date DATE NOT NULL  ENCODE zstd
	,specimen_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,quantity DOUBLE PRECISION   ENCODE zstd
	,unit_concept_id BIGINT   ENCODE zstd
	,anatomic_site_concept_id BIGINT   ENCODE zstd
	,disease_status_concept_id BIGINT   ENCODE zstd
	,specimen_source_id VARCHAR(50)   ENCODE zstd
	,specimen_source_value VARCHAR(50)   ENCODE zstd
	,unit_source_value VARCHAR(50)   ENCODE zstd
	,anatomic_site_source_value VARCHAR(50)   ENCODE zstd
	,disease_status_source_value VARCHAR(50)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, specimen_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.specimen owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110045" ON ccae_tests_cdm.specimen;

create constraint trigger "RI_ConstraintTrigger_67110045" after
insert
    or
update
    on
    ccae_tests_cdm.specimen
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('specimen_specimen_concept_id_fkey', 'specimen', 'concept', 'UNSPECIFIED', 'specimen_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110049" ON ccae_tests_cdm.specimen;

create constraint trigger "RI_ConstraintTrigger_67110049" after
insert
    or
update
    on
    ccae_tests_cdm.specimen
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('specimen_person_id_fkey', 'specimen', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.visit_detail definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.visit_detail;

--DROP TABLE ccae_tests_cdm.visit_detail;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.visit_detail
(
	visit_detail_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE RAW
	,visit_detail_concept_id BIGINT NOT NULL  ENCODE RAW
	,visit_detail_start_date DATE NOT NULL  ENCODE zstd
	,visit_detail_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE az64
	,visit_detail_end_date DATE NOT NULL  ENCODE zstd
	,visit_detail_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE az64
	,visit_detail_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,care_site_id BIGINT   ENCODE zstd
	,admitted_from_concept_id BIGINT   ENCODE zstd
	,discharged_to_concept_id BIGINT   ENCODE zstd
	,preceding_visit_detail_id BIGINT   ENCODE zstd
	,visit_detail_source_value VARCHAR(150)   ENCODE zstd
	,visit_detail_source_concept_id BIGINT   ENCODE zstd
	,admitted_from_source_value VARCHAR(150)   ENCODE zstd
	,discharged_to_source_value VARCHAR(150)   ENCODE zstd
	,parent_visit_detail_id BIGINT   ENCODE zstd
	,visit_occurrence_id BIGINT NOT NULL  ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, visit_detail_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.visit_detail owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110078" ON ccae_tests_cdm.visit_detail;

create constraint trigger "RI_ConstraintTrigger_67110078" after
insert
    or
update
    on
    ccae_tests_cdm.visit_detail
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('visit_detail_visit_detail_concept_id_fkey', 'visit_detail', 'concept', 'UNSPECIFIED', 'visit_detail_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110082" ON ccae_tests_cdm.visit_detail;

create constraint trigger "RI_ConstraintTrigger_67110082" after
insert
    or
update
    on
    ccae_tests_cdm.visit_detail
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('visit_detail_person_id_fkey', 'visit_detail', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


-- ccae_tests_cdm.visit_occurrence definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.visit_occurrence;

--DROP TABLE ccae_tests_cdm.visit_occurrence;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.visit_occurrence
(
	visit_occurrence_id BIGINT NOT NULL  ENCODE zstd
	,person_id BIGINT NOT NULL  ENCODE RAW
	,visit_concept_id BIGINT NOT NULL  ENCODE RAW
	,visit_start_date DATE NOT NULL  ENCODE zstd
	,visit_start_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,visit_end_date DATE NOT NULL  ENCODE zstd
	,visit_end_datetime TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,visit_type_concept_id BIGINT NOT NULL  ENCODE zstd
	,provider_id BIGINT   ENCODE zstd
	,care_site_id BIGINT   ENCODE zstd
	,visit_source_value VARCHAR(150)   ENCODE zstd
	,visit_source_concept_id BIGINT   ENCODE zstd
	,admitted_from_concept_id BIGINT   ENCODE zstd
	,admitted_from_source_value VARCHAR(150)   ENCODE lzo
	,discharged_to_concept_id BIGINT   ENCODE zstd
	,discharged_to_source_value VARCHAR(150)   ENCODE lzo
	,preceding_visit_occurrence_id BIGINT   ENCODE lzo
)
DISTSTYLE KEY
 DISTKEY (person_id)
 SORTKEY (
	person_id
	, visit_concept_id
	)
;
ALTER TABLE ccae_tests_cdm.visit_occurrence owner to rhealth_etl;

-- Table Triggers

-- DROP TRIGGER "RI_ConstraintTrigger_67110067" ON ccae_tests_cdm.visit_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110067" after
insert
    or
update
    on
    ccae_tests_cdm.visit_occurrence
from
    ccae_tests_cdm.concept not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('visit_occurrence_visit_concept_id_fkey', 'visit_occurrence', 'concept', 'UNSPECIFIED', 'visit_concept_id', 'concept_id');
-- DROP TRIGGER "RI_ConstraintTrigger_67110071" ON ccae_tests_cdm.visit_occurrence;

create constraint trigger "RI_ConstraintTrigger_67110071" after
insert
    or
update
    on
    ccae_tests_cdm.visit_occurrence
from
    ccae_tests_cdm.person not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('visit_occurrence_person_id_fkey', 'visit_occurrence', 'person', 'UNSPECIFIED', 'person_id', 'person_id');


