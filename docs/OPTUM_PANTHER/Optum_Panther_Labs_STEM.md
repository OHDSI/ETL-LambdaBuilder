---
layout: default
title: Labs
nav_order: 3
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Labs table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Labs

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use result_date to determine which VISIT_OCCURRENCE_ID the record should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid|If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id |  encid | Lookup the PROVIDER_ID from the VISIT_DETAIL table using the encid|If encid is blank then leave PROVIDER_ID blank|
| start_date | result_date  | | |
| end_date | result_date | | | 
| start_datetime | result_date result_time | Combine the result_date and result_time to create a datetime| |
| end_datetime | result_date result_time | Combine the result_date and result_time to create a datetime| |
| concept_id | test_name |Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_EHR_LABNAM'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero.| |
|source_value|test_name|||
| source_concept_id |0 || |
| type_concept_id | 32856  | Lab result| | 
| operator_concept_id |relative_indicator | When relative_indicator is NULL/empty, leave the value as NULL. Otherwise do as follows:<br><br>CASE WHEN relative_incicator == ‘<=’ THEN 4171754<br>CASE WHEN relative_incicator == ‘>=’ THEN 4171755<br>CASE WHEN relative_incicator == ‘<’ THEN 4171756 <br>CASE WHEN relative_incicator == ‘=’ THEN 4172703 <br>CASE WHEN relative_incicator == ‘>’ THEN 4172704<br>ELSE 0| |
| unit_concept_id | result_unit  | Map to UCUM vocabulary using a CASE-SENSITIVE matching; if no match if found, match to the JNJ_UNITS STCM. If no match is found in either vocabulary, set this field to 0.| |
| unit_source_value | result_unit | | |
| range_high | normal_range | Parse lower bound (split on hyphen), first piece | | 
| range_low | normal_range |Parse upper bound (split on hyphen), second piece | |
| value_as_number | test_result | If value of test_result is numeric put in value_as_number| |
| value_as_string | test_result | If value of test_result is NOT numeric put in value_as_string | |
| value_as_concept_id | test_result |If value of test_result is NOT numeric use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_EHR_LABRES'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero. | |
| value_source_value | test_result | | |
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
