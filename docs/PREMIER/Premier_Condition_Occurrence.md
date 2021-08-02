---
title: "Condition Occurrence"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 3
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
| CONDITION_CONCEPT_ID | PATICD_DIAG.ICD_CODEPATBILL.STD_CHG_CODE | For records from PATBILL.STD_CHG_CODE:QUERY: SOURCE TO STANDARD SELECT TARGET_VOCABULARY_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('JNJ_PMR_PROC_CHRG_CD')AND TARGET_DOMAIN_ID = 'Condition'For records from PATICD_DIAG.ICD_CODE:where ICD_VERSION=9QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM')AND TARGET_DOMAIN_ID = 'Condition'For records from PATICD_DIAG.ICD_CODE:where ICD_VERSION=10QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD10CM')AND TARGET_DOMAIN_ID = 'Condition' | ICD9 diagnosis codes are mapped to SNOMED concepts  |
| CONDITION_START_DATE | PATBILL.SERV_DAY VISIT_OCCURRENCE.VISIT_START_DATEORVISIT_OCCURRENCE.VISIT_START_DATE  | If condition is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf observation comes from PATICD_DIAG.ICD_CODE then use visit start date | If condition is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf observation comes from PATICD_DIAG.ICD_CODE then use visit start date |
| CONDITION_START_DATETIME | - | NULL |  |
| CONDITION_END_DATE | - | NULL |  |
| CONDITION_END_DATETIME | - | NULL |  |
| CONDITION_TYPE_CONCEPT_ID | - | For records from PATICD_DIAG.ICD_CODE:when PAT.I_O_IND =’I’ and ICD.PRI_SEC =’P’ then 38000183when PAT.I_O_IND=’I’ and  PATICD_DIAG.ICD_PRI_SEC =’S’ then 38000185when PAT.I_O_IND=’O’ and  PATICD_DIAG.ICD_PRI_SEC =’P’ then 38000215when PAT.I_O_IND=’O’ and  PATICD_DIAG.ICD_PRI_SEC =’S’ then 38000216when PAT.I_O_IND in (’I’ , “O”) and PATICD_DIAG.ICD_PRI_SEC =’A’ then 4203942For records from PATBILL.STD_CHG_CODE:when PAT.I_O_IND =’I’ then 38000186when PAT.I_O_IND=’O’ then 38000217 |  |
| STOP_REASON | - | NULL |  |
| PROVIDER_ID | PAT.ADMPHY | NULL |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| CONDITION_SOURCE_VALUE | PATICD_DIAG.ICD_CODE |  |  |
| CONDITION_SOURCE_CONCEPT_ID |  | QUERY: SOURCE TO SOURCESELECT SOURCE_CONCEPT_IDFROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('ICD9CM', 'ICD10', 'ICD10CM')AND TARGET_VOCABULARY_ID IN ('ICD9CM', 'ICD10', 'ICD10CM') AND DOMAIN_ID='CONDITION' |  |
| CONDITION_STATUS_SOURCE_VALUE | PATICD_DIAG.ICD_POA |  |  |
| CONDITION_STATUS_CONCEPT_ID | PATICD_DIAG.ICD_POA | When PATICD_DIAG.ICD_POA in (‘W’, ‘Y’) then 46236988Else 0 |  |
