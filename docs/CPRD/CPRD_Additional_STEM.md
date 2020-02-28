---
layout: default
title: Additional
nav_order: 5
parent: CPRD to STEM
grand_parent: CPRD
description: "CPRD Additional table mapping to CDM STEM table"

---

# CDM Table name: stem_table

The STEM table is a staging area where CPRD source codes like Read codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

## Reading from CPRD.Additional

In the below table, only the relevant STEM fields are shown. Any fields that do not have a mapping from the CPRD Clinical table are not included.

Observation values will also be drawn from the ‘Additional’ file.  This file contains categorical and continuous data values, units, dates, medcodes (conditions), and prodcodes (drugs) pertaining to diseases including allergy, asthma, hypertension, epilepsy and diabetes and lifestyle data (smoking, alcohol use, diet and exercise), as well as child health surveillance, death, elder health care, examination, immunization, maternity, pathology and blood group information.  There is also score/scale data (e.g. The Patient Health Questionnaire (PHQ-9) which measures severity of depression) in the ‘Additional’ file which will be captured. The query [CPRD_Additional_Setup.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Additional_Setup.sql) should be used to create an intermediate table and all mapping to the CDM will be done from this table, referred to below as add_int. Each record in the add_int table will become between one and seven records in the measurement table. Please refer to [CPRD_Additional_Setup.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Additional_Setup.sql) for comments and rationale for how the add_int table is created. 

To map the values in the additional table to standard concepts concatenate the fields add_int.enttype + '-' + add_int.category + '-' + add_int.description + '-' + add_int.data. This will retain the information from the entity table about the record and the specific data field being mapped. Please refer to appendix 2 which is a table showing the enttypes and data_field descriptions from the additional table and counts of each.

These concatenated source values will then be mapped to standard concepts using the mapping file created in Usagi. The source_vocabulary_id is 'JNJ_CPRD_ADD_ENTTYPE' and the query used to prepare the data for mapping is [CPRD_Additional_Descriptions.sql.](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Vocab%20Updates/CPRD_Additional_Descriptions.sql)


![](images/image19.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the concept_id field. If a read code is mapped to concept_id 0, put the domain_id as Observation. |  |
| person_id | patid | Use patid to lookup Person_id |  |
| visit_occurrence_id | patid  adid | Look up visit_occurrence_id based on the unique combination of patid, consid, and eventdate. To find consid and eventdate use adid to link back to the clinical table. | Use the Visit_occurrence_id assigned in the previous visit definition step |
| provider_id | staffid | Map staffid to provider_id |  |
| start_datetime |  | Join back to the Clinical table using adid and set the eventdate as the start_datetime and set the time to midnight. |  |
| concept_id |  | Map the source value (add_int.enttype + '-' + add_int.category + '-' + add_int.description + '-' + add_int.data) to a concept using the [SOURCE_TO_STANDARD_QUERY](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) with the filters: <br><br>   WHERE source_vocabulary_id = 'JNJ_CPRD_ADD_ENTTYPE'  AND standard_concept = 'S'  AND invalid_concept is NULL  | |
| source_value |  | Concatenate add_int.enttype + '-' + add_int.category + '-' + add_int.description + '-' + add_int.data. |  This will retain the information from the entity table about the record and the specific data field being mapped. Please refer to [appendix 2](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Appendix_2_Additional_Table_Descriptions.xlsx) which is a table showing the enttypes and data_field descriptions from the additional table and counts of each. |
| source_concept_id |  | 0 | |
| type_concept_id |  | Use the following type concepts based on the **domain** of the concept_id:  <br><br>  Condition - **32020** EHR encounter diagnosis. <br><br> Observation - **38000280** Observation recorded from EHR.  <br><br>Procedure - **38000275** EHR order list entry. <br><br> Measurement - **44818702** Lab result.  <br><br>Drug - **38000177** prescription written.  <br><br>If concept vocabulary_id is 'CVX' then **38000179** - Physician administered drug (identified as procedure). |  
| unit_concept_id |  | Look up add_int.unit_source_value in the CONCEPT table where vocabulary_id = 'UCUM' and standard_concept = 'S' and invalid_reason is NULL. |  |
| unit_source_value | add_int.unit_source_value |  | |
| start_date | add_int.eventdate |  | For the additional table, the adid is used to link back to the clinical table to get the eventdate. |
| end_date | start_date |  |  |
| value_as_number | add_int.value_as_number |   | |
| value_as_string | add_int.value_as_string  | |  |
| value_as_concept_id |  |  | If the last part of the source value says 'Read code for condition' then map the code in add_int.value_as_string to a standard concept using the SOURCE_TO_STANDARD query with the filters:<br><br>    WHERE source_vocabulary_id = 'Read'  AND standard_concept = 'S'  AND invalid_concept is NULL  <br><br>   If the last part of the source value says 'Drug code' then map the code in add_int.value_as_string to a standard concept using the SOURCE_TO_STANDARD query with the filters:  <br><br>   WHERE source_vocabulary_id = 'Gemscript'  AND standard_concept = 'S'  AND invalid_concept is NULL  <br><br>   Otherwise, if the value in add_int.qualifier_source_value is not null then lookup the values in add_int.qualifier_source_value in the CONCEPT table where domain_id=' Meas Value' and vocabulary_id=' LOINC' and standard_concept = 'S' and invalid_concept is NULL. |
| value_source_value | If not NULL, put add_int.qualifier_source_value here. 
