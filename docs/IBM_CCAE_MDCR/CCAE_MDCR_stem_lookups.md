---
layout: default
title: STEM Lookup Files
nav_order: 9
grand_parent: IBM CCAE & MDCR
parent: IBM CCAE & MDCR to STEM
description: "Lookup Files for tables staged into STEM"
---

## STEM Key Conventions and Lookup Files

This page is dedicated to information that leveraged across multiple tables moving to the STEM table.

## Key Conventions
* IBM removes decimal points from ICD diagnosis.  When mapping to the OMOP Vocabulary the decimal points need to also be removed from the Vocabulary concept code in order to map between the source and the vocabulary.  
* Only keep records with valid ICD9 or ICD10 diagnoses, the DXVER variable in all tables indicates the ICD version to map to. If DXVER=9 then use ICD9CM; if DXVER=0 then use ICD10CM otherwise if DXVER is null then use a date filter:
  + If before October 1, 2015 use ICD9CM
  + If after October 1, 2015 use ICD10 (**OUTPATIENT_SERVICES** use SVCDATE, **INPATIENT_SERVICES** use ADMDATE, **FACILITY_HEADER** use SVCDATE, and **INPATIENT_ADMISSIONS** use ADMDATE).
* Valid Codes
  1)	ICD9 must start with 0-9, V or E, and non-numeric character is not allowed in other positions.
  2)	If ICD9 starts with 0-9 or V, length should be between 3 and 5; if starts with E, length should be between 4 and 5. 
  3)	ICD10 must be between 3 and 7 digits

## Condition Type Concept ID Lookup

|**Claim Type**|**Source**|**Position**|**CONDITION\_TYPE\_CONCEPT\_ID**|**CONDITION\_NAME**|
:-----:|:-----:|:-----:|:-----:|:-----:
|IP|**INPATIENT_SERVICES** and **OUTPATIENT_SERVICES** Tables | 1 (PDX)|38000183|Inpatient detail – primary
|&#8595;|&#8595;|2 (DX1)|38000184|Inpatient detail – 1st position
|&#8595;|&#8595;|3 (DX2)|38000185|Inpatient detail - 2rd position
|&#8595;|&#8595;|4 (DX3)|38000186|Inpatient detail - 3th position
|&#8595;|&#8595;|5 (DX4)|38000187|Inpatient detail - 4th position
|&#8595;|&#8595;|6 (DX5)|38000188|Inpatient detail - 5th position
|&#8595;|**INPATIENT_ADMISSIONS** and **FACILITY_HEADER** Tables|1 (PDX)|38000199|Inpatient header - primary
|&#8595;|&#8595;|2 (DX1)|38000200|Inpatient header - 1st position
|&#8595;|&#8595;|3 (DX2)|38000201|Inpatient header - 2nd position
|&#8595;|&#8595;|4 (DX3)|38000202|Inpatient header - 3rd position
|&#8595;|&#8595;|5 (DX4)|38000203|Inpatient header - 4th position
|&#8595;|&#8595;|6 (DX5)|38000204|Inpatient header - 5th position
|&#8595;|&#8595;|7 (DX6)|38000205|Inpatient header - 6th position
|&#8595;|&#8595;|8 (DX7)|38000206|Inpatient header - 7th position
|&#8595;|&#8595;|9 (DX8)|38000207|Inpatient header - 8th position
|&#8595;|&#8595;|10 (DX9)|38000208|Inpatient header - 9th position
|&#8595;|&#8595;|11 (DX10)|38000209|Inpatient header - 10th position
|&#8595;|&#8595;|12 (DX11)|38000210|Inpatient header - 11th position
|&#8595;|&#8595;|13 (DX12)|38000211|Inpatient header - 12th position
|&#8595;|&#8595;|14 (DX13)|38000212|Inpatient header - 13th position
|&#8595;|&#8595;|15 (DX14)|38000213|Inpatient header - 14th position
|ER or OP|**INPATIENT_SERVICES** and **OUTPATIENT_SERVICES** Tables|1 (PDX)|38000215|Outpatient detail - 1st position
|&#8595;|&#8595;|2 (DX1)|38000215|Outpatient detail - 1st position
|&#8595;|&#8595;|3 (DX2)|38000216|Outpatient detail - 2nd position
|&#8595;|&#8595;|4 (DX3)|38000217|Outpatient detail - 3rd position
|&#8595;|&#8595;|5 (DX4)|38000218|Outpatient detail - 4th position
|&#8595;|&#8595;|6 (DX5)|38000219|Outpatient detail - 5th position
|&#8595;|**FACILITY_HEADER** Table|2 (DX1)|38000230|Outpatient header - 1st position
|&#8595;|&#8595;|3 (DX2)|38000231|Outpatient header - 2nd position
|&#8595;|&#8595;|4 (DX3)|38000232|Outpatient header - 3rd position
|&#8595;|&#8595;|5 (DX4)|38000233|Outpatient header - 4th position
|&#8595;|&#8595;|6 (DX5)|38000234|Outpatient header - 5th position
|&#8595;|&#8595;|7 (DX6)|38000235|Outpatient header - 6th position
|&#8595;|&#8595;|8 (DX7)|38000236|Outpatient header - 7th position
|&#8595;|&#8595;|9 (DX8)|38000237|Outpatient header - 8th position
|&#8595;|&#8595;|10 (DX9)|38000238|Outpatient header - 9th position


