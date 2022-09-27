---
layout: default
title: Death
nav_order: 10
parent: CPRD Aurum
description: "CPRD Aurum Death Logic"

---

# CDM Table: DEATH

## Reading from CPRD_Aurum.Patient

If deathdate is populated with a date in the Patient table then the patient will be included in the Death table.  

**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PERSON_ID|patid||
DEATH_DATE|cprd_ddate|
DEATH_DATETIME| ||
DEATH_TYPE_CONCEPT_ID|32815 (Death Certificate)
CAUSE_OF_DEATH_CONCEPT_ID|0||
CAUSE_OF_DEATH_SOURCE_VALUE|0||
CAUSE_SOURCE_CONCEPT_ID|0||