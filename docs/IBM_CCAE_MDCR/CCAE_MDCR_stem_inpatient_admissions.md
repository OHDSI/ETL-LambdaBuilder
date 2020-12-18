---
layout: default
title: INPATIENT_ADMISSIONS
nav_order: 5
grand_parent: IBM CCAE & MDCR
parent: IBM CCAE & MDCR to STEM
description: "INPATIENT_ADMISSIONS to STEM table description"
---

## Table name: **STEM_TABLE**

### Key conventions
* Any code with a domain of ‘Procedure’ should be added, regardless if it is a diagnosis (DX) field or procedure (PROC) field. PPROC appears in both IBM **INPATIENT_SERVICES** and **INPATIENT_ADMISSIONS** tables. To avoid duplicates, extract PPROC only from the **INPATIENT_ADMISSIONS** table. 
* Each record with a value in PROC1 in this table will be kept as one line in the **COST** table, and assign SVCDATE as PROCEDURE_DATE
* PDX appears in both **INPATIENT_SERVICES** and **INPATIENT_ADMISSIONS** tables.  To avoid duplicates, extract PDX only from the **INPATIENT_ADMISSIONS** table. The **INPATIENT_SERVICES** should still be added, but as DX1.
* For data coming from a DX or PROC field in **INPATIENT_ADMISSIONS** with the DOMAIN_ID ‘Observation’: 
  * Remove any duplicate records 
  * Set VISIT_PROVID and VISIT_PROVSTD as PPROV and PROVCAT


### Reading from **INPATIENT_ADMISSIONS**

