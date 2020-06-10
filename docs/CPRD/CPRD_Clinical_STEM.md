---
layout: default
title: Clinical
nav_order: 1
parent: CPRD to STEM
grand_parent: CPRD
description: "CPRD Clinical table mapping to CDM STEM table"

---

# CDM Table name: stem_table

The STEM table is a staging area where CPRD source codes like Read codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

## Reading from CPRD.Clinical

In the below table, only the relevant STEM fields are shown. Any fields that do not have a mapping from the CPRD Clinical table are not included.

## **COVID Codes**

Any record with one of the SARS-COV-2 read codes listed below should be mapped to the correct MEASUREMENT_CONCEPT_IDs as shown in the table. These two read codes are considered "pre-coordinated" in that both the test and the outcome of the test are contained in the code. For example the read code 4J3R200 (2019-nCoV not detected), indicates both that a test was done for SARS-COV-2 and that the virus was not detected. For records with a pre-coordinated read code the MEASUREMENT_CONCEPT_ID, VALUE_SOURCE_VALUE, *and* VALUE_AS_CONCEPT_ID should be assigned as detailed below.

|Read Code | Read Code Description| MEASUREMENT CONCEPT_ID|VALUE_SOURCE_VALUE| VALUE_AS CONCEPT_ID|
|----|----|----|----|---|
|4J3R200|2019-nCoV (novel coronavirus) not detected|756065|Not Detected|9190|
|4J3R100|2019-nCoV (novel coronavirus) detected|756065|Detected| 4126681|

![](images/image14.png)

| Destination Field | Source field | Logic | Comment field |
| ---- | ---- | :--------: | ------ |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the CONCEPT_ID field. If a read code is mapped to CONCEPT_ID 0, put the domain_id as Observation. |  |
| person_id | patid | Use patid to lookup Person_id  |  |
| visit_occurrence_id | consid  patid  eventdate | Look up VISIT_OCCURRENCE_ID based on the unique patid, consid, and eventdate. | Use the VISIT_OCCURRENCE_ID assigned in the previous visit definition step |
| provider_id | staffid | Use the staffid to look up provider_id in the provider table. | |
| start_datetime | eventdate |  | |
| concept_id | medcode | Use the medcode to link to the medical table to find the read code. Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the read code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'Read'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>*BE CAREFUL - READ CODES ARE CASE SENSITIVE*. If there is no mapping available, set concept_id to zero. | See the query [CPRD_Clinical_Medcodes.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Clinical_Medcodes.sql) as a high-level look at the domains covered by this table and how the link to the medical table should be made. |
| source_value | medical.read_code | Use the medcode to link to the medical table to find the read code. Store read code as source_value. | |
| source_concept_id | medcode | Use the medcode to link to the medical table to find the read code.     Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the read code to a source concept id with the following filters:<br><br> Where source_vocabulary_id = 'Read' <br><br>*BE CAREFUL - READ CODES ARE CASE SENSITIVE*. If there is no mapping available set source_concept_id to zero. | |
| type_concept_id |  | Use the following type concepts based on the **domain** of the concept_id:  <br><br>  Condition - **32020** EHR encounter diagnosis. <br><br> Observation - **38000280** Observation recorded from EHR.  <br><br>Procedure - **38000275** EHR order list entry. <br><br> Measurement - **44818702** Lab result.  <br><br>Drug - **38000177** prescription written.  <br><br>If concept vocabulary_id is 'CVX' then **38000179** - Physician administered drug (identified as procedure). |  |
