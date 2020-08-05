---
layout: default
title: Visit Detail
nav_order: 5
parent: Optum EHR
description: "Mapping the Visit_Detail table from the Optum Panther Encounter and CareArea tables"

---

# CDM Table name: VISIT_DETAIL

VISIT_DETAIL records will be created from both the Encounter and the CareArea tables. Each VISIT_DETAIL record will be associated with a VISIT_OCCURRENCE_ID. Please refer to the visit logic for how that was done.

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
| visit_detail_type_concept_id |   | 44818518 | Visit derived from EHR record |
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
| visit_detail_type_concept_id |   | 44818518 | Visit derived from EHR record |
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

## Change Log
- All de-duped encounters now create VISIT_DETAIL records
- Records from CareArea now create VISIT_DETAIL records