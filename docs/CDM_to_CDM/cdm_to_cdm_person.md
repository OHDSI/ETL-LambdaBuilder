---
layout: default
title: Person
nav_order: 1
parent: CDM to CDM
description: "Person mapping from an existing CDM instance"

---

# CDM Table name: PERSON

Map the new PERSON table from the existing PERSON table. The following data quality fixes are employed:

- Any person with an unknown year_of_birth is removed.
- Any person with an implausible year_of_birth is removed.
   - Persons with a year_of_birth in the future are removed.
   - Persons with a year_of_birth prior to 1875 are removed.

## Reading from PERSON

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| person_id | person_id |  |  |
| gender_concept_id | gender_concept_id |  |  |
| year_of_birth | year_of_birth |  |  |
| month_of_birth | month_of_birth |  |  |
| day_of_birth | day_of_birth |  |  |
| birth_datetime | birth_datetime |  |  |
| race_concept_id | race_concept_id |  |  |
| ethnicity_concept_id | ethnicity_concept_id |  |   |
| location_id | location_id |  |  |
| provider_id | provider_id |  |  |
| care_site_id | care_site_id |  |  |
| person_source_value | person_source_value |  |  |
| gender_source_value | gender_source_value |  |  |
| gender_source_concept_id | gender_source_concept_id |  |  |
| race_source_value | race_source_value |  |   |
| race_source_concept_id | race_source_concept_id |  |  |
| ethnicity_source_value |  ethnicity_source_value |  |  | 

## Change log
