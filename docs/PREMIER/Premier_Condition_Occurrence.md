---
title: "Condition Occurrence"
author: "Andryc, A; Fortin, S"
nav_order: 3
parent: Premier
layout: default
---

# Table Name: Condition Occurrence

The CONDITION_OCCURRENCE table will house records from PATBILL and PATICD_DIAG that have been mapped to the condition domain and SNOMED vocabulary. 

Condition occurrences in Premier are stored in PATICD_DIAG as diagnosis codes. The table houses admitting, primary and secondary diagnosis by visit. The CDM transformation captures all 3 types of diagnoses. In many cases patients will have the same admitting and primary diagnosis. The field PATICD_DIAG.ICD_VERSION identifies the diagnosis code as either ICD-9 or ICD-10. The data contain ICD-9 codes for diagnoses prior to 2015/10/01 and ICD-10 codes for diagnoses on or after 2015/10/01. The condition start date is determined as the visit start date from the VISIT_OCCURRENCE table. The exact day of diagnosis is not recorded in Premier, thus the assumption is made that the diagnosis is made on the VISIT_START_DATE. The CONDITION_END_DATE is null because in Premier we are unaware of when the condition is no longer relevant to the patient. The ASSOCIATED_PROVIDER_ID that is provided is the randomly generated key provided by Premier for the provider that admitted the patient. There are two providers that exist in Premier, the admitting and attending. This ETL makes the decision to use admitting because it is unknown whether the admitting provider, attending provider or another person diagnosed the person.  

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| CONDITION_OCCURRENCE_ID | - | System-generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| CONDITION_CONCEPT_ID | PATICD_DIAG.ICD_CODE <br /> PATBILL.STD_CHG_CODE | For records from PATBILL.STD_CHG_CODE: <br /> QUERY: SOURCE TO STANDARD SELECT TARGET_VOCABULARY_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('JNJ_PMR_PROC_CHRG_CD') AND TARGET_DOMAIN_ID = 'Condition' <br /> <br /> For records from PATICD_DIAG.ICD_CODE: where ICD_VERSION=9 QUERY: SOURCE TO STANDARD SELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM') AND TARGET_DOMAIN_ID = 'Condition' <br /> <br />For records from PATICD_DIAG.ICD_CODE: where ICD_VERSION=10 <br /> QUERY: SOURCE TO STANDARD SELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD10CM') AND TARGET_DOMAIN_ID = 'Condition' | ICD9 diagnosis codes are mapped to SNOMED concepts  |
| CONDITION_START_DATE | PATBILL.SERV_DATE VISIT_OCCURRENCE.VISIT_START_DATE OR VISIT_OCCURRENCE.VISIT_START_DATE  | If observation comes from PATICD_DIAG.ICD_CODE or PATBILL then use visit start date |  |
| CONDITION_START_DATETIME | - | NULL |  |
| CONDITION_END_DATE | - | NULL |  |
| CONDITION_END_DATETIME | - | NULL |  |
| CONDITION_TYPE_CONCEPT_ID | | Records coming from the PATICD_DIAG table should be given a condition_type_concept_id = 32818 (EHR Administration Record) <BR> Records coming from the PATBILL.STD_CHG_CODE table should be given a condition_type_concept_id = 32852 (Hospital Cost)|  |
| STOP_REASON | - | NULL |  |
| PROVIDER_ID | PAT.ADMPHY | NULL |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| CONDITION_SOURCE_VALUE | PATICD_DIAG.ICD_CODE |  |  |
| CONDITION_SOURCE_CONCEPT_ID |  | QUERY: SOURCE TO SOURCE SELECT SOURCE_CONCEPT_IDFROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('ICD9CM', 'ICD10', 'ICD10CM') AND TARGET_VOCABULARY_ID IN ('ICD9CM', 'ICD10', 'ICD10CM') AND DOMAIN_ID='CONDITION' |  |
| CONDITION_STATUS_SOURCE_VALUE | PATICD_DIAG.ICD_PRI_SEC <br> PATBILL |  | Records coming from PATICD_DIAG will have condition_status_source_value = 'A', 'P' or 'S'.<br><br>  Records coming from PATBIL will have a condition_status_source_value = 'From PATBILL - No information provided' |
| CONDITION_STATUS_CONCEPT_ID | PATICD_DIAG.ICD_PRI_SEC | Records from PATICD_DIAG: <br> ICD_PRI_SEC = A, then 32890 (admission diagnosis) <br> ICD_PRI_SEC = P, then 32902 (primary diagnosis) <br> ICD_PRI_SEC = S, then 32908 (secondary diagnosis) <br><br> Records from PATBILL: <br> Assign 32908 (secondary diagnosis)| |

## Change log:
 * 2023.10.23:
     + SERV_DAY changed to SERV_DATE
 * 2021.08.11:  
     + Updated CONDITION_STATUS_CONCEPT_ID to leverage icd_pir_sec and the standard status concepts. This replaced previous logic leveraging ICD_POA.  
     + Added comments to CONDITION_SOURCE_VALUE.
     + Updated CONDITION_TYPE_CONCEPT_ID so that it leveraged standard type concepts moving forward.
