---
layout: default
title: Cost
nav_order: 9
parent: IBM CCAE & MDCR
description: "**COST** mapping from IBM MarketScan® Commercial Database (CCAE) & IBM MarketScan® Medicare Supplemental Database (MDCR) **INPATIENT_ADMISSIONS**,**INPATIENT_SERVICES**, **OUTPATIENT_SERVICES**, and **DRUG_CLAIMS**"
---

## Table name: **COST**

The **COST** table captures all cost information.
<br>

### Key conventions

* Costs will be taken from **INPATIENT_ADMISSIONS**, **INPATIENT_SERVICES**, **OUTPATIENT_SERVICES**, and **DRUG_CLAIMS** and should be loaded at the **same time** as the **VISIT_DETAIL** table.
* To associate the costs with the correct fact table (**CONDITION_OCCURRENCE**, **PROCEDURE_OCCURRENCE**, **DEVICE_EXPOSURE**, **DRUG_EXPOSURE**, **MEASUREMENT**, **OBSERVATION** or **VISIT_OCCURRENCE**) join to the **visit_detail_id** in the corresponding fact table to the **cost.cost_event_id**.
* Since the amount of observation time in **OBSERVATION_PERIOD** may be greater than that in PAYER_PLAN_PERIOD table, use left join to avoid excluding records when pulling PAYER_PLAN_PERIOD_ID.  For those records fall out of PAYER_PLAN_PERIOD_START_DATE AND 
  PAYER_PLAN_PERIOD_END_DATE, set PAYER_PLAN_PERIOD_ID as NULL.

<br>

### Reading from **DRUG_CLAIMS**


<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | Costs coming from the **DRUG_CLAIMS** table will have COST_EVENT_ID = the corresponding VISIT_DETAIL_ID that was generated for loading the VISIT_DETAIL table | - |
| COST_DOMAIN_ID | - | 'Visit Detail' | - |
| COST_TYPE_CONCEPT_ID | - | `32869` | <br>`32869` (Pharmacy claim)</br> <br>This should match the VISIT_DETAIL_TYPE_CONCEPT_ID.</br>
| CURRENCY_CONCEPT_ID |  | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | - | - |
| TOTAL_COST | - | - | - |
| TOTAL_PAID | PAY | - | - |
| PAID_BY_PAYER | - | - | -|
| PAID_BY_PATIENT | - | - | - |
| PAID_PATIENT_COPAY | - | - | - |
| PAID_PATIENT_COINSURANCE | - | - | - |
| PAID_PATIENT_DEDUCTIBLE | - | - | - |
| PAID_BY_PRIMARY | - | - | - |
| PAID_INGREDIENT_COST | - | - | - |
| PAID_DISPENSING_FEE | - | - | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	<br><br> There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - | - |
| REVENUE_CODE_CONCEPT_ID | - | 0 | - |
| REVENUE_CODE_SOURCE_VALUE | - | - | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | - | - |

<br><br>

### Reading from **OUTPATIENT_SERVICES**


<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | Costs coming from the **OUTPATIENT_SERVICES** table will have COST_EVENT_ID = the corresponding VISIT_DETAIL_ID that was generated for loading the VISIT_DETAIL table | - |
| COST_DOMAIN_ID | - | 'Visit Detail' | - |
| COST_TYPE_CONCEPT_ID | - | `32860` | <br>`32860`	Outpatient Claim Detail </br> <br>This should match the VISIT_DETAIL_TYPE_CONCEPT_ID.</br> |
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | - | - |
| TOTAL_COST | - | - | - |
| TOTAL_PAID | PAY | - | - |
| PAID_BY_PAYER | - | - | -|
| PAID_BY_PATIENT | - | - | - |
| PAID_PATIENT_COPAY | - | - | - |
| PAID_PATIENT_COINSURANCE | - | - | - |
| PAID_PATIENT_DEDUCTIBLE | - | - | - |
| PAID_BY_PRIMARY | - | - | - |
| PAID_INGREDIENT_COST | - | - | - |
| PAID_DISPENSING_FEE | - | - | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	<br><br> There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - | - |
| REVENUE_CODE_CONCEPT_ID | - | 0 | - |
| REVENUE_CODE_SOURCE_VALUE | - | - | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | - | - |

<br><br>

### Reading from **INPATIENT_SERVICES**


<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | Costs coming from the **INPATIENT_SERVICES** table will have COST_EVENT_ID = the corresponding VISIT_DETAIL_ID that was generated for loading the VISIT_DETAIL table | - |
| COST_DOMAIN_ID | - | 'Visit Detail' | - |
| COST_TYPE_CONCEPT_ID | - | `32854` | <br>`32854`	Inpatient Claim Detail </br> <br>This should match the VISIT_DETAIL_TYPE_CONCEPT_ID.</br> |
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | - | - |
| TOTAL_COST | - | - | - |
| TOTAL_PAID | PAY | - | - |
| PAID_BY_PAYER | - | - | -|
| PAID_BY_PATIENT | - | - | - |
| PAID_PATIENT_COPAY | - | - | - |
| PAID_PATIENT_COINSURANCE | - | - | - |
| PAID_PATIENT_DEDUCTIBLE | - | - | - |
| PAID_BY_PRIMARY | - | - | - |
| PAID_INGREDIENT_COST | - | - | - |
| PAID_DISPENSING_FEE | - | - | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	<br><br> There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - | - |
| REVENUE_CODE_CONCEPT_ID | - | 0 | - |
| REVENUE_CODE_SOURCE_VALUE | - | - | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | - | - |
<br>


### Reading from **INPATIENT_ADMISSIONS**


<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | Costs coming from the **INPATIENT_ADMISSIONS** table will have COST_EVENT_ID = the corresponding VISIT_DETAIL_ID that was generated for loading the VISIT_DETAIL table | - |
| COST_DOMAIN_ID | - | 'Visit Detail' | - |
| COST_TYPE_CONCEPT_ID | - | `32855` | <br>`32855`	Inpatient Claim Header </br> <br>This should match the VISIT_DETAIL_TYPE_CONCEPT_ID.</br>|
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | - | - |
| TOTAL_COST | - | - | - |
| TOTAL_PAID | PAY | - | - |
| PAID_BY_PAYER | - | - | -|
| PAID_BY_PATIENT | - | - | - |
| PAID_PATIENT_COPAY | - | - | - |
| PAID_PATIENT_COINSURANCE | - | - | - |
| PAID_PATIENT_DEDUCTIBLE | - | - | - |
| PAID_BY_PRIMARY | - | - | - |
| PAID_INGREDIENT_COST | - | - | - |
| PAID_DISPENSING_FEE | - | - | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	<br><br> There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - | - |
| REVENUE_CODE_CONCEPT_ID | - | 0 | - |
| REVENUE_CODE_SOURCE_VALUE | - | - | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | - | - |
<br>


## Change Log

### Dec 14, 2023
* Updated COST ETL guidance to populate the COST table at the same time as the VISIT_DETAIL table and apply logic to populate the cost_event_id, cost_type_concept_id and cost_domain_id with visit_detail_id, visit_detail_concept_id and 'Visit Detail' respectively.

### Dec 7, 2023
* Updated COST ETL logic to map Outpatient_services.pay, Inpatient_services.pay and Drug_claims.pay to cost.total_paid