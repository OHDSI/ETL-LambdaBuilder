---
layout: default
title: Visit Detail
nav_order: 5
parent: Optum EHR
description: "Mapping the Visit_Detail table from the Optum Panther Encounter, CareArea, and Visit tables"

---

# CDM Table name: VISIT_DETAIL

VISIT_DETAIL records will be created from the Encounter, CareArea, Visit and Procedure tables. Each VISIT_DETAIL record will be associated with a VISIT_OCCURRENCE_ID. Please refer to the visit logic for how that was done.

## Reading from OPTUM_EHR.Encounter

Starting with the Encounter table, de-duplicate records by ptid, encid, interaction_type, interaction_date, and interaction_time. After de-duplication each record should create a record in VISIT_DETAIL. 

To find a provider associated with a VISIT_DETAIL record, join to the encounter_provider table on encounter.encid = encounter_provider.encid. If more than one provider is associated to a record, the provider with provider_role of 'ATTENDING' should be prioritized. If there is more than one provider with the provider_role of 'ATTENDING', pick one. If no provider has the role of 'ATTENDING' then sort by provider_role and choose the first.

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_detail_id | Autogenerate | Use the above logic to define VISIT_DETAIL records. |  |
| person_id | ptid |   |   |
| visit_detail_concept_id | interaction_type | | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_EHR_VISIT' |
| visit_detail_start_date | Interaction_date |   |   |
| visit_detail_start_datetime | Interaction_time | Combine interaction_date and interaction_time into a datetime value |   |
| visit_detail_end_date | Interaction_date  |   |   |
| visit_detail_end_datetime |  Interaction_time | Combine interaction_date and interaction_time into a datetime value  |   |
| visit_detail_type_concept_id |   | 32827 | EHR encounter |
| provider_id | encounter_provider.provid|  | Use the logic detailed above to choose a provider for the VISIT_DETAIL record. |
| care_site_id |   |   |   |
| visit_detail_source_value | interaction_type |   |   |
| visit_detail_source_concept_id | 0 | |   |
| admitting_source_concept_id | 0 | |  |
| admitting_source_value |  |   |  |
| discharge_to_concept_id | 0 | |  |
| discharge_to_source_value ||   |  |
| preceding_visit_detail_id | Visit_detail_id | If the row_number() for the   current row > 1, look up the previous visit_detail_id cooresponding to the   parent visitid. |   |
| visit_detail_parent_id | NULL |   |   |
| visit_occurrence_id | encid | Each encounter will be associated with a visit. Use the encid to lookup the corresponding VISIT_OCCURRENCE_ID |   |

## Reading from OPTUM_EHR.CareArea

First remove any records where CareArea.carearea is 'OTHER CARE AREA' or 'UNKNOWN CARE AREA'. Then, de-duplicate records by ptid, encid, carearea, carearea_date, and carearea_time. After de-duplication each record should create a record in VISIT_DETAIL. 

To find a provider associated with a VISIT_DETAIL record, join to the encounter_provider table on carearea.encid = encounter_provider.encid. If more than one provider is associated to a record, the provider with provider_role of 'ATTENDING' should be prioritized. If there is more than one provider with the provider_role of 'ATTENDING', pick one. If no provider has the role of 'ATTENDING' then sort by provider_role and choose the first.

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_detail_id | Autogenerate | Use the above logic to define VISIT_DETAIL records from the CareArea table. |  |
| person_id | ptid |   |   |
| visit_detail_concept_id | carearea | | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_EHR_VISIT'<br> and Target_standard_concept = 'S'<br>and target_invalid_reason is NULL |
| visit_detail_start_date | carearea_date |   |   |
| visit_detail_start_datetime | carearea_time | Combine carearea_date and carearea_time into a datetime value |   |
| visit_detail_end_date | carearea_date  |   |   |
| visit_detail_end_datetime |  carearea_time | Combine carearea_date and carearea_time into a datetime value  |   |
| visit_detail_type_concept_id |   | 32828 | EHR episode record |
| provider_id | encounter_provider.provid|  | Use the logic detailed above to choose a provider for the VISIT_DETAIL record. |
| care_site_id |   |   |   |
| visit_detail_source_value | carearea |   |   |
| visit_detail_source_concept_id | carearea | |Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) with the filter:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_EHR_VISIT'|
| admitting_source_concept_id | 0 | |  |
| admitting_source_value |  |   |  |
| discharge_to_concept_id | 0 | |  |
| discharge_to_source_value ||   |  |
| preceding_visit_detail_id | Visit_detail_id | If the row_number() for the   current row > 1, look up the previous visit_detail_id cooresponding to the   parent visitid. |   |
| visit_detail_parent_id | NULL |   |   |
| visit_occurrence_id | encid | Each encounter will be associated with a visit. Use the encid to lookup the corresponding VISIT_OCCURRENCE_ID |   |

