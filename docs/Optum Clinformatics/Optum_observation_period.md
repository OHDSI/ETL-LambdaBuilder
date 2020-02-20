---
layout: default
title: Observation Period
nav_order: 2
parent: Optum Clinformatics
description: "Observation_Period mapping from Optum member_continuous_enrollment table"

---

# CDM Table: OBSERVATION_PERIOD

The information in the OBSERVATION_PERIOD table is sourced from the  **Member_Continuous_Enrollment** table. This table can contain multiple records per person, each record representing a period of time the person was enrolled in a health benefit Plan. These records are consolidated using the logic below to create records in the OBSERVATION_PERIOD table. 

## **OBSERVATION_PERIOD Table Logic**

- Members not in OMOP **PERSON** table will be excluded.
- Periods of continuous enrollment are consolidated by combining records as long as the time between the end of one enrollment period and the start of the next is less than or equal to 32 days (<= 32 days).
- If the earliest ELIGEFF occurs prior to 05/01/2000 revise ELIGEFF to match the start date of data `MAX(ELIGEFF, '05-01-2000')`
- If the latest ELIGEND > **Member_Continuous_Enrollment** last date of Extract_Ym, then edit `ELIGEND = MAX(ELIGEND, Extract_Ym)


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
OBSERVATION_PERIOD_ID| |System generated.|
PERSON_ID|**Member_Continuous_Enrollment** PATID| |
OBSERVATION_PERIOD_START_DATE|**Member_Continuous_Enrollment** ELIGEFF|[See logic](#OBSERVATION_PERIOD_Table_Logic)|
OBSERVATION_PERIOD_END_DATE|**Member_Continuous_Enrollment** ELIGEND|[See logic](#OBSERVATION_PERIOD_Table_Logic)
PERIOD_TYPE_CONCEPT_ID|Use concept_id 44814722 ('Period while enrolled in insurance')| |


---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*