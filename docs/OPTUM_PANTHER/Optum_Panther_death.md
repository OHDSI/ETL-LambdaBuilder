---
layout: default
title: Death
nav_order: 3
parent: Optum EHR
description: "Death table mapping from Optum EHR patient table"

---

# CDM Table: DEATH

In Optum EHR this information will be sourced from the native **PATIENT** table. Only take records where **DECEASED_INDICATOR** = 1 and **DATE_OF_DEATH** is not blank. 

**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
|:-----:|:-----:|:-----:|:-----:|
PERSON_ID|PTID|||
DEATH_DATE|**DATE_OF_DEATH**|Since DATE_OF_DEATH is given as year/month, use the last day of the month as the day value.||
DEATH_DATETIME|Set time to 00:00:00 UTC Tz|||
DEATH_TYPE_CONCEPT_ID|32519 |||
CAUSE_OF_DEATH_CONCEPT_ID|0|||
CAUSE_OF_DEATH_SOURCE_VALUE|0|||
CAUSE_SOURCE_CONCEPT_ID|0|||

## Change Log:

### November 2, 2021
- Changed DEATH_TYPE_CONCEPT_ID to 32519


---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*
