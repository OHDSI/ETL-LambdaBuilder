---
layout: default
title: Person
nav_order: 1
parent: CPRD_ETL
description: "Person mapping from CPRD patient table"

---

![](/docs/CPRD/image2.png)

## CDM Table name: PERSON

### Reading from CPRD.Patient

The patients in the CDM are restricted to the subset of all CPRD patients deemed to have reached certain quality standards as defined by the data providers. Patients whose acceptable patient flag (patient.accept) is not equal to 1 will be removed (1=acceptable, 0=unacceptable). 


![](/docs/image2.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| person_id | patid |  |  |
| gender_concept_id | gender | Map CPRD gender as follows:    CPRD	Description			OMOP	Concept_id  Gender 				Description  Code  0	Data Not Entered	  1	Male		M	MALE	8507  2	Female		F	FEMALE	8532  3	Indeterminate		  4	Unknown | Remove anyone with an unknown gender, CPRD gender code in (0,3,4) |
| year_of_birth | yob | patient.yob+1800 | Remove any patients that are born before 1900 |
| month_of_birth | mob |  | Patient.mob only populated for children, if 0, set as NULL |
| day_of_birth |  |  |  |
| birth_datetime |  |  |  |
| race_concept_id |  |  | 0 |
| ethnicity_concept_id |  |  | 0  -  Could be possible to write an algorithm in the future using the Read codes that are available for a patient. |
| location_id |  |  |  |
| provider_id |  |  |  |
| care_site_id | patid | Last 3 digits of patient.patid is the practice identifier |  |
| person_source_value | patid |  |  |
| gender_source_value | gender |  |  |
| gender_source_concept_id |  |  | 0 |
| race_source_value |  |  |  |
| race_source_concept_id |  |  | 0 |
| ethnicity_source_value |  |  |  |
| ethnicity_source_concept_id |  |  | 0 |
