---
title: "CDM Source"
author: "Andryc, A; Fortin, S"
layout: default
parent: Premier
---

# CDM Table Name:  CDM_SOURCE

The CDM_SOURCE table houses metadata about the version of the CDM that is populated, including key elements such as the vocabulary version used in generating the CDM.

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| CDM_SOURCE_NAME |  | Premier Hospitalization Database (PHD) |  |
| CDM_SOURCE_ABBRIVIATION |  | Premier |  |
| CDM_HOLDER |  | Janssen Research & Development |  |
| SOURCE_DESCRIPTION |  | Anonymized hospital transactional database from over 500 hospitals from 2000-present day includes inpatient, outpatient, and emergency room visits. The database is a visit-oriented database, with each visit having its own unique id.  Conditions are coded as ICD9 codes and procedures are coded both in ICD9, CPT, and HCPCS procedure codes. Drugs, labs, and other procedures are coded as a standard charge code and occur as a transaction.  Cost information is associated to each transaction including charges and quantity of each transaction is recorded in the billing table. |  |
| SOURCE_DOCUMENTATION_REFERENCE |  |  |  |
| CDM_ETL_REFERENCE |  |  |  |
| SOURCE_RELEASE_DATE |  | SELECT VERSION_DATE FROM [_Version] | Get from the raw source tables. |
| CDM_RELEASE_DATE |  | SELECT CONVERT(VARCHAR(10), GETDATE(),102) | Get the date the run completes. |
| CDM_VERSION |  | V5.3.1 |  |
| VOCABULARY_VERSION |  | SELECT VOCABULARY_VERSION FROM VOCABULARY WHERE VOCABULARY_ID = 'None' | Taken from the Vocabulary loaded into the CDM. |

