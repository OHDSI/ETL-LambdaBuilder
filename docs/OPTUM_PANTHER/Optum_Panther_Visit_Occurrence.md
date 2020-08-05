---
layout: default
title: Visit Occurrence
nav_order: 6
parent: Optum EHR
description: "Mapping the Visit_Occurrence table from the Optum Panther Encounter and Visit tables"

---

# CDM Table name: VISIT_OCCURRENCE

VISIT_OCCURRENCE records will come from the OPTUM_EHR.Visit and Encounter tables. 

## Reading from OPTUM_EHR.Visit

Records in the Optum EHR Visit table are constructed by Optum off of the Encounter table and occasionally the dates between the two are slightly incorrect, as in the encounters associated with a visit occur one or two days after the visit_end_date. To account for this, take all visits and join them to the encounter table on Visit.visitid = Encounter.visitid and Visit.ptid = Encounter.ptid. After joining, if Encounter.interaction_date occurs after the Visit.visit_end_date, replace the visit_end_date with interaction_date.

After updating the visit_end_date, assign the rest of the columns as follows:

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_occurrence_id | autogenerate |   |   |
| person_id | ptid |   |   |
| visit_concept_id | visit_type |  | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where source_vocabulary_id = 'JNJ_OPTUM_EHR_VISIT'  |
| visit_start_date | visit_start_date |   |   |
| visit_start_datetime | visit_start_time | Combine visit_start_date and visit_start_time into a datetime  |   |
| visit_end_date | visit_end_date | Use the logic above to update visit_end_date from the Optum Visit table.  |   |
| visit_end_datetime | visit_end_time  | Combine visit_end_date and visit_end_time into a datetime  |   |
| visit_type_concept_id |   | 44818518 | Visit derived from EHR record |
| provider_id | |  |  |
| care_site_id |   |   |   |
| visit_source_value | visit_type |   |   |
| visit_source_concept_id | 0 |  |   |
| admitting_source_concept_id | Admission_source | | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_VISIT_ADM' |
| admitting_source_value | Admission_source | 
| discharge_to_concept_id | discharge_disposition |   |  Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where SOURCE_VOCABULARY_ID = 'JNJ_OPTUM_VISIT_DIS' |
| discharge_to_source_value | discharge_disposition |  |   |

## Reading from OPTUM_EHR.Encounter

To create visits from the Encounter table, find all encounter records where visitid = NULL. Then, group the records by ptid, interaction_date, and interaction_type. Each unique combination of these three columns should create a VISIT_OCCURRENCE record. 

To find a provider associated with a VISIT_OCCURRENCE record, join to the encounter_provider table on encounter.encid = encounter_provider.encid. If more than one provider is associated to a record, the provider with provider_role of 'ATTENDING' should be prioritized. If there is more than one provider with the provider_role of 'ATTENDING', pick one. If no provider has the role of 'ATTENDING' then sort by provider_role and choose the first.

After creating VISIT_OCCURRENCE records from the OPTUM_EHR.Visit and Encounter tables, find all VISIT_DETAIL records that occur during the time of a VISIT_OCCURRENCE record and set the VISIT_DETAIL.VISIT_OCCURRENCE_ID accordingly.

| Destination Field | Source Field | Logic | Comment |
|-|-|-|-|
| visit_occurrence_id | autogenerate |   |   |
| person_id | ptid |   |   |
| visit_concept_id | interaction_type |  | Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filter:<br> Where source_vocabulary_id = 'JNJ_OPTUM_EHR_VISIT'  |
| visit_start_date | interaction_date |   |   |
| visit_start_datetime | set to midnight 00:00:00| |   |
| visit_end_date | interaction_date |  |   |
| visit_end_datetime | set to 23:59:59  |  |   |
| visit_type_concept_id |   | 44818518 | Visit derived from EHR record |
| provider_id | encounter_provider.provid |  | Use the logic detailed above to choose a provider for the VISIT_DETAIL record. |
| care_site_id |   |   |   |
| visit_source_value |  |   |   |
| visit_source_concept_id | 0 |  |   |
| admitting_source_concept_id | 0 | |  |
| admitting_source_value |  | ||
| discharge_to_concept_id |  |   |  |
| discharge_to_source_value | 0 |  |   |

## Change Log:

- Visits are built similarly to how they were before except interaction_time is not taken into account. Interaction_time will now be stored in the VISIT_DETAIL records associated with a VISIT_OCCURRENCE