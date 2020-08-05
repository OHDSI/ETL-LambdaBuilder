---
layout: default
title: Immunizations
nav_order: 5
parent: Optum EHR to STEM
grand_parent: OPTUM_PANTHER
description: "OPTUM EHR Immunzations table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Immunizations

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id |  |  | |
| visit_detail_id| | | |
| provider_id |  | | |
| start_date |immunization_date | | |
| end_date | immunization_date | | | 
| start_datetime | immunization_date | Set time to midnight| |
| end_datetime | immunization_date | Set time to midnight| |
| concept_id | ndc |Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL and immunization date between valid_start_date and valid_end_date<br><br>If there is no mapping available, set concept_id to zero.| |
|source_value|ndc|||
| source_concept_id |ndc | | |
| type_concept_id | 45754907  | Derived Value| | 
| operator_concept_id |0 |Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC' | |
| unit_concept_id |  | | |
| unit_source_value |  | | |
| range_high | |  | | 
| range_low |  | | |
| value_as_number |  | | |
| value_as_string |  |  | |
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
| condition_status_concept_id | | | |
| condition_status_source_value | | | |
