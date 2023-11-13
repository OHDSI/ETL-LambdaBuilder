---
layout: default
title: Visit_Occurrence
nav_order: 7
parent: CPRD GOLD
description: "Visit_Occurrence mapping from CPRD GOLD event tables"

---


# CDM Table name: VISIT_OCCURRENCE

## Reading from VISIT_DETAIL

Take all records from the VISIT_DETAIL table and create one VISIT_OCCURRENCE record for each PERSON_ID and VISIT_START_DATE combination. This will make it so that a person will have only one visit to their GP per day. After defining visits, go back and assign each VISIT_DETAIL record its associated VISIT_OCCURRENCE_ID.

For datetime fields, set time to midnight 00:00:00.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id |  |  | Autogenerate |
| person_id | person_id |  |  |
| visit_concept_id |  |  | 9202 - OP |
| visit_start_date | visit_detail_start_date |  |  |
| visit_start_datetime | visit_detail_start_datetime | |  |
| visit_end_date | visit_detail_end_date | | |
| visit_end_datetime | visit_detail_end_datetime ||  |
| visit_type_concept_id |  | Use **32817** - EHR |  |
| provider_id | visit_detail.provider_id | Choose one provider_id if a patient saw more than one provider on the same day. |  |
| care_site_id | visit_detail.care_site_id| |  |
| visit_source_value | visit_detail_source_value | Choose one visit_detail_source_value for this field if a patient had more than one visit_detail_source_value on the same day. |  |
| visit_source_concept_id |  |  | 0 |
| admitting_source_concept_id |  |  |  |
| admitting_source_value |  |  | NULL |
| discharge_to_concept_id |  |  |  |
| discharge_to_source_value |  |  | NULL |
| preceding_visit_occurrence_id |  | Put the visit_occurrence_id of the most recent prior visit here. |  |
