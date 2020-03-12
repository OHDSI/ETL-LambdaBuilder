---
layout: default
title: Lab_Results
nav_order: 5
parent: Optum Clinformatics to STEM
grand_parent: Optum Clinformatics
description: "Optum Lab_Results table mapping to CDM STEM table"

---

# CDM Table: STEM 

The STEM table is a staging area where source codes like ICD9 codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables.

### **Notes**
- VISIT_DETAIL must be built before STEM (refer to [VISIT_DETAIL file](VISIT_DETAIL.md))
- The **MED_PROCEDURE** table can be joined to **MEDICAL_CLAIMS** which is joined to **VISIT_DETAIL**. 
- Referential integrity is maintained with VISIT_DETAIL. 
- For every record in **STEM** there should be 1 row record in VISIT_DETAIL (n:1 join). 
- For every record in **VISIT_DETAIL** there may be 0 to n rows in **STEM**.

## **Mapping from LAB_RESULTS**
- Take the records from **LAB_RESULTS** and join them to **MEDICAL_CLAIMS** on
        - patid = patid
        - pat_planid = pat_planid
        - labclmid = clmid
    - This will assign each lab result at least one **VISIT_DETAIL** VISIT_DETAIL_ID based on the lookup created during VISIT_DETAIL creation. If more than one is assigned, choose one.  
        - Some records in **LAB_RESULTS** do not have a labclmid. If this is the case **PROCEDURE_OCCURRENCE** VISIT_DETAIL_ID and VISIT_OCCURRENCE_ID should be left blank.

- START_DATE is assigned to VISIT_DETAIL_START_DATE 
- The VISIT_DETAIL.VISIT_OCCURRENCE_ID and VISIT_DETAIL.VISIT_DETAIL_ID are FK in STEM table.

![](images/image20.png)

|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
| :----: | :----: | :--------: | :------: |
| id |  |Autogenerate||
| domain_id ||This should be the domain_id of the standard concept in the CONCEPT_ID field. If a code is mapped to CONCEPT_ID 0, put the domain_id as Observation.||
| person_id | **VISIT_DETAIL** PERSON_ID<br><br>**LAB_RESULT** PATID| Use patid to lookup Person_id ||
| visit_detail_id |**VISIT_DETAIL**<br>VISIT_DETAIL_ID|||
| visit_occurrence_id |**VISIT_DETAIL**<br>VISIT_OCCURRENCE_ID|Use the linking to **VISIT_DETAIL** to look up VISIT_OCCURRENCE_ID||
| provider_id |**VISIT_DETAIL**<br>PROVIDER_ID |||
| start_datetime |**VISIT_DETAIL** VISIT_DETAIL_START_DATETIME |||
| concept_id | LOINC_CD, PROC_CD|Use the SOURCE_TO_STANDARD query with the filter<br/><br/>**LOINC_CD**<br> WHERE SOURCE_VOCABULARY_ID IN ('LOINC') AND TARGET_STANDARD_CONCEPT ='S' AND TARGET_INVALID_REASON IS NULL <br/><br/>**PROC_CD**<br> WHERE SOURCE_VOCABULARY_ID IN ('HCPCS','CPT4') AND TARGET_STANDARD_CONCEPT ='S' AND TARGET_INVALID_REASON IS NULL AND TARGET_CONCEPT_CLASS_ID NOT IN ('HCPCS Modifier','CPT4 Modifier')| Start with LOINC_CD, if it does not have a mapping then try to map the PROC_CD. If the PROC_CD does not have a mapping then set concept_id to 0|
| source_value |LOINC_CD, PROC_CD|||
| source_concept_id |LOINC_CD, PROC_CD|Use the SOURCE_TO_SOURCE query with the filter<br/><br/>**LOINC_CD**<br> WHERE SOURCE_VOCABULARY_ID IN ('LOINC') <br/><br/>**PROC_CD**<br> WHERE SOURCE_VOCABULARY_ID IN ('HCPCS','CPT4') |Put the SOURCE_CONCEPT_ID of the either the LOINC_CD or PROC_CD that was used to map the standard concept_id.|
| type_concept_id |Set to 44818702 (Lab Result)|||  
| operator_concept_id | |||
| unit_concept_id | **LAB_RESULTS** RSLT_UNIT_NM |Use the SOURCE_TO_STANDARD query with the filter <br><br>Where SOURCE_VOCABULARY_ID = 'UCUM' AND TARGET_STANDARD_CONCEPT = 'S' AND TARGET_INVALID_REASON IS NULL|If there is no mapping to a standard concept then set to 0||
| unit_source_value |**LAB_RESULTS** RSLT_UNIT_NM |||
| start_date | **VISIT_DETAIL** VISIT_DETAIL_START_DATE||| 
| end_date |  |||
| range_high |**LAB_RESULTS** HI_NRML ||| 
| range_low | **LAB_RESULTS** LOW_NRML ||| 
| value_as_number | **LAB_RESULTS** RSLT_NBR |||
| value_as_string | **LAB_RESULTS** RSLT_TXT |||
| value_as_concept_id | |||
| value_source_value | |||
| end_datetime | |||
| verbatim_end_date |  |||
| days_supply | |||
| dose_unit_source_value ||||
| lot_number | |||
|MODIFIER_CONCEPT_ID|| | |
| modifier_source_value | |||
| quantity | |||
| refills | |||
| route_concept_id | |||
| route_source_value | |||
| sig |  |||
| stop_reason | |||
| unique_device_id | |||
| anatomic_site_concept_id | |||
| disease_status_concept_id |  |||
| specimen_source_id ||||
| anatomic_site_source_value | |||
| disease_status_source_value | |||
| condition_status_concept_id | |||
| condition_status_source_value | |||