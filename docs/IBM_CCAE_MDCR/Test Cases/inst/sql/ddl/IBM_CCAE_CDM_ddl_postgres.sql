-- DROP SCHEMA ccae_tests_cdm;

CREATE SCHEMA ccae_tests_cdm;
-- ccae_tests_cdm."_version" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."_version";

--DROP TABLE ccae_tests_cdm._version;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm._version
(
	version_id INTEGER NOT NULL  
	,version_date DATE NOT NULL  
)

;


-- ccae_tests_cdm.care_site definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.care_site;

--DROP TABLE ccae_tests_cdm.care_site;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.care_site
(
	care_site_id BIGINT NOT NULL  
	,care_site_name VARCHAR(255)   
	,place_of_service_concept_id BIGINT   
	,location_id BIGINT   
	,care_site_source_value VARCHAR(150)   
	,place_of_service_source_value VARCHAR(150)   
)

;


-- ccae_tests_cdm.cdm_source definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cdm_source;

--DROP TABLE ccae_tests_cdm.cdm_source;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cdm_source
(
	cdm_source_name VARCHAR(255) NOT NULL  
	,cdm_source_abbreviation VARCHAR(30)   
	,cdm_holder VARCHAR(255)   
	,source_description VARCHAR(65535)   
	,source_documentation_reference VARCHAR(255)   
	,cdm_etl_reference VARCHAR(255)   
	,source_release_date DATE   
	,cdm_release_date DATE   
	,cdm_version VARCHAR(10)   
	,cdm_version_concept_id BIGINT NOT NULL  
	,vocabulary_version VARCHAR(20)   
)

;


-- ccae_tests_cdm.cohort definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cohort;

--DROP TABLE ccae_tests_cdm.cohort;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cohort
(
	cohort_definition_id BIGINT NOT NULL  
	,subject_id BIGINT NOT NULL  
	,cohort_start_date DATE NOT NULL  
	,cohort_end_date DATE NOT NULL  
)
;


-- ccae_tests_cdm.cohort_definition definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cohort_definition;

--DROP TABLE ccae_tests_cdm.cohort_definition;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cohort_definition
(
	cohort_definition_id BIGINT NOT NULL  
	,cohort_definition_name VARCHAR(255) NOT NULL  
	,cohort_definition_description VARCHAR(65535)   
	,definition_type_concept_id BIGINT NOT NULL  
	,cohort_definition_syntax VARCHAR(65535)   
	,subject_concept_id BIGINT NOT NULL  
	,cohort_initiation_date DATE   
)

;


-- ccae_tests_cdm.concept definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept;

--DROP TABLE ccae_tests_cdm.concept;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept
(
	concept_id BIGINT NOT NULL  
	,concept_name VARCHAR(500) NOT NULL  
	,domain_id VARCHAR(20) NOT NULL  
	,vocabulary_id VARCHAR(200) NOT NULL  
	,concept_class_id VARCHAR(20) NOT NULL  
	,standard_concept VARCHAR(1)   
	,concept_code VARCHAR(100) NOT NULL  
	,valid_start_date DATE NOT NULL  
	,valid_end_date DATE NOT NULL  
	,invalid_reason VARCHAR(1)   
	,PRIMARY KEY (concept_id)
)
;

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
	ancestor_concept_id BIGINT NOT NULL  
	,descendant_concept_id BIGINT NOT NULL  
	,min_levels_of_separation INTEGER NOT NULL  
	,max_levels_of_separation INTEGER NOT NULL  
)
;


-- ccae_tests_cdm.concept_class definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_class;

