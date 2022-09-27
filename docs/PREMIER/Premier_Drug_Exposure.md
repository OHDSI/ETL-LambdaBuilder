---
title: "Drug Exposure"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 9
layout: default
---

# Table Name: Drug Exposure

The DRUG_EXPOSURE table will house records from PATBILL and PATCPT that have been mapped to the drug or metadata domain. 

Administrations of drugs are recorded in the PATBILL table as standard charges.  Premier captures the day of administration in the SERV_DAY field. DRUG_EXPOSURE_START_DATE is determined by adding the number of service days to the visit start day using VISIT_OCCURRENCE .VISIT_START_DATE and PATBILL.SERV_DAY. If the start date is greater than the end of the month, then it’s truncated to the end of month. Procedure drugs reside in the PATCPT table. DRUG_EXPOSURE_START_DATE for procedures is the last day of visit or VISIT_END_DATE, since dates for the administration of procedure drugs is not recorded, the assumption is made that the procedure occurred sometime before the end of the visit. DRUG_EXPOSURE_END_DATE cannot be determined because the patient is not followed each stay and days’ supply information is not available.  

Premier does not provide NDC codes for drugs that are administered during a visit. The PRESCRIBING_PROVIDER_ID is determined from the visit using the admitting provider id of the visit. In Premier, the admitting and attending providers are provided and due to the similarity of both the fields, the admitting provider id is used. The determination cannot be made if the admitting provider was the provider that prescribed the medication but that is the only information that is available. Drug type is considered inpatient administration for all drugs, except those drugs that are procedures and come from PATCPT. Both HCPCS codes and CPT codes are available in PATCPT. The quantity of drugs administered as captured from the QTY field in PATBILL. 

Each standard charge from PATBILL maps to the CHGMSTR table that houses additional information regarded the department, and descriptions about the item. To map each drug to an appropriate concept, USAGI was used to map STD_CHG_DESC to the value of an RxNorm concept. The CHGMSTR table is segmented by the department STD_DEPT_DESC. The drug records represented in this table are captured from the Pharmacy department. Any mapping that cannot be correctly identified is mapped to a CONCEPT_ID of zero. All drugs will be mapped and included in this table even if they don’t have a valid concept. All charges are loaded into the SOURCE_TO_CONCEPT_MAP table, and the table is attached in the appendix. The STD_CHG_CODE is mapped to a HOSP_CHG using the table HOSPCHG, and each HOSP_CHG has a description that is displayed in the CDM as the source value. 

Only records that fall within an OBSERVATION_PERIOD are available for each person. The VISIT_OCCURRENCE table must be created before the DRUG_EXPOSURE table is created.

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| DRUG_EXPOSURE_ID | - | System generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| DRUG_CONCEPT_ID | PATCPT.CPT_CODEPATBILL.STD_CHG_CODE | QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'JNJ_PMR_DRUG_CHRG_CD')AND TARGET_DOMAIN_ID = 'Drug'  | Include all concepts that map to a concept id of zero. |
| DRUG_EXPOSURE_START_DATE | PATBILL.SERV_DAY VISIT_OCCURRENCE.VISIT_START_DATEOrVISIT_OCCURRENCE.VISIT_END_DATE | If drug is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf drug comes from PATCPT then use visit end date |  |
| DRUG_EXPOSURE_START_DATETIME | - | NULL |  |
| DRUG_EXPOSURE_END_DATE | DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE | DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE | Now a required field. No info on days supply, so set same date as drug_exposure_start_date |
| DRUG_EXPSURE_END_DATETIME | - | NULL |  |
| VERBATIM_END_DATE | - | NULL |  |
| DRUG_TYPE_CONCEPT_ID |  | All records within the drug_exposure table should have a drug_type_concept_id = 32875 (Provider financial system) |  |
| STOP_REASON | - | NULL |  |
| REFILLS | - | NULL |  |
| QUANTITY | PATBILL.STD_QTY |  | Value is applied only to records that come from PATBILL, else records from PATCPT or PATICD are NULL |
| DAYS_SUPPLY | - | NULL |  |
| SIG | - | NULL |  |
| ROUTE_CONCEPT_ID | - | NULL |  |
| LOT_NUMBER | - | NULL |  |
| PROVIDER_ID | PAT.ADMPHY | NULL |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| DRUG_SOURCE_VALUE |  | SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) A |  |
| DRUG_SOURCE_CONCEPT_ID | - | NULL |  |
| ROUTE_SOURCE_VALUE | - | NULL |  |
| DOSE_UNIT_SOURCE_VALUE | - | NULL |  |

## Change Log:
* 2021.08.11:  Updated DRUG_TYPE_CONCEPT_ID to leverage standard concept id.
