---
layout: default
title: Payer Plan Period
nav_order: 3
parent: IBM CCAE & MDCR
description: "**PAYER_PLAN_PERIOD** mapping from IBM MarketScan® Commercial Database (CCAE) & IBM MarketScan® Medicare Supplemental Database (MDCR) **ENROLLMENT_DETAIL**."
---

## Table name: **PAYER_PLAN_PERIOD**

### Key conventions

* For each person, create a record associating the person to the duration they were on a specific type of benefit plan (defined by DATATYP, and PLANTYP) per the **ENROLLMENT_DETAIL** table. Payer plan entries are consolidated by combining records that indicate continuous enrollment over a period for a specific payer plan.  Consolidation is done through the following steps:
    * Define the PAYER_SOURCE_VALUE (see logic in table below).  
    * Only use records where the person has prescription benefits (RX=1).
    * **ENROLLMENT_DETAIL** records for each person are sorted in ascending order by DTSTART, DTEND.
    * Periods of continuous enrollment are consolidated by combining monthly records as long as the time between the end of one enrollment period and the start of the next is 32 days or less (<=32) and PAYER_SOURCE_VALUE have not changed.
    * The gap between plan periods needs to be 32 days or less (<=32).  
    * Use both DATATYP (i.e. DATATYP=2, 4 for identifying capitated plan) and PLANTYP (e.g. HMO, PPO, etc.) to define PAYER_SOURCE_VALUE. 
    * Switch of type of plan enrolled may cause the overlap of enroll periods on two plans:

<br>

| DATATYP | DTSTART | DTEND | ENROLID | PLANTYP |
| --- | --- | --- | --- | --- |
| 1 | 10/1/2006 | 10/31/2006 | 9687901 | 6 |
| 1 | 10/5/2006 | 10/31/2006 | 9687901 | 5 |

<br>

Sort ENROLLMENT_DETAIL table by ENROLID, DTSTART and DTEND, and if there is some overlap between two coverage periods, always truncate the first one and discard the first record if DTEND < DSTART after truncation. The example above can be truncated as below:



| DATATYP | DTSTART | DTEND | ENROLID | PLANTYP |
|---|---|---|---|---|
| 1 | 10/1/2006 | 10/4/2006 |	9687901 | 6 |
| 1 | 10/5/2006 | 10/31/2006 |	9687901 | 5 |



* Payer plans may break out differently than observation periods, the amount of observation time and payer plan period time may not match for each person.
* Remove duplicate records before assigning PAYER_PLAN_PERIOD_ID.

<br><br>

### Reading from **ENROLLMENT_DETAIL**

![](images/image12.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PAYER_PLAN_PERIOD_ID | - | System generated. | - |
| PERSON_ID | ENROLID | - | - |
| CONTRACT_PERSON_ID | - | NULL | - |
| PAYER_PLAN_PERIOD_START_DATE | DTSTART | Minimum start date of a contiguous enrollment in a plan. | - |
| PAYER_PLAN_PERIOD_END_DATE | DTEND | Maximum end date of a contiguous enrollment in a plan. | - |
| PAYER_CONCEPT_ID | - | 0 | - |
| PAYER_SOURCE_VALUE | PLANTYP<br>DATATYP | Use PLANTYP string:   <br>1 - Basic/major medical  <br>2 - Comprehensive  <br>3 - EPO  <br>4 - HMO  <br>5 - POS  <br>6 - PPO  <br>7 - POS with capitation  <br>8 - CDHP  <br>9 - HDHP     <br><br>If DATATYP in (2,4) then replace <span style="color:blue">[1]</span> with “C”; else replace <span style="color:blue">[1]</span> with “N”; <br><br>If database is CCAE replace <span style="color:blue">[2]</span> replace with “Commercial”.  <br>If database is MDCR replace <span style="color:blue">[2]</span> with “Medicare”. | NULL:  Unknown  <br>1: <span style="color:blue">[1]  [2]</span> Basic/Major Medical  <br>2: <span style="color:blue">[1]  [2]</span> Comprehensive  <br>3: <span style="color:blue">[1]  [2]</span> EPO  <br>4: <span style="color:blue">[1]  [2]</span> HMO  <br>5: <span style="color:blue">[1]  [2]</span> POS  <br>6: <span style="color:blue">[1]  [2]</span> PPO  <br>7: <span style="color:blue">[1]  [2]</span> POS with Capitation  <br>8: <span style="color:blue">[1]  [2]</span> CDHP  <br>9: <span style="color:blue">[1]  [2]</span> HDHP |
| PAYER_SOURCE_CONCEPT_ID | - | 0 | - |
| PLAN_CONCEPT_ID | - | 0 | - |
| PLAN_SOURCE_VALUE | - | NULL | - |
| PLAN_SOURCE_CONCEPT_ID | - | 0 | - |
| CONTRACT_CONCEPT_ID | - | 0 | - |
| CONTRACT_SOURCE_VALUE | - | NULL | - |
| CONTRACT_SOURCE_CONCEPT_ID | - | 0 | - |
| SPONSOR_CONCEPT_ID | - | 0 | - |
| SPONSOR_SOURCE_VALUE | - | NULL | - |
| SPONSOR_SOURCE_CONCEPT_ID | - | 0 | - |
| FAMILY_SOURCE_VALUE | ENROLID | **ENROLLMENT_DETAIL**:   `SUBSTRING(RIGHT('00000000000' + CONVERT(VARCHAR,ENROLID), 11), 1,9)` | Family IDs are the first 9 digits of an ENROLID.  For ENROLIDs, less than 11 digits, left-pad with zeros and only take the first 9 digits.<br> |
| STOP_REASON_CONCEPT_ID | - | 0 | - |
| STOP_REASON_SOURCE_VALUE | - | NULL | - |
| STOP_REASON_SOURCE_CONCEPT_ID | - | 0 | - |