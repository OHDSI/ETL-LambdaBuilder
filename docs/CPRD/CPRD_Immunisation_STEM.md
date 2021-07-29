---
layout: default
title: Immunisation
nav_order: 3
parent: CPRD to STEM
grand_parent: CPRD
description: "CPRD Immunisation table mapping to CDM STEM table"

---

# CDM Table name: stem_table

The STEM table is a staging area where CPRD source codes like Read codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

## Reading from CPRD.Immunisation

In the below table, only the relevant STEM fields are shown. Any fields that do not have a mapping from the CPRD Clinical table are not included.

![](images/image17.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| id |  |  | Autogenerate |
| domain_id |  | This should be the domain_id of the standard concept in the concept_id field.     If a read code is mapped to concept_id 0, put the domain_id as Observation. |  |
| person_id | patid | Use patid to lookup Person_id |  |
| visit_occurrence_id | patid  eventdate  consid | Look up visit_occurrence_id based on the unique patid, consid, and eventdate | Use the Visit_occurrence_id assigned in the previous visit definition step |
| provider_id | staffid | Use staffid to look up provider id in the provider table | |
| start_datetime | eventdate |  |  |
| concept_id | medcode | Use the medcode to link to the medical table to find the read code. Use the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query to map the read code to standard concept(s) with the following filters: <br> <br>  Where source_vocabulary_id = 'Read'  and Target_standard_concept = 'S'  and target_invalid_reason is NULL<br><br>*BE CAREFUL - READ CODES ARE CASE SENSITIVE*. If there is no mapping available, set concept_id to zero.  | See the query [CPRD_Immunisation_Medcodes.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Queries/CPRD_Immunisation_Medcodes.sql) as a high-level look at the domains covered by this table and how the link to the medical table should be made. |
| source_value | medical.read_code | Use the medcode to link to the medical table to find the read code. Store read code as source_value. |  |
| source_concept_id | medcode | Use the medcode to link to the medical table to find the read code.     Use the [SOURCE_TO_SOURCE](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_SOURCE.sql) query to map the read code to a source concept id with the following filters:<br><br> Where source_vocabulary_id = 'Read' <br><br>*BE CAREFUL - READ CODES ARE CASE SENSITIVE*. If there is no mapping available set source_concept_id to zero. | |
| type_concept_id |  | Use **32827** - EHR encounter record |  |
