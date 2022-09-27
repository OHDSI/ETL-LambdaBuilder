---
layout: default
title: Diagnosis
nav_order: 2
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Diagnosis table to STEM"
---

# CDM Table name: STEM

The **Diagnosis** table has multiple columns we use to assign CONDITION_STATUS_CONCEPT_ID. These are PRIMARY_DIAGNOSIS, ADMITTING_DIAGNOSIS, DISCHARGE_DIAGNOSIS, and DISCHARGE_STATUS. The below table details the possible combinations of the fields and how to assign the CONDITION_STATUS_CONCEPT_ID accordingly. 

|Primary_Diagnosis Value|	Admitting_Diagnosis Value	|Discharge_Diagnosis Value|	Discharge_Status Value|	**Set Condition_Status_Concept_Id to**|
|-|-|-|-|-|
|1|	0	|0	|any value	|32902|
1|	1	|any value|	any value	|32901|
1|	0	|1	|any value|	32903| 
0	|0	|0|	History of|	4188893|
0|	0	|0|	Possible diagnosis of|	32899|
0|1|any value|any value|32830|
0|0|1|any value|32896|
0|0|0|any value | 0


## Reading from OPTUM_EHR.Diagnosis

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id |   | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a source code is mapped to CONCEPT_ID 0, put the domain_id as Observation.| |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid| If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id | encid | Lookup the PROVIDER_ID from the VISIT_DETAIL table using the encid |If encid is blank then leave PROVIDER_ID blank|
| start_date | diag_date  | | |
| end_date | diag_date | | | 
| start_datetime | diag_date diag_time| Combine diag_date and diag_time to create a datetime | |
| end_datetime |diag_date diag_time| Combine diag_date and diag_time to create a datetime | |
| concept_id | diagnosis_cd_type <br> diagnosis_cd|Use the diagnosis_cd_type find the source vocabulary of the code. If diagnosis_cd_type = 'ICD9' use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'ICD9CM'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>If diagnosis_cd_type = 'ICD10' then use the filters: Where source_vocabulary_id = 'ICD10CM'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL <br><br>If diagnosis_cd_type = 'SNOMED' then use the filters: Where source_vocabulary_id = 'SNOMED'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL <br><br>If there is no mapping available, set concept_id to zero.|For diagnosis_cd_type in (ICD9, ICD10), strip dot from lookup |
|source_value|diagnosis_cd|||
| source_concept_id | diagnosis_cd_type <br> diagnosis_cd| Use the diagnosis_cd_type find the source vocabulary of the code. If diagnosis_cd_type = 'ICD9' use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the code to a concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'ICD9CM' <br><br>If diagnosis_cd_type = 'ICD10' then use the filters: Where source_vocabulary_id = 'ICD10CM' <br><br>If diagnosis_cd_type = 'SNOMED' then use the filters: Where source_vocabulary_id = 'SNOMED' <br><br>If there is no mapping available, set concept_id to zero.|For diagnosis_cd_type in (ICD9, ICD10), strip dot from lookup |
| type_concept_id | 32840 | EHR problem list| | 
| operator_concept_id |  | | |
| unit_concept_id |   | | |
| unit_source_value |  | | |
| start_date |   | | |
| end_date |  | | | 
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
| condition_status_concept_id | Primary_diagnosis <br>Admitting_diagnosis<br>Discharge_diagnosis<br>Diagnosis_Status| See table above for the logic | |
| condition_status_source_value |Diagnosis_Status<br>Poa<br>Admitting_diagnosis<br>Discharge_diagnosis<br>Primary_diagnosis  | Concatenate Diagnosis_status and those field names that equal ‘1’. For example, if Diagnosis_Status is 'Diagnosis of' and POA = ‘1’ and‘primary_diagnosis = ‘1’ this field should read:<br><br>‘Diagnosis of;POA;PRIMARY_DIAGNOSIS’| |

## Change Log:
- Slight change to condition_status_concept_id logic, removes the condition to set it to 0 if diagnosis.poa = 1.
- Adds SNOMED to the list of diagnosis_cd_types

### 8/17/2020
- Changes logic so that all diagnoses are brought into the CDM, regardless of diagnosis_status in the native.
- Updates condition_status accordingly so diagnosi_status is concatenated along with poa, admitting_diagnosis, discharge_diagnosis, and primary_diagnosis