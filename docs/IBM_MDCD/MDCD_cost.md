---
layout: default
title: Cost
nav_order: 9
parent: IBM MDCD
description: "**COST** mapping from IBM MarketScan® Medicaid  Database (MDCD) **TEMP_INPATIENT_ADMISSIONS**, **TEMP_MEDICAL**,  and **DRUG_CLAIMS**"
---

## Table name: **COST**

The **COST** table captures all cost information for procedures, drugs, visits and devices.
<br>

### Key conventions

* Costs will be taken from **TEMP_INPATIENT_ADMISSIONS**, **TEMP_MEDICAL** and **DRUG_CLAIMS** and should be loaded after the **VISIT_OCCURRENCE** table since the mapped domains will be needed in order to properly associate the costs with the correct fact table (**CONDITION_OCCURRENCE**, **PROCEDURE_OCCURRENCE**, **DEVICE_EXPOSURE**, **DRUG_EXPOSURE**, **MEASUREMENT**, **OBSERVATION** or **VISIT_OCCURRENCE**).
* Each line of service from **TEMP_MEDICAL** table will create one and only one record in the **COST** table since costs are associated with PROC1. 
  * Starts after you have remove duplicate drug records (see Drug Claims to STEM documentation). 
  * After mapping each PROC1 in **TEMP_MEDICAL** to the correct CONCEPT_ID and the correct DOMAIN during the VISIT_OCCURRENCE step, use this information to populate COST_EVENT_ID and COST_DOMAIN_ID.
* When taking cost information from **TEMP_INPATIENT_ADMISSIONS** we take any **INPATIENT_ADMISSION** that matches up to an ‘IP’ **TEMP_MEDICAL** record on ENROLID, CASEID, and YEAR.
* Drug cost information is pulled from the **DRUG_CLAIMS** table at the same time the **DRUG_EXPOSURE** is loaded and follows the same pull logic as described for **DRUG_EXPOSURE** table. 

<br>

### Reading from **DRUG_CLAIMS**

![](images/image17DrugCost.png)

<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | Costs coming from the **DRUG_CLAIMS** table will have COST_EVENT_ID = DRUG_EXPOSURE_ID | - |
| COST_DOMAIN_ID | - | `Drug` | - |
| COST_TYPE_CONCEPT_ID | - | `32810` | `32810`	Claim |
| CURRENCY_CONCEPT_ID |  | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | - | - |
| TOTAL_COST | AWP | - | - |
| TOTAL_PAID | - | PAID_BY_PAYER + PAID_BY_PATIENT + PAID_BY_PRIMARY | - |
| PAID_BY_PAYER | netpay | SUM(NETPAY) | -|
| PAID_BY_PATIENT | - | PAID_PATIENT_COPAY + PAID_PATIENT_COINSURANCE + PAID_PATIENT + DEDUCTIBLE | - |
| PAID_PATIENT_COPAY | copay | SUM(COPAY) | - |
| PAID_PATIENT_COINSURANCE | coins | SUM(COINS) | - |
| PAID_PATIENT_DEDUCTIBLE | deduct | SUM(DEDUCT) | - |
| PAID_BY_PRIMARY | cob | SUM(COB) | - |
| PAID_INGREDIENT_COST | ingcost | SUM(INGCOST) | - |
| PAID_DISPENSING_FEE | dispfee | SUM(DISPFEE) | - |
| PAYER_PLAN_PERIOD_ID | - | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.<br><br>There should only be one possible plan. |
| AMOUNT_ALLOWED | - | NULL | - |
| REVENUE_CODE_CONCEPT_ID | - | 0 | - |
| REVENUE_CODE_SOURCE_VALUE | - | NULL | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | NULL | - |

<br><br>

### Reading from **OUTPATIENT_SERVICES**

![](images/image14OPSCost.png)

<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | This allows the cost to be linked to the associated record. If a PROC1 code maps to a CONCEPT_ID with a domain of 'device', then this will be the DEVICE_EXPOSURE_ID assigned in the DEVICE_EXPOSURE table. | - |
| COST_DOMAIN_ID | - | If a PROC1 code maps to a CONCEPT_ID with a domain of 'Device', then this will be 'Device'. | - |
| COST_TYPE_CONCEPT_ID | - | `32810` | `32810`	Claim |
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | NULL | - |
| TOTAL_COST | - | NULL | - |
| TOTAL_PAID | - | PAID_BY_PAYER + PAID_BY_PATIENT + PAID_BY_PRIMARY | - |
| PAID_BY_PAYER | NETPAY | - | - |
| PAID_BY_PATIENT | - | PAID_PATIENT_COPAY + PAID_PATIENT_COINSURANCE + PAID_PATIENT + DEDUCTIBLE | - |
| PAID_PATIENT_COPAY | COPAY | - | - |
| PAID_PATIENT_COINSURANCE | COINS | - | - |
| PAID_PATIENT_DEDUCTIBLE | DEDUCT | - | - |
| PAID_BY_PRIMARY | COB | - | - |
| PAID_INGREDIENT_COST | - | NULL | - |
| PAID_DISPENSING_FEE | - | NULL | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	<br><br> There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | NULL | - |
| REVENUE_CODE_CONCEPT_ID | REVCODE | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br> Filters: <br>  `WHERE SOURCE_VOCABULARY_ID IN ('Revenue Code')` <br> `AND TARGET_STANDARD_CONCEPT = 'S'` | - |
| REVENUE_CODE_SOURCE_VALUE | REVCODE | - | - |
| DRG_CONCEPT_ID | - | 0 | - |
| DRG_SOURCE_VALUE | - | - | - |

