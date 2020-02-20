---
layout: default
title: Med_Procedure
nav_order: 3
parent: Optum Clinformatics to STEM
grand_parent: Optum Clinformatics
description: "Optum Med_Procedure table mapping to CDM STEM table"

---

# CDM Table: STEM 

The STEM table is a staging area where source codes like ICD9 codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables.

### **Notes**
- VISIT_DETAIL must be built before STEM (refer to [VISIT_DETAIL file](VISIT_DETAIL.md))
- The **MED_PROCEDURE** table can be joined to **MEDICAL_CLAIMS** which is joined to **VISIT_DETAIL**. 
- Referential integrity is maintained with VISIT_DETAIL. 
- For every record in **STEM** there should be 1 row record in VISIT_DETAIL (n:1 join). 
- For every record in **VISIT_DETAIL** there may be 0 to n rows in **STEM**.

## **Mapping from MED_PROCEDURE**
- Take the records from **MEDICAL_CLAIMS** and join them to **MED_PROCEDURE** on 
    - clmid = clmid
    - loc_cd = loc_cd
    - fst_dt = fst_dt
    - pat_planid = pat_planid
    - This will assign each diagnosis at least one **VISIT_DETAIL** VISIT_DETAIL_ID based on the lookup created during **VISIT_DETAIL** creation. If more than one is assigned, choose one.  

- The ICD_FLAG field in **MED_PROCEDURE** defines if the claim is using ICD9 or ICD10.
    - If ICD_FLAG is 9, then use VOCABULARY_ID = 'ICD9Proc'
    - If ICD_FLAG is 10, then use VOCABULARY_ID = 'ICD10PCS'
- START_DATE is assigned to VISIT_DETAIL_START_DATE
- The VISIT_DETAIL.VISIT_OCCURRENCE_ID and VISIT_DETAIL.VISIT_DETAIL_ID are FK in STEM table.

**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
| :----: | :----: | :--------: | :------: |
| id | |Autogenerate||
| domain_id ||This should be the domain_id of the standard concept in the CONCEPT_ID field. If a code is mapped to CONCEPT_ID 0, put the domain_id as Observation.||
| person_id | patid| Use patid to lookup Person_id ||
| visit_detail_id |**VISIT_DETAIL**<br>VISIT_DETAIL_ID||
| visit_occurrence_id |**VISIT_DETAIL**<br>VISIT_OCCURRENCE_ID|Use the linking to **VISIT_DETAIL** to look up VISIT_OCCURRENCE_ID||
| provider_id |**VISIT_DETAIL**<br>PROVIDER_ID |||
| start_datetime |**VISIT_DETAIL** VISIT_DETAIL_START_DATETIME |||
| concept_id | **MED_PROCEDURE**<br>PROC|Use the SOURCE_TO_STANDARD query with the filter<br/><br/>Use the SOURCE_TO_STANDARD query<br/><br/> WHERE SOURCE_VOCABULARY_ID IN (*'ICD9Proc'* OR *'ICD10PCS'*, 'HCPCS','CPT4') AND TARGET_STANDARD_CONCEPT ='S' AND TARGET_INVALID_REASON IS NULL AND TARGET_CONCEPT_CLASS_ID NOT IN ('HCPCS Modifier','CPT4 Modifier') |If ICD_FLAG = 9 then use 'ICD9Proc', else if ICD_FLAG = 10 then use 'ICD10PCS'|
| source_value | **MED_PROCEDURE**<br>PROC|||
| source_concept_id |**MED_PROCEDURE**<br>PROC |Use the SOURCE_TO_SOURCE query with the filter<br><br>WHERE SOURCE_VOCABULARY_ID IN (*'ICD9Proc'* OR *'ICD10PCS'*) |If ICD_FLAG = 9 then use 'ICD9Proc', else if ICD_FLAG = 10 then use 'ICD10PCS'|
| type_concept_id |**MED_PROCEDURE**<br>PROC_POSITION |If PROC_POSITION = 01 then use concept_id = 44786630 (Primary condition). Use 44786631 (Secondary ProcedurE) for all others.  |||
| end_datetime | |||
