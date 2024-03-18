---
layout: default
title: Medication_Administration
nav_order: 7
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Medication_Administrations table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Medication_Administrations

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use admin_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid|If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id | provid | Lookup the PROVIDER_ID in the PROVIDER table using provid|If provid then leave PROVIDER_ID blank|
| start_date | admin_date  | | Use order_date if admin_date is epmty or null. |
| end_date | admin_date | | Use order_date if admin_date is epmty or null. | 
| start_datetime | admin_time | Combine admin_date and admin_time into a datetime| |
| end_datetime | admin_time| Combine admin_date and admin_time into a datetime| |
| concept_id |ndc |Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL and admin_date between valid_start_date and valid_end_date<br><br>If there is no mapping available, set concept_id to zero.| |
|source_value| ndc |||
| source_concept_id | ndc | Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC'<br><br>If there is no mapping available, set concept_id to zero.| |
| type_concept_id | 32818  | EHR Administration record | | 
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
| quantity | quantity_of_dose | | |
| refills |  | | |
| route_concept_id | route | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'JNJ_OPTUM_EHR_ROUTE'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If there is no mapping available, set concept_id to zero. | |
| route_source_value | route | | |
| sig |   | | |
| stop_reason | discontinue_reason | | |
| unique_device_id |  | | |
| anatomic_site_concept_id |  | | |
| disease_status_concept_id |   | | |
| specimen_source_id | | | |
| anatomic_site_source_value |  | | |
| disease_status_source_value |  | | |
| condition_status_concept_id | | | |
| condition_status_source_value | | | |

## Change Log

### March 12, 2024
- start/end date added use order_date if admin_date is epmty or null 