<br><br>

### Reading from **INPATIENT_ADMISSIONS**

![](images/image30IPACOST.png)

<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | This allows the cost to be linked to the associated record. If a PROC1 code maps to a CONCEPT_ID with a domain of 'device', then this will be the DEVICE_EXPOSURE_ID assigned in the DEVICE_EXPOSURE table. | - |
| COST_DOMAIN_ID | - | If a PROC1 code maps to a CONCEPT_ID with a domain of 'Device', then this will be 'Device'. | - |
| COST_TYPE_CONCEPT_ID | - | `32810` | `32810` Claim |
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | NULL | - |
| TOTAL_COST | - | NULL | - |
| TOTAL_PAID | - | PAID_BY_PAYER + PAID_BY_PATIENT + PAID_BY_PRIMARY | - |
| PAID_BY_PAYER | TOTNET | - | - |
| PAID_BY_PATIENT | - | PAID_PATIENT_COPAY + PAID_PATIENT_COINSURANCE + PAID_PATIENT + DEDUCTIBLE | - |
| PAID_PATIENT_COPAY | TOTCOPAY | - | - |
| PAID_PATIENT_COINSURANCE | TOTCOINS | - | - |
| PAID_PATIENT_DEDUCTIBLE | TOTDED | - | - |
| PAID_BY_PRIMARY | totcob | - | - |
| PAID_INGREDIENT_COST | - | NULL | - |
| PAID_DISPENSING_FEE | - | NULL | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - |
| REVENUE_CODE_CONCEPT_ID | - | - | - |
| REVENUE_CODE_SOURCE_VALUE | - | - | - |
| DRG | DRG | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br>Filters:<br>`WHERE SOURCE_VOCABULARY_ID IN ('DRG')`<br>`AND SOURCE_CONCEPT_CLASS_ID IN ('MS-DRG')`<br>`AND TARGET_STANDARD_CONCEPT = 'S'`<br>`AND TSVCDAT >= TARGET_VALID_START_DATE`<br>`AND TSVCDAT <= TARGET_VALID_END_DATE`<br>`AND TARGET_STANDARD_CONCEPT IS NOT NULL` | The filter to the left should be used for records coming from the INPATIENT_SERVICES table only. When a cost record comes from the INPATIENT_ADMISSIONS table replace TSVCDAT with DISDATE. |
| DRG_SOURCE_VALUE | DRG | - | - |


<br>

<br>

### Reading from **INPATIENT_SERVICES**

![](images/image15IPSCOST.png)

<br>

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| COST_ID | - | A system generated unique identifier for each cost record | - |
| COST_EVENT_ID | - | This allows the cost to be linked to the associated record. If a PROC1 code maps to a CONCEPT_ID with a domain of 'device', then this will be the DEVICE_EXPOSURE_ID assigned in the **DEVICE_EXPOSURE** table. | - |
| COST_DOMAIN_ID | - | If a PROC1 code maps to a CONCEPT_ID with a domain of 'Device', then this will be 'Device'. | - |
| COST_TYPE_CONCEPT_ID | - | `32810` | `32810`	Claim |
| CURRENCY_CONCEPT_ID | - | `44818668` | This will be `44818668` for all rows since this is a US claims database and paid in US Dollars. |
| TOTAL_CHARGE | - | NULL | - |
| TOTAL_COST | - | NULL | - |
| TOTAL_PAID | - | PAID_BY_PAYER + PAID_BY_PATIENT + PAID_BY_PRIMARY | - |
| PAID_BY_PAYER | NETPAY | - | - |
| PAID_BY_PATIENT | - | PAID_PATIENT_COPAY +PAID_PATIENT_COINSURANCE+PAID_PATIENT+DEDUCTIBLE | - |
| PAID_PATIENT_COPAY | COPAY | - | - |
| PAID_PATIENT_COINSURANCE | COINS | - | - |
| PAID_PATIENT_DEDUCTIBLE | DEDUCT | - | - |
| PAID_BY_PRIMARY | COB | - | - |
| PAID_INGREDIENT_COST | - | NULL | - |
| PAID_DISPENSING_FEE | - | NULL | - |
| PAYER_PLAN_PERIOD_ID | - | Lookup associated PAYER_PLAN_PERIOD_ID.  Look up by PERSON_ID and PROCEDURE_DATE.  If there no match, put NULL.	There should only be one possible plan. | - |
| AMOUNT_ALLOWED | - | - |
| REVENUE_CODE_CONCEPT_ID | revcode | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br> Filters: <br>  `WHERE SOURCE_VOCABULARY_ID IN ('Revenue Code')` <br> `AND TARGET_STANDARD_CONCEPT = 'S'` | - |
| REVENUE_CODE_SOURCE_VALUE | revcode | - | - |
| DRG_CONCEPT_ID | DRG | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br>Filters:<br>`WHERE SOURCE_VOCABULARY_ID IN ('DRG')`<br>`AND SOURCE_CONCEPT_CLASS_ID IN ('MS-DRG')`<br>`AND TARGET_STANDARD_CONCEPT = 'S'`<br>`AND TSVCDAT >= TARGET_VALID_START_DATE`<br>`AND TSVCDAT <= TARGET_VALID_END_DATE`<br>`AND TARGET_STANDARD_CONCEPT IS NOT NULL` | The filter to the left should be used for records coming from the **INPATIENT_SERVICES** table only. When a cost record comes from the **INPATIENT_ADMISSIONS** table replace TSVCDAT with DISDATE. |
| DRG_SOURCE_VALUE | DRG | - | - |

<br>