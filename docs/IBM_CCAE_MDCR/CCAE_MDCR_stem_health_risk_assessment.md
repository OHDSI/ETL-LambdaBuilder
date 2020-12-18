---
layout: default
title: HEALTH_RISK_ASSESSMENT
nav_order: 8
grand_parent: IBM CCAE & MDCR
parent: IBM CCAE & MDCR to STEM
description: "HEALTH_RISK_ASSESSMENT to STEM table description"
---

## Table name: **STEM_TABLE**


#### Key conventions
 * Medicare does not have HEALTH_RISK_ASSESSMENT (HRA) data
 * This data is in a wide format, meaning for a given patient and given date there are multiple column that represent conditions and obervations.  We pivot that data so that one row of HRA data can become many rows within the appropriate CDM tables.  The poster <a href='https://www.ohdsi.org/web/wiki/lib/exe/fetch.php?media=resources:using_the_omop_cdm_with_survey_and_registry_data_v6.0.pdf'>"Applying the OMOP Common Data Model to Survey Data"</a> provides an illustration of how we pivot and work with the data.
 * Keep all records with valid values no matter whether SURVDATE is within observation period or not.  
 * Keep all records even if some data moves to other domains, the OBSERVATION_CONCEPT_ID will be 0 for the records that moved elsewhere.
 * The following are list of HRA data variables, with character or numeric value.  However, the data for all surveys can be converted into numeric value. 

**Test\_Name**|**Missing\_Value**|**Value\_Type**
:-----:|:-----:|:-----:
ALCDYAMT|'-','9'|String
ALCWEEK|'-','9'|String
ALC\_AMT|'-','9'|String
CC\_ALLERGY|'-','9'|String
CC\_ARTHRITIS|'-','9'|String
CC\_ASTHMA|'-','9'|String
CC\_BACKPAIN|'-','9'|String
CC\_CHF|'-','9'|String
CC\_DEPRESS|'-','9'|String
CC\_DIAB|'-','9'|String
CC\_HEARTDIS|'-','9'|String
CC\_HIGHBP|'-','9'|String
CC\_HIGHCOL|'-','9'|String
CC\_HRTBURN|'-','9'|String
CC\_LUNGDIS|'-','9'|String
CC\_MIGRAINE|'-','9'|String
CC\_NONSKINCAN|'-','9'|String
CC\_OSTEOPO|'-','9'|String
CC\_SKINCAN|'-','9'|String
CGRAMT|'-','9'|String
CGRCURR|'-','9'|String
CGRDUR|'-','9'|String
CGRPREV|'-','9'|String
CGRQUIT|'-','9'|String
CGTAMT|'-','9'|String
CGTCURR|'-','9'|String
CGTDUR|'-','9'|String
CGTPKAMT|'-','9'|String
CGTPREV|'-','9'|String
CGTQTCAT|'-','9'|String
CGTQUIT|'-','9'|String
CHEWAMT|'-','9'|String
CHEWCURR|'-','9'|String
CHEWDUR|'-','9'|String
CHEWPREV|'-','9'|String
CHEWQUIT|'-','9'|String
COPESTRS|'-','9'|String
DIETFRT|'-','9'|String
DIETFRVG|'-','9'|String
DIETVEG|'-','9'|String
DRNKDRV|'-','9'|String
EDUC\_LVL|'-','9'|String
EXERMO|'-','9'|String
FAMABSCAT12|'-','9'|String
FIREEXT|'-','9'|String
FLU\_SHOT|'-','9'|String
HLTIMPCT|'-','9'|String
JOB\_SAT|'-','9'|String
LIFE\_SAT|'-','9'|String
LIFTWGT|'-','9'|String
MH\_FREQ|'-','9'|String
MH\_PROB|'-','9'|String
PIPEAMT|'-','9'|String
PIPECURR|'-','9'|String
PIPEDUR|'-','9'|String
PIPEPREV|'-','9'|String
PIPEQUIT|'-','9'|String
PLANALC|'-','9'|String
PLANDIET|'-','9'|String
PLANDRAD|'-','9'|String
PLANEXER|'-','9'|String
PLANSLP|'-','9'|String
PLANSTRS|'-','9'|String
PLANTOB|'-','9'|String
PLANWGT|'-','9'|String
PREV\_MAMMO|'-','9'|String
PREV\_PAPTEST|'-','9'|String
PREV\_PROSTEX|'-','9'|String
PREV\_SIGMOID|'-','9'|String
PRODABSCAT|'-','9'|String
RISK\_ALC|'-','9'|String
RISK\_BP|'-','9'|String
RISK\_CHOL|'-','9'|String
RISK\_EXER|'-','9'|String
RISK\_GLUC|'-','9'|String
RISK\_MH|'-','9'|String
RISK\_NUTR|'-','9'|String
RISK\_SAFE|'-','9'|String
RISK\_SLEEP|'-','9'|String
RISK\_SMOK|'-','9'|String
RISK\_WGT|'-','9'|String
SEATBELT|'-','9'|String
SELFHLTH|'-','9'|String
SLPAPNEA|'-','9'|String
SLPPROB|'-','9'|String
SMKDETECT|'-','9'|String
STRETCH|'-','9'|String
TOBCURR|'-','9'|String
TOBPREV|'-','9'|String
WRKABSCAT|'-','9'|String
WRKABSCAT12|'-','9'|String
BMI|NULL|Numeric
CGRQTYR|NULL|Numeric
CGTQTYR|NULL|Numeric
CHEWQTYR|NULL|Numeric
CHOLESTR|NULL|Numeric
DIAST\_BP|NULL|Numeric
EXERWEEK|NULL|Numeric
GLUCOSE|NULL|Numeric
HDL|NULL|Numeric
HEIGHT|NULL|Numeric
LDL|NULL|Numeric
PIPEQTYR|NULL|Numeric
SYSTO\_BP|NULL|Numeric
TRIGLYCD|NULL|Numeric
WEIGHT|NULL|Numeric
WORKABS|NULL|Numeric

