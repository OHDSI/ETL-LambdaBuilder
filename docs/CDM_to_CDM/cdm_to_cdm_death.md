---
layout: default
title: Death
nav_order: 3
parent: CDM to CDM
description: "DEATH mapping from an existing CDM instance"
---

## Table name: **DEATH**

Map the new DEATH table from the existing DEATH table.The following data quality fixes are employed:

- Any death records with a death_date and/or death_datetime that occurs in the future is removed.

### Reading from **DEATH**

| destination field | source field | logic | comment field |
| --- | --- | --- | --- |
| person_id | person_id | | |
| death_date | death_date | | |
| death_datetime | death_datetime | | |
| death_type_concept_id | death_type_concept_id |  | |
| cause_concept_id | cause_concept_id| | |
| cause_source_value | cause_source_value | | |
| cause_source_concept_id | cause_source_concept_id | | |

## Change log