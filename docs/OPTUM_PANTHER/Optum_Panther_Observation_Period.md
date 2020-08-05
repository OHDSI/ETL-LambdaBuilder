---
layout: default
title: Observation Period
nav_order: 2
parent: OPTUM_PANTHER
description: "Description for how to build the Optum Panther Observation Period table from the encounter table "

---

# CDM Table name: OBSERVATION_PERIOD

## Reading from OPTUM_EHR.Encounter

The OBSERVATION_PERIOD table should be built by setting the OBSERVATION_PERIOD_START_DATE as the date of the earliest encounter available in the data and the OBSERVATION_PERIOD_END_DATE should the the date of the latest encounter in the data. 

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
|     observation_period_id    |          |          |          |
|     person_id    |     ptid    |          |          |
|     observation_period_start_date    |   min(interaction_date)    |      |          |
|     observation_period_end_date    |     max(interaction_date)   |       |          |
|     period_type_concept_id    |     38000280    |          |     Observation   recorded from EHR    |

## Change Log
- Removed the use of *first_month_active* and *last_month_active* and changed to using the encounter dates instead