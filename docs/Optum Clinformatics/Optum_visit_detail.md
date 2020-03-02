---
layout: default
title: Visit_Detail
nav_order: 7
parent: Optum Clinformatics
description: "Visit_Occurrence mapping from Optum_Clinformatics claims tables"

---
# CDM Table: VISIT_DETAIL

This table will be populated from three source tables, **MEDICAL_CLAIMS**, **RX_CLAIMS**, **INPATIENT_CONFINEMENT** tables. 

## **Record level referential integrity with source**
Record level referential integrity is important for drug utilization and health economics analysis. Records from the source will be preserved to the best of our ability in the CDM. The records in the **MEDICAL_CLAIMS** tables is allowed to be duplicated (because there maybe multiple charges on a single claim line or there mabye multiple standard costs listed). 

While creating records in the **VISIT_DETAIL** table the duplicate claim lines will **not** be consolidated. Any duplicate procedures or diagnoses resulting from the duplicated claim lines will not affect analysis. See the **PROCEDURE_OCCURRENCE** table for how to use procedure units. The charges and costs will be preserved in the **COST** table, creating a 1:many relationship between the **COST** table and the **VISIT_DETAIL** table. See [logic](#VISIT_DETAIL-Logic) below for details.

The **VISIT_DETAIL** table will have 1:1 record level referential integrity to **MEDICAL_CLAIMS**, **INPATIENT_CONFINEMENT** and **RX_CLAIMS** - except as noted below. 

## **Special notes**
- **VISIT_DETAIL**.VISIT_OCCURRENCE_ID, a system generated primary key of the **VISIT_DETAIL** will be the fk to many OMOP tables including domain-tables (**CONDITION_OCCURRENCE**, **PROCEDURE_OCCURRENCE**, **OBSERVATION**, **MEASUREMENT**, **DRUG_EXPOSURE**, etc.) and to **COST** table **COST**.COST_EVENT_ID).
- **VISIT_OCCURRENCE** will be generated from **VISIT_DETAIL** table through an 'era' logic where inpatient records will be grouped together into continous non-overlapping periods, and all visit_detail records (inpatient, outpatient, other) that are in that temporal non overlapping continous period will be considered one visit_occurrence_id record. For records outside this non-overlapping inpatient period, we will take all outpatient records and identify unique person-date combinations. For each unique person-date combination a visit_occurrence_id will be assigned and all visit_detail_id records temporally assocciated with that person-date combination will be assigned that visit_occurrence_id. (See documentation for **VISIT_OCCURRENCE**.visit_occurrence_id)
- Linkages across source tables should use the combination of PATID and PAT_PLANID.

## **Mapping from RX_CLAIMS**
- In the **RX_CLAIMS** table some values in DAYS_SUP are invalid. Any value < 0 or > 365 should be updated using this logic:
```
    CASE
    WHEN DAYS_SUPPLY < 0 THEN 0
    WHEN DAYS_SUPPLY > 365 THEN 365
    WHEN DAYS_SUPPLY IS NULL THEN 0
    ELSE DAYS_SUPPLY
    END
```
- After updating DAYS_SUP using the script above, to assign VISIT_DETAIL_END_DATE use the logic **RX_CLAIMS** FILL_DT+DAYS_SUP-1. If DAYS_SUP is 0 or empty then do **RX_CLAIMS** FILL_DT.

## **VISIT_DETAIL Logic**
1. Remove persons not in person table
2. Create a primary key to identify each record in the **MEDICAL_CLAIMS**, **INPATIENT_CONFINEMENT** and **RX_CLAIMS** tables. This primary key will become the **VISIT_DETAIL_ID**. Retain this information as a lookup table for later linkage of diagnoses and procedures. This system generated key may also be used to lookup records in source table i.e. maintain a lookup table that is able to link visit_detail_id to the records of **MEDICAL_CLAIMS**, **INPATIENT_CONFINEMENT** and **RX_CLAIMS** tables (record level referential integerity).


