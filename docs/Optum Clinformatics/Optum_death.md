---
layout: default
title: Death
nav_order: 15
parent: Optum Clinformatics
description: "DEATH table mapping from DOD DEATH table, MEDICAL_CLAIMS and MED_DIAGNOSIS in DOD "

---

# CDM Table: DEATH

- DOD: this table will be sourced from the table **Death** - except for persons not in person table. If person is absent in **Death** table, but the fact of death is confirmed by information in MEDICAL_CLAIMS.DSTATUS, populate the DEATH table as well.
- SES: As of 2025, we are no longer deriving death data from Optum SES.
- Cause of death is not present in source data.

## **DEATH Table Logic**
- Delete person if not in PERSON table.

### **Deriving date of death from the death record in DOD**

- If the observation_period_start_date occurs prior to the death date, delete the death record
- If the death date occurs before the patient's date of birth, then delete the death record.
- If there are outpatient or pharmacy visits (VISIT_CONCEPT_ID in 9202, 581458) with visit start date after 30 days of death date, delete the visit record. 
- If there are inpatient or ER visits (VISIT_CONCEPT_ID in 9201, 9203) with visit start date after 30 days of death date, delete the death record. 
- If person is absent in **Death** table, but the fact of death is confirmed by the MEDICAL_CLAIMS logic (see below), populate the DEATH table as well.

### **Deriving date of death from MEDICAL_CLAIMS in DOD**
- Date of death will be derived from claims as follows:
- The date of death will be associated to the VISIT_END_DATE.
- These fields will be scanned for death information:
  1. **MEDICAL_CLAIMS** DSTATUS (Discharge Status)

#### Using **MEDICAL_CLAIMS** DSTATUS

DEATH = TRUE where DSTATUS in (21,22,23,24,25,26,27,28,29,40,41,42),
see the descriptions below for the reference:

| Source Field       | Source Code | Source Code Description               | DEATH_TYPE_CONCEPT_ID |
|------------------|--------------|-----------------------------------------|--------------------------|
| **MEDICAL_CLAIMS** DSTATUS | 20           | EXPIRED                                 | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 21           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 22           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 23           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 24           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 25           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 26           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 27           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 27           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 28           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 29           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 40           | EXPIRED AT HOME (HOSPICE)               | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 41           | EXPIRED IN A MEDICAL FACILITY (HOSPICE) | 32812        |
| **MEDICAL_CLAIMS** DSTATUS | 42           | EXPIRED – PLACE UNKNOWN (HOSPICE)       | 32812        |


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PERSON_ID|PATID||
DEATH_DATE|**VISIT_OCCURRENCE** VISIT_END_DATE <br><br> **DEATH**<br/> ymdod or visit_end_date if MEDICAL_CLAIMS.DSTATUS logic is applied|**DEATH**<br/> Use the last day of the month|
DEATH_DATETIME|Set time to 00:00:00 UTC Tz||
DEATH_TYPE_CONCEPT_ID|Derived field|if death acquired from DOD DEATH - 32885, in the other cases - 32812 |
CAUSE_OF_DEATH_CONCEPT_ID|0||
CAUSE_OF_DEATH_SOURCE_VALUE|0||
CAUSE_SOURCE_CONCEPT_ID|0||
---
*Common Data Model ETL Mapping Specification for Optum Extended DOD*
<br>*CDM Version = 5.4

## Change log

### 02-Feb-2025
- Updated logic to remove derived death for Optum SES
- Removed logic from MEDICAL_CLAIMS.DRG and MED_DIAGNOSIS in Optum DOD

### 04-Dec-2024
- fixed misprint in the delete death record rule (DOD), inpatient VISIT_CONCEPT_ID 9202 -> 9201

### 11-Aug-2023

- table is revived since in CDM v5.4 the death table is present (the file was retired in intent of migration to CDM v6)
- Type concepts are up-to-date
- in DOD usage of SES logic if entry is absent in DEATH table
