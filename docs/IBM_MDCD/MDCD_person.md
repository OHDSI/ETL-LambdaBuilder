---
layout: default
title: Person
nav_order: 1
parent: IBM MDCD
description: "**PERSON** mapping from IBM MarketScan® Medicaid (MDCD) **ENROLLMENT_DETAIL**."
---

## Table name: **PERSON**

### Key conventions
* Delete the following members:  Year(GETDATE()) - max(DOBYR)  < 90 AND max(DOBYR) >= min(DOBYR) +2 or sex changed over different enrollment period. 
  * If a person has two valid sex values across different enrollment periods then they are excluded. However, if they have an invalid sex value on their record at some point they will not be excluded and, instead, the sex value on the last, or most recent, enrollment detail is used. 
* Only use records where the person has prescription benefits (DRUGCOVG =1) or eligible for both Medicaid and Medicare coverage (MEDICARE =1). 
* If the person's other information changes (e.g. location, race, ethnicity), the last known record is used
* Delete individuals whose DOBYR &lt; 1900 or &gt; the current year.
* After defining the patient’s DOBYR (the one on their last record), exclude any individual who was born &gt; 1 year after their first enrollment period.
* The **ENROLLMENT_DETAIL** table may store multiple records for each person.  However, the CDM will only store one record per person in the **PERSON** table.  
* For MONTH_OF_BIRTH, the **OBSERVATION_PERIOD** table will need to be generated first. Then, the value can be derived from using YEAR_OF_BIRTH and OBSERVATION_PERIOD_START_DATE only if the year of birth is equal to the year of the first OBSERVATION_PERIOD_START_DATE.


### Reading from **ENROLLMENT_DETAIL**

![]()

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PERSON_ID | ENROLID | - | - |
| GENDER_CONCEPT_ID | SEX | Map source values to  their associated CONCEPT_IDs:   <br>1 	- 8507  <br>2 	- 8532    <br>If SEX is not 1 or 2 exclude that person. | The exclusion of a person by gender should happen on last enrollment record not just if they had one bad SEX record.<br><br> CONCEPT_IDs: <br>8507 = 'Male' <br>8532 = 'Female'|
| YEAR_OF_BIRTH | DOBYR | DOBYR needs to be > 1900 and <= current year.  If the DOBYR does not meet this criteria, drop the person. | - |
| MONTH_OF_BIRTH | - | NULL |  |
| DAY_OF_BIRTH | - | NULL | - |
| BIRTH_DATETIME | - | NULL | - |
| RACE_CONCEPT_ID | STDRACE | Map values of STDRACE to  their associated CONCEPT_IDs: <br> `CASE` <br> `WHEN STDRACE ='1' THEN 8527 (White)`<br> `WHEN STDRACE ='2' THEN 8516 (Black)` <br> `ELSE 0 (OTHER)` <br> `END AS RACE_CONCEPT_ID`| Codes from MDCD:  <br> 1: White  <br> 2: Black  <br> 4: Hispanic  <br> 9: Other`|
| ETHNICITY_CONCEPT_ID | STDRACE | Map values of STDRACE to  their associated CONCEPT_IDs: <br> `CASE` <br>` WHEN STDRACE ='4' THEN 38003563 (Hispanic or Latino)` <br> `ELSE 0 (OTHER)` <br> `END AS ETHNICITY_CONCEPT_ID` | - |
| LOCATION_ID | - | NULL | - |
| PROVIDER_ID | - | NULL | - |
| CARE_SITE_ID | - | NULL | - |
| PERSON_SOURCE_VALUE | ENROLID | - | - |
| GENDER_SOURCE_VALUE | SEX | - | - |
| GENDER_SOURCE_CONCEPT_ID | - | 0 | - |
| RACE_SOURCE_VALUE | STDRACE |  | - |
| RACE_SOURCE_CONCEPT_ID | - | 0 | - |
| ETHNICITY_SOURCE_VALUE | STDRACE |  | - |
| ETHNICITY_SOURCE_CONCEPT_ID | - | 0 | - |


## Change Log
19-Feb-2021: Correct the exclusion based on year of birth to read "Delete the following members:  Year(GETDATE()) - max(DOBYR)  < 90 AND max(DOBYR) >= min(DOBYR) +2". Once a person reaches 90 years of age their birth year is incremented up to protect patient privacy. 