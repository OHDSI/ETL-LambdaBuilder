---
layout: default
title: NLP_Drug_Rationale
nav_order: 9
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR NLP_Drug_Rationale table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.NLP_Drug_Rationale

Only map records where drug_action in in ( ‘TAKE’, ‘START’, ‘ADMINISTER’, ‘MEDICATE’)) AND (sentiment is null) 

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid | If there is no encid, then leave blank |
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid| If there is not encid, then leave blank|
| provider_id | provid | Lookup the PROVIDER_ID in the PROVIDER table using provid| If there is no provid then leave blank|
| start_date | note_date  | | |
| end_date | note_date |  | | 
| start_datetime | note_date | Set time to midnight| |
| end_datetime | note_date | Set time to midnight | |
| concept_id |drug_name |Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_NLP_DRUG'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL <br><br>If there is no mapping available, set concept_id to zero.| |
|source_value| drug_name |||
| source_concept_id | 0 | | |
| type_concept_id | 32831  | EHR note | | 
| operator_concept_id | 0 | | |
| unit_concept_id | | | |
| unit_source_value |  | | |
| range_high | |  | | 
| range_low |  | | |
| value_as_number |  || |
| value_as_string | || |
| value_as_concept_id |  | | |
| value_source_value |  | | |
| verbatim_end_date |   | | |
| days_supply |  | | |
| dose_unit_source_value | strength_unit | | |
| lot_number |  | | |
| modifier_concept_id |   | | |
| modifier_concept_id |  | | |
| modifier_source_value |  | | |
| quantity | | | |
| refills | | | |
| route_concept_id |  |  | |
| route_source_value | | | |
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