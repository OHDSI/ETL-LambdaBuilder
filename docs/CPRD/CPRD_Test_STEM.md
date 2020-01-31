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

Each record in the test table has an associated read code. It was decided that the read codes should be mapped to standard concepts instead of mapping the individual enttypes. The reasoning behind this choice was based on the distribution of the read codes associated with each enttype which can be found in appendix 1. While some of the read codes map to conditions, the majority map to observations or measurements. What this means is that the generic enttype 290 which stands for 'Immunoglobulin' can be made much more specific since the read codes point to IgA, IgG, or IgM. At this point the mapping will be left as-is, meaning that the codes that map to conditions will stay that way for now. When choosing to use records from the test table in an analysis please refer back to appendix 1 to determine how many read codes corresponding to a certain enttype map to a domain other than a measurement or observation. At the point when a use case is determined, those read codes and enttypes can be reexamined and their mapping updated. All records from the test table will retain the pattern 'enttype-description-readcode' in the source_value field of the table they end up in so it is possible to find them and group by enttype if so desired.

![](images/image18.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the concept_id field.     If a read code is mapped to concept_id 0, put the domain_id as Observation.  | |
| person_id | patid | Use patid to lookup person_id. |  |
| visit_occurrence_id | patid  eventdate  consid | Look up visit_occurrence_id based on the unique combination of patid, consid, and eventdate. | Use the Visit_occurrence_id assigned in the previous visit definition step. |
| provider_id | staffid | Use staffid to lookup provider_id in the provider table. | |
| start_datetime | eventdate |  | Set time to midnight 00:00:00 |
| concept_id | read_code | Using the test_int table, map the read_code to a standard concept using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the filters: <br><br>   WHERE source_vocabulary_id = 'Read'  AND standard_concept = 'S'  AND invalid_concept is NULL | |
| source_value |  | Concatenate test_int.code + '-' + test_int.description + '-' + test_int.read_code.  | This will retain the read_code as well as the enttype. Some of the read codes map to conditions so this will help to identify the records coming from the test table. Please refer to [appendix 1](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Appendix_1_Test_Table_Mapping.xlsx) which is a table showing the mapping of read codes in the test table to concepts, domains, and counts of each. |
| source_concept_id | read_code | Map test_int.read_code to a source_concept_id using the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query with the filter: <br><br>   WHERE source_vocabulary_id = 'Read'  | |
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
