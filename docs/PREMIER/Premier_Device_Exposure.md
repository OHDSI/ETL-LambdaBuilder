---
title: "Device Exposure"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 6
layout: default
---

# Table Name: Device Exposure

The DEVICE_EXPOSURE table will house records from PATBILL, PATCPT, PATICD_DIAG, and PATCID_PROC that have been mapped to the device domain.  

The Premier database has information captured about the various devices in the billing table PATBILL and PATCPT includes codes that are mapped into the device domain. USAGI is used to make PATBILL records to standard concepts, and concepts that are in the Device domain are included. Similarly, HCPCS codes extracted from STD_CHG_CODE records that map to the Device domain also move to DEVICE_EXPOSURE. The ASSOCIATED_PROVIDER_ID that is provided is the randomly generated key provided by Premier for the provider that admitted the patient. There are two providers that exist in Premier, the admitting and attending. This ETL makes the decision to use admitting because it is unknown whether the admitting provider, attending provider or another person diagnosed the person. The STD_CHG_CODE is mapped to a HOSP_CHG using HOSPCHG, and each HOSP_CHG has a description that is displayed in the CDM along with the standard change code descriptions.  

Many CPT-4, CPT-4 Category III, and “C” HCPCS codes are embedded in Premier STD_CHG_CODES.  Most CPT-4 codes do have a corresponding Premier standard charge item(s). If a CPT-4 code is embedded in a Premier standard charge item, then it will be in positions 7-11. Not every item on a hospital’s charge master, however, can be represented by a CPT-4 code. Examples would be items billed for pharmacy, room charges, central supplies, etc. Many “C” HCPCS codes (unique temporary pricing codes established by CMS for hospital outpatient department services and procedures) and CPT-4 Category III codes (temporary codes for emerging technology, services and procedures) are also embedded in the Premier standard charge code. For C codes, the C is dropped and replaced with a 0. For example, positions 7 – 11 of the standard charge code for embedded C code, C8921, is 08921. For temporary codes, the trailing T is dropped and the year it was created is tacked to the end. For example, for standard charge code 360360000192002, the CPT code is  0019T, and the year it was added is 2002. The CPT code, less the trailing T, is in positions 8 – 11, and the year is in positions 12 – 15 of the standard charge code. See the query in PROCEDURE_OCCURRENCE section for extracting embedded codes from STD_CHG_CODE. 

Records that have a valid OBSERVATION_PERIOD for each patient are included. 

The field mapping is as follows: 

| Destination Field  | Source Field  | Applied Rule  | Comment  |
| --- | --- | --- | --- |
| DEVICE_EXPOSURE_ID  | -  | System-generated  |  |
| PERSON_ID  | PAT.MEDREC_KEY  |  |  |
| DEVICE_CONCEPT_ID  | PATBILL.STD_CHG_CODE  | QUERY:SOURCE To STANDARD:  |  |
|  | PATICD_PROC.ICD_CODE  |  |  |
|  | PATICD_DIAG.ICD_CODE  | SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('HCPCS', 'ICD10CM', 'JNJ_PMR_PROC_CHRG_CD') AND TARGET_DOMAIN_ID IN ('Device')  |  |
|  | PATCPT.CPT_CODE   |  |  |
| DEVICE_EXPOSURE_START_DATE  | VISIT_OCCURRENCE.VISIT_END_DATE  or  VISIT_OCCURRENCE.VISIT_START_DATE   PATBILL.SERV_DAY  |  | If the device is a CPT code or HCPCS code then discharge date is used as device date because the exact date is unknown. If the row is coming from PATBILL then a combination or admit date and service date is used.  |
| DEVICE_EXPOSURE_START_DATETIME  | -  | NULL  |  |
| DEVICE_EXPOSURE_END_DATE  |    |  |  |
| DEVICE_EXPOSURE_END_DATETIME  | -  | NULL  |  |
| DEVICE_TYPE_CONCEPT_ID | -  | All records within the device_exposure table should have a device_type_concept_id = 32875 (Provider financial system) |  |
| UNIQUE_DEVICE_ID  | -  | NULL  |  |
| PROVIDER_ID  | PAT.ADMPHY  |  |  |
| VISIT_OCCURRENCE_ID  | PAT.PAT_KEY  |  |  |
| DEVICE_SOURCE_VALUE  | PATCPT.CPT_CODE For all other procedures: CHGMSTR.STD_CHG_CODE_DESC/ HOSP_CHG.HOSP_CHG_DESC   | SELECT SOURCE_VALUE FROM  ( SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL A JOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODE JOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id  ) A UNION ( SELECT CPT_CODE AS SOURCE_VALUE FROM PATCPT )  | To preserve the most detailed description of procedures, if hospital charge descriptions are available, they are to be used, otherwise standard charge code description is displayed  |
| DEVICE_SOURCE_CONCEPT_ID  | -  | NULL  |  |

## Change Log:
* 2021.08.12:  Updated DEVICE_TYPE_CONCEPT_ID to leverage standard concept id.
