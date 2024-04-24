---
layout: default
title: Observation Period
nav_order: 2
parent: CDM to CDM
description: "Observation Period mapping from an existing CDM instance"

---

# CDM Table name: OBSERVATION_PERIOD

Map the new OBSERVATION_PERIOD table from the existing OBSERVATION_PERIOD table. The following data quality fixes are employed:

- Any person with an implausible observation period is removed. If any of the below rules are violated the person and all their data are removed.
   - Persons with an observation_period_start_date in the future are removed.
   - Persons with an observation_period_start_date that occurs after the observation_period_end_date are removed.
- If the observation_period_end_date is a future date it is truncated either to the current date or to the end date of the database.


## Reading from OBSERVATION_PERIOD

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| OBSERVATION_PERIOD_ID | OBSERVATION_PERIOD_ID | - | - |
| PERSON_ID | PERSON_ID | - | - |
| OBSERVATION_PERIOD_START_DATE | OBSERVATION_PERIOD_START_DATE | - | - |
| OBSERVATION_PERIOD_END_DATE | OBSERVATION_PERIOD_END_DATE | - |  |
| PERIOD_TYPE_CONCEPT_ID | PERIOD_TYPE_CONCEPT_ID | - | - |


## Change Log
