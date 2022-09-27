CREATE SCHEMA IF NOT EXISTS {VOCABULARY_SCHEMA};

DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.DRUG_STRENGTH;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.CONCEPT;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.CONCEPT_RELATIONSHIP;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.CONCEPT_ANCESTOR;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.CONCEPT_SYNONYM;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.VOCABULARY;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.RELATIONSHIP;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.CONCEPT_CLASS;
DROP TABLE IF EXISTS {VOCABULARY_SCHEMA}.DOMAIN;

CREATE TABLE {VOCABULARY_SCHEMA}.CONCEPT (
			concept_id integer NOT NULL, 
			concept_name varchar(255) NOT NULL, 
			domain_id varchar(20) NOT NULL, 
			vocabulary_id varchar(20) NOT NULL, 
			concept_class_id varchar(20) NOT NULL, 
			standard_concept varchar(1) NULL, 
			concept_code varchar(50) NOT NULL, 
			valid_start_date date NOT NULL, 
			valid_end_date date NOT NULL, 
			invalid_reason varchar(1) NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.VOCABULARY (
			vocabulary_id varchar(20) NOT NULL, 
			vocabulary_name varchar(255) NOT NULL, 
			vocabulary_reference varchar(255) NOT NULL, 
			vocabulary_version varchar(255) NULL, 
			vocabulary_concept_id integer NOT NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.DOMAIN (
			domain_id varchar(20) NOT NULL, 
			domain_name varchar(255) NOT NULL, 
			domain_concept_id integer NOT NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.CONCEPT_CLASS (
			concept_class_id varchar(20) NOT NULL, 
			concept_class_name varchar(255) NOT NULL, 
			concept_class_concept_id integer NOT NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.CONCEPT_RELATIONSHIP (
			concept_id_1 varchar(20) NOT NULL, 
			concept_id_2 varchar(20) NOT NULL, 
			relationship_id varchar(20) NOT NULL, 
			valid_start_date varchar(10) NOT NULL, 
			valid_end_date varchar(10) NOT NULL, 
			invalid_reason varchar(1) NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.RELATIONSHIP (
			relationship_id varchar(20) NOT NULL, 
			relationship_name varchar(255) NOT NULL, 
			is_hierarchical varchar(1) NOT NULL, 
			defines_ancestry varchar(1) NOT NULL, 
			reverse_relationship_id varchar(20) NOT NULL, 
			relationship_concept_id integer NOT NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.CONCEPT_SYNONYM ( 
			concept_id integer NOT NULL, 
			concept_synonym_name varchar(1000) NOT NULL, 
			language_concept_id integer NOT NULL );  

CREATE TABLE {VOCABULARY_SCHEMA}.CONCEPT_ANCESTOR (
			ancestor_concept_id integer NOT NULL, 
			descendant_concept_id integer NOT NULL, 
			min_levels_of_separation integer NOT NULL, 
			max_levels_of_separation integer NOT NULL );    

CREATE TABLE {VOCABULARY_SCHEMA}.DRUG_STRENGTH (
			drug_concept_id integer NOT NULL, 
			ingredient_concept_id integer NOT NULL, 
			amount_value NUMERIC NULL, 
			amount_unit_concept_id integer NULL, 
			numerator_value NUMERIC NULL, 
			numerator_unit_concept_id integer NULL, 
			denominator_value NUMERIC NULL, 
			denominator_unit_concept_id integer NULL, 
			box_size integer NULL, 
			valid_start_date date NOT NULL, 
			valid_end_date date NOT NULL, 
			invalid_reason varchar(1) NULL );  

COPY {VOCABULARY_SCHEMA}.DRUG_STRENGTH FROM '{VOCABULARY_DIRECTORY}\DRUG_STRENGTH.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.CONCEPT FROM '{VOCABULARY_DIRECTORY}\CONCEPT.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.CONCEPT_RELATIONSHIP FROM PROGRAM 'cmd /c "type {VOCABULARY_DIRECTORY}\CONCEPT_RELATIONSHIP.csv"' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.CONCEPT_ANCESTOR FROM '{VOCABULARY_DIRECTORY}\CONCEPT_ANCESTOR.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.CONCEPT_SYNONYM FROM '{VOCABULARY_DIRECTORY}\CONCEPT_SYNONYM.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.VOCABULARY FROM '{VOCABULARY_DIRECTORY}\VOCABULARY.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.RELATIONSHIP FROM '{VOCABULARY_DIRECTORY}\RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.CONCEPT_CLASS FROM '{VOCABULARY_DIRECTORY}\CONCEPT_CLASS.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;

COPY {VOCABULARY_SCHEMA}.DOMAIN FROM '{VOCABULARY_DIRECTORY}\DOMAIN.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' ;


ALTER TABLE {VOCABULARY_SCHEMA}.concept_relationship 
    ALTER COLUMN concept_id_1 TYPE int USING concept_id_1::int,
    ALTER COLUMN concept_id_2 TYPE int USING concept_id_2::int,
    ALTER COLUMN valid_start_date TYPE date USING valid_start_date::date,
    ALTER COLUMN valid_end_date TYPE date USING valid_end_date::date
;

ALTER TABLE {VOCABULARY_SCHEMA}.concept ADD CONSTRAINT xpk_concept PRIMARY KEY (concept_id);

ALTER TABLE {VOCABULARY_SCHEMA}.vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY (vocabulary_id);

ALTER TABLE {VOCABULARY_SCHEMA}.domain ADD CONSTRAINT xpk_domain PRIMARY KEY (domain_id);

ALTER TABLE {VOCABULARY_SCHEMA}.concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY (concept_class_id);

ALTER TABLE {VOCABULARY_SCHEMA}.concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY (concept_id_1,concept_id_2,relationship_id);

ALTER TABLE {VOCABULARY_SCHEMA}.relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY (relationship_id);

ALTER TABLE {VOCABULARY_SCHEMA}.concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY (ancestor_concept_id,descendant_concept_id);

ALTER TABLE {VOCABULARY_SCHEMA}.drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY (drug_concept_id, ingredient_concept_id);



CREATE UNIQUE INDEX idx_concept_concept_id  ON {VOCABULARY_SCHEMA}.concept  (concept_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.concept  USING idx_concept_concept_id ;
CREATE INDEX idx_concept_code ON {VOCABULARY_SCHEMA}.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON {VOCABULARY_SCHEMA}.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON {VOCABULARY_SCHEMA}.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON {VOCABULARY_SCHEMA}.concept (concept_class_id ASC);
CREATE INDEX idx_concept_id_varchar ON {VOCABULARY_SCHEMA}.concept (CAST(concept_id AS VARCHAR));

CREATE UNIQUE INDEX idx_vocabulary_vocabulary_id  ON {VOCABULARY_SCHEMA}.vocabulary  (vocabulary_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.vocabulary  USING idx_vocabulary_vocabulary_id ;

CREATE UNIQUE INDEX idx_domain_domain_id  ON {VOCABULARY_SCHEMA}.domain  (domain_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.domain  USING idx_domain_domain_id ;

CREATE UNIQUE INDEX idx_concept_class_class_id  ON {VOCABULARY_SCHEMA}.concept_class  (concept_class_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.concept_class  USING idx_concept_class_class_id ;

CREATE INDEX idx_concept_relationship_id_1 ON {VOCABULARY_SCHEMA}.concept_relationship (concept_id_1 ASC);
CREATE INDEX idx_concept_relationship_id_2 ON {VOCABULARY_SCHEMA}.concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON {VOCABULARY_SCHEMA}.concept_relationship (relationship_id ASC);

CREATE UNIQUE INDEX idx_relationship_rel_id  ON {VOCABULARY_SCHEMA}.relationship  (relationship_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.relationship  USING idx_relationship_rel_id ;

CREATE INDEX idx_concept_synonym_id  ON {VOCABULARY_SCHEMA}.concept_synonym  (concept_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.concept_synonym  USING idx_concept_synonym_id ;

CREATE INDEX idx_concept_ancestor_id_1  ON {VOCABULARY_SCHEMA}.concept_ancestor  (ancestor_concept_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.concept_ancestor  USING idx_concept_ancestor_id_1 ;
CREATE INDEX idx_concept_ancestor_id_2 ON {VOCABULARY_SCHEMA}.concept_ancestor (descendant_concept_id ASC);

CREATE INDEX idx_drug_strength_id_1  ON {VOCABULARY_SCHEMA}.drug_strength  (drug_concept_id ASC);
CLUSTER {VOCABULARY_SCHEMA}.drug_strength  USING idx_drug_strength_id_1 ;
CREATE INDEX idx_drug_strength_id_2 ON {VOCABULARY_SCHEMA}.drug_strength (ingredient_concept_id ASC);