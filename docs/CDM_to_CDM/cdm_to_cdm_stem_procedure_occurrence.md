---
layout: default
title: Procedure Occurrence
nav_order: 5
grand_parent: CDM to CDM
parent: CDM to CDM to STEM
description: Existing Procedure Occurrence to STEM for remapping
---

**How to remap source concepts and standard concepts when going from an old CDM to a new CDM with updated vocab:**

**Step 1:** Start with original source_concept_id as it is given in the original CDM. Using the [source-to-source query](https://ohdsi.github.io/CommonDataModel/sqlScripts.html#Source_to_Source), identify the source_code and source_vocabulary_id.

**Step 2:** Use the source_code and source_vocabulary_id you found in step 1 and find the correct source_concept_id through the [source-to-source query](https://ohdsi.github.io/CommonDataModel/sqlScripts.html#Source_to_Source) where the date of the event falls between the valid_start_date and valid_end_date of the concept. 

**Note** most of the source concepts will likely stay the same but there are some drug codes that are reused and therefore will change source concepts.

**Step 3:** Map the new source_concept_id to a standard concept_id using the [Source-to-Standard Query](https://ohdsi.github.io/CommonDataModel/sqlScripts.html).


### Reading from **PROCEDURE_OCCURRENCE**

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| DOMAIN_ID | - | - | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a code is mapped to CONCEPT_ID 0, put the domain_id as Observation |
| PERSON_ID | PERSON_ID | - | - |
| VISIT_OCCURRENCE_ID | VISIT_OCCURRENCE_ID  | - | - |
| VISIT_DETAIL_ID | VISIT_DETAIL_ID  | - | - |
| PROVIDER_ID | PROVIDER_ID  | - | -|
| ID | PROCEDURE_OCCURRENCE_ID |  | - |
| CONCEPT_ID | **PROCEDURE_SOURCE_CONCEPT_ID** | Use the [Source-to-Standard Query](https://ohdsi.github.io/CommonDataModel/sqlScripts.html).<br><br> Lookup the target concept that the source concept maps to. If there are multiple target concepts, create multiple records.| 	  |
| SOURCE_VALUE | PROCEDURE_SOURCE_VALUE | - | - |
| SOURCE_CONCEPT_ID | **PROCEDURE_SOURCE_CONCEPT_ID**<br><br>**PROCEDURE_SOURCE_VALUE** | Please see the logic above for properly assigning source and standard concepts. | - |
| TYPE_CONCEPT_ID | PROCEDURE_TYPE_CONCEPT_ID | - | - |
| START_DATE | PROCEDURE_DATE | - | - |
| START_DATETIME | PROCEDURE_DATETIME | - | - |
| END_DATE | - | - | - |
| END_DATETIME | - | - | - |
| VERBATIM_END_DATE | - | - | - |
| DAYS_SUPPLY | - | - | - |
| DOSE_UNIT_SOURCE_VALUE | - | - | - |
| LOT_NUMBER | LOT_NUMBER | - | - |
| MODIFIER_CONCEPT_ID | MODIFER_CONCEPT_ID | - | - |
| MODIFIER_SOURCE_VALUE | MODIFIER_SOURCE_VALUE | - | - |
| OPERATOR_CONCEPT_ID | - | - | - |
| QUANTITY | QUANTITY | - | - |
| RANGE_HIGH | - | - | - |
| RANGE_LOW | - | - | - |
| REFILLS | - | - | - |
| ROUTE_CONCEPT_ID | - | - | - |
| ROUTE_SOURCE_VALUE | - | - | - |
| SIG | - | - | - |
| STOP_REASON | - | - | - |
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
| CONDITION_STATUS_CONCEPT_ID | - | - | - | 
| CONDITION_STATUS_SOURCE_VALUE | - | - | - |
| EVENT_ID | - | - | - |
| EVENT_FIELD_CONCEPT_ID | - | - | - |
| VALUE_AS_DATETIME | - | - | - |
| QUALIFIER_CONCEPT_ID | - | - | - |
| QUALIFIER_SOURCE_VALUE | - | - | - |