### Reading from **HEALTH_RISK_ASSESSMENT**

![](_files/image5.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| domain_id | - | - | - |
| person_id | enrolid | - | - |
| visit_occurrence_id | - | - | - |
| visit_detail_id | - | - | - |
| provider_id | - | - | - |
| id | - | System generated. | - |
| concept_id | the test name or name of the column | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a>.<br><br> `WHERE SOURCE_VOCABULARY_ID IN ('JNJ_TRU_HRA_QUESTION')`<br>`AND TARGET_INVALID_REASON IS NULL` | - |
| source_value | the test name or name of the column | - | - |
| source_concept_id | - | 0 | - |
| type_concept_id | - | `44786633` – numeric HRA values <br>`44786634` – categorical HRA values | Use table above to help know if the value is numeric or categorical. |
| start_date | survdate | - | - |
| start_datetime | survdate | start_date + midnight | - |
| end_date | - | NULL | - |
| end_datetime | - | NULL | - |
| verbatim_end_date | - | NULL | - |
| days_supply | - | NULL | - |
| dose_unit_source_value | - | NULL | - |
| lot_number | - | NULL | - |
| modifier_concept_id | - | 0 | - |
| modifier_source_value | - | NULL | - |
| operator_concept_id | - | 0 | - |
| quantity | - | NULL | - |
| range_high | - | NULL | - |
| range_low | - | NULL | - |
| refills | - | NULL | - |
| route_concept_id | - | 0 | - |
| route_source_value | - | NULL | - |
| sig | - | NULL | - |
| stop_reason | - | NULL | - |
| unique_device_id | - | NULL | - |
| unit_concept_id | - | 0 | - |
| unit_source_value | - | NULL | - |
| value_as_concept_id | - | 0 | - |
| value_as_number |  | If a question has a numeric result, put that answer here. | Use table above to help know if the value is numeric or categorical.|
| value_as_string |  | If a question has a string response, put that answer here. | Use table above to help know if the value is numeric or categorical. |
| value_source_value | the test name or name of the column | - | - |
| anatomic_site_concept_id | - | 0 | - |
| disease_status_concept_id | - | 0 | - |
| specimen_source_id | - | NULL | - |
| anatomic_site_source_value | - | NULL | - |
| disease_status_source_value | - | NULL | - |
| condition_status_concept_id | - | 0 | - |
| condition_status_source_value | - | NULL | - |
| event_id | - | NULL | - |
| event_field_concept_id | - | 0 | - |
| value_as_datetime | - | NULL | - |
| qualifier_concept_id | - | 0 | - |
| qualifier_source_value | - | NULL | - |