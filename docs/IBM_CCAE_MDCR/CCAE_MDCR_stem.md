---
layout: default
title: IBM CCAE & MDCR to STEM
nav_order: 10
parent: IBM CCAE & MDCR
has_children: true
description: "STEM table description"
---

## CDM Table: STEM

The STEM table is a staging area where source codes like ICD9 codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (CONDITION_OCCURRENCE, DRUG_EXPOSURE, PROCEDURE_OCCURRENCE, MEASUREMENT, OBSERVATION, DEVICE_EXPOSURE) the record will move to. Please see the STEM &rarr; CDM mapping files for a description of which STEM fields move to which STEM tables.

## Key Conventions

* IBM removes decimal points from ICD diagnosis.  When mapping to the OMOP Vocabulary the decimal points need to also be removed from the Vocabulary concept code in order to map between the source and the vocabulary.  

* Only keep records with valid ICD9CM or ICD10CM diagnoses, the DXVER variable in all tables indicates the ICD version to map to. If DXVER=9 then use ICD9CM; if DXVER=0 then use ICD10CM otherwise if DXVER is null then use a date filter:
  + If before October 1, 2015 use ICD9CM
  + If after October 1, 2015 use ICD10CM (**OUTPATIENT_SERVICES** use SVCDATE, **INPATIENT_SERVICES** use ADMDATE, **FACILITY_HEADER** use SVCDATE, and **INPATIENT_ADMISSIONS** use ADMDATE).

* Valid Codes
  1)	ICD9CM must start with 0-9, V or E, and non-numeric character is not allowed in other positions.
  2)	If ICD9CM starts with 0-9 or V, length should be between 3 and 5; if starts with E, length should be between 4 and 5. 
  3)	ICD10CM must be between 3 and 7 digits

### Fields in the STEM table

| Field | 
| --- | 
| ID | 
| DOMAIN_ID |  
| PERSON_ID | 
| VISIT_OCCURRENCE_ID | 
| PROVIDER_ID | 
| START_DATETIME | 
| CONCEPT_ID | 
| SOURCE_CONCEPT_ID | 
| TYPE_CONCEPT_ID |  
| OPERATOR_CONCEPT_ID | 
| UNIT_CONCEPT_ID |  
| UNIT_SOURCE_VALUE | 
| START_DATE |  
| END_DATE |  
| RANGE_HIGH |  
| RANGE_LOW | 
| VALUE_AS_NUMBER | 
| VALUE_AS_STRING | 
| VALUE_AS_CONCEPT_ID | 
| VALUE_SOURCE_VALUE | 
| END_DATETIME | 
| VERBATIM_END_DATE |  
| DAYS_SUPPLY | 
| DOSE_UNIT_SOURCE_VALUE | 
| LOT_NUMBER | 
| MODIFIER_CONCEPT_ID | 
| MODIFIER_SOURCE_VALUE | 
| QUANTITY | 
| REFILLS | 
| ROUTE_CONCEPT_ID | 
| ROUTE_SOURCE_VALUE | 
| SIG |  
| STOP_REASON | 
| UNIQUE_DEVICE_ID | 
| ANATOMIC_SITE_CONCEPT_ID | 
| DISEASE_STATUS_CONCEPT_ID |  
| SPECIMEN_SOURCE_ID |
| ANATOMIC_SITE_SOURCE_VALUE | 
| DISEASE_STATUS_SOURCE_VALUE | 
| CONDITION_STATUS_CONCEPT_ID | 
| CONDITION_STATUS_SOURCE_VALUE |  
| EVENT_FIELD_CONCEPT_ID |
| EVENT_ID |
| QUALIFIER_CONCEPT_ID |
| QUALIFIER_SOURCE_VALUE |
| SIG |
| SOURCE_VALUE |
| VALUE_AS_DATETIME |
| VISIT_DETAIL_ID |

