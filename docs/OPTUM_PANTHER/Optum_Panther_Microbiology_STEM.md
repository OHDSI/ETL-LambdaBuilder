---
layout: default
title: Microbiology
nav_order: 4
parent: Optum EHR to STEM
grand_parent: Optum EHR
description: "OPTUM EHR Microbiology table to STEM"
---

# CDM Table name: STEM

## Reading from OPTUM_EHR.Microbiology

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
| id | autogenerate  | | |
| domain_id | Observation | | |
| person_id | ptid | | |
| visit_occurrence_id | encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use coalesce(collect_date, result_date) to determine which VISIT_OCCURRENCE_ID the record should be associated to|
| visit_detail_id| encid | Lookup the VISIT_DETAIL_ID based on the encid|If encid is blank then leave VISIT_DETAIL_ID blank|
| provider_id |  encid | Lookup the PROVIDER_ID from the VISIT_DETAIL table using the encid|If encid is blank then leave PROVIDER_ID blank|
| start_date | coalesce(collect_date, result_date)  | | |
| end_date | coalesce(collect_date, result_date) | | | 
| start_datetime | coalesce(collect_date, result_date) collect_time | Combine the coalesce(collect_date, result_date) and collect_time to create a datetime| |
| end_datetime | coalesce(collect_date, result_date) collect_time | Combine the coalesce(collect_date, result_date) and collect_time to create a datetime| |
| concept_id | 4252364 | Clinical microbiology | |
|source_value|specimen_source|||
| source_concept_id |0 || |
| type_concept_id | 32835  | EHR Pathology report| | 
| operator_concept_id |NULL | | |
| unit_concept_id | | | |
| unit_source_value | | | |
| range_high | |  | | 
| range_low |  | | |
| value_as_number | | | |
| value_as_string | organism |  | |
| value_as_concept_id | | | |
| value_source_value | organism | | |
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
