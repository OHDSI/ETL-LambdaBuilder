---
title: "Person"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 15
layout: default
---

# Table Name: PERSON

In Premier, the PAT table contains all demographic, admission, and total cost data for each visit. There are multiple entries per person, thus a single record needs to be created to populate the PERSON table.  MONTH_OF_BIRTH and DAY_OF_BIRTH are not available in Premier, because age is the only available field. YEAR_OF_BIRTH is calculated from the first transformed admission date. The admission year minus the age results in the YEAR_OF_BIRTH. Some patients (MEDREC_KEY) have some visits (PAT_KEY) where AGE is recorded as 999. This is problematic where AGE=999 at a patient's first visit since year of birth is calculated as year of fist visit (date_part(year, min(VISIT_START_DATE))) minus AGE.  The ETL calculates year of birth as year of first visit minus age where age does not equal 999. If all patient age records are 999, then we drop that patient and they do not move to the CDM. 

Since no address information is available in Premier for each person, LOCATION_ID is null. 

Primary care providers for each person are not known, thus PROVIDER_ID and CARE_SITE is NULL. 

Race can vary among records for the same person in the PAT table, so the most common race value is used for these people. 

Ethnicity is available in the race field so logic is applied to parse out the ethnicity from each record. Hispanic is the only ethnicity available in Premier so for those with ethnicity recorded as Hispanic, their race is set to ‘Other’. For populating the ETHNICITY field, if the race is Hispanic then ETHNICITY is assigned Hispanic otherwise the ethnicity is coded as NULL.

Delete any patients that have invalid birth years < 1900 or > the current year. After birth year has been determined delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH.  Due to data discrepancies in Premier additional logic has been applied to generating gender and age. If a person has YEAR_OF_BIRTH that varies over two years then that person is dropped. Also, if a person has multiple genders recorded or unknown gender then those records are dropped. 

The exclusion criterion for the PERSON table removes about 1% of the population in the database. 

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| PERSON_ID | PAT.MEDREC_KEY | Field is a randomly generated identifier that is available in Premier |  |
| GENDER_CONCEPT_ID | PAT.GENDER | When PAT.GENDER=M then GENDER_CONCEPT_ID=8507 When PAT.GENDER=F then GENDER_CONCEPT_ID=8532 Delete records with Unknown gender | CONCEPT_ID’s are VOCABULARY_ID=Gender |
| YEAR_OF_BIRTH | VISIT_OCCURRENCE.VISIT_START_DATE <br> PAT.AGE | DATE_PART(YEAR, MIN(VISIT_START_DATE)) - AGE WHERE AGE <> 999 <br> YEAR_OF_BIRTH needs to be > 1900 and <=current year <br> Drop patients for whom all PAT.AGE records = 999 |  |
| MONTH_OF_BIRTH | - | NULL | Premier only provides age |
| DAY_OF_BIRTH | - | NULL | Premier only provides age |
| TIME_OF_BIRTH | - | NULL | Premier only provides age |
| BIRTH_DATETIME | - | NULL | Premier only provides age |
| RACE_CONCEPT_ID | PAT.RACE | When PAT.RACE=’W’ then RACE_CONCEPT_ID=8527<br>When PAT.RACE=’B’ then RACE_CONCEPT_ID =8516<br>When PAT.RACE=’H’ then RACE_CONCEPT_ID=0 and ETHNICITY_CONCEPT_ID=38003563<br>When PAT.RACE='A' then RACE_CONCEPT_ID=8515<br>Race value of ‘O’ and ‘U’ gets mapped to 0 | Premier combines both race and ethnicity into one field. Ethnicity is removed from race. If multiple race records per person, see logic to obtain the max value of race that occurs in all records.|
| ETHNICITY_CONCEPT_ID | PAT.RACE <br> PAT.HISPANIC_IND | When PAT.RACE=’H’ or PAT.HISPANIC_IND=’Y’ then ETHNICITY_CONCEPT_ID=38003563 <br> When PAT.HISPANIC=’N’ then ETHNICITY_CONCEPT_ID=38003564 <br> Ethnicity value of U gets mapped to 0 | If race is not Hispanic set ethnicity to 0 |
| LOCATION_ID | - | NULL |  |
| PROVIDER_ID | - | NULL |  |
| CARE_SITE_ID | - | NULL |  |
| PERSON_SOURCE_VALUE | PAT.MEDREC_KEY |  |  |
| GENDER_SOURCE_VALUE | PAT.GENDER |  |  |
| GENDER_SOURCE_CONCEPT_ID | - | NULL |  |
| RACE_SOURCE_VALUE | PAT.RACE |  |  |
| RACE_SOURCE_CONCEPT_ID | - | NULL |  |
| ETHNICITY_SOURCE_VALUE | PAT.RACE |  |  |
| ETHNICITY_SOURCE_CONCEPT_ID | - | NULL |  |

## To Do:
- 2020-12-21:  Currently working to integrate the Asian race into the OMOP CDM Premier ETL.
- 2020-12-21:  Currently working running validation on the Hisapnic ethnicity logic.