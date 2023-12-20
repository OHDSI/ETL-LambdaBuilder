---
layout: default
title: Optum EHR Device Exposure 
nav_order: 9
parent: Optum EHR
description: "Device Exposure Quantity Imputation"

---

# Optum EHR Device Quantity Imputation

## Table name: device_exposure


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
| quantity | quantity | set QUANTITY = NULL where DEVICE_EXPOSURE.quantity <1  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| device_source_value | source_value |  |  |
| device_source_concept_id | source_concept_id |  |  |

### Change log

- 12-Dec-2023
Added quantity logic