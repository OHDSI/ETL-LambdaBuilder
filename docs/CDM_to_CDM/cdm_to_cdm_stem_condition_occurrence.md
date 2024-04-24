---
layout: default
title: Condition Occurrence
nav_order: 1
grand_parent: CDM to CDM
parent: CDM to CDM to STEM
description: Existing Condition_occurrence to STEM for remapping
---


### Reading from **CONDITION_OCCURRENCE**

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| DOMAIN_ID | - | - | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a code is mapped to CONCEPT_ID 0, put the domain_id as Observation |
| PERSON_ID | PERSON_ID | - | - |
| VISIT_OCCURRENCE_ID | VISIT_OCCURRENCE_ID  | - | - |
| VISIT_DETAIL_ID | VISIT_DETAIL_ID  | - | - |
| PROVIDER_ID | PROVIDER_ID  | - | -|
| ID | CONDITION_OCCURRENCE_ID |  | - |
| CONCEPT_ID | **CONDITION_SOURCE_CONCEPT_ID** | Use the [Source-to-Standard Query](https://ohdsi.github.io/CommonDataModel/sqlScripts.html).<br><br> Lookup the target concept that the source concept maps to. If there are multiple target concepts, create multiple records.| 	  |
| SOURCE_VALUE | CONDITION_SOURCE_VALUE | - | - |
| SOURCE_CONCEPT_ID | CONDITION_SOURCE_CONCEPT_ID | - | - |
| TYPE_CONCEPT_ID | CONDITION_TYPE_CONCEPT_ID | - | - |
| START_DATE | CONDITION_START_DATE | - | - |
| START_DATETIME | CONDITION_START_DATETIME  | - | - |
| END_DATE | CONDITION_END_DATE | - | - |
| END_DATETIME | CONDITION_END_DATETIME | - | - |
| VERBATIM_END_DATE | - | - | - |
| DAYS_SUPPLY | - | - | - |
| DOSE_UNIT_SOURCE_VALUE | - | - | - |
| LOT_NUMBER | - | - | - |
| MODIFIER_CONCEPT_ID | - | - | - |
| MODIFIER_SOURCE_VALUE | - | - | - |
| OPERATOR_CONCEPT_ID | - | - | - |
| QUANTITY | - | - | - |
| RANGE_HIGH | - | - | - |
| RANGE_LOW | - | - | - |
| REFILLS | - | - | - |
| ROUTE_CONCEPT_ID | - | - | - |
| ROUTE_SOURCE_VALUE | - | - | - |
| SIG | - | - | - |
| STOP_REASON | STOP_REASON | - | - |
| UNIQUE_DEVICE_ID | - | - | - |
| UNIT_CONCEPT_ID | - | - | - |
| UNIT_SOURCE_VALUE | - | - | - |
| VALUE_AS_CONCEPT_ID | - | - | - |
| VALUE_AS_NUMBER | - | - | - |
| VALUE_AS_STRING | - | - | - |
| VALUE_SOURCE_VALUE | - | - | - |
| ANATOMIC_SITE_CONCEPT_ID | - | - | - |
| DISEASE_STATUS_CONCEPT_ID | - | - | - |
| SPECIMEN_SOURCE_ID | - | - | - |
| ANATOMIC_SITE_SOURCE_VALUE | - | - | - |
| DISEASE STATUS_SOURCE_VALUE | - | - | - |
| CONDITION_STATUS_CONCEPT_ID | CONDITION_STATUS_CONCEPT_ID | - | - | 
| CONDITION_STATUS_SOURCE_VALUE | CONDITION_STATUS_SOURCE_VALUE | - | - |
| EVENT_ID | - | - | - |
| EVENT_FIELD_CONCEPT_ID | - | - | - |
| VALUE_AS_DATETIME | - | - | - |
| QUALIFIER_CONCEPT_ID | - | - | - |
| QUALIFIER_SOURCE_VALUE | - | - | - |