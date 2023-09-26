---
title: "Observation"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 13
layout: default
---

# Table Name: Observation

The observation table houses additional demographic and visit data that is housed in Premier. Certain ICD9, CPT, and standard charge codes map to standardized observation table concept. Marital status, admission information, discharge status, and patient type records are specific to Premier and map to non-standard observation table concepts. 

PATICD_DIAG.ICD_CODE, PATICD_PROC.ICD_CODE, PATCPT.CPT_CODE, and PATBILL.STD_CHG_CODE map to OBSERVATION.OBSERVATION_CONCEPT_ID using the source to standard cte_vocab_map. These records also map to OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID using the source to source cte_vocab_map.

PAT.MART_STATUS, PAT.POINT_OF_ORIGIN, PAT.DISC_STATUS, and PAT.PATTYPE map to set OBSERVATION_CONCEPT_ID codes described in the table below and OBSERVATION_SOURCE_CONCEPT_ID=0. 

All inpatient visits (where PAT.I_O_IND=’I’) are associated with a sampling weight PAT.PROJ_WGT. Each inpatient visit record maps to an OBSERVATION table record where OBSERVATION_CONCEPT_ID = 37392832, OBSERVATION_TYPE_CONCEPT_ID = 900000003, and VALUE_AS_NUMBER = PAT.PROJ_WGT. Weights from outpatient visits (PAT.I_O_IND=’O’) are all PROJ_WGT=0 and do not move to the OBSERVATION table.

Details on Premier visit sampling weight from [https://www.ncbi.nlm.nih.gov/pubmedhealth/PMH0047457/](https://www.ncbi.nlm.nih.gov/pubmedhealth/PMH0047457/)

"Each hospitalization encounter has an associated statistical weight that allows extrapolation to the volume of hospitalizations estimated for the U.S. as a whole. These weights are based on the inverse of the sampling probabilities associated with each hospital in relationship to the universe of non-federal acute care hospitals, stratified by hospital characteristics, so that the aggregate of hospitalizations approximates the number and distribution of discharges from acute care, non-federal hospitals."

The observation start date is assigned the VISIT_START_DATE. The ASSOCIATED_PROVIDER_ID that is provided is the randomly generated key provided by Premier for the provider that admitted the patient. There are two providers that exist in Premier, the admitting and attending. This ETL makes the decision to use admitting because it is unknown whether the admitting provider, attending provider or another person diagnosed the person.  

 
The field mapping is performed as follows:

|Destination Field|Source Field|Applied Rule|Comment|
|--- |--- |--- |--- |
|OBSERVATION_ID|-|System-generated||
|PERSON_ID|PAT.MEDREC_KEY|||
|OBSERVATION_CONCEPT_ID|PATCPT.CPT_COD PATBILL.STD_CHG_CODE PATICD_PROC.ICD_CODEPAT ICD_DIAG.ICD_CODE PAT.PROJ_WGT|For records from PATCPT.CPT_CODE, and PATBILL.STD_CHG_CODE:  QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'JNJ_PMR_OBS_CODE', 'JNJ_PMR_PROC_CHRG_CD')AND TARGET_DOMAIN_ID = 'Observation'For records from PATICD_PROC.ICD_CODE and PATICD_DIAG.ICD_CODE:where ICD_VERSION=9  QUERY: SOURCE TO STANDARD  SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM')AND TARGET_DOMAIN_ID = 'Observation'For records from PATICD_PROC.ICD_CODE and PATICD_DIAG.ICD_CODE:where ICD_VERSION=10  QUERY: SOURCE TO STANDARD  SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD10CM')AND TARGET_DOMAIN_ID = 'Observation'For PAT.MART_STATUS, OBSERVATION_CONCEPT_ID=4053609 For PAT.POINT_OF_ORIGIN, OBSERVATION_CONCEPT_ID=40757183For PAT.DISC_STATUS, OBSERVATION_CONCEPT_ID= 40757177 For PAT.PATTYPE, OBSERVATION_CONCEPT_ID= 40769091For records from PAT.PROJ_WGT:OBSERVATION_CONCEPT_ID = 37392832||
|OBSERVATION_DATE|PATBILL.SERV_DAY VISIT_OCCURRENCE.VISIT_START_DATEORVISIT_OCCURRENCE.VISIT_START_DATE|If observation is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf observation comes from PAT.MS_DRG, PAT.PROJ_WGT, PATCPT.CPT_CODE, PATICD_PROC.ICD_CODE, PATICD_DIAG.ICD_CODE then use visit start date||
|OBSERVATION_DATETIME|-|NULL||
|OBSERVATION_TYPE_CONCEPT_ID|-|38000281 Observation recorded from EHR with text resultIf record from PAT.PROJ_WGT, then 900000003 observation numeric result||
|VALUE_AS_NUMBER|PAT.PROJ_WGT|If I_O_IND=’O’ then PAT.PROJ_WGT||
|VALUE_AS_STRING|PAT.MART_STATUSPAT.POINT_OF_ORIGINPAT.DISC_STATUSPAT.PAT_TYPE|Value_as_string only populated for Premier-specific fields mart_status, point_of_origin, disc_status, and pat_typeMarital status values populated directly from PAT.MART_STATUS as ‘M’, ‘S’, ‘O’, or ‘U’select point_of_origin_desc from poorgin pojoin pat p on p.mart_status=po.point_of_originselect disc_status from poorgin pojoin pat p on p.mart_status=po.point_of_originselect pat_type_desc from pattype pjoin pat p1 on p1.pat_type=p.pat_type|Use look up values in the text fields.|
|VALUE_AS_CONCEPT_ID|PATCPT.CPT_COD PATBILL.STD_CHG_CODE PATICD_PROC.ICD_CODEPAT ICD_DIAG.ICD_CODE PAT.PROJ_WGT|same rules as for concept_id and source_concept_id, but use 'Maps to value' relationship||
|QUALIFER_CONCEPT_ID|-|NULL||
|UNIT_CONCEPT_ID|-|NULL|Set UNIT_CONCEPT_ID = NULL when the source unit value is NULL;Set UNIT_CONCEPT_ID = 0 when source unit value is not NULL but doesn't have a mapping|
|PROVIDER_CONCEPT_ID|PAT.ADMPHY|||
|VISIT_OCCURRENCE_ID|PAT.PAT_KEY|||
|OBSERVATION_SOURCE_VALUE|PAT.DRG\PATICD.ICD_CODE\PATCPT.CPT_CODE\CHARGE CODE|Standard charge code value:SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id||
|OBSERVATION_SOURCE_CONCEPT_ID|-|QUERY: SOURCE TO SOURCE SELECT SOURCE_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('ICD9CM', 'ICD10CM', 'CPT4', 'HCPCS') AND TARGET_VOCABULARY_ID IN ('ICD9CM', 'ICD10CM', 'CPT4', 'HCPCS')||
|UNITS_SOURCE_VALUE|-|NULL||
|QUALIFIER_SOURCE_VALUE|-|NULL||


### 01-Aug-2023
- Added Maps to value logic
- Cleared formatting

