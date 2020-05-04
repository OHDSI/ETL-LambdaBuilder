---
layout: default
title: Test
nav_order: 4
parent: CPRD to STEM
grand_parent: CPRD
description: "CPRD Test table mapping to CDM STEM table"

---

# CDM Table name: stem_table

The STEM table is a staging area where CPRD source codes like Read codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

### Reading from test

In the below table, only the relevant STEM fields are shown. Any fields that do not have a mapping from the CPRD Clinical table are not included.

Measurement and observation values will also be drawn from the ‘Test’ file.  This file contains categorical (qualifiers and/or operators) and continuous data values, units, and normal ranges for lab tests and procedures.  Test types (enttype) in the ‘test’ file have 4, 7 or 8 fields; this information (data_fields) can be found in the ‘Entity’ lookup where enttype = test.code.  The query 'CPRD_Test_Setup.sql' should be used to create an intermediate table and all mapping to the CDM will be done from this table, referred to below as test_int. Each record in the test_int will become one record in the measurement table. Please the refer to [CPRD_Test_Setup.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Test_Setup.sql) for comments and rationale for how the test_int table is created. 

Each record in the test table has an associated entity type. These entity types are mapped to measurements using the vocabulary 'JNJ_CPRD_TEST_ENT'. The records in this table also have read codes associated. If you are interested the counts, read codes, and concepts they would map to are available in the [Test Table Appendix](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Appendix_1_Test_Table_Mapping.xlsx).

![](images/image18.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the concept_id field.     If a read code is mapped to concept_id 0, put the domain_id as Observation.  | |
| person_id | patid | Use patid to lookup person_id. |  |
| visit_occurrence_id | patid  eventdate  consid | Look up visit_occurrence_id based on the unique combination of patid, consid, and eventdate. | Use the Visit_occurrence_id assigned in the previous visit definition step. |
| provider_id | staffid | Use staffid to lookup provider_id in the provider table. | |
| start_datetime | eventdate |  | Set time to midnight 00:00:00 |
| concept_id | read_code | Using the test_int table, map the enttype to a standard concept using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filters: <br><br>   WHERE source_vocabulary_id = 'JNJ_CPRD_TEST_ENT'  AND standard_concept = 'S'  AND target_invalid_reason is NULL | |
| source_value |  | Concatenate test_int.code + '-' + test_int.description |  |
| source_concept_id | 0 | | |
| type_concept_id |  | Use the following type concepts based on the **domain** of the concept_id:  <br><br>  Condition - **32020** EHR encounter diagnosis. <br><br> Observation - **38000280** Observation recorded from EHR.  <br><br>Procedure - **38000275** EHR order list entry. <br><br> Measurement - **44818702** Lab result.  <br><br>Drug - **38000177** prescription written.  <br><br>If concept vocabulary_id is 'CVX' then **38000179** - Physician administered drug (identified as procedure).  | |
| operator_concept_id |  | Map test_int.operator to a standard concept_id using the following logic:   <br><br> <	 as  4171756 <br> <= 	as  4171754 <br> =	as  4172703 <br> >	as  4172704 <br> >=	as  4172704  <br><br>  This can also be done by joining to the CONCEPT table where operator = concept_name and domain = 'Meas Value Operator' and standard_concept = 'S' and invalid_reason is NULL.  | |
| unit_concept_id |  | Look up test_int.unit in the CONCEPT table where vocabulary_id = 'UCUM' and standard_concept = 'S' and invalid_reason is NULL.  |  |
| unit_source_value | test_int.unit |  |  |
| start_date | test_int.eventdate |  |    |
| end_date |  |  |  |
| range_high | Test_int.range_high  |  |  |
| range_low | Test_int.range_low  |  ||
| value_as_number | Test_int.value_as_number |  |  |
| value_as_string |  |  | |
| value_as_concept_id |  | Lookup the values in test_int.value_as_concept_id in the CONCEPT table where domain_id=' Meas Value' and vocabulary_id=' LOINC' and standard_concept = 'S' and invalid_concept is NULL.     |  |
| value_source_value | test_int.value_as_concept_id | If not NULL, put test_int.value_as_concept_id here. |  |
