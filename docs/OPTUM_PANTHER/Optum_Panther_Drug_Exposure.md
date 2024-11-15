---
layout: default
title: Optum EHR Drug Exposure 
nav_order: 8
parent: Optum EHR
description: "Drug Exposure End Date Imputation"

---

# Optum EHR Drug Exposure End Date Imputation

Due to the nature of EHR data most days_supply fields are input as zero. Martijn developed a method during the LEGEND-Hypertension study that will impute the value and updated the DRUG_EXPOSURE_END_DATE.

- Take the most frequent non-zero exposure length per drug_concept_id as the default, if that frequency is greater than 10. 
- For all drug exposures with zero length use the default length defined in step 1 and update the DRUG_EXPOSURE_END_DATE using the formula DRUG_EXPOSURE_END_DATE = DRUG_EXPOSURE_START_DATE + *imputed DAYS_SUPPLY* - 1
  - This is true unless the DAYS_SUPPLY is greater than 365 days. In that case, the DRUG_EXPOSURE_END_DATE is reverted back to equal the DRUG_EXPOSURE_START_DATE to handle implausible values and prevent them from making the DRUG_ERAs too long.

Code he uses to do this: https://github.com/schuemie/MethodsLibraryPleEvaluation/blob/master/inst/sql/sql_server/ExposureLengthImputation.sql 

We apply this imputation strategy after data has been moved to the DRUG_EXPOSURE table from the STEM table as detailed below. Once completed the DRUG_ERA logic is run to create DRUG_ERAs using the imputed dates.

<ins>**Optum EHR Days Supply Filtering**</ins> <br>
Some records from source tables for cdm.DRUG_EXPOSURE have very high days_supply values, which are likely inaccurate (most states in the US require prescriptions to be renewed at least annually). 
Reocrds with days_supply > 365 are excluded from cdm.DRUG_EXPOSURE.

## Table name: drug_exposure

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id | id |  |  |
| person_id | person_id |  |  |
| drug_concept_id | concept_id |  |  |
| drug_exposure_start_date | start_date |  |  |
| drug_exposure_start_datetime | start_datetime |  |  |
| drug_exposure_end_date | end_date | If zero, apply imputation strategy |  |
| drug_exposure_end_datetime | end_datetime |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id | type_concept_id |  |  |
| stop_reason | stop_reason |  |  |
| refills | refills |  |  |
| quantity | quantity | Allowed number of refills up to 24. if this number is higher, set drug_expusure.refills = NULL |  |
| days_supply | days_supply |  |  |
| sig | sig |  |  |
| route_concept_id | route_concept_id |  |  |
| lot_number | lot_number |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| drug_source_value | source_value |  |  |
| drug_source_concept_id | source_concept_id |  |  |
| route_source_value | route_source_value |  |  |
| dose_unit_source_value | dose_unit_source_value |  |  |

### Change log

- 12-Dec-2023
Set max allowed refills up to 24
