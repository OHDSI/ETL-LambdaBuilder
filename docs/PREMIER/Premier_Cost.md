---
title: "Cost"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 14
layout: default
---

# Table Name: Cost

Costs and charges are captured in Premier and are housed in the PATBILL table. Each record includes a billing item identified by STD_CHG_CODE and its associated charge to the patient (BILL_CHARGES) and cost to the provider (BILL_COST). Amounts paid (by patient, payer, copay, etc.) are not captured in Premier. Since each PATBILL record includes a cost and charge component, these records will be referred to as billing records henceforth. Each billing record is categorized by department using the REVENUE_CONCEPT_CODE_ID field. 

Drug Costs: Drug exposure records that come from the PATBILL table will have costs associated with them, but drug exposure records that come from PATICD or PATCPT will not have an associated cost. BILL_COST and BILL_CHARGES for DRUG_EXPOSURE records that originate from PATBILL will be stored in the COST table. Use DRUG_EXPOSURE logic to determine which PATBILL records are drug exposures. 

Procedure Costs: Procedure occurrence records that come from the PATBILL table will have costs associated with them, but procedure occurrence records that come from PATICD_PROC or PATCPT will not have an associated cost. BILL_COST and BILL_CHARGES for PROCEDURE_OCCURRENCE records that originate from PATBILL will be stored in the COST table. Use PROCEDURE_OCCURRENCE logic to determine which PATBILL records are procedure occurrences. 

Device Costs: Device exposure records that come from the PATBILL table will have costs associated with them, but device exposure records that come from PATICD_DIAG,  PATICD_PROC, or PATCPT will not have an associated cost. BILL_COST and BILL_CHARGES for DEVICE_EXPOSURE records that originate from PATBILL will be stored in the COST table. Use DEVICE_EXPOSURE logic to determine which PATBILL records are device exposures. 

Observation Costs: Observation records that come from the PATBILL table will have costs associated with them, but observation records that come from PAT.MS_DRG, PATICD_DIAG, PATICD_PROC, and PATCPT will not have an associated cost. BILL_COST and BILL_CHARGES for OBSERVATION records that originate from PATBILL will be stored in the COST table. Use OBSERVATION logic to determine which PATBILL records are observation records. 

Measurement Costs: Measurement records that come from the PATBILL table will have costs associated with them, but measurement records that come from PATCPT will not have an associated cost. BILL_COST and BILL_CHARGES for MEASUREMENT records that originate from PATBILL will be stored in the COST table. Use MEASUREMENT logic to determine which PATBILL records are observation records. 

DRG codes: DRG information is captured in PAT.MS_DRG, where one code is associated with one visit. Although a single visit will have multiple associated cost records, the same DRG code will be associated with each cost record for the visit.  

Note: MS_DRG codes contain 3 digits, including those codes with leading zeros (i.e. 00# and 0##). These leading zeros are missing in Premier data and must be added in the ETL process for accurate mapping using the source to standard cte_vocab_map.  

The field mapping is as follows: 

| Destination Field  | Source Field  | Applied Rule  | Comment  |
| --- | --- | --- | --- |
| COST_ID  |  | A unique identifier for each COST record  |  |
| COST_EVENT_ID  | DRUG_EXPOSURE.DRUG_EXPOSURE_ID OR PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID OR DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID OR OBSERVATION.OBSERVATION_ID OR MEASUREMENT.MEASUREMENT_ID  |  |  |
| COST_DOMAIN_ID  |  | WHEN cost_event_id = drug_exposure.drug_exposure_id THEN cost_domain_id = ‘Drug’ OR WHEN cost_event_id = procedure_occurrence.procedure_occurrence_id THEN cost_domain_id = ‘Procedure’ OR WHEN cost_event_id = device_exposure.device_exposure_id THEN cost_domain_id = ‘Device’ OR WHEN cost_event_id = observation.observation_id THEN cost_domain_id = ‘Observation’ OR WHEN cost_event_id = measurement.measurement_id THEN cost_domain_id = ‘Measurement’  | WHEN cost_event_id = drug_exposure.drug_exposure_id THEN cost_domain_id = ‘Drug’ OR WHEN cost_event_id = procedure_occurrence.procedure_occurrence_id THEN cost_domain_id = ‘Procedure’ OR WHEN cost_event_id = device_exposure.device_exposure_id THEN cost_domain_id = ‘Device’ OR WHEN cost_event_id = observation.observation_id THEN cost_domain_id = ‘Observation’ OR WHEN cost_event_id = measurement.measurement_id THEN cost_domain_id = ‘Measurement’  |
| COST_TYPE_CONCEPT_ID  | NULL  | Currently NULL but to adhere to standard decided upon here: http://forums.ohdsi.org/t/discrepancy-in-understanding-the-cost-type-concept-id/1805  |  |
| CURRENCY_CONCEPT_ID  |  | 44818668- American dollar  |  |
| TOTAL_CHARGE  | PATBILL.BILL_CHARGES  | SELECT bill_charges  FROM patbill  | Note we are not moving total visit costs or charges from PAT.PAT_COST and PAT.PAT_CHARGES  |
| TOTAL_COST  | PATBILL.BILL_COST  | SELECT bill_cost FROM patbill  |  |
|  |  |  |  |
| TOTAL_PAID  |  | Null  |  |
| PAID_BY_PAYER  |  | Null  |  |
| PAID_BY_PATIENT  |  | Null  |  |
| PAID_PATIENT_COPAY  |  | Null  |  |
| PAID_PATIENT_COINSURANCE  |  | Null  |  |
| PAID_PATIENT_DEDUCTIBLE  |  | Null  |  |
| PAID_BY_PRIMARY  |  | Null  |  |
| PAID_INGREDIENT_COST  |  | Null  |  |
| PAID_DISPENSING_FEE  |  | Null  |  |
| PAYER_PLAN_PERIOD_ID  |  | Null  |  |
| AMOUNT_ALLOWED  |  | Null  |  |
| REVENUE_CODE_CONCEPT_ID  |  | QUERY:SOURCE To STANDARD: SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN (JNJ_PMR_COST_CHRG_CD') AND TARGET_DOMAIN_ID IN ('Revenue Code')  |  |
| REVENUE_CODE_SOURCE_VALUE  | CHGMSTR.SUM_DEPT_DESC  | SELECT sum_dept_desc || ' / ' || std_dept_desc AS revenue_code_source_value FROM chgmstr  |  |
| DRG_CONCEPT_ID  | PAT.MS_DRG  | QUERY: SOURCE TO STANDARD SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP  WHERE SOURCE_VOCABULARY_ID IN ('DRG')  |  |
| DRG_SOURCE_VALUE  | PAT.MS_DRG  |  |  |

