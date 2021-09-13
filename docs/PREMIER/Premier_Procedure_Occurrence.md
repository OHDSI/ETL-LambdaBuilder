---
title: "Procedure Occurrence"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 16
layout: default
---

# Table Name: Procedure Occurrence

The PROCEDURE_OCCURRENCE table will house records from PATBILL, PATCPT, and PATICD_PROC. Procedure records from PATBILL are mapped to the procedure domain; procedure records from PATCPT and procedure records from PATICD_PROC are mapped to the SNOMED vocabulary.

The PATBILL table holds all charges that were consumed within a visit. For our CDM, the drugs are separated and inserted into the DRUG_EXPOSURE table, and all other billing records are entered into the PROCEDURE_OCCURRENCE table. For records that are obtained through PATBILL, the start date is determined from the service day in PATBILL and VISIT_START_DATE. If the combination of start date and service day records result in a date greater than the end of the month, the VISIT_END_DATE is assigned.

PATCPT houses the HCPCS and CPT codes by visit, and it is unknown when the procedure was performed. Procedure drugs are recorded as procedure drugs and move to the DRUG_EXPOSURE table. The procedure start date is identified as the VISIT_END_DATE from VISIT_OCCURRENCE.  Procedure type is determined by the indicator of whether it was an inpatient stay or outpatient stay. 

PATICD_PROC holds procedure codes that move to the PROCEDURE_OCCURRENCE table. The day the procedure was performed during the visit is recorded as PATICD_PROC.PROC_DAY. The PROCEDURE_DATE is determined by VISIT_START_DATE + PROC_DAY. If the combination of start date and procedure day records result in a date greater than the end of the month, the VISIT_END_DATE is assigned.  

In order to map each drug to an appropriate concept, USAGI was used on the STD_CHG_DESC to map the value to a concept; all concepts that map into the procedure domain are included in this table. The STD_CHG_CODE is mapped to a HOSP_CHG using HOSPCHG, and each HOSP_CHG has a description that is displayed in the CDM along with the standard change code descriptions. Billing records that do not map to a target concept are moved to PROCEDURE_OCCURRENCE with CONCEPT_ID = 0.

Many CPT-4, CPT-4 Category III, and “C” HCPCS codes are embedded in Premier STD_CHG_CODES.  Most CPT-4 codes do have a corresponding Premier standard charge item(s). If a CPT-4 code is embedded in a Premier standard charge item, then it will be in positions 7-11. Not every item on a hospital’s charge master, however, can be represented by a CPT-4 code. Examples would be items billed for pharmacy, room charges, central supplies, etc. Many “C” HCPCS codes (unique temporary pricing codes established by CMS for hospital outpatient department services and procedures) and CPT-4 Category III codes (temporary codes for emerging technology, services and procedures) are also embedded in the Premier standard charge code. For C codes, the C is dropped and replaced with a 0. For example, positions 7 – 11 of the standard charge code for embedded C code, C8921, is 08921. For temporary codes, the trailing T is dropped and the year it was created is tacked to the end. For example, for standard charge code 360360000192002, the CPT code is 0019T, and the year it was added is 2002. The CPT code, less the trailing T, is in positions 8 – 11, and the year is in positions 12 – 15 of the standard charge code. See the query below for extracting embedded codes from STD_CHG_CODE. 

