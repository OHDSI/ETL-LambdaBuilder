---
layout: default
title: Observation Period
nav_order: 3
parent: Optum_Clinformatics
description: "Payer_Plan_Period mapping from Optum member_continuous_enrollment table"

---

# CDM Table: PAYER_PLAN_PERIOD

This table will be sourced from the **Member_Enrollment** table except for those persons not in person table. The lineage to source is maintained through Pat_PlanId. Thus, every row record in PAYER_PLAN_PERIOD will have a 1:1 lineage row from the **Member_Enrollment** source table; but not all rows in source table may have a row in PAYER_PLAN_PERIOD. 

Just like in the source **Member_Enrollment** table, a person will have a new row record in PAYER_PLAN_PERIOD every time there is change in any information about the member, such as state or product. If there are overlaps in enrollment periods in source table, those overlaps will also exist in PAYER_PLAN_PERIOD.  

## **PAYER_PLAN_PERIOD Table Logic**

- Delete all records for a person who is not in OMOP *PERSON* table.  
- - If the earliest ELIGEFF occurs prior to 05/01/2000 revise ELIGEFF to match the start date of data `MAX(ELIGEFF, '05-01-2000')`
- If the latest ELIGEND > **Member_Continuous_Enrollment** last date of Extract_Ym, then edit `ELIGEND = MAX(ELIGEND, Extract_Ym)`
- Delete all records in **Member_Enrollment** with `ELIGEND < '05/01/2000'`

### **Mapping of source field values to OMOP Vocabulary concept id**

#### **Mapping BUS**
BUS|DESCRIPTION|OMOP Concept_Id
:-----:|:-----:|:-----:
COM|Commercial|327
MCR|Medicare|281
NONE|No Business Line Code|0
UNK|Unknown|0

#### **Mapping HEALTH_EXCH**
HEALTH_EXCH|DESCRIPTION|OMOP Concept_Id
:-----:|:-----:|:-----:
0|Non Exchange|
1|Group Exchange|275
2|Individual State Exchange|276
3|Individual Federal Exchange|276


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PAYER_PLAN_PERIOD_ID|Autogenerate | | 
PERSON_ID|**Member_Enrollment** PATID| |
CONTRACT_PERSON_ID|NONE|Cannot be generated in Optum DOD/SES|Optum has FAMILY_ID to person's within family. But, it does not indicate which person in the family is the contract holder. 
PAYER_PLAN_PERIOD_START_DATE|**Member_Enrollment** ELIGEFF|Minimum start date of enrollment in a plan.|[See Table Logic](#PAYER_PLAN_PERIOD-Table-Logic)
PAYER_PLAN_PERIOD_END_DATE|**Member_Enrollment** ELIGEND|Maximum end date of a continuous enrollment in a plan.|[See Table Logic](#PAYER_PLAN_PERIOD-Table-Logic)
PAYER_CONCEPT_ID|**Member_Enrollment** BUS_LINE (BUS) & HEALTH_EXCH|[See mapping for BUS](#mapping-bus) [and HEALTH_EXCH](#mapping-HEALTH_EXCH)|Use multi step process to assign concept_id. <br> Check BUS = 'MCR' Yes: assign concept_id. <br> Else, <br> Check if HEALTH_EXCH in (1,2,3) Yes: assign concept_id. <br>Else, <br> Check if BUS = 'COM' Yes: assign concept_id. <br> Else, assign 0 as concept_id. 
PAYER_SOURCE_VALUE|Concatenate **Member_Enrollment** BUS_LINE (BUS) & HEALTH_EXCH||
PAYER_SOURCE_CONCEPT_ID|||
PLAN_CONCEPT_ID|0||
PLAN_SOURCE_VALUE|Concatenate **Member_Enrollment** PRODUCT & CDHP||
PLAN_SOURCE_CONCEPT_ID| | |
CONTRACT_CONCEPT_ID| | |
CONTRACT_SOURCE_VALUE| | |
CONTRACT_SOURCE_CONCEPT_ID| | |
SPONSOR_CONCEPT_ID|0| |
SPONSOR_SOURCE_VALUE|Concatenate **Member_Enrollment** ASO & GROUP_NBR| |
SPONSOR_SOURCE_CONCEPT_ID| | |
FAMILY_SOURCE_VALUE|**Member_Enrollment** FAMILY_ID | |
STOP_REASON_CONCEPT_ID|Populate with concept_id = 352 if PAYER_PLAN_PERIOD_END_DATE = date of death.| |
STOP_REASON_SOURCE_VALUE|| |
STOP_REASON_SOURCE_CONCEPT_ID| | |

---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*