## **PROVIDER_ID Assignment Logic**
- For records from **MEDICAL_CLAIMS** and **INPATIENT_CONFINEMENT**:
    - Each record in **MEDICAL_CLAIMS** and **INPATIENT_CONFINEMENT** has a provider value in the PROV field. Use this value to link to **PROVIDER_BRIDGE** to find the PROV_UNIQUE id. 
    - Use the PROV_UNIQUE value to find PROVIDER_ID by linking PROV_UNIQUE to **PROVIDER**.PROVIDER_SOURCE_VALUE. If PROV_UNIQUE does not have an associated PROVIDER_ID then set PROVIDER_ID to 0
- For records from **RX_CLAIMS**:
    - Records in **RX_CLAIMS** have provider values in the fields PRESCRIBING_PROV, NPI, and DEA. 
    - Start with PRESCRIBING_PROV. If that is blank or *NULL* take the NPI and if that is blank or *NULL* take the DEA
    - Using the **PROVIDER_BRIDGE** table find PROV_UNIQUE by matching the PRESCRIBING_PROV value to the PROV field, NPI to NPI or DEA to DEA. 
    - Use the PROV_UNIQUE value to find PROVIDER_ID by linking PROV_UNIQUE to **PROVIDER**.PROVIDER_SOURCE_VALUE. If PROV_UNIQUE does not have an associated PROVIDER_ID then set PROVIDER_ID to 0

## **CARE_SITE_ID Assignment Logic**
-   For records from **MEDICAL_CLAIMS**:
    - Each record in **MEDICAL_CLAIMS**  has a value in the field BILL_PROV. Use this value to link to **PROVIDER_BRIDGE** on BILL_PROV = PROV to find the PROV_UNIQUE id.
    - Use the PROV_UNIQUE value to find CARE_SITE_ID by linking PROV_UNIQUE to **CARE_SITE**.CARE_SITE_SOURCE_VALUE. If PROV_UNIQUE does not have an associated CARE_SITE_ID then set CARE_SITE_ID to 0
- For records from **RX_CLAIMS**: 
    - Each record in **RX_CLAIMS** has a value in the field Pharm. 
    - Link to CARE_SITE by linking Pharm to **CARE_SITE**.CARE_SITE_SOURCE_VALUE. If pharm does not have an associated CARE_SITE_ID then set PROVIDER_ID to 0

