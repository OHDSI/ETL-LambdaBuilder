---
layout: default
title: Observations
nav_order: 4
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Observations table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Observations

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use obs_date to determine which VISIT_OCCURRENCE_ID the record should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid|If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id |  encid | Lookup the PROVIDER_ID from the VISIT_DETAIL table using the encid|If encid is blank then leave PROVIDER_ID blank|
| start_date | obs_date  | | |
| end_date | obs_date | | | 
| start_datetime | obs_date obs_time | Combine the obs_date and obs_time to create a datetime| |
| end_datetime | obs_date obs_time | Combine the obs_date and obs_time to create a datetime| |
| concept_id | obs_type |Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_EHR_OBTYPE'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero.| |
|source_value|obs_type|||
| source_concept_id |0 || |
| type_concept_id | 32831  | EHR Note| | 
| operator_concept_id |0 | | |
| unit_concept_id | obs_unit  | Map to UCUM vocabulary using a CASE-SENSITIVE matching; if no match if found, match to the JNJ_UNITS STCM. If no match is found in either vocabulary, set this field to 0.| |
| unit_source_value | obs_unit | | |
| range_high | |  | | 
| range_low |  | | |
| value_as_number | obs_result | If value of obs_result is numeric put in value_as_number| |
| value_as_string | obs_result | If value of obs_result is NOT numeric put in value_as_string | |
| value_as_concept_id | obs_result |If value of obs_result is NOT numeric use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_EHR_LABRES'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero. | |
| value_source_value | obs_type | | |
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
| condition_status_concept_id | | | |
| condition_status_source_value | | | |