## Reading from OPTUM_EHR.Visit

Each record in the native Visit table will create a record in the VISIT_DETAIL table. 

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_detail_id | Autogenerate | Use the above logic to define VISIT_DETAIL records. |  |
| person_id | ptid |   |   |
| visit_detail_concept_id | visit_type | | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filters:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_EHR_VISIT' and standard_concept = 'S' and invalid_reason is NULL|
| visit_detail_start_date | visit_start_date |   |   |
| visit_detail_start_datetime | visit_start_time | Combine visit_start_date and visit_start_time into a datetime value |   |
| visit_detail_end_date | visit_end_date  |   |   |
| visit_detail_end_datetime |  visit_end_time | Combine visit_end_date and visit_end_time into a datetime value  |   |
| visit_detail_type_concept_id |   | 32827 | EHR encounter |
| provider_id | |  |  |
| care_site_id |   |   |   |
| visit_detail_source_value | visit_type |   |   |
| visit_detail_source_concept_id | 0 | |   |
| admitting_source_concept_id | 0 | |  |
| admitting_source_value | admission_source |   |  |
| discharge_to_concept_id | discharge_disposition| Take the first two digits of the discharge_disposition value. Map this value to a standard concept using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filters:<br> Where SOURCE_VOCABULARY_ID = 'UB04 Pt dis status' and standard_concept = 'S' and invalid_reason is NULL |  |
| discharge_to_source_value |discharge_disposition |   |  |
| preceding_visit_detail_id | Visit_detail_id | If the row_number() for the   current row > 1, look up the previous visit_detail_id cooresponding to the   parent visitid. |   |
| visit_detail_parent_id | NULL |   |   |
| visit_occurrence_id | visit | Each encounter in the native visit table will be associated with a visit in the CDM VISIT_OCCURRENCE table. Use the visitid to lookup the corresponding VISIT_OCCURRENCE_ID |   |

## Reading from OPTUM_EHR.Procedure

Each record in the native Procedure table **where proc_code is 99221, 99222, 99223, 99231, 99232, or 99233** will create a record in the VISIT_DETAIL table. This is to help identify inpatient records. Not all encounters in the Encounter table reflect every day a patient stays in the hospital. However, for a hospital to be reimbursed for those days, they use the procedure codes listed for initial day and subsequent days. 

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_detail_id | Autogenerate | Use the above logic to define VISIT_DETAIL records. |  |
| person_id | ptid |   |   |
| visit_detail_concept_id | 9201 | | |
| visit_detail_start_date | proc_date |   |   |
| visit_detail_start_datetime | proc_time | Combine proc_date and proc_time into a datetime value |   |
| visit_detail_end_date | proc_date  |   |   |
| visit_detail_end_datetime |  proc_time | Combine proc_date and proc_time into a datetime value  |   |
| visit_detail_type_concept_id |   | 32827 | EHR encounter |
| provider_id | |  |  |
| care_site_id |   |   |   |
| visit_detail_source_value | proc_code |   |   |
| visit_detail_source_concept_id | proc_code | |Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) with the filter:<br> Where SOURCE_VOCABULARY_ID = 'CPT4'   |
| admitting_source_concept_id | 0 | |  |
| admitting_source_value |  |   |  |
| discharge_to_concept_id | |  |  |
| discharge_to_source_value | |   |  |
| preceding_visit_detail_id |  |  |   |
| visit_detail_parent_id | NULL |   |   |
| visit_occurrence_id | visit | Each encounter in the native visit table will be associated with a visit in the CDM VISIT_OCCURRENCE table. Use the visitid to lookup the corresponding VISIT_OCCURRENCE_ID |   |

## Change Log

### June 6, 2022
- Added the native Procedure table to generate IP records in the VISIT_DETAIL table

### June 3, 2022
- Added the native Visit table to generate records in the VISIT_DETAIL table

- All de-duped encounters now create VISIT_DETAIL records
- Records from CareArea now create VISIT_DETAIL records