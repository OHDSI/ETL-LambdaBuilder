---
layout: default
title: Procedure
nav_order: 2
parent: Optum EHR to STEM
grand_parent: OPTUM_PANTHER
description: "OPTUM EHR Procedure table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Procedure

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use proc_date to determine which VISIT_OCCURRENCE_ID the record should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid|If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id | provid_perform | Lookup the provid_perform in the PROVIDER table to get the PROVIDER_ID |If provid_perform is blank then leave PROVIDER_ID blank|
| start_date | proc_date  | | |
| end_date | proc_date | | | 
| start_datetime | proc_date proc_time | Combine the proc_date and proc_time to create a datetime| |
| end_datetime | proc_date proc_time | Combine the proc_date and proc_time to create a datetime| |
| concept_id | proc_code_type <br> proc_code|Use the proc_code_type to find the source vocabulary of the code and use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = **see comments for how to assign this**  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero.| Use the following logic to match proc_code_type with the appropriate SOURCE_VOCABULARY_ID: 'CPT4' = CPT4<br>'HCPCS' = HCPCS<br>'ICD10' = ICD10PCS<br>'ICD9' = ICD9Proc<br>'REV' = Revenue Code<br>'SNOMED' = SNOMED<br><br>For proc_code_type = ICD10, strip dot from lookup<br><br>For proc_code_type = ICD9, leave dots in lookup. |
|source_value|proc_code|||
| source_concept_id | proc_code_type <br> proc_code|Use the proc_code_type to find the source vocabulary of the code and use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = **see comments for how to assign this**<br><br> If there is no mapping available, set concept_id to zero.|Use the following logic to match proc_code_type with the appropriate SOURCE_VOCABULARY_ID: 'CPT4' = CPT4<br>'HCPCS' = HCPCS<br>'ICD10' = ICD10PCS<br>'ICD9' = ICD9Proc<br>'REV' = Revenue Code<br>'SNOMED' = SNOMED<br><br>For proc_code_type = ICD10, strip dot from lookup<br><br>For proc_code_type = ICD9, leave dots in lookup. |
| type_concept_id | 38000275 | EHR order list entry| | 
| operator_concept_id |  | | |
| unit_concept_id |   | | |
| unit_source_value |  | | |
| range_high |  | | | 
| range_low |  | | |
| value_as_number |  | | |
| value_as_string |  | | |
| value_as_concept_id |  | | |
| value_source_value |  | | |
| verbatim_end_date |   | | |
| days_supply |  | | |
| dose_unit_source_value |  | | |
| lot_number |  | | |
| modifier_concept_id |   | | |
| modifier_concept_id |  | | |
| modifier_source_value |  | | |
| quantity |  | | |
| refills |  | | |
| route_concept_id |  | | |
| route_source_value |  | | |
| sig |   | | |
| stop_reason |  | | |
| unique_device_id |  | | |
| anatomic_site_concept_id |  | | |
| disease_status_concept_id |   | | |
| specimen_source_id | | | |
| anatomic_site_source_value |  | | |
| disease_status_source_value |  | | |
| condition_status_concept_id |  | | |
| condition_status_source_value | | | |

## Change Log:
- Explicitly lists the proc_code_types and how they should be mapped to standard concepts