To account for COVID19 and Ventilator specific hospital charge codes that have related standard charge codes of UNKNOWN or are mapped to zero the team leverages chgmstr_no_std_chg_desc_freq.csv (https://jnj-my.sharepoint.com/:x:/r/personal/mblacke_its_jnj_com/Documents/JNJ%20CDM%20Process/CDM%20Updates%202020/Private/Premier/Vocab%20Updates/chgmstr_no_std_chg_desc_freq.xlsx?d=wd99069f245a44b94beef585c8c683d78&csf=1&web=1&e=DDZ5W8).  This logic was originally patched and as of June 26, 2020 is being built into the standard COVID PREMIER ETL builder. 

##REGULAR MAINTENANCE: 

To account for regular updates to the Premier Standard Charge codes it is recommended that the following script be run on the most recent data and N-1 to assess whether any additional codes have been added to the data set but not previously accounted for (https://jnj-my.sharepoint.com/:u:/r/personal/mblacke_its_jnj_com/Documents/JNJ%20CDM%20Process/CDM%20Updates%202020/Private/Premier/Vocab%20Updates/Premier_new_covid_chg_codes.sql?csf=1&web=1&e=EF9bND). 

##TODO: 

- Alan/Stephen:  Consider adding HOSPCHG.HOSP_CHG_ID to the PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_VALUE to make tracking codes across CDM and NATIVE data sets easier.  This field is currently a concatenation of standard charge description and hospital charge description. 

- Rupa/Jamie:  Procedure providers, PATICD_PROC.PROC_PHY, are associated with procedure records from PATICD_PROC. Procedure providers will be associated with PROCEDURE_OCCURRENCE records only. Procedure providers will also move to the PROVIDER table with an associated PROCPHY_SPEC. Often, the procedure physician and admitting physician are the same person (ADM_PHY = PROC_PHY). 

Records that have a valid OBSERVATION_PERIOD for each patient are included.

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| PROCEDURE_OCCURRENCE_ID | - | System-generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| PROCEDURE_CONCEPT_ID | PATBILL.STD_CHG_CODE \ PATICD_PROC.ICD_CODE \ PATCPT.CPT_CODE | QUERY SOURCE TO STANDARD:SELECT TARGET_CONCEPT_IDWHERE SOURCE_VOCABULARY_ID IN ('JNJ_PMR_PROC_CHRG_CD', 'CPT4', 'HCPCS', 'ICD10CM', 'ICD10PCS', 'ICD9CM', 'ICD9Proc') AND TARGET_DOMAIN_ID ='Procedure'AND SOURCE_CONCEPT_CLASS_ID NOT IN ('CPT4 Modifier', 'ICD10PCS Hierarchy')SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('JNJ_PMR_PROC_CHRG_CD' AND TARGET_CONCEPT_ID=0 |  |
| PROCEDURE_DATE | VISIT_OCCURRENCE.VISIT_END_DATE or VISIT_OCCURRENCE.VISIT_START_DATE  PATBILL.SERV_DAYorVISIT_OCCURRENCE.VISIT_START_DATEPATICD_PROC.PROC_DAY  |  | If the procedure is a CPT code then discharge date is used as procedure date because the exact date is unknown. If the row is coming from PATBILL then a combination or admit date and service date is used. If the record comes from PATICD_PROC then a combination of admit date and service date is used. |
| PROCEDURE_DATETIME | - | NULL |  |
| PROCEDURE_TYPE_CONCEPT_ID | | All records within the procedure_occurrence table should have a procedure_type_concept_id = 32875 (Provider financial system) ||
| MODIFIER_CONCEPT_ID | - | NULL |  |
| QUANTITY | PATBILL.STD_QTY | Quantities are populated for all records obtained from the billing record. |  |
| PROVIDER_ID | PATICD_PROC.PROC_PHY |  |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| PROCEDURE_SOURCE_VALUE | PATICD_PROC.ICD CODE Or PATCPT.CPT_CODEFor all other procedures:CHGMSTR.STD_CHG_CODE_DESC/ HOSP_CHG.HOSP_CHG_DESC  | SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) ASELECT SOURCE_VALUE FROM (SELECT ICD_CODE FROM PATICD_PROC AJOIN CONCEPT C ON C.CONCEPT_CODE=A.ICD_CODEWHERE VOCABULARY_ID=’ICDProc’) AUNION(SELECT CPT_CODE AS SOURCE_VALUE FROM PATCPT) | To preserve the most detailed description of procedures, if hospital charge descriptions are available, they are to be used, otherwise standard charge code description is displayed |
| PROCEDURE_SOURCE_CONCEPT_ID | - | SELECT SOURCE_CONCEPT_IDFROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('ICD9Proc', 'CPT4', 'HCPCS')AND TARGET_VOCABULARY_ID IN ('ICD9Proc', 'CPT4', 'HCPCS') AND DOMAIN_ID='Procedure 'SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) A |  |
| QUALIFER_SOURCE_VALUE | - | NULL |  |

## Supplementary Code:

````{SQL echo=FALSE}
WITH CTE_CPT4 AS ( 

  SELECT CONCEPT_CODE AS FIXED_CONCEPT_CODE, CONCEPT_NAME, CONCEPT_ID, DOMAIN_ID, CONCEPT_CODE, VOCABULARY_ID 

FROM CDM.CONCEPT 

WHERE VOCABULARY_ID = 'CPT4' 

AND CONCEPT_CLASS_ID = 'CPT4' 

AND STANDARD_CONCEPT = 'S' 

), 

CTE_HCPCS AS ( 

  SELECT CONCAT('0',SUBSTRING(CONCEPT_CODE,2,4)) AS FIXED_CONCEPT_CODE, CONCEPT_ID, CONCEPT_NAME, DOMAIN_ID, CONCEPT_CODE, VOCABULARY_ID 

FROM CDM.CONCEPT 

WHERE VOCABULARY_ID = 'HCPCS' 

AND SUBSTRING(CONCEPT_CODE,1,1) = 'C' 

AND STANDARD_CONCEPT = 'S' 

), 

CTE_CPT4_3 AS ( 

  SELECT SUBSTRING(CONCEPT_CODE,1,4) AS FIXED_CONCEPT_CODE, CONCEPT_NAME, CONCEPT_ID, DOMAIN_ID, CONCEPT_CODE, VOCABULARY_ID 

FROM CDM.CONCEPT 

WHERE VOCABULARY_ID = 'CPT4' 

AND CONCEPT_CLASS_ID = 'CPT4' 

AND STANDARD_CONCEPT = 'S' 

AND SUBSTRING(CONCEPT_CODE,5,1) = 'T' 

),  

CTE_CODE_PULL AS ( 

  SELECT  

    CASE  

      WHEN c1.CONCEPT_ID IS NOT NULL THEN c1.CONCEPT_ID 

      WHEN c2.CONCEPT_ID IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN c2.CONCEPT_ID 

      WHEN c3.CONCEPT_ID IS NOT NULL THEN c3.CONCEPT_ID 

      WHEN c4.CONCEPT_ID IS NOT NULL THEN c4.CONCEPT_ID 

      ELSE NULL 

    END TARGET_CONCEPT_ID, 

    CASE  

      WHEN c1.CONCEPT_NAME IS NOT NULL THEN c1.CONCEPT_NAME 

      WHEN c2.CONCEPT_NAME IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN c2.CONCEPT_NAME 

      WHEN c3.CONCEPT_NAME IS NOT NULL THEN c3.CONCEPT_NAME 

      WHEN c4.CONCEPT_NAME IS NOT NULL THEN c4.CONCEPT_NAME 

      ELSE NULL  

    END TARGET_CONCEPT_NAME, 

    CASE  

      WHEN c1.CONCEPT_CODE IS NOT NULL THEN c1.CONCEPT_CODE 

      WHEN c2.CONCEPT_CODE IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN c2.CONCEPT_CODE 

      WHEN c3.CONCEPT_CODE IS NOT NULL THEN c3.CONCEPT_CODE 

      WHEN c4.CONCEPT_CODE IS NOT NULL THEN c4.CONCEPT_CODE 

      ELSE NULL  

    END TARGET_CONCEPT_CODE, 

    CASE  

      WHEN c1.VOCABULARY_ID IS NOT NULL THEN c1.VOCABULARY_ID 

      WHEN c2.VOCABULARY_ID IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN c2.VOCABULARY_ID 

      WHEN c3.VOCABULARY_ID IS NOT NULL THEN c3.VOCABULARY_ID 

      WHEN c4.VOCABULARY_ID IS NOT NULL THEN c4.VOCABULARY_ID 

      ELSE NULL  

    END TARGET_VOCABULARY_ID, 

    CASE  

      WHEN c1.DOMAIN_ID IS NOT NULL THEN c1.DOMAIN_ID 

      WHEN c2.DOMAIN_ID IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN c2.DOMAIN_ID 

      WHEN c3.DOMAIN_ID IS NOT NULL THEN c3.DOMAIN_ID 

      WHEN c4.DOMAIN_ID IS NOT NULL THEN c4.DOMAIN_ID 

      ELSE NULL  

    END TARGET_DOMAIN_ID, 

    CASE  

      WHEN c1.CONCEPT_ID IS NOT NULL THEN '1-CPT4' 

      WHEN c2.CONCEPT_ID IS NOT NULL AND SUM_DEPT_DESC NOT IN ('SUPPLY', 'PHARMACY') THEN '2-HCPCs' 

      WHEN c3.CONCEPT_ID IS NOT NULL THEN '3-CPT4 III' 

      WHEN c4.CONCEPT_ID IS NOT NULL THEN '4-USAGI Mapping' 

      ELSE '5-UNMAPPED' 

    END TARGET_FLAG, 

    cm.* 

  FROM CHGMSTR cm 

    LEFT OUTER JOIN CTE_CPT4 c1 

      ON c1.FIXED_CONCEPT_CODE = SUBSTRING(cm.STD_CHG_CODE,7,5) 

    LEFT OUTER JOIN CTE_HCPCS c2 

      ON c2.FIXED_CONCEPT_CODE = SUBSTRING(cm.STD_CHG_CODE,7,5) 

    LEFT OUTER JOIN CTE_CPT4_3 c3 

      ON c3.FIXED_CONCEPT_CODE = substring(std_chg_code, 8, 4)  

      AND  substring(std_chg_code, 12, 4) in  

      ('2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008',  

       '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017')  

    LEFT OUTER JOIN cdm.SOURCE_TO_CONCEPT_MAP stcm 

      ON stcm.SOURCE_CODE = cm.STD_CHG_CODE 

      AND SOURCE_VOCABULARY_ID IN ( 

      'JNJ_PMR_DRUG_CHRG_CD','JNJ_PMR_PROC_CHRG_CD' 

      ) 

      AND stcm.TARGET_CONCEPT_ID != 0 

    LEFT OUTER JOIN cdm.CONCEPT c4 

      ON stcm.TARGET_CONCEPT_ID = c4.CONCEPT_ID 

) 

SELECT DISTINCT cp.*,  

  CASE WHEN z.CODE_COUNT IS NULL THEN 0 ELSE z.CODE_COUNT END AS CODE_COUNT 

FROM CTE_CODE_PULL cp 

  LEFT OUTER JOIN ( 

    SELECT STD_CHG_CODE, COUNT(*) AS CODE_COUNT 

    FROM PATBILL 

    GROUP BY STD_CHG_CODE 

   ) z 

    ON z.STD_CHG_CODE = cp.STD_CHG_CODE 
```
    
## Change Log:
* 2021.08.11:  Updated PROCEDURE_TYPE_CONCEPT_ID to leverage standard concept id.
