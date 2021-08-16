---
layout: default
title: Procedure_Occurrence
nav_order: 9
parent: JMDC
description: "Procedure_Occurrence mapping from JMDC diagnosis and procedure tables"

---

# CDM Table name: PROCEDURE_OCCURRENCE

## Reading from JMDC.Diagnosis
When an ICD10 code in the diagnosis table maps to a concept in the Procedure domain a record should be created in the procedure_occurrence table.

![](images/PROC_DIAG.png) 

|     Destination Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     procedure_occurrence_id    |          |          |          |
|     visit_occurrence_id    |     claim_id    |     Remove ‘C’ prefix    |          |
|     person_id    |     member_id    |     Remove 'M' prefix    |          |
|     procedure_type_concept_id    |     type_of_claim    |     Outpatient: **32859** (Outpatient claim)    InPatient or DPC: **32853** (Inpatient claim)      |          |
|     procedure_date    |     month_and_year_of_medical_care    |     Use visit_start_date    |          |
|     procedure_concept_id    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table, and   use vocab to map to standard concept. Remove '-' prior to mapping (e.g.   'I50-' should map to 'I50'), and ignore period (e.g. 'I500' should map to   'I50.0')    |
|     procedure_source_concept_id    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table, and   use vocab to map to source concept. Remove '-' prior to mapping (e.g. 'I50-'   should map to 'I50'), and ignore period (e.g. 'I500' should map to 'I50.0')    |
|     procedure_source_value    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table    |
|     provider_id    |     medical_facility_id    |          |     Use dummy provider corresponding to the institute    |
|     procedure_datetime    |          |          |          |
|     modifier_concept_id    |          |          |          |
|     quantity    |          |          |          |
|     visit_detail_id    |          |          |          |
|     modifier_source_value    |          |          |          |

## Reading from JMDC.Procedure

![](images/PROC_proc.png) 

|     Destination Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     procedure_occurrence_id    |          |          |          |
|     visit_occurrence_id    |     claim_id    |     Remove ‘C’ prefix    |          |
|     person_id    |     member_id    |     Remove 'M' prefix    |          |
|     procedure_type_concept_id    |     type_of_claim    |     Outpatient: **32859** (Outpatient claim)    InPatient or DPC: **32853** (Inpatient claim)     |          |
|     procedure_date    |     month_and_year_of_medical_care     date_of_procedure    |     Use date of procedure when populated, otherwise use start   of visit    |          |
|     procedure_concept_id    |     standardized_procedure_id    |          |          |
|     procedure_source_concept_id    |     standardized_procedure_id    |          |          |
|     procedure_source_value    |     standardized_procedure_id    |          |          |
|     provider_id    |     medical_facility_id    |          |     Use dummy provider corresponding to the institute    |
|     procedure_datetime    |          |          |          |
|     modifier_concept_id    |          |          |          |
|     quantity    |          |          |          |
|     visit_detail_id    |          |          |          |
|     modifier_source_value    |          |          |          |