--DROP TABLE ccae_tests_cdm.concept_class;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_class
(
	concept_class_id VARCHAR(20) NOT NULL  
	,concept_class_name VARCHAR(255) NOT NULL  
	,concept_class_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm.concept_synonym definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_synonym;

--DROP TABLE ccae_tests_cdm.concept_synonym;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_synonym
(
	concept_id BIGINT NOT NULL  
	,concept_synonym_name VARCHAR(1500) NOT NULL  
	,language_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm.cost definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.cost;

--DROP TABLE ccae_tests_cdm.cost;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.cost
(
	cost_id BIGINT NOT NULL  
	,cost_event_id BIGINT NOT NULL  
	,cost_domain_id VARCHAR(20) NOT NULL  
	,cost_type_concept_id BIGINT NOT NULL  
	,currency_concept_id BIGINT   
	,total_charge NUMERIC(38,2)   
	,total_cost NUMERIC(38,2)   
	,total_paid NUMERIC(38,2)   
	,paid_by_payer NUMERIC(38,2)   
	,paid_by_patient NUMERIC(38,2)   
	,paid_patient_copay NUMERIC(38,2)   
	,paid_patient_coinsurance NUMERIC(38,2)   
	,paid_patient_deductible NUMERIC(38,2)   
	,paid_by_primary NUMERIC(38,2)   
	,paid_ingredient_cost NUMERIC(38,2)   
	,paid_dispensing_fee NUMERIC(38,2)   
	,payer_plan_period_id BIGINT   
	,amount_allowed NUMERIC(38,2)   
	,revenue_code_concept_id BIGINT   
	,revenue_code_source_value VARCHAR(50)   
	,drg_concept_id BIGINT   
	,drg_source_value VARCHAR(3)   
)
;


-- ccae_tests_cdm."domain" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."domain";

--DROP TABLE ccae_tests_cdm."domain";
CREATE TABLE IF NOT EXISTS ccae_tests_cdm."domain"
(
	domain_id VARCHAR(20) NOT NULL  
	,domain_name VARCHAR(255) NOT NULL  
	,domain_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm.drug_strength definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.drug_strength;

--DROP TABLE ccae_tests_cdm.drug_strength;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.drug_strength
(
	drug_concept_id BIGINT NOT NULL  
	,ingredient_concept_id BIGINT NOT NULL  
	,amount_value DOUBLE PRECISION   
	,amount_unit_concept_id BIGINT   
	,numerator_value DOUBLE PRECISION   
	,numerator_unit_concept_id BIGINT   
	,denominator_value DOUBLE PRECISION   
	,denominator_unit_concept_id BIGINT   
	,box_size INTEGER   
	,valid_start_date DATE NOT NULL  
	,valid_end_date DATE NOT NULL  
	,invalid_reason VARCHAR(1)   
)

;


-- ccae_tests_cdm.fact_relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.fact_relationship;

--DROP TABLE ccae_tests_cdm.fact_relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.fact_relationship
(
	domain_concept_id_1 BIGINT NOT NULL  
	,fact_id_1 BIGINT NOT NULL  
	,domain_concept_id_2 BIGINT NOT NULL  
	,fact_id_2 BIGINT NOT NULL  
	,relationship_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm."location" definition

-- Drop table

-- DROP TABLE ccae_tests_cdm."location";

--DROP TABLE ccae_tests_cdm."location";
CREATE TABLE IF NOT EXISTS ccae_tests_cdm."location"
(
	location_id BIGINT NOT NULL  
	,address_1 VARCHAR(50)   
	,address_2 VARCHAR(50)   
	,city VARCHAR(50)   
	,state VARCHAR(25)   
	,zip VARCHAR(9)   
	,county VARCHAR(20)   
	,location_source_value VARCHAR(50)   
	,country_concept_id BIGINT   
	,country_source_value VARCHAR(150)   
	,latitude NUMERIC(38,2)   
	,longitude NUMERIC(38,2)   
)

;


-- ccae_tests_cdm.metadata definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.metadata;

--DROP TABLE ccae_tests_cdm.metadata;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.metadata
(
	metadata_id BIGINT NOT NULL  
	,metadata_concept_id BIGINT NOT NULL  
	,metadata_type_concept_id BIGINT NOT NULL  
	,name VARCHAR(250) NOT NULL  
	,value_as_string VARCHAR(65535)   
	,value_as_concept_id BIGINT   
	,value_as_number NUMERIC(38,2)   
	,metadata_date DATE   
	,metadata_datetime TIMESTAMP   
)

;


-- ccae_tests_cdm.note_nlp definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.note_nlp;

--DROP TABLE ccae_tests_cdm.note_nlp;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.note_nlp
(
	note_nlp_id BIGINT NOT NULL  
	,note_id BIGINT NOT NULL  
	,section_concept_id BIGINT   
	,snippet VARCHAR(250)   
	,"offset" VARCHAR(250)   
	,lexical_variant VARCHAR(250) NOT NULL  
	,note_nlp_concept_id BIGINT   
	,note_nlp_source_concept_id BIGINT   
	,nlp_system VARCHAR(250)   
	,nlp_date DATE NOT NULL  
	,nlp_datetime TIMESTAMP   
	,term_exists VARCHAR(1)   
	,term_temporal VARCHAR(50)   
	,term_modifiers VARCHAR(2000)   
)

;


-- ccae_tests_cdm.person definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.person;

--DROP TABLE ccae_tests_cdm.person;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.person
(
	person_id BIGINT NOT NULL  
	,gender_concept_id BIGINT NOT NULL  
	,year_of_birth INTEGER NOT NULL  
	,month_of_birth INTEGER   
	,day_of_birth INTEGER   
	,birth_datetime TIMESTAMP   
	,race_concept_id BIGINT NOT NULL  
	,ethnicity_concept_id BIGINT NOT NULL  
	,location_id BIGINT   
	,provider_id BIGINT   
	,care_site_id BIGINT   
	,person_source_value VARCHAR(50)   
	,gender_source_value VARCHAR(50)   
	,gender_source_concept_id BIGINT   
	,race_source_value VARCHAR(50)   
	,race_source_concept_id BIGINT   
	,ethnicity_source_value VARCHAR(50)   
	,ethnicity_source_concept_id BIGINT   
	,PRIMARY KEY (person_id)
)
;

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
	provider_id BIGINT NOT NULL  
	,provider_name VARCHAR(255)   
	,npi VARCHAR(25)   
	,dea VARCHAR(20)   
	,specialty_concept_id BIGINT   
	,care_site_id BIGINT   
	,year_of_birth INTEGER   
	,gender_concept_id BIGINT   
	,provider_source_value VARCHAR(100)   
	,specialty_source_value VARCHAR(100)   
	,specialty_source_concept_id BIGINT   
	,gender_source_value VARCHAR(50)   
	,gender_source_concept_id BIGINT   
)

;


-- ccae_tests_cdm.relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.relationship;

--DROP TABLE ccae_tests_cdm.relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.relationship
(
	relationship_id VARCHAR(20) NOT NULL  
	,relationship_name VARCHAR(255) NOT NULL  
	,is_hierarchical VARCHAR(1) NOT NULL  
	,defines_ancestry VARCHAR(1) NOT NULL  
	,reverse_relationship_id VARCHAR(20) NOT NULL  
	,relationship_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm.source_to_concept_map definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.source_to_concept_map;

--DROP TABLE ccae_tests_cdm.source_to_concept_map;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.source_to_concept_map
(
	source_code VARCHAR(255)   
	,source_concept_id BIGINT NOT NULL  
	,source_vocabulary_id VARCHAR(50) NOT NULL  
	,source_code_description VARCHAR(255)   
	,target_concept_id BIGINT NOT NULL  
	,target_vocabulary_id VARCHAR(50)   
	,valid_start_date DATE NOT NULL  
	,valid_end_date DATE NOT NULL  
	,invalid_reason VARCHAR(1)   
)

;


-- ccae_tests_cdm.test_results definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.test_results;

--DROP TABLE ccae_tests_cdm.test_results;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.test_results
(
	id INTEGER   
	,description VARCHAR(512)   
	,test VARCHAR(256)   
	,status VARCHAR(5)   
)
;


-- ccae_tests_cdm.vocabulary definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.vocabulary;

--DROP TABLE ccae_tests_cdm.vocabulary;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.vocabulary
(
	vocabulary_id VARCHAR(20) NOT NULL  
	,vocabulary_name VARCHAR(255) NOT NULL  
	,vocabulary_reference VARCHAR(255)   
	,vocabulary_version VARCHAR(255)   
	,vocabulary_concept_id BIGINT NOT NULL  
)

;


-- ccae_tests_cdm.concept_relationship definition

-- Drop table

-- DROP TABLE ccae_tests_cdm.concept_relationship;

--DROP TABLE ccae_tests_cdm.concept_relationship;
CREATE TABLE IF NOT EXISTS ccae_tests_cdm.concept_relationship
(
	concept_id_1 BIGINT NOT NULL  
	,concept_id_2 BIGINT NOT NULL  
	,relationship_id VARCHAR(20) NOT NULL  
	,valid_start_date DATE NOT NULL  
	,valid_end_date DATE NOT NULL  
	,invalid_reason VARCHAR(1)   
)
;

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
	condition_era_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,condition_concept_id BIGINT NOT NULL  
	,condition_era_start_date DATE NOT NULL  
	,condition_era_end_date DATE NOT NULL  
	,condition_occurrence_count INTEGER   
)
;

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
	condition_occurrence_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,condition_concept_id BIGINT NOT NULL  
	,condition_start_date DATE NOT NULL  
	,condition_start_datetime TIMESTAMP   
	,condition_end_date DATE   
	,condition_end_datetime TIMESTAMP   
	,condition_type_concept_id BIGINT NOT NULL  
	,stop_reason VARCHAR(20)   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,condition_status_concept_id BIGINT   
	,condition_source_value VARCHAR(65535)   
	,condition_source_concept_id BIGINT   
	,condition_status_source_value VARCHAR(65535)   
)
;

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
	person_id BIGINT NOT NULL  
	,death_date DATE NOT NULL  
	,death_datetime TIMESTAMP   
	,death_type_concept_id BIGINT NOT NULL  
	,cause_concept_id BIGINT   
	,cause_source_value VARCHAR(50)   
	,cause_source_concept_id BIGINT   
)
;

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
	device_exposure_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,device_concept_id BIGINT NOT NULL  
	,device_exposure_start_date DATE NOT NULL  
	,device_exposure_start_datetime TIMESTAMP   
	,device_exposure_end_date DATE   
	,device_exposure_end_datetime TIMESTAMP   
	,device_type_concept_id BIGINT NOT NULL  
	,unique_device_id VARCHAR(50)   
	,production_id VARCHAR(255)   
	,quantity INTEGER   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,device_source_value VARCHAR(255)   
	,device_source_concept_id BIGINT   
	,unit_concept_id BIGINT   
	,unit_source_value VARCHAR(255)   
	,unit_source_concept_id BIGINT   
)
;

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
	dose_era_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,drug_concept_id BIGINT NOT NULL  
	,unit_concept_id BIGINT NOT NULL  
	,dose_value NUMERIC(38,2) NOT NULL  
	,dose_era_start_date DATE NOT NULL  
	,dose_era_end_date DATE NOT NULL  
)
;

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
	drug_era_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,drug_concept_id BIGINT NOT NULL  
	,drug_era_start_date DATE NOT NULL  
	,drug_era_end_date DATE NOT NULL  
	,drug_exposure_count INTEGER   
	,gap_days INTEGER   
)
;

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
	drug_exposure_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,drug_concept_id BIGINT NOT NULL  
	,drug_exposure_start_date DATE NOT NULL  
	,drug_exposure_start_datetime TIMESTAMP   
	,drug_exposure_end_date DATE   
	,drug_exposure_end_datetime TIMESTAMP   
	,verbatim_end_date DATE   
	,drug_type_concept_id BIGINT NOT NULL  
	,stop_reason VARCHAR(20)   
	,refills INTEGER   
	,quantity NUMERIC(38,2)   
	,days_supply INTEGER   
	,sig VARCHAR(65535)   
	,route_concept_id BIGINT   
	,lot_number VARCHAR(65535)   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,drug_source_value VARCHAR(65535)   
	,drug_source_concept_id BIGINT   
	,route_source_value VARCHAR(65535)   
	,dose_unit_source_value VARCHAR(65535)   
)
;

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
	episode_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,episode_concept_id BIGINT NOT NULL  
	,episode_start_date DATE NOT NULL  
	,episode_start_datetime TIMESTAMP   
	,episode_end_date DATE   
	,episode_end_datetime TIMESTAMP   
	,episode_parent_id BIGINT   
	,episode_number INTEGER   
	,episode_object_concept_id BIGINT NOT NULL  
	,episode_type_concept_id BIGINT NOT NULL  
	,episode_source_value VARCHAR(250)   
	,episode_source_concept_id BIGINT   
	,PRIMARY KEY (episode_id)
)
;

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
	episode_id BIGINT NOT NULL  
	,event_id BIGINT NOT NULL  
	,episode_event_field_concept_id BIGINT NOT NULL  
)
;

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
	measurement_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,measurement_concept_id BIGINT NOT NULL  
	,measurement_date DATE NOT NULL  
	,measurement_datetime TIMESTAMP   
	,measurement_time VARCHAR(50)   
	,measurement_type_concept_id BIGINT NOT NULL  
	,operator_concept_id BIGINT   
	,value_as_number NUMERIC(38,2)   
	,value_as_concept_id BIGINT   
	,unit_concept_id BIGINT   
	,range_low NUMERIC(38,2)   
	,range_high NUMERIC(38,2)   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,measurement_source_value VARCHAR(65535)   
	,measurement_source_concept_id BIGINT   
	,unit_source_value VARCHAR(65535)   
	,unit_source_concept_id BIGINT   
	,value_source_value VARCHAR(65535)   
	,measurement_event_id BIGINT   
	,meas_event_field_concept_id BIGINT   
)
;

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
	note_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,note_date DATE NOT NULL  
	,note_datetime TIMESTAMP   
	,note_type_concept_id BIGINT NOT NULL  
	,note_text VARCHAR(65535)   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,note_source_value VARCHAR(50)   
	,note_class_concept_id BIGINT NOT NULL  
	,note_title VARCHAR(250)   
	,encoding_concept_id BIGINT NOT NULL  
	,language_concept_id BIGINT NOT NULL  
	,note_event_id BIGINT   
	,note_event_field_concept_id BIGINT   
)
;

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
	observation_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,observation_concept_id BIGINT NOT NULL  
	,observation_date DATE NOT NULL  
	,observation_datetime TIMESTAMP   
	,observation_type_concept_id BIGINT NOT NULL  
	,value_as_number NUMERIC(38,2)   
	,value_as_string VARCHAR(65535)   
	,value_as_concept_id BIGINT   
	,qualifier_concept_id BIGINT   
	,unit_concept_id BIGINT   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,observation_source_value VARCHAR(65535)   
	,observation_source_concept_id BIGINT   
	,unit_source_value VARCHAR(65535)   
	,qualifier_source_value VARCHAR(65535)   
	,value_source_value VARCHAR(700)   
	,observation_event_id BIGINT   
	,obs_event_field_concept_id BIGINT   
)
;

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
	observation_period_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,observation_period_start_date DATE NOT NULL  
	,observation_period_end_date DATE NOT NULL  
	,period_type_concept_id BIGINT NOT NULL  
)
;

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
	payer_plan_period_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,payer_plan_period_start_date DATE NOT NULL  
	,payer_plan_period_end_date DATE NOT NULL  
	,payer_concept_id BIGINT   
	,payer_source_value VARCHAR(150)   
	,payer_source_concept_id BIGINT   
	,plan_concept_id BIGINT   
	,plan_source_value VARCHAR(150)   
	,plan_source_concept_id BIGINT   
	,sponsor_concept_id BIGINT   
	,sponsor_source_value VARCHAR(150)   
	,sponsor_source_concept_id BIGINT   
	,family_source_value VARCHAR(150)   
	,stop_reason_concept_id BIGINT   
	,stop_reason_source_value VARCHAR(150)   
	,stop_reason_source_concept_id BIGINT   
)
;

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
	procedure_occurrence_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,procedure_concept_id BIGINT NOT NULL  
	,procedure_date DATE NOT NULL  
	,procedure_datetime TIMESTAMP   
	,procedure_end_date DATE   
	,procedure_end_datetime TIMESTAMP   
	,procedure_type_concept_id BIGINT NOT NULL  
	,modifier_concept_id BIGINT   
	,quantity INTEGER   
	,provider_id BIGINT   
	,visit_occurrence_id BIGINT   
	,visit_detail_id BIGINT   
	,procedure_source_value VARCHAR(500)   
	,procedure_source_concept_id BIGINT   
	,modifier_source_value VARCHAR(50)   
)
;

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
	specimen_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,specimen_concept_id BIGINT NOT NULL  
	,specimen_type_concept_id BIGINT NOT NULL  
	,specimen_date DATE NOT NULL  
	,specimen_datetime TIMESTAMP   
	,quantity DOUBLE PRECISION   
	,unit_concept_id BIGINT   
	,anatomic_site_concept_id BIGINT   
	,disease_status_concept_id BIGINT   
	,specimen_source_id VARCHAR(50)   
	,specimen_source_value VARCHAR(50)   
	,unit_source_value VARCHAR(50)   
	,anatomic_site_source_value VARCHAR(50)   
	,disease_status_source_value VARCHAR(50)   
)
;

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
	visit_detail_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,visit_detail_concept_id BIGINT NOT NULL  
	,visit_detail_start_date DATE NOT NULL  
	,visit_detail_start_datetime TIMESTAMP   
	,visit_detail_end_date DATE NOT NULL  
	,visit_detail_end_datetime TIMESTAMP   
	,visit_detail_type_concept_id BIGINT NOT NULL  
	,provider_id BIGINT   
	,care_site_id BIGINT   
	,admitted_from_concept_id BIGINT   
	,discharged_to_concept_id BIGINT   
	,preceding_visit_detail_id BIGINT   
	,visit_detail_source_value VARCHAR(150)   
	,visit_detail_source_concept_id BIGINT   
	,admitted_from_source_value VARCHAR(150)   
	,discharged_to_source_value VARCHAR(150)   
	,parent_visit_detail_id BIGINT   
	,visit_occurrence_id BIGINT NOT NULL  
)
;

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
	visit_occurrence_id BIGINT NOT NULL  
	,person_id BIGINT NOT NULL  
	,visit_concept_id BIGINT NOT NULL  
	,visit_start_date DATE NOT NULL  
	,visit_start_datetime TIMESTAMP   
	,visit_end_date DATE NOT NULL  
	,visit_end_datetime TIMESTAMP   
	,visit_type_concept_id BIGINT NOT NULL  
	,provider_id BIGINT   
	,care_site_id BIGINT   
	,visit_source_value VARCHAR(150)   
	,visit_source_concept_id BIGINT   
	,admitted_from_concept_id BIGINT   
	,admitted_from_source_value VARCHAR(150)   
	,discharged_to_concept_id BIGINT   
	,discharged_to_source_value VARCHAR(150)   
	,preceding_visit_occurrence_id BIGINT   
)
;

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


