---
layout: default
title: Person
nav_order: 1
parent: Optum Clinformatics
description: "Person mapping from Optum member_continuous_enrollment table"

---

# CDM Table: PERSON

The information in the PERSON table is sourced from the  **Member_Continuous_Enrollment** table. This table can contain multiple records per person, each record representing a period of time the person was enrolled in a health benefit Plan. These records are consolidated using the logic below to create one record per person in the PERSON table. 

## PERSON Table Logic

- Delete person if gender (GDR_CD) changed over different enrollment period.
- Delete person if there is more than one YRDOB, such that max(YRDOB) > min(YRDOB) +2.
- Choose last/recent record for person: 
    - Sort **Member_Continuous_Enrollment** by ascending order of ELIGEFF and ELIGEND to identify last/recent record by person. 
    - Use persons demographics information from this record as the values to populate the PERSON table, 
- After finding the last/recent record for a person, delete person if demographics meet any of the following criteria
    - YEAR_OF_BIRTH < 1900
    - YEAR_OF_BIRTH > CURRENT_YEAR
    - YEAR_OF_BIRTH > Min(Year(ELIGEFF)) +1
    - **Member_Continuous_Enrollment** GDR_CD is not M or F (not Male or Female).
- How to determine MONTH_OF_BIRTH and DAY_OF_BIRTH. 
    - if person has enrollment in the year of birth, then MONTH_OF_BIRTH = MONTH(MIN(ELIGEFF)) and DAY_OF_BIRTH = 1st day of the month. 
    - For datetime values, when time is not available, default to UTC timezone mid-night 00:00:00
 
### **Mapping of source field values to OMOP Vocabulary concept id**

#### **Mapping Gender**

|**GDR_CD**|**DESCRIPTION**|**OMOP Concept_Id**|
|:-----:|:-----:|:-----:|
|M|Male|8507|
|F|Female|8532|

#### **Mapping Race**

**Prior to the 202406 Optum Release, the race was derived.** An external vendor utilized the member’s name and geography to derive the member’s ethnicity (e.g. Chinese, Irish, Somali, Mexican etc.). Once the ethnicity was determined, the member was mapped to one of five race categories: A-Asian, B-Black, H-Hispanic, W-White or Unknown/Other.

**Release 202406 and after** Optum Extended now uses the same methodology as EHR and Market Clarity, relying on self-reported race/ethnicity data. Most of the information is sourced from vendor providing self-reported race/ethnicity data and additional data is brought in from Optum EHR. 

Optum generally prioritizes the most recently received self-reported race value for a patient. If multiple race values are received for a patient at the same time, Optum first prioritize the race with the highest frequency of reporting and if there are equal numbers of reported records for each different race value, the patient is considered multi-race and mapped to 'Unknown' race.

Race is also now split into two variables such that patients can denote both their race and ethnicity rather than the two being combined.

|**Race**|**DESCRIPTION**|**OMOP Concept_Id**|
|:-----:|:-----:|:-----:|
|A|Asian|8515|
|B|Black|8516|
|W|White|8527|
|U, Blank, or *NULL*|Unknown|0|

#### **Mapping Ethnicity**

|Race|DESCRIPTION|OMOP Concept_Id|
|:-----:|:-----:|:-----:|
|N|Not Hispanic|38003564|
|H|Hispanic|38003563|
|U, Blank, or *NULL*|Unknown|0|


------------------

## **Mapping the PERSON table**

### From the MEMBER_CONTINUOUS_ENROLLMENT table
![](images/image2.png)

### From the DEATH table
![](images/image3.png)

|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
|:-----:|:-----:|:-----:|:-----:|
|PERSON_ID|**Member_Continuous_Enrollment** PATID| | |
|GENDER_CONCEPT_ID|**Member_Continuous_Enrollment** GDR_CD|[See mapping](#Mapping-Gender)||
|YEAR_OF_BIRTH|**Member_Continuous_Enrollment** YRDOB||
|MONTH_OF_BIRTH|Derived field|[See logic above](#PERSON-Table-Logic)|
|DAY_OF_BIRTH|Derived field|[See logic above](#PERSON-Table-Logic)|
|BIRTH_DATETIME|**Member_Continuous_Enrollment** YRDOB <br> **PERSON** MONTH_OF_BIRTH <br> **PERSON** DAY_OF_BIRTH <br> UTC tz midnight|Concatenate the source field values into datetime value with UTC Timezone|
|DEATH_DATETIME|**(DOD only) DEATH** YMDOD|Set the day to the last day of the month and set time to UTC tz midnight|
|RACE_CONCEPT_ID|**Member_Enrollment** Race|[See Race mapping](#Mapping-Race)||
|ETHNICITY_CONCEPT_ID|**Member_Enrollment** Race|[See Ethnicity mapping](#Mapping-Race)||
|LOCATION_ID|FK to Location table.|Represents the last known location for person in **Member_Continuous_Enrollment**. For **SES** the field is REGION, and **DOD** it is STATE||
|PROVIDER_ID||| |
|CARE_SITE_ID|| | |
|PERSON_SOURCE_VALUE|**Member_Continuous_Enrollment** PATID|||
|GENDER_SOURCE_VALUE|**Member_Continuous_Enrollment** GDR_CD|||
|GENDER_SOURCE_CONCEPT_ID||0||
|RACE_SOURCE_VALUE|**Member_Enrollment** Race |`If Race in ('W','A','U','B')`||
|RACE_SOURCE_CONCEPT_ID||0||
|ETHNICITY_SOURCE_VALUE|**Member_Enrollment** Race|`If Race = 'H'`||
|ETHNICITY_SOURCE_CONCEPT_ID||0||

---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>CDM Version = 5.4

## Change log

### 2-Aug-2024
- Race and ethnicity now self-reported as two separate columns

### 3-Nov-2023
- Race now included in Member_Enrollment table instead of SES table 
- Race added to DOD
- SES LOCATION_ID division -> region

### 11-Aug-2023

- Death logic is removed since in CDM v5.4 the death table is present itself (not in person table)