## Procedure Type Concept ID Lookup

|**Type of Associated Visit**|**Source**|**Position**|**PROCEDURE_TYPE_CONCEPT_ID**|**CONCEPT_NAME**|
:-----:|:-----:|:-----:|:-----:|:-----:
|IP|**INPATIENT_SERVICES** and **OUTPATIENT_SERVICES** TABLES|1 (PROC1)|38000249|Inpatient detail – 1st position|
|&#8595;|**INPATIENT_ADMISSIONS** and **FACILITY_HEADER** TABLES|1 (PPROC)|38000250|Inpatient header – primary position|
|&#8595;|&#8595;|2 (PROC1)|38000251|Inpatient header – 1st position|
|&#8595;|&#8595;|3 (PROC2) |38000252|Inpatient header – 2nd position|
|&#8595;|&#8595;|4 (PROC3)|38000253|Inpatient header – 3rd position|
|&#8595;|&#8595;|5 (PROC4) |38000254|Inpatient header – 4th position|
|&#8595;|&#8595;|6 (PROC5)|38000255|Inpatient header – 5th position|
|&#8595;|&#8595;|7 (PROC6)|38000256|Inpatient header – 6th position|
|&#8595;|&#8595;|8 (PROC7)|38000257|Inpatient header – 7th position|
|&#8595;|&#8595;|9 (PROC8)|38000258|Inpatient header – 8th position|
|&#8595;|&#8595;|10 (PROC9)|38000259|Inpatient header – 9th position|
|&#8595;|&#8595;|11 (PROC10)|38000260|Inpatient header – 10th position|
|&#8595;|&#8595;|12 (PROC11)|38000261|Inpatient header – 11th position|
|&#8595;|&#8595;|13(PROC12)|38000262|Inpatient header – 12th position|
|&#8595;|&#8595;|14 (PROC13)|38000263|Inpatient header – 13th position|
|&#8595;|&#8595;|15 (PROC14)|38000264|Inpatient header – 14th position|
|&#8595;|&#8595;|16 (PROC15)|38000265|Inpatient header – 15th position|
|ER or OP|INPATIENT_SERVICES and OUTPATIENT_SERVICES TABLES|1 (PROC1)|38000267|Outpatient detail – 1st position|
|&#8595;|FACILITY_HEADER TABLES|2 (PROC1)|38000269|Outpatient header – 1st position|
|&#8595;|&#8595;|3 (PROC2) |38000270|Outpatient header – 2nd position|
|&#8595;|&#8595;|4 (PROC3)|38000271|Outpatient header – 3rd position|
|&#8595;|&#8595;|5 (PROC4)|38000272|Outpatient header – 4th position|
|&#8595;|&#8595;|6 (PROC5)|38000273|Outpatient header – 5th position|
|&#8595;|&#8595;|7 (PROC6)|38000274|Outpatient header – 6th position  |

## DSTATUS Lookup

We will use the field DSTATUS in **INPATIENT_ADMISSIONS** and **FACILITY_HEADER** tables that are created during the building of the **VISIT_OCCURRENCE** table to map discharge status.

* For all records the CONCEPT_ID = `4202605`(Discharge Status)
* Use the below table to map VALUE_AS_STRING

| DSTATUS | VALUE_AS_STRING                                     |
|---------|-----------------------------------------------------|
| 01      | Discharged to home self care                        |
| 02      | Transfer to short term hospital                     |
| 03      | Transfer to SNF                                     |
| 04      | Transfer to ICF                                     |
| 05      | Transfer to other facility                          |
| 06      | Discharged home under care                          |
| 07      | Left against medical advice                         |
| 08-19   | Other alive status                                  |
| 20      | Died                                                |
| 21      | Discharged/transferred to court/law enforcement     |
| 30-39   | Still patient                                       |
| 40-42   | Other died status                                   |
| 43      | Discharged/transferred to federal hospital          |
| 50      | Discharged to home (from Hospice)                   |
| 51      | Transfer to med fac (from Hospice)                  |
| 61      | Transfer to Medicare approved swing bed             |
| 62      | Transferred to inpatient rehab facility (IRF)       |
| 63      | Transferred to long term care hospital (LTCH)       |
| 64      | Transferred to nursing facility Medicaid certified  |
| 65      | Transferred to psychiatric hospital or unit         |
| 66      | Transferred to critical access hospital (CAH)       |
| 70      | Transfer to another facility NEC                    |
| 71      | Transfer/referred to other facility for outpt svcs  |
| 72      | Transfer/referred to this facility for outpt svcs   |
| 99      | Transfer (Hospital ID MDST change)                  |
