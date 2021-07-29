---
layout: default
title: Measurement
nav_order: 10
parent: JMDC
description: "Measurement mapping from JMDC diagnosis table"

---

# CDM Table name: MEASUREMENT

When an ICD10 code in the diagnosis table maps to a concept in the Measurement domain a record should be created in the measurement table.

## Reading from JMDC.Diagnosis

![](images/meas_diag.png)

|     Destination Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     measurement_id    |          |          |          |
|     visit_occurrence_id    |     claim_id    |     Remove ‘C’ prefix    |          |
|     person_id    |     member_id    |     Remove 'M' prefix    |          |
|     measurement_type_concept_id    |     type_of_claim    |     Outpatient: **32859** (Outpatient claim)    InPatient or DPC: **32853** (Inpatient claim)     |     Coming from the **annual_health_checkup** table set to 32836 (EHR physical examination)    |
|     measurement_date    |     month_and_year_of_medical_care    |     Use derived visit_start_date    |          |
|     measurement_concept_id    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table, and   use vocab to map to standard concept.    |
|     measurement_source_value    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table    |
|     measurement_source_concept_id    |     standard_disease_code    |          |     Lookup icd10_level4_code in diagnosis_master table, and   use vocab to map to source concept.    |
|     provider_id    |     medical_facility_id    |     Use dummy provider corresponding to the institute    |     Use dummy provider corresponding to the institute    |
|     measurement_datetime    |          |          |          |
|     operator_concept_id    |          |          |          |
|     value_as_number    |          |          |          |
|     value_as_concept_id    |          |          |     From Health checkups: from mapping table. Else 4181412   (Present)    |
|     unit_concept_id    |          |          |     From mapping table    |
|     range_low    |          |          |     From Health checkups: take from reference file    |
|     range_high    |          |          |     From Health checkups: take from reference file    |
|     visit_detail_id    |          |          |          |
|     unit_source_value    |          |          |     From mapping table    |