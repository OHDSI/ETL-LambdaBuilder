---
layout: default
title: Visit Occurrence
nav_order: 7
parent: CDM to CDM
description: "VISIT_OCCURRENCE mapping from an existing CDM instance"
---

# CDM Table: VISIT_OCCURRENCE

Map the new VISIT_OCCURRENCE table from the existing VISIT_OCCURRENCE table.  The following data quality fixes are employed:

- Any visit_occurrence records with a visit_start_date and/or visit_start_datetime that occurs in the future is removed.

### Reading from **VISIT_OCCURRENCE**

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id|visit_occurrence_id |||
| person_id|person_id|||
| visit_concept_id|visit_concept_id|||
| visit_start_date|visit_start_date|||
| visit_start_datetime| visit_start_datetime|||
| visit_end_date|visit_end_date|||
| visit_end_datetime|visit_end_datetime|||
| visit_type_concept_id|visit_type_concept_id|||
| provider_id|provider_id|||
| care_site_id|care_site_id|||
| visit_source_value| visit_source_value|||
| visit_source_concept_id|visit_source_concept_id|||
| admitted_from_concept_id|admitted_from_concept_id (v5.4) <br> admitting_source_concept_id (v5.3)|||
| admitted_from_source_value| admitted_from_source_value (v5.4)  <br> admitting_source_value (v5.3)|||
| discharged_to_concept_id| discharged_to_concept_id (v5.4)  <br> discharge_to_concept_id (v5.3)|||
| discharged_to_source_value| discharged_to_source_value (v5.4)  <br>  discharge_to_source_value (v5.3)|||
| preceding_visit_occurrence_id|preceding_visit_occurrence_id|||

## Change Log
