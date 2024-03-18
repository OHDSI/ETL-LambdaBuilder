---
title: "Observation"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 13
layout: default
---

# Table Name: Observation

The observation table houses additional demographic and visit data that is housed in Premier. Certain ICD9, CPT, and standard charge codes map to standardized observation table concept. Marital status, admission information, discharge status, and patient type records are specific to Premier and map to non-standard observation table concepts. 

Additionally, procedures that occur on the same day as billing records for operation time will have operation time calculated and recorded in the observation table.

PATICD_DIAG.ICD_CODE, PATICD_PROC.ICD_CODE, PATCPT.CPT_CODE, and PATBILL.STD_CHG_CODE map to OBSERVATION.OBSERVATION_CONCEPT_ID using the source to standard cte_vocab_map. These records also map to OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID using the source to source cte_vocab_map.

PAT.MART_STATUS, PAT.POINT_OF_ORIGIN, PAT.DISC_STATUS, and PAT.PATTYPE map to set OBSERVATION_CONCEPT_ID codes described in the table below and OBSERVATION_SOURCE_CONCEPT_ID=0. 

The observation start date is assigned the VISIT_START_DATE. The ASSOCIATED_PROVIDER_ID that is provided is the randomly generated key provided by Premier for the provider that admitted the patient. There are two providers that exist in Premier, the admitting and attending. This ETL makes the decision to use admitting because it is unknown whether the admitting provider, attending provider or another person diagnosed the person.  

In Premier, many procedures are recorded in the PATICD_PROC table, which includes the date the procedure was performed as PATICD_PROC.PROC_DATE. Certain billing records in PATBILL include information on surgical operation time. The sample code below the field mapping table returns surgical operation time values in minutes for procedures where operation time billing record(s) happen on the same day. It is assumed that if a procedure and an operating time bill happen on the same day, then the operating time is associated with the procedure. These operation time values move to the Observation table and the OBSERVATION_DATE equals the corresponding PROCEDURE_DATE (which is PROC_DATE). To associate a surgical operation time with a procedure: OBSERVATION.VISIT_OCCURRENCE_ID=PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID AND OBSERVATION.OBSERVATION_DATE=PROCEDURE_OCCURRENCE.PROCEDURE_DATE.
There are three providers that exist in Premier, the admitting, attending, and procedure. This ETL makes the decision to use admitting physician for all observations except operation time because it is unknown whether the admitting provider, attending provider or another person obtained the observation. 

##TODO: 
- For operation time observations, the provider is set as the procedure physician.
Only records that fall within an OBSERVATION_PERIOD are available for each person. The VISIT_OCCURRENCE table must be created before the OBSERVATION table is created.

 
The field mapping is performed as follows:

