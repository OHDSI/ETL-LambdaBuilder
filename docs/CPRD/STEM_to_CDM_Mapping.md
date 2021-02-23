---
layout: default
title: STEM to CDM
nav_order: 8
description: "STEM to CDM"

---

The images below detail how the STEM table is mapped to CDM tables. The STEM table is a staging area where source codes like ICD10, ICD9, and Read codes are first mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. 

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Table name: condition_occurrence

![](CPRD_v6_0_Mapping_files/image20.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| condition_occurrence_id | id |  |  |
| person_id | person_id |  |  |
| condition_concept_id | concept_id |  |  |
| condition_start_date | start_date |  |  |
| condition_start_datetime | start_datetime |  |  |
| condition_end_date | end_date |  |  |
| condition_end_datetime | end_datetime |  |  |
| condition_type_concept_id | type_concept_id |  |  |
| stop_reason | stop_reason |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| condition_source_value | source_value |  |  |
| condition_source_concept_id | source_concept_id |  |  |
| condition_status_source_value | condition_status_source_value |  |  |
| condition_status_concept_id | condition_status_concept_id |  |  |

## Table name: device_exposure

![](CPRD_v6_0_Mapping_files/image21.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| device_exposure_id | id |  |  |
| person_id | person_id |  |  |
| device_concept_id | concept_id |  |  |
| device_exposure_start_date | start_date |  |  |
| device_exposure_start_datetime | start_datetime |  |  |
| device_exposure_end_date | end_date |  |  |
| device_exposure_end_datetime | end_datetime |  |  |
| device_type_concept_id | type_concept_id |  |  |
| unique_device_id | unique_device_id |  |  |
| quantity | quantity |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| device_source_value | source_value |  |  |
| device_source_concept_id | source_concept_id |  |  |

## Table name: measurement

![](CPRD_v6_0_Mapping_files/image22.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| measurement_id | id |  | Autogenerate |
| person_id | person_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| measurement_concept_id | concept_id |  |  |
| measurement_date | start_date |  |  |
| measurement_datetime | start_datetime |  |  |
| measurement_time |  |  |  |
| measurement_type_concept_id | type_concept_id |  | 44818702=’Lab Result’ |
| operator_concept_id | operator_concept_id |  |  |
| value_as_number | value_as_number |  |  |
| value_as_concept_id | value_as_concept_id |  |  |
| range_low | range_low |  |  |
| range_high | range_high |  |  |
| unit_concept_id | unit_concept_id |  |  |
| provider_id | provider_id |  |  |
| visit_detail_id |  |  |  |
| measurement_source_value |  |  |  |
| measurement_source_concept_id | source_concept_id |  |  |
| unit_source_value | unit_source_value |  |  |
| value_source_value | value_source_value |  |  |

## Table name: drug_exposure

![](CPRD_v6_0_Mapping_files/image23.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id | id |  |  |
| person_id | person_id |  |  |
| drug_concept_id | concept_id |  |  |
| drug_exposure_start_date | start_date |  |  |
| drug_exposure_start_datetime | start_datetime |  |  |
| drug_exposure_end_date | end_date |  |  |
| drug_exposure_end_datetime | end_datetime |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id | type_concept_id |  |  |
| stop_reason | stop_reason |  |  |
| refills | refills |  |  |
| quantity | quantity |  |  |
| days_supply | days_supply |  |  |
| sig | sig |  |  |
| route_concept_id | route_concept_id |  |  |
| lot_number | lot_number |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| drug_source_value | source_value |  |  |
| drug_source_concept_id | source_concept_id |  |  |
| route_source_value | route_source_value |  |  |
| dose_unit_source_value | dose_unit_source_value |  |  |

## Table name: procedure_occurrence

![](CPRD_v6_0_Mapping_files/image24.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| procedure_occurrence_id | id |  |  |
| person_id | person_id |  |  |
| procedure_concept_id | concept_id |  |  |
| procedure_date | start_date |  |  |
| procedure_datetime | start_datetime |  |  |
| procedure_type_concept_id | type_concept_id |  |  |
| modifier_concept_id | modifier_concept_id |  |  |
| quantity | quantity |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| procedure_source_value | source_value |  |  |
| procedure_source_concept_id | source_concept_id |  |  |
| modifier_source_value | modifier_source_value |  |  |

## Table name: observation

![](CPRD_v6_0_Mapping_files/image25.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| observation_id | id |  |  |
| person_id | person_id |  |  |
| observation_concept_id | concept_id |  |  |
| observation_date | start_date |  |  |
| observation_datetime | start_datetime |  |  |
| observation_type_concept_id | type_concept_id |  |  |
| value_as_number | value_as_number |  |  |
| value_as_string | value_as_string |  |  |
| value_as_concept_id | value_as_concept_id |  |  |
| qualifier_concept_id |  |  |  |
| unit_concept_id | unit_concept_id |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| observation_source_value | source_value |  |  |
| observation_source_concept_id | source_concept_id |  |  |
| unit_source_value | unit_source_value |  |  |
| qualifier_source_value |  |  |  |

## Table name: specimen

![](CPRD_v6_0_Mapping_files/image26.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| specimen_id | id |  |  |
| person_id | person_id |  |  |
| specimen_concept_id | concept_id |  |  |
| specimen_type_concept_id | type_concept_id |  |  |
| specimen_date | start_date |  |  |
| specimen_datetime | start_datetime |  |  |
| quantity | quantity |  |  |
| unit_concept_id | unit_concept_id |  |  |
| anatomic_site_concept_id | anatomic_site_concept_id |  |  |
| disease_status_concept_id | disease_status_concept_id |  |  |
| specimen_source_id | specimen_source_id |  |  |
| specimen_source_value | source_value |  |  |
| unit_source_value | unit_source_value |  |  |
| anatomic_site_source_value | anatomic_site_source_value |  |  |
| disease_status_source_value | disease_status_source_value |  |  |
