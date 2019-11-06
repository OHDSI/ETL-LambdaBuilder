---
layout: default
title: Observation_Period
nav_order: 2
parent: CPRD
description: "Observation_Period mapping from CPRD patient and practice tables"

---

## CDM Table name: OBSERVATION_PERIOD

### Reading from CPRD.Patient

Remove any patients who do not contribute valid observation time (observation start date is less than observation end date). 

![](images/image3.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| observation_period_id |  |  | Autogenerate |
| person_id | patid |  |  |
| observation_period_start_date | crd | Take the max(patient.crd, practice.uts) to determine this date |  |
| observation_period_end_date | tod | Take the min(patient.tod, practice.lcd,date data received) | THEMIS rule #23 now allows for data to be retained after the OBSERVATION_PERIOD_END_DATE and an option is now available in ATLAS to include that data in an analysis. |
| period_type_concept_id |  |  | 44814725 - Period inferred by algorithm |


### Reading from CPRD.Practice

![](images/image4.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| observation_period_id |  |  | Autogenerate |
| person_id |  |  |  |
| observation_period_start_date | uts | Take the max(patient.crd, practice.uts) to determine this date |  |
| observation_period_end_date | lcd | Take the min(patient.tod, practice.lcd, date data received) |  |
| period_type_concept_id |  |  | 44814725 - Period inferred by algorithm |