|Destination Field|Source Field|Applied Rule|Comment|
|--- |--- |--- |--- |
|OBSERVATION_ID|-|System-generated||
|PERSON_ID|PAT.MEDREC_KEY|||
|OBSERVATION_CONCEPT_ID|PATCPT.CPT_COD<br>PATBILL.STD_CHG_CODE<br>PATICD_PROC.ICD_CODEPAT<br>ICD_DIAG.ICD_CODE|For records from PATCPT.CPT_CODE, and PATBILL.STD_CHG_CODE:  <br><br>QUERY: SOURCE TO STANDARD <code>SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'JNJ_PMR_OBS_CODE', 'JNJ_PMR_PROC_CHRG_CD') AND TARGET_DOMAIN_ID = 'Observation'</code> <br><br> For records from PATICD_PROC.ICD_CODE and PATICD_DIAG.ICD_CODE: where ICD_VERSION=9  QUERY: SOURCE TO STANDARD  <code> SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM') AND TARGET_DOMAIN_ID = 'Observation'</code> <br><br>For records from PATICD_PROC.ICD_CODE and PATICD_DIAG.ICD_CODE:where ICD_VERSION=10  QUERY: SOURCE TO STANDARD  <code>SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD10CM') AND TARGET_DOMAIN_ID = 'Observation'</code> <br><br>For PAT.MART_STATUS, OBSERVATION_CONCEPT_ID=4053609 <br><br>For PAT.POINT_OF_ORIGIN, OBSERVATION_CONCEPT_ID=40757183 <br><br>For PAT.DISC_STATUS, OBSERVATION_CONCEPT_ID=40757177 <br><br>For PAT.PATTYPE, OBSERVATION_CONCEPT_ID=40769091 <br><br>When operation time observation values then 3016562||
|OBSERVATION_DATE|PATBILL.SERV_DATE <br>VISIT_OCCURRENCE.VISIT_START_DATE OR VISIT_OCCURRENCE.VISIT_START_DATE|If observation is from PATBILL use service date<br>If observation comes from PAT.MS_DRG, PATCPT.CPT_CODE, PATICD_PROC.ICD_CODE, PATICD_DIAG.ICD_CODE then use visit start date <br><br> For operation time observation, a combination of procedure date and visit start date unless the procedure date is greater than the end of the month||
|OBSERVATION_DATETIME|-|NULL||
|OBSERVATION_TYPE_CONCEPT_ID|-|38000281 Observation recorded from EHR with text result||
|VALUE_AS_NUMBER||||
|VALUE_AS_STRING|PAT.MART_STATUSPAT.POINT_OF_ORIGIN<br>PAT.DISC_STATUS<br>PAT.PAT_TYPE|Value_as_string only populated for Premier-specific fields mart_status, point_of_origin, disc_status, and pat_type<br>Marital status values populated directly from PAT.MART_STATUS as ‘M’, ‘S’, ‘O’, or ‘U’ <br><code>select point_of_origin_desc from poorgin pojoin pat p on p.mart_status=po.point_of_origin</code> <br><br> <code>select disc_status from poorgin pojoin pat p on p.mart_status=po.point_of_origin</code> <br><br> <code>select pat_type_desc from pattype pjoin pat p1 on p1.pat_type=p.pat_type</code>|Use look up values in the text fields.|
|VALUE_AS_CONCEPT_ID|PATCPT.CPT_COD <br>PATBILL.STD_CHG_CODE <br>PATICD_PROC.ICD_CODEPAT<br> ICD_DIAG.ICD_CODE |same rules as for concept_id and source_concept_id, but use 'Maps to value' relationship||
|QUALIFER_CONCEPT_ID|-|NULL||
|UNIT_CONCEPT_ID|-|For operation time records 8550 Else NULL|Set UNIT_CONCEPT_ID = NULL when the source unit value is NULL;Set UNIT_CONCEPT_ID = 0 when source unit value is not NULL but doesn't have a mapping|
|PROVIDER_CONCEPT_ID|PAT.ADMPHY|When operation time PATICD_PROC.PROC_PHY Else PAT.ADMPHY||
|VISIT_OCCURRENCE_ID|PAT.PAT_KEY|||
|OBSERVATION_SOURCE_VALUE|PAT.DRG<br>PATICD.ICD_CODE<br>PATCPT.CPT_CODE<br>CHARGE CODE|Standard charge code value:<br> <code>SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODE JOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id</code>||
|OBSERVATION_SOURCE_CONCEPT_ID|-|QUERY: SOURCE TO SOURCE <br> <code>SELECT SOURCE_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM', 'ICD10CM', 'CPT4', 'HCPCS') AND TARGET_VOCABULARY_ID IN ('ICD9CM', 'ICD10CM', 'CPT4', 'HCPCS')</code> <br><br>For operation time records, NULL for now||
|UNITS_SOURCE_VALUE|-|NULL||
|QUALIFIER_SOURCE_VALUE|-|NULL||

### 03-Mar-2024 
- Added Surgery (concept_id=3016562)
  
### 01-Aug-2023
- Added Maps to value logic
- Cleared formatting