---
title: "Death"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 5
layout: default
---

# Table:  Death

Death is mapped from discharge status and ICD9 codes. The cause of death is not available in Premier. Discharge status from the PAT table should be used first, and if no codes are found, then ICD9 codes are used. ICD codes that indicate death are found in the source to concept map, see applied rule section below. Keep only one record for each patient, if both discharge status and ICD9 codes indicate death, use discharge status first.  No records should be populated for that person 32 days after the death date. 

The field mapping is as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| PERSON_ID | PAT.MEDREC_KEY |||
| DEATH_DATE | VISIT_OCCURRENCE.VISIT_END_DATE || The exact date of death cannot be determined thus the VISIT_END date is used. |
| DEATH_DATETIME || NULL ||
| DEATH_TYPE_CONCEPT_ID | PAT.DISC_STATUS <br>OR<br> PATICD.ICD_CODE | Logic based on discharge status or ICD9 diagnosis code. If discharge code is present then assign 38003566, a discharge status of PAT.DISC_STATUS in (20, 40, 41, 42) indicates death.  Otherwise search PATICD.ICD_CODE records for ICD codes and assign 38003567.To identify death ICD codes, use the following.  QUERY: SOURCE TO STANDARD SELECT SOURCE_CODEFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID = ‘JNJ_DEATH’ ||
| CAUSE_CONCEPT_ID || NULL ||
| CAUSE_SOURCE_VALUE || NULL ||
| CAUSE_SOURCE_CONCEPT_ID || NULL ||
