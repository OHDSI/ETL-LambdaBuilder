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

## Death logic

Death datetime is now in the PERSON table instead of a separate DEATH table. Here is how the field DEATH_DATETIME should be determined:

- DOD: DEATH_DATETIME will be sourced from the table **Death** - except for persons not in person table and based on logic below. 
- SES: this table will be algorithmically derived from observations in claims data. 

For **DOD** only,
- If there are outpatient or pharmacy visits (VISIT_CONCEPT_ID in 9202, 581458) with visit start date after 30 days of death date, delete the visit record. 
- If there are inpatient or ER visits (VISIT_CONCEPT_ID in 9202, 9203) with visit start date after 30 days of death date, delete the death record. 
- If the death date occurs before the patient's date of birth, then delete the death record. **Deriving date of death in SES**

In **SES** data only, 
- These fields will be scanned for death information:
    1. **MEDICAL_CLAIMS** DSTATUS (Discharge Status) - where DSTATUS in (21,22,23,24,25,26,27,28,29,40,41,42)
    1. **MED_DIAGNOSIS** DIAG (ICD10CM or ICD9CM diagnosis codes) - use the SOURCE_TO_SOURCE query with the filter ```WHERE SOURCE_VOCABULARY_ID IN ('JNJ_DEATH')```
     1. **MEDICAL_CLAIMS** DRG using the query: 
        
``` 
SELECT CONCEPT_ID, CONCEPT_NAME, CONCEPT_CODE, valid_start_date, valid_end_date
FROM concept
WHERE CONCEPT_ID IN (
  38000421,38001111,38001112,38001113)
```   

- The date of death will be associated to the VISIT_END_DATE.
 
    
### **Mapping of source field values to OMOP Vocabulary concept id**

#### **Mapping Gender**
|GDR_CD|DESCRIPTION|OMOP Concept_Id|
|:-----:|:-----:|:-----:|
M|Male|8507
F|Female|8532

#### **Mapping Race**
|Race|DESCRIPTION|OMOP Concept_Id|
|:-----:|:-----:|:-----:|
A|Asian|8515
B|Black|8516
H|Hispanic|0
W|White|8527
U, Blank, or *NULL*|Unknown|0

#### **Mapping Ethnicity**
|Race|DESCRIPTION|OMOP Concept_Id|
|:-----:|:-----:|:-----:|
A|Asian|38003564
B|Black|38003564
H|Hispanic|38003563
W|White|38003564
U, Blank, or *NULL*|Unknown|0


------------------
------------------

|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
|:-----:|:-----:|:-----:|:-----:|
|PERSON_ID|**Member_Continuous_Enrollment** PATID| | |
|GENDER_CONCEPT_ID|**Member_Continuous_Enrollment** GDR_CD|[See mapping](#Mapping-Gender)||
|YEAR_OF_BIRTH|**Member_Continuous_Enrollment** YRDOB||
|MONTH_OF_BIRTH|Derived field|[See logic above](#PERSON-Table-Logic)|
|DAY_OF_BIRTH|Derived field|[See logic above](#PERSON-Table-Logic)|
|BIRTH_DATETIME|**Member_Continuous_Enrollment** YRDOB <br> **PERSON** MONTH_OF_BIRTH <br> **PERSON** DAY_OF_BIRTH <br> UTC tz midnight|Concatenate the source field values into datetime value with UTC Timezone|
|DEATH_DATETIME|**(DOD only) DEATH** YMDOD|Set the day to the last day of the month and set time to UTC tz midnight|
|RACE_CONCEPT_ID|**(SES only)** **SES** D_RACE_CODE|[See Race mapping](#Mapping-Race)|This data does not exist for DOD so this should be set to 0 for persons in the DOD database.|
|ETHNICITY_CONCEPT_ID|**(SES only)** **SES**  D_RACE_CODE |[See Ethnicity mapping](#Mapping-Race)|This data does not exist for DOD so this should be set to 0 for persons in the DOD database.|
|LOCATION_ID|FK to Location table.|Represents the last known location for person in **Member_Continuous_Enrollment**. For **SES** the field is DIVISON, and **DOD** it is STATE||
|PROVIDER_ID||| |
|CARE_SITE_ID|| | |
|PERSON_SOURCE_VALUE|**Member_Continuous_Enrollment** PATID|||
|GENDER_SOURCE_VALUE|**Member_Continuous_Enrollment** GDR_CD|||
|GENDER_SOURCE_CONCEPT_ID||0||
|RACE_SOURCE_VALUE|**(SES only) SES** D_RACE_CODE |`If D_RACE_CODE in ('W','A','U','B')`|This data does not exist for DOD so this should be set to NULL for persons in the DOD database.|
|RACE_SOURCE_CONCEPT_ID||0||
|ETHNICITY_SOURCE_VALUE|**(SES only)**<br/>**SES** D_RACE_CODE|`If D_RACE_CODE = 'H'`|This data does not exist for DOD so this should be set to NULL for persons in the DOD database.|
|ETHNICITY_SOURCE_CONCEPT_ID||0|||

---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*