![](_files/image4.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| DOMAIN_ID | - | NULL | - |
| PERSON_ID | ENROLID | NULL | - |
| VISIT_OCCURRENCE_ID | - | <ul><li>Refer to logic in building VISIT_OCCURRENCE table for linking with VISIT_OCCURRENCE_ID.</li><li>Health Risk Assesment and Lab data does not get assigned a VISIT_OCCURRENCE_ID.</li><li>If not assigned set to NULL.</li><ul>| - |
| VISIT_DETAIL_ID | - | NULL | - |
| PROVIDER_ID | - | NULL | - |
| ID | - | System generated. | - |
| CONCEPT_ID | PDX<br>DX1-15<br>PPROC<br>PROC1-15<br><br>DSTATUS | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a>.  If DXVER does not have a value, review to the "Key Conventions" under the "STEM Key Conventions and Lookup Files" page.  If no map is made, assign to 0.<br/><br/>**[PDX, DX1-15]**<br/>If DXVER=9 use the filter:<br/> `WHERE SOURCE_VOCABULARY_ID IN (‘ICD9CM’)`<br>`AND TARGET_STANDARD_CONCEPT = 'S'`<br/><br/>If DXVER=0 use the filter:<br/>`WHERE SOURCE_VOCABULARY_ID IN (’ICD10CM’)`<br>`AND TARGET_STANDARD_CONCEPT = 'S'` <br /><br />**[PPROC, PROC1-15]**<br/>When PROCTYP <> 0:  `WHERE SOURCE_VOCABULARY_ID IN ('ICD9Proc','HCPCS','CPT4',’ICD10PCS’)`<br>`AND TARGET_STANDARD_CONCEPT = 'S'` | As data is being assigned a CONCEPT_ID check the domain, this tells you what domain table the data should land.<br><br>If the CONCEPT = 0 the PDX, DX1-15 rows should land in **CONDITION_OCCURRENCE** and the PPROC, PROC1-15 should land in the **PROCEDURE_OCCURRENCE** table. |
| SOURCE_VALUE | PDX<br>DX1-15<br>PPROC<br>PROC1-15<br><br>DSTATUS | **DSTATUS**<br> Use "DSTATUS Lookup" in the "STEM Lookup Files" page to convert number to value. | - |
| SOURCE_CONCEPT_ID | - | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Source Query</a>.  If no map is made, assign to 0.<br/><br/>**[PDX, DX1-15]**<br/>If DXVER=9 use the filter:<br/> `WHERE SOURCE_VOCABULARY_ID IN (‘ICD9CM’)  AND TARGET_VOCABULARY_ID IN (‘ICD9CM’)`<br/><br/>If DXVER=0 use the filter:<br/>`WHERE SOURCE_VOCABULARY_ID IN (’ICD10CM’)  AND TARGET_VOCABULARY_ID IN (’ICD10CM’)` <br /><br />**[PPROC, PROC1-15]**<br/>When PROCTYP <> 0:  `WHERE SOURCE_VOCABULARY_ID IN ('ICD9Proc','HCPCS','CPT4',’ICD10PCS’)  AND TARGET_VOCABULARY_ID IN ('ICD9Proc','HCPCS','CPT4',’ICD10PCS’)  AND TARGET_CONCEPT_CLASS_ID NOT IN ('HCPCS Modifier','CPT4 Modifier',’CPT4 Hierarchy’,’ICD10PCS Hierarchy’)` | - |
| TYPE_CONCEPT_ID | - | Refer to "Condition Type Concept ID Lookup" and "Procedure Type Concept ID Lookup" on the "STEM Lookup Files" page. | - |
| START_DATE | - | **[CONDITION]**<BR/> If a date is not defined, use VISIT_START_DATE.  For each diagnosis code, always assign its associated VISIT_START_DATE as CONDITION_START_DATE, and use VISIT_PROVID and VISIT_PROVSTD to extract its ASSOCIATED_PROVIDER_ID from PROVIDER table. <BR/><BR/> **[OBSERVATION]**<BR/> If a date is not defined, use VISIT_END_DATE of the associated visit. <BR/><BR/> **[PROCEDURE]** <ul><li>For procedure (PPROC, PROC1-PROC15) Assign position =1 for PPROC and 2 for PROC1, etc., set VISIT_END_DATE as PROCEDURE_DATE, VISIT_PROVID and VISIT_PROVSTD as PPROV and PROVCAT. Assign Priority =2.</li> <li>For any procedure coming from a DX field in TEMP_FACILITY_HEADER (DX1-DX9) assign position=8 for DX1, 9 for DX2, etc. set VISIT_END_DATE as PROCEDURE_DATE, VISIT_PROVID and VISIT_PROVSTD as PPROV and PROVCAT. Assign priority = 6.</li><li> If a date is not defined, use VISIT_END_DATE of the associated visit.</li>  | - |
| START_DATETIME | - | START_DATE + midnight  | - |
| END_DATE | - | NULL | - |
| END_DATETIME | - | NULL | - |
| VERBATIM_END_DATE | - | NULL | - |
| DAYS_SUPPLY | - | NULL | - |
| DOSE_UNIT_SOURCE_VALUE | - | NULL | - |
| LOT_NUMBER | - | NULL | - |
| MODIFIER_CONCEPT_ID | - | 0 | - |
| MODIFIER_SOURCE_VALUE | - | NULL | - |
| OPERATOR_CONCEPT_ID | - | 0 | - |
| QUANTITY | - | NULL | - |
| RANGE_HIGH | - | NULL | - |
| RANGE_LOW | - | NULL | - |
| REFILLS | - | NULL | - |
| ROUTE_CONCEPT_ID | - | 0 | - |
| ROUTE_SOURCE_VALUE | - | NULL | - |
| SIG | - | NULL | "Sig" is short for the Latin, signetur, or "let it be labeled." |
| STOP_REASON | - | NULL | - |
| UNIQUE_DEVICE_ID | - | NULL | - |
| UNIT_CONCEPT_ID | - | 0 | - |
| UNIT_SOURCE_VALUE | - | NULL | - |
| VALUE_AS_CONCEPT_ID | - | 0 | - |
| VALUE_AS_NUMBER | - | NULL | - |
| VALUE_AS_STRING | - | NULL | - |
| VALUE_SOURCE_VALUE | - | NULL | - |
| ANATOMIC_SITE_CONCEPT_ID | - | 0 | - |
| DISEASE_STATUS_CONCEPT_ID | - | 0 | - |
| SPECIMEN_SOURCE_ID | - | NULL | - |
| ANATOMIC_SITE_SOURCE_VALUE | - | NULL | - |
| DISEASE_STATUS_SOURCE_VALUE | - | NULL | - |
| CONDITION_STATUS_CONCEPT_ID | - | 0 | - |
| CONDITION_STATUS_SOURCE_VALUE | - | NULL | - |
| EVENT_ID | - | NULL | - |
| EVENT_FIELD_CONCEPT_ID | - | 0 | - |
| VALUE_AS_DATETIME | - | NULL | - |
| QUALIFIER_CONCEPT_ID | - | 0 | - |
| QUALIFIER_SOURCE_VALUE | - | NULL | - |