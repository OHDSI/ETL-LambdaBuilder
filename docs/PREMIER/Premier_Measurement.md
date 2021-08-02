---
title: "Measurement"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 8
layout: default
---

# Table Name: Measurement

The MEASUREMENT table will house records from PATBILL, PATCPT, and PATICD_DIAG that have been mapped to the measurement domain. Additionally, procedures that occur on the same day as billing records for operation time will have operation time calculated and recorded in the measurement table. 

Measurements are recorded in the PATBILL table as standard charges.  Premier captures the day the measurement is made in the SERV_DAY field thus, the MEASUREMENT_DATE is determined from the VISIT_START_DATE from VISIT_OCCURRENCE and PATBILL.SERV_DAY unless the start date is greater than the end of the month, then it’s truncated to the end of month. For measurements recorded in the PATCPT table, the day the measurement was made is unknown so MEASUREMENT_DATE is recorded as VISIT_END_DATE. 

In Premier, many procedures are recorded in the PATICD_PROC table, which includes the day the procedure was performed as PATICD_PROC.PROC_DAY. Certain billing records in PATBILL include information on surgical operation time. The sample code below the field mapping table returns surgical operation time values in minutes for procedures where operation time billing record(s) happen on the same day. It is assumed that if a procedure and an operating time bill happen on the same day, then the operating time is associated with the procedure. These operation time values move to the MEASUREMENT table and the MEASUREMENT_DATE equals the corresponding PROCEDURE_DATE (which is VISIT_OCCURRENCE + PROC_DAY). To associate a surgical operation time with a procedure: MEASUREMENT.VISIT_OCCURRENCE_ID=PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID AND MEASUREMENT.MEASUREMENT_DATE=PROCEDURE_OCCURRENCE.PROCEDURE_DATE.
There are three providers that exist in Premier, the admitting, attending, and procedure. This ETL makes the decision to use admitting physician for all measurements except operation time because it is unknown whether the admitting provider, attending provider or another person obtained the measurement. 

##TODO: 
- For operation time measurements, the provider is set as the procedure physician.
Only records that fall within an OBSERVATION_PERIOD are available for each person. The VISIT_OCCURRENCE table must be created before the MEASUREMENT table is created.
- Integrate documentation for GEN_LAB and LAB_RESULT sections into the MEASUREMENT section.

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| MEASUREMENT_ID | - | System generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| MEASUREMENT_CONCEPT_ID | PATCPT.CPT_CODE<br>PATBILL.STD_CHG_CODE<br>PATICD_DIAG.ICD_CODE<br>PATBILL.STD_CHG_DESC | QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'ICD10CM', 'ICD9CM', 'JNJ_PMR_PROC_CHRG_CD')AND TARGET_DOMAIN_ID = 'Measurement'When operation time measurement values then 3016562  | Only capture those records that have a domain map to Measurement. |
| MEASUREMENT_DATE | VISIT_OCCURRENCE.VISIT_START_DATEPATBILL.SERV_DAY <br>Or<br>VISIT_OCCURRENCE.VISIT_END_DATE <br>Or<br> VISIT_OCCURRENCE.VISIT_START_DATEPATICD_PROC.PROC_DAY |  | If measurement is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf measurement comes from PATCPT then use visit end dateFor operation time measurement, a combination of procedure day and visit start date unless the procedure day is greater than the end of the month |
| MEASUREMENT_DATETIME | - | NULL |  |
| MEASUREMENT_TYPE_CONCEPT_ID | - | For operation time records 45754907-Derived valueelse44818701-From physical examination |  |
| OPERATOR_CONCEPT_ID | - | NULL |  |
| VALUE_AS_NUMBER | - | See query below |  |
| VALUE_AS_CONCEPT_ID | - | NULL |  |
| UNIT_CONCEPT_ID | - | For operation time records 8550Else NULL |  |
| RANGE_LOW | - | NULL |  |
| RANGE_HIGH | - | NULL |  |
| PROVIDER_ID | PATICD_PROC.PROC_PHYPAT.ADMPHY | When operation time PATICD_PROC.PROC_PHYElsePAT.ADMPHY |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| MEASUREMENT_SOURCE_VALUE |  | SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) AUNION(SELECT CPT_CODE AS SOURCE_VALUE FROM PATCPT)For operation time records, NULL for now |  |
| MEASUREMENT_SOURCE_CONCEPT_ID | - | QUERY: SOURCE TO SOURCESELECT SOURCE_CONCEPT_IDFROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS')AND TARGET_VOCABULARY_ID IN ('CPT4', 'HCPCS') AND DOMAIN_ID='Measurement' | Only populated for standard coding CPT4, and HCPCS codes |
| UNIT_SOURCE_VALUE | - | NULL |  |
| VALUE_SOURCE_VALUE | - | NULL |  |
