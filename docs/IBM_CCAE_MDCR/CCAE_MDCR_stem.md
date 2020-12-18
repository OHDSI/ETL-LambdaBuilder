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


### Lookups Leveraged Across Tables

