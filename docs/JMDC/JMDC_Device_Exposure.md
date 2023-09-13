---
title: "Device Exposure"
parent: JMDC
nav_order: 15
layout: default
---

# Table Name: Device Exposure

The DEVICE_EXPOSURE table will house records from JMDC.Drug that mapped to a Device domain

The field mapping is as follows: 

| Destination Field  | Source Field  | Applied Rule  | Comment  |
| --- | --- | --- | --- |
| DEVICE_EXPOSURE_ID  | -  | System-generated  |  |
| PERSON_ID  | member_id    |     Remove 'M' prefix    |          |
| DEVICE_CONCEPT_ID  | jmdc_drug_code    | Map to standard concepts using the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a> where source_vocabulary_id = 'JMDC' and domain of target_concept = 'Device'          |         |
| DEVICE_EXPOSURE_START_DATE  |date_of_prescription     month_and_year_of_medical_care    |     Use date of prescription if available, otherwise set to   start of visit.    |          |
| DEVICE_EXPOSURE_START_DATETIME  | -  | NULL  |  |
| DEVICE_EXPOSURE_END_DATE  |    |  |  |
| DEVICE_EXPOSURE_END_DATETIME  | -  | NULL  |  |
| DEVICE_TYPE_CONCEPT_ID |  type_of_claim    |     Pharmacy, Outpatient: 32869 (Pharmacy claim)  Inpatient or DPC: 32818   (EHR administration record)    |          |
| UNIQUE_DEVICE_ID  | -  | NULL  |  |
| PROVIDER_ID  |  medical_facility_id    |          |     Use the dummy providers we created per institution.    |
| VISIT_OCCURRENCE_ID  |      claim_id    |     Remove ‘C’ prefix    |          |
| DEVICE_SOURCE_VALUE  | jmdc_drug_code    |          |          |
| DEVICE_SOURCE_CONCEPT_ID  | jmdc_drug_code       |    Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Source Query</a> where source_vocabulary_id = 'JMDC' and domain of target_concept = 'Device'          |         |

## Change Log:

### 10-Aug-2023 
Table added

