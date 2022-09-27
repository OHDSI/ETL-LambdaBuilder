---
layout: default
title: Immunizations
nav_order: 5
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Immunzations table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Immunizations

The immunization table contains NDC codes as well as descriptions of immunizations administered. This logic starts with NDC codes and then if no mappings are found moves to the field immunization_desc to map vaccines. Right now the only ones mapped based on descriptions are COVID-19 vaccines. 

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
| concept_id | ndc <br><br>immunization_desc|Start by using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the **ndc** code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL and immunization date between valid_start_date and valid_end_date<br><br> Then, if there is no mapping, use the **immunization_desc** with the filters: <br><br> Where source_vocabulary_id = 'JNJ_OPTUM_EHR_VAX'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br> Then, if no mapping available set to 0| |
|source_value|ndc immunization_desc|Concatenate the ndc code and immunization_desc with a '-' in between||
| source_concept_id |ndc <br><br>immunization_desc| Start by using the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the **ndc** code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'NDC' <br><br>Then, if there is no mapping, use the **immunization_desc** with the filters:<br><br>Where source_vocabulary_id = 'JNJ_OPTUM_EHR_VAX'| |
| type_concept_id | 32818  | EHR Administration Record| | 
| operator_concept_id |0 | | |
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


----
## Change Log

**11-Mar-2021**: Added logic to map COVID-19 vaccines in Optum EHR to standard concepts. NDC code was concatenated with immunization desc in the source value field and a new vocabulary was added. Type concept was changed to 'EHR Administration Record'