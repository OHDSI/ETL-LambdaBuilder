---
layout: default
title: Optum EHR to STEM
nav_order: 7
parent: Optum EHR
has_children: true
description: "Stem table description"
---

# CDM Table name: STEM

The STEM table is a staging area where Optum EHR source codes like ICD10CM codes will first be mapped to concept_ids. The STEM table itself is an amalgamation of the OMOP event tables to facilitate record movement. This means that all fields present across the OMOP event tables are present in the STEM table. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to. Please see the STEM -> CDM mapping files for a description of which STEM fields move to which STEM tables. 

This logic is reiterated from the PERSON table page but is put here as well for clarity:

The Optum EHR Patient table contains an indicator that denotes whether the paient is part of an integrated delivery network, which means that there is a higher likelihood of complete capture of medical events. An integrated delivery network is an organization or group of hospitals and health care providers that aligns local facilities, managing them as one. To keep track of this, for each person in the Patient table with **idn_indicator** = 1, create a record in the OBSERVATION table where OBSERVATION_DATE = OBSERVATION_PERIOD_START_DATE, OBSERVATION_CONCEPT_ID = 44804235 and VALUE_AS_NUMBER = 1, OBSERVATION_SOURCE_VALUE = 'IDN' and OBSERVATION_TYPE_CONCEPT_ID = 32817 (EHR). 

Dataset contains dates beore 2007 year, which are mistakes, since the start of the dataset is 01-Jan-2007. Events with these dates are removed from the CDM.


**Fields in the STEM table**

| Field | 
| --- | 
| id | 
| domain_id |  
| person_id | 
| visit_occurrence_id | 
| visit_detail_id |
| provider_id | 
| start_datetime | 
| concept_id | 
| source_value |
| source_concept_id | 
| type_concept_id |  
| operator_concept_id | 
| unit_concept_id |  
| unit_source_value | 
| start_date |  
| end_date |  
| range_high |  
| range_low | 
| value_as_number | 
| value_as_string | 
| value_as_concept_id | 
| value_source_value | 
| end_datetime | 
| verbatim_end_date |  
| days_supply | 
| dose_unit_source_value | 
| lot_number | 
| modifier_concept_id |  
| modifier_concept_id | 
| modifier_source_value | 
| quantity | 
| refills | 
| route_concept_id | 
| route_source_value | 
| sig |  
| stop_reason | 
| unique_device_id | 
| anatomic_site_concept_id | 
| disease_status_concept_id |  
| specimen_source_id |
| anatomic_site_source_value | 
| disease_status_source_value | 
| condition_status_concept_id | 
| condition_status_source_value |  

### Change log

- 07-Aug-2023
Cut of dates before 01-Jan-2007 rule added