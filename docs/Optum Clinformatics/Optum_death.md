#DEPRECATED IN CDM V6.0 +. Below documentation only applies for V5+ < V6

# CDM Table: DEATH

- DOD: this table will be sourced from the table **Death** - except for persons not in person table and based on logic below. 
- SES: this table will be algorithmically derived from observations in claims data. 
- Cause of death is not present in source data.

## **DEATH Table Logic**
- Delete person if not in PERSON table.
- For DOD only,
    - If there are outpatient or pharmacy visits (VISIT_CONCEPT_ID in 9202, 581458) with visit start date after 30 days of death date, delete the visit record. 
    - If there are inpatient or ER visits (VISIT_CONCEPT_ID in 9202, 9203) with visit start date after 30 days of death date, delete the death record. 
    - If the death date occurs before the patient's date of birth, then delete the death record.

## **Deriving date of death in SES**
- In SES data only, date of death will be derived from claims as follows.
- The date of death will be associated to the VISIT_END_DATE.
- These fields will be scanned for death information:
  1. **MEDICAL_CLAIMS** DSTATUS (Discharge Status)
  1. **MED_DIAGNOSIS** DIAG (ICD10CM or ICD9CM diagnosis codes)
  1. **MEDICAL_CLAIMS** DRG

### **Mapping DEATH_TYPE_CONCEPT_ID**

If a person in the **DOD** database has a death record sourced from the **DEATH** table use **DEATH_TYPE_CONCEPT_ID = 32519**

#### Using **MEDICAL_CLAIMS** DSTATUS

| Source Field       | Source Code | Source Code Description               | DEATH_TYPE_CONCEPT_ID |
|------------------|--------------|-----------------------------------------|--------------------------|
| **MEDICAL_CLAIMS** DSTATUS | 20           | EXPIRED                                 | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 21           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 22           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 23           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 24           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 25           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 26           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 27           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 27           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 28           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 29           | EXPIRED TO BE DEFINED AT STATE LEVEL    | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 40           | EXPIRED AT HOME (HOSPICE)               | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 41           | EXPIRED IN A MEDICAL FACILITY (HOSPICE) | 32507        |
| **MEDICAL_CLAIMS** DSTATUS | 42           | EXPIRED – PLACE UNKNOWN (HOSPICE)       | 32507        |


#### Using ICD9CM and ICD10CM from **MED_DIAGNOSIS** DIAG   

Use [Source to Source](code_snippets.md#source-to-source) and filter with
```WHERE SOURCE_VOCABULARY_ID IN ('JNJ_DEATH')``` to find DEATH records using the diagnosis codes. Give these records **DEATH_TYPE_CONCEPT_ID = 32508**

#### Using ICD9CM and ICD10CM from **MEDICAL_CLAIMS** DRG 

For DRGs, use the following query.  DRGs are date-sensitve so we need to only pick up DRGs that fall within the valid start and end dates.

```
SELECT CONCEPT_ID, CONCEPT_NAME, CONCEPT_CODE, valid_start_date, valid_end_date
FROM concept
WHERE CONCEPT_ID IN (
  38000421,38001111,38001112,38001113
)
```
Any records that have a DRG indicating the person is deceased should use the **DEATH_TYPE_CONCEPT_ID = 32509**

The **DEATH_TYPE_CONCEPT_ID**s should be treated hierarchically, where **MEDICAL_CLAIMS** DSTATUS > **MED_DIAGNOSIS** DIAG > **MEDICAL_CLAIMS** DRG


***


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PERSON_ID|PATID||
DEATH_DATE|**SES: VISIT_OCCURRENCE** VISIT_END_DATE <br><br> **DOD: DEATH**<br/> ymdod|**(DOD only) DEATH**<br/> Use the last day of the month|
DEATH_DATETIME|Set time to 00:00:00 UTC Tz||
DEATH_TYPE_CONCEPT_ID|Derived field|[See mapping logic](#Mapping-DEATH_TYPE_CONCEPT_ID) |These CONCEPT_IDs fall under VOCABULARY_ID = 'Death Type' in CONCEPT table.
CAUSE_OF_DEATH_CONCEPT_ID|0||
CAUSE_OF_DEATH_SOURCE_VALUE|0||
CAUSE_SOURCE_CONCEPT_ID|0||
---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*
