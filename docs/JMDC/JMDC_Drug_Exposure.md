---
layout: default
title: Drug_Exposure
nav_order: 12
parent: JMDC
description: "Drug_Exposure mapping from JMDC drug table"

---

# CDM Table name: DRUG_EXPOSURE

## Reading from JMDC.Drug

![](images/drug_drug.png)

|     Destination Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     drug_exposure_id    |          |          |          |
|     visit_occurrence_id    |     claim_id    |     Remove ‘C’ prefix    |          |
|     person_id    |     member_id    |     Remove 'M' prefix    |          |
|     drug_type_concept_id    |     type_of_claim    |     Pharmacy, Outpatient: 38000175 (Prescription dispensed in   pharmacy)  Inpatient or DPC: 38000180   (Inpatient administration)    |          |
|     drug_exposure_start_date    |     date_of_prescription     month_and_year_of_medical_care    |     Use date of prescription if available, otherwise set to   start of visit.    |          |
|     drug_exposure_end_date    |     month_and_year_of_medical_care     date_of_prescription     administered_days    |     Drug_exposure_end_date = drug_exposure_start_date +   min(administered_days,180)    |          |
|     days_supply    |     administered_days    |     If value > 180, set to 180 (occurs in 74 prescriptions)    |          |
|     drug_concept_id    |     jmdc_drug_code    |          |     Look up in drug mapping table    |
|     drug_source_value    |     jmdc_drug_code    |          |          |
|     sig    |     as_needed_medication_flag     prescribed_amount_per_day     administered_amount     unit_of_administered_amount    |     <prescribed_amount_per_day>   <administered_amount> per day (<as_needed_medication_flag     >?as needed, <administered_amount> <   unit_of_administered_amount> total                            |     Combine the four fields to create a sig string:          |
|     provider_id    |     medical_facility_id    |          |     Use the dummy providers we created per institution.    |
|     quantity    |          |          |          |
|     dose_unit_source_value    |          |          |          |
|     drug_source_concept_id    |          |          |          |
|     drug_exposure_end_datetime    |          |          |          |
|     verbatim_end_date    |          |          |          |
|     stop_reason    |          |          |          |
|     refills    |          |          |          |
|     drug_exposure_start_datetime    |          |          |          |
|     route_concept_id    |          |          |          |
|     lot_number    |          |          |          |
|     visit_detail_id    |          |          |          |
|     route_source_value    |          |          |          |