---
layout: default
title: Test
nav_order: 4
parent: CPRD to STEM
grand_parent: CPRD GOLD
description: "CPRD GOLD Test table mapping to CDM STEM table"

---

# CDM Table name: stem_table

The STEM table is a staging area where CPRD source codes like Read codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

### **Reading from Test**

In the below table, only the relevant STEM fields are shown. Any fields that do not have a mapping from the CPRD Test table are not included.

Measurement and observation values will also be drawn from the ‘Test’ file.  This file contains categorical (qualifiers and/or operators) and continuous data values, units, and normal ranges for lab tests and procedures.  Test types (enttype) in the ‘test’ file have 4, 7 or 8 fields; this information (data_fields) can be found in the ‘Entity’ lookup where enttype = test.code.  The query 'CPRD_Test_Setup.sql' should be used to create an intermediate table and all mapping to the CDM will be done from this table, referred to below as test_int. Each record in the test_int will become one record in the measurement table. Please the refer to [CPRD_Test_Setup.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Test_Setup.sql) for comments and rationale for how the test_int table is created. 

Each record in the test table has an associated entity type. These entity types are mapped to measurements using the vocabulary 'JNJ_CPRD_TEST_ENT'. The records in this table also have read codes associated. To preserve all information from the record the standard *_CONCEPT_ID will be mapped from the entity type and the source values and *_SOURCE_CONCEPT_IDs will be generated from the read codes. If you are interested the counts, read codes, and concepts they would map to please see the [Test Table Appendix](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Appendix_1_Test_Table_Mapping.xlsx).

## **COVID Codes**

As discussed above, the lab tests in the CPRD Test table are given both an entity type and a read code. The entity type is typically more generic while the read code can either refer to the test that was performed or the outcome of the test. In the case of COVID-19 it is common to see something like entity type 283 (Viral Studies) with an accomanying read code of 4J3R200 (2019-nCoV not detected). The vocabulary created for the Test table ([JNJ_CPRD_TEST_ENT](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Vocab%20Updates/JNJ_CPRD_TEST_ENT.csv)) only maps the more generic entity types to concept ids since they are more reliable when determining which lab test was actually performed. In the case of COVID-19 this approach makes it difficult to pull out SARS-COV-2 specific tests. To account for this, any test record with one of the SARS-COV-2 read codes listed below should be mapped to the correct MEASUREMENT_CONCEPT_IDs as shown in the table. Two of the read codes are considered "pre-coordinated" in that both the test and the outcome of the test are contained in the code. For example the read code referenced above, 4J3R200 (2019-nCoV not detected), indicates both that a test was done for SARS-COV-2 and that it was not detected. For Test records with a pre-coordinated read code  the MEASUREMENT_CONCEPT_ID, VALUE_SOURCE_VALUE, *and* VALUE_AS_CONCEPT_ID should be assigned as detailed below.

|Read Code | Read Code Description| MEASUREMENT CONCEPT_ID|VALUE_SOURCE_VALUE| VALUE_AS CONCEPT_ID|
|----|----|----|----|---|
|4J3R200|2019-nCoV (novel coronavirus) not detected|756065|Not Detected|9190|
|4J3R100|2019-nCoV (novel coronavirus) detected|756065|Detected| 4126681|
|4J3R.00*|2019-nCoV (novel coronavirus) serology|706179|||

*This read code is not pre-coordinated. For records with this code assign VALUE_SOURCE_VALUE and VALUE_AS_CONCEPT_ID as normal.

![](images/image18.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the concept_id field.     If an entity type is mapped to concept_id 0, put the domain_id as Observation.  | |
| person_id | patid | Use patid to lookup person_id. |  |
| visit_occurrence_id | patid  eventdate  consid | Look up visit_occurrence_id based on the unique combination of patid, consid, and eventdate. | Use the Visit_occurrence_id assigned in the previous visit definition step. |
| provider_id | staffid | Use staffid to lookup provider_id in the provider table. | |
| start_datetime | eventdate |  | Set time to midnight 00:00:00 |
| concept_id | test_int.map_value | Using the test_int table, map the concatenated enttype and enttype description to a standard concept using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filters: <br><br>   WHERE source_vocabulary_id = 'JNJ_CPRD_TEST_ENT'  AND standard_concept = 'S'  AND target_invalid_reason is NULL |There are three read codes that need to be mapped differently for COVID testing. Please see above for logic. |
| source_value |  | test_int.read_code | This is the read code on the Test record |
| source_concept_id | test_int.read_code |Map the read code to a concept id using the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the read code to a source concept id with the following filters:<br><br> Where source_vocabulary_id = 'Read' <br><br>*BE CAREFUL - READ CODES ARE CASE SENSITIVE*. If there is no mapping available set source_concept_id to zero.| This maps the read code on the record to a concept id so that both the test (enttype) and read codes are mapped.|
| type_concept_id |  | Use **32856** - Lab  | |
| operator_concept_id |  | Map test_int.operator to a standard concept_id using the following logic:   <br><br> <	 as  4171756 <br> <= 	as  4171754 <br> =	as  4172703 <br> >	as  4172704 <br> >=	as  4172704  <br><br>  This can also be done by joining to the CONCEPT table where operator = concept_name and domain = 'Meas Value Operator' and standard_concept = 'S' and invalid_reason is NULL.  | |
| unit_concept_id |  | Look up test_int.unit in the CONCEPT table where vocabulary_id = 'UCUM' and standard_concept = 'S' and invalid_reason is NULL.  | Set UNIT_CONCEPT_ID = NULL when the source unit value is NULL;<br>Set UNIT_CONCEPT_ID = 0 when source unit value is not NULL but doesn't have a mapping |
| unit_source_value | test_int.unit |  |  |
| start_date | test_int.eventdate |  |    |
| end_date |  |  |  |
| range_high | test_int.range_high  |  |  |
| range_low | test_int.range_low  |  ||
| value_as_number | test_int.value_as_number |  |  |
| value_as_string |  |  | |
| value_as_concept_id |  | Lookup the values in test_int.value_as_concept_id in the CONCEPT table where domain_id=' Meas Value' and standard_concept = 'S' and invalid_concept is NULL.     | **If there is more than one concept returned, choose one**<br><br>Be sure to map the values for the COVID codes listed above|
| value_source_value | test_int.value_as_concept_id | If not NULL, put test_int.value_as_concept_id here. |  |