**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
VISIT_DETAIL_ID| |System generated.|Has to have 1:1 record level referential integrity to source tables **MEDICAL_CLAIMS**, **RX_CLAIMS** and **INPATIENT_CONFINEMENT**. A lookup table is maintained.
PERSON_ID|**MEDICAL_CLAIMS** PATID <br> **RX_CLAIMS** PATID <br> **INPATIENT_CONFINEMENT** PATID|||
VISIT_DETAIL_CONCEPT_ID|**MEDICAL_CLAIMS** Pos <br><br> **RX_CLAIMS** MAIL_IND,Spclt_Ind <br><br> **INPATIENT_CONFINEMENT** Pos|**MEDICAL_CLAIMS** Pos and **INPATIENT_CONFINEMENT** Pos use SOURCE_TO_STANDARD query with the filters: <br> `Where source_vocabulary_id = 'CMS Place of Service' and invalid_reason is NULL and standard_concept = 'S'` <br><br> **RX_CLAIMS** MAIL_IND = 'Y' then concept_id = 38004345 (Mail order pharmacy). <br>else, if Spclt_Ind = 'Y' then 38004348 (Specialty Pharmacy), <br>else concept_id = '581458' (Pharmacy visit) | If pos in **MEDICAL_CLAIMS** is blank, *NULL* or does not have a mapping then set to 9202. <br><br>If pos in **INPATIENT_CONFINEMENT** is blank, *NULL* or does not have a mapping then set to 9201.
VISIT_DETAIL_START_DATE|**MEDICAL_CLAIMS** FST_DT<br><br>**RX_CLAIMS** FILL_DT<br><br>**INPATIENT_CONFINEMENT** Admit_Date| |
VISIT_DETAIL_START_DATETIME|**MEDICAL_CLAIMS** FST_DT<br><br>**RX_CLAIMS** FILL_DT<br><br>**INPATIENT_CONFINEMENT** Admit_Date||Set time to 00:00:00 UTC TZ
VISIT_DETAIL_END_DATE|**MEDICAL_CLAIMS** LST_DT<br><br>**RX_CLAIMS** FILL_DT+DAYS_SUP-1.<br> If DAYS_SUP is 0 or empty then do **RX_CLAIMS** FILL_DT<br><br>**INPATIENT_CONFINEMENT** Disch_Date| [See mapping from RX_CLAIMS](#Mapping-from-RX_CLAIMS)|
VISIT_DETAIL_END_DATETIME|**MEDICAL_CLAIMS** LST_DT<br><br>**RX_CLAIMS** FILL_DT+DAYS_SUP<br>If DAYS_SUP is 0 or empty then do **RX_CLAIMS** FILL_DT+1<br><br>**INPATIENT_CONFINEMENT** Disch_Date||Set time to 00:00:00 UTC TZ
VISIT_DETAIL_TYPE_CONCEPT_ID|If derived from **RX_CLAIMS** use concept 32022 ('Visit derived from encounter on pharmacy claim')<br><br>If derived from **MEDICAL_CLAIMS** then use the fields PAID_STATUS and PROVCAT with the given lookup tables. <br><br>If derived from **INPATIENT_CONFINEMENT** use concept 32023  |For **MEDICAL_CLAIMS**: Using the given **LOOKUP TABLES** PROVCAT has a column called 'CATGY_ROL_UP_4_DESC'. Use this value along with the PAID_STATUS to assign a CONCEPT_ID  | [See Mapping Medical_Claim to concepts for VISIT_TYPE_CONCEPT_ID](#Mapping-Medical_Claim-to-concepts-for-VISIT_TYPE_CONCEPT_ID)
PROVIDER_ID|**MEDICAL_CLAIMS** PROV -> **PROVIDER_BRIDGE** PROV_UNIQUE<br><br>**INPATIENT_CONFINEMENT** PROV -> **PROVIDER_BRIDGE** PROV_UNIQUE<br><br>**RX_CLAIMS** Prescriber_Prov/ NPI/ DEA -> **Provider_Bridge** PROV_UNIQUE||[See Provider Assignment Logic](#PROVIDER_ID-Assignment-Logic)
CARE_SITE_ID|**MEDICAL_CLAIMS** BILL_PROV<br><br>**INPATIENT_CONFINEMENT** leave blank<br><br>**RX_CLAIMS** Pharm. Use corresponding CARE_SITE_ID for field Pharm| |[See Care Site Assignment Logic](#CARE_SITE_ID-Assignment-Logic)
VISIT_DETAIL_SOURCE_VALUE|**MEDICAL_CLAIMS** clmid+'-'+clmseq<br><br>**INPATIENT_CONFINEMENT** conf_id <br><br>**RX_CLAIMS** clmid |
VISIT_DETAIL_SOURCE_CONCEPT_ID|0||
ADMITTED_FROM_SOURCE_VALUE||  |
ADMITTED_FROM_CONCEPT_ID|0||
DISCHARGE_TO_SOURCE_VALUE|**MEDICAL_CLAIMS** DSTATUS| |This is 'UB04 Patient Discharge Status' codes
DISCHARGE_TO_CONCEPT_ID|||
PRECEDING_VISIT_DETAIL_ID|**VISIT_DETAIL**VISIT_DETAIL_ID|**MEDICAL_CLAIMS** Clmid, Clmseq<br><br>If record from **INPATIENT_CONFINEMENT**, **RX_CLAIMS** then leave blank.|This is self-referencing key used to represent sequence of care (in this case claim.) The sequence is determined by a grouped sort order, as follows. Grouping is by combination PatId, Pat_Planid, Clmid, Clmseq, sorting by PAID_STATUS (D/N/P) to get sequential events within the group. The preceding Visit_detail_id of current visit_detail_id sorted in this sequence is used to populate PRECEDING_VISIT_DETAIL_ID.
VISIT_DETAIL_PARENT_ID|**INPATIENT_CONFINEMENT**Conf_id, **MEDICAL_CLAIMS** Conf_id|If the VISIT_DETAIL row record was sourced from **INPATIENT_CONFINEMENT** then VISIT_DETAIL_PARENT_ID = VISIT_DETAIL_ID. <br><br>If the VISIT_DETAIL row record was sourced from **MEDICAL_CLAIMS** then VISIT_DETAIL_PARENT_ID = VISIT_DETAIL_ID of the row record in **VISIT_DETAIL** where **INPATIENT_CONFINEMENT** conf_id = **MEDICAL_CLAIMS** conf_id.<br><br>If record from sourced from **RX_CLAIMS** then leave blank. | This is a self referencing row record in VISIT_DETAIL used to point to the parent visit_detail record of current visit_detail record. It is useful to identify the relationship between individual medical claims related to an inpatient confinement record.
VISIT_OCCURRENCE_ID|**VISIT_OCCURRENCE** VISIT_OCCURRENCE_ID | **VISIT_OCCURRENCE** is constructed/derived from **VISIT_DETAIL**. |**VISIT_OCCURRENCE** VISIT_OCCURRENCE_ID is a FK for **VISIT_DETAIL** and can be used to identify **VISIT_DETAIL** records constructing one **VISIT_OCCURRENCE** record.





----------------------------------------------------------------------
<br>
<br>
<br>
----------------------------------------------------------------------
### **Mapping of source field values to OMOP Vocabualary concept id**
----------------------------------------------------------------------


#### **Mapping Medical_Claim to concepts for VISIT_TYPE_CONCEPT_ID**

Each record in the **MEDICAL_CLAIMS** table has a value in the fields PROVCAT and PAID_STATUS. Lookup PROVCAT in the provided lookup table to find the CATGY_ROL_UP_4_DESC. Use the table below to assign VISIT_TYPE_CONCEPT_ID based on the combination of PROVCAT.CATGY_ROL_UP_4_DESC and PAID_STATUS

PROVCAT.CATGY_ROL_UP_4_DESC|PAID_STATUS|PAID_STATUS Description|OMOP Concept_Id|Concept Name
:-----:|:-----:|:-----:|:-----:|:-----:
FACILITY|D|Denied|32026|Visit derived from encounter on medical facility claim denied
FACILITY|N|INVALID_POSSIBLE INPUT ERROR|32023|Visit derived from encounter on medical facility claim
FACILITY|P|Paid|32025|Visit derived from encounter on medical facility claim paid
FACILITY|empty|UNKNOWN|32023|Visit derived from encounter on medical facility claim
MISCELLANEOUS|D|Denied|32021|Visit derived from encounter on medical claim
MISCELLANEOUS|N|INVALID_POSSIBLE INPUT ERROR|32021|Visit derived from encounter on medical claim
MISCELLANEOUS|P|Paid|32021|Visit derived from encounter on medical claim
MISCELLANEOUS|empty|UNKNOWN|32021|Visit derived from encounter on medical claim
PROFESSIONAL|D|Denied|32029|	Visit derived from encounter on medical professional claim denied
PROFESSIONAL|N|INVALID_POSSIBLE INPUT ERROR|32024|	Visit derived from encounter on medical professional claim
PROFESSIONAL|P|Paid|32028|Visit derived from encounter on medical professional claim paid
PROFESSIONAL|empty|UNKNOWN|32024|	Visit derived from encounter on medical professional claim
UNKNOWN|D|Denied|32021|Visit derived from encounter on medical claim
UNKNOWN|N|INVALID_POSSIBLE INPUT ERROR|32021|Visit derived from encounter on medical claim
UNKNOWN|P|Paid|32021|Visit derived from encounter on medical claim
UNKNOWN|empty|UNKNOWN|32021|Visit derived from encounter on medical claim
<br>
<br>
<br>
<br>

### **FOR LATER USE AND NOT INCORPORATED IN THIS ETL DESIGN**
---
#### **Mapping ADMIT_TYPE & ADMIT_CHAN to admission_source_concept_id**

ADMIT_TYPE|DESCRIPTION|ADMIT_CHAN|ADMIT_CHAN DESCRIPTION|Interpretation
:-----:|:-----:|:-----:|:-----:|:-----:|:-----:
1|EMERGENCY|6|TRANSFER FROM A ANOTHER HEALTH CARE FACILITY|Transfer from another health care facility
1|EMERGENCY|1|PHYSICIAN REFERRAL|Referred by a doctors office
1|EMERGENCY|2|CLINIC REFERRAL|Referred by a doctors office
1|EMERGENCY|3|HMO REFERRAL|Referred by a doctors office
1|EMERGENCY|4|TRANSFER FROM A HOSPITAL|Transfer from another hospital
1|EMERGENCY|5|TRANSFER FROM A SKILLED NURSING FACILITY|Transfer from skilled nursing facility
1|EMERGENCY|7|EMERGENCY ROOM|Transfer from emergency room
1|EMERGENCY|A|TRANSFER FROM A  RURAL PRIMARY CARE HOSPITAL|Transfer from another hospital
2|URGENT|6|TRANSFER FROM A ANOTHER HEALTH CARE FACILITY|Transfer from another health care facility
2|URGENT|1|PHYSICIAN REFERRAL|Referred by a doctors office
2|URGENT|2|CLINIC REFERRAL|Referred by a doctors office
2|URGENT|3|HMO REFERRAL|Referred by a doctors office
2|URGENT|4|TRANSFER FROM A HOSPITAL|Transfer from another hospital
2|URGENT|5|TRANSFER FROM A SKILLED NURSING FACILITY|Transfer from skilled nursing facility
2|URGENT|7|EMERGENCY ROOM|Transfer from emergency room
2|URGENT|A|TRANSFER FROM A  RURAL PRIMARY CARE HOSPITAL|Transfer from another hospital
3|ELECTIVE|6|TRANSFER FROM A ANOTHER HEALTH CARE FACILITY|Transfer from another health care facility
3|ELECTIVE|1|PHYSICIAN REFERRAL|Referred by a doctors office
3|ELECTIVE|2|CLINIC REFERRAL|Referred by a doctors office
3|ELECTIVE|3|HMO REFERRAL|Referred by a doctors office
3|ELECTIVE|4|TRANSFER FROM A HOSPITAL|Transfer from another hospital
3|ELECTIVE|5|TRANSFER FROM A SKILLED NURSING FACILITY|Transfer from skilled nursing facility
3|ELECTIVE|7|EMERGENCY ROOM|Transfer from emergency room
3|ELECTIVE|A|TRANSFER FROM A  RURAL PRIMARY CARE HOSPITAL|Transfer from another hospital
4|NEWBORN|1|PHYSICIAN REFERRAL|Baby was born in hospital and had a normal delivery
4|NEWBORN|2|CLINIC REFERRAL|Baby was born in hospital and was premature
4|NEWBORN|3|HMO REFERRAL|Baby was born in hospital and was sick
4|NEWBORN|4|TRANSFER FROM A HOSPITAL|Baby was born in outside hospital and was transferred
4|NEWBORN||ANY|Baby was born in hospital
4|NEWBORN|A|TRANSFER FROM A  RURAL PRIMARY CARE HOSPITAL|Baby was born in outside hospital and was transferred
5|TRAUMA CENTER  |6|TRANSFER FROM A ANOTHER HEALTH CARE FACILITY|Transfer from another health care facility
5|TRAUMA CENTER  |1|PHYSICIAN REFERRAL|Referred by a doctors office
5|TRAUMA CENTER  |2|CLINIC REFERRAL|Referred by a doctors office
5|TRAUMA CENTER  |3|HMO REFERRAL|Referred by a doctors office
5|TRAUMA CENTER  |4|TRANSFER FROM A HOSPITAL|Transfer from another hospital
5|TRAUMA CENTER  |5|TRANSFER FROM A SKILLED NURSING FACILITY|Transfer from skilled nursing facility
5|TRAUMA CENTER  |7|EMERGENCY ROOM|Transfer from emergency room
5|TRAUMA CENTER  |A|TRANSFER FROM A  RURAL PRIMARY CARE HOSPITAL|Transfer from another hospital

---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*