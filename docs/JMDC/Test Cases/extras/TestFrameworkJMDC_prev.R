initFramework <- function() {
  frameworkContext <- new.env(parent = globalenv())
  class(frameworkContext) <- 'frameworkContext'
  assign('frameworkContext', frameworkContext, envir = globalenv())
  frameworkContext$inserts <- list()
  frameworkContext$expects <- list()
  frameworkContext$testId <- -1
  frameworkContext$testDescription <- ""
  frameworkContext$defaultValues <- new.env(parent = frameworkContext)

  defaults <- list()
  defaults$member_id <- ''
  defaults$health_checkup_id <- ''
  defaults$date_of_health_checkup <- '2014-04-01'
  defaults$bmi <- '21.1'
  defaults$abdominal_circumference <- ''
  defaults$presence_of_medical_history <- '2'
  defaults$presence_of_subjective_symptoms <- '2'
  defaults$presence_of_objective_symptoms <- '2'
  defaults$systolic_bp <- '120'
  defaults$diastolic_bp <- '70'
  defaults$time_of_blood_collection <- '2'
  defaults$triglyceride <- ''
  defaults$hdl_cholesterol <- ''
  defaults$ldl_cholesterol <- ''
  defaults$ast <- '18'
  defaults$alt <- '15'
  defaults$g_gt <- ''
  defaults$fasting_blood_sugar <- ''
  defaults$casual_blood_sugar <- ''
  defaults$hba1c <- ''
  defaults$urinary_sugar <- '1'
  defaults$uric_protein_qualitative <- '1'
  defaults$hct <- ''
  defaults$hemoglobin_content <- ''
  defaults$rbc_count <- ''
  defaults$ecg <- ''
  defaults$fundus_examination_keith_wagener_classification <- ''
  defaults$fundus_examination_scheie_classification_h <- ''
  defaults$fundus_examination_scheie_classification_s <- ''
  defaults$fundus_examination_scott_classification <- ''
  defaults$smoking_habit <- '2'
  defaults$eating1_fast_eating <- '2'
  defaults$eating2_before_bedtime <- '2'
  defaults$eating3_late_evening_snack <- ''
  defaults$eating3_snack <- ''
  defaults$eating_habit <- '2'
  defaults$drinking_habit <- '3'
  defaults$amount_drinking <- '1'
  defaults$sleep <- '1'
  defaults$drug1_hypertension <- '2'
  defaults$drug2_diabetes <- '2'
  defaults$drug3_hyperlipidemia <- '2'
  defaults$medical_history1_cerebrovascular <- '2'
  defaults$medical_history2_cardiovascular <- '2'
  defaults$medical_history3_renal <- '2'
  defaults$anemia <- '2'
  defaults$change_of_weight_from_age_of_twenty <- '2'
  defaults$exercise_habit <- '2'
  defaults$physical_activity <- '2'
  defaults$walking_speed <- '2'
  defaults$change_of_weight_in_a_year <- ''
  defaults$mastication <- '1'
  defaults$lifestyle_modification <- '2'
  defaults$request_for_health_guidance <- '2'
  defaults$serum_uric_acid <- ''
  defaults$serum_creatinine <- ''
  defaults$total_cholesterol <- ''
  assign('annual_health_checkup', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- ''
  defaults$claim_id <- ''
  defaults$type_of_claim <- 'Outpatient'
  defaults$month_and_year_of_medical_care <- '202303'
  defaults$paper_claim_flag <- ''
  defaults$medical_facility_id <- 'F0054756'
  defaults$large_classification_of_department <- ''
  defaults$medium_classification_of_department <- ''
  defaults$department_on_claim_name <- ''
  defaults$days_of_medical_care <- '1'
  defaults$admission_date <- ''
  defaults$discharge_date <- ''
  defaults$total_point <- '350'
  assign('claim', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$version_id <- ''
  defaults$version_date <- ''
  assign('version', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$standardized_material_code <- '728490000'
  defaults$standardized_material_version <- '202004'
  defaults$standardized_material_name <- 'Wound dressing material for skin defect (for wounds reaching subcutaneous tissue/standard type)'
  defaults$unit <- ''
  defaults$material_category_large_classification_name <- 'Cardiac/vascular material'
  defaults$material_category_medium_classification_name <- 'Film'
  defaults$material_code <- 'Z133'
  assign('material_master', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$jmdc_drug_code <- ''
  defaults$drug_name <- 'Deleted NHI price'
  defaults$standardized_unit <- ''
  defaults$atc_level1_code <- 'A'
  defaults$atc_level1_name <- 'ALIMENTARY TRACT AND METABOLISM'
  defaults$atc_level2_code <- 'V03'
  defaults$atc_level2_name <- 'ALL OTHER THERAPEUTIC PRODUCTS'
  defaults$atc_level3_code <- 'V03B'
  defaults$atc_level3_name <- 'KANPO AND CHINESE MEDICINES'
  defaults$atc_level4_code <- 'V03B2'
  defaults$atc_level4_name <- 'Chinese medicines'
  defaults$who_atc_code <- 'V03AX'
  defaults$who_atc_name <- 'Other therapeutic products'
  defaults$drug_code <- ''
  defaults$yj_code <- '2171022'
  defaults$receipt_computerized_processing_code <- ''
  defaults$general_name <- 'Amlodipine Besilate'
  defaults$brand_name <- 'Unknown Brand Name in English'
  defaults$generic_drug_flag <- '1'
  defaults$formulation_large_classification_name <- 'Oral Use'
  defaults$formulation_medium_classification_name <- 'Tablet'
  defaults$formulation_small_classification_name <- 'Tablet'
  defaults$titer <- ''
  defaults$titer_unit <- ''
  assign('drug_master', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- ''
  defaults$month_and_year_of_birth_of_member <- '199501'
  defaults$gender_of_member <- 'Male'
  defaults$family_id <- ''
  defaults$insured_or_dependent <- 'Insured'
  defaults$relationship <- 'Insured'
  defaults$observation_start <- '201704'
  defaults$observation_end <- '202303'
  defaults$withdrawal_death_flag <- ''
  assign('enrollment', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- ''
  defaults$claim_id <- ''
  defaults$statement_id <- '1'
  defaults$type_of_claim <- 'Outpatient'
  defaults$month_and_year_of_medical_care <- '202303'
  defaults$medical_facility_id <- 'F0234485'
  defaults$standard_disease_code <- '4779004'
  defaults$standard_disease_name <- 'allergic rhinitis'
  defaults$main_disease_flag <- ''
  defaults$causative_disease_flag <- ''
  defaults$suspicion_flag <- ''
  defaults$date_of_medical_care_start <- '2020-02-17'
  defaults$outcome <- '1'
  defaults$outcome_death_flag <- ''
  defaults$outcome_exacerbation_flag <- ''
  assign('diagnosis', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- 'M018737735'
  defaults$claim_id <- ''
  defaults$statement_id <- '1'
  defaults$type_of_claim <- 'DPC'
  defaults$month_and_year_of_medical_care <- '202108'
  defaults$date_of_material <- ''
  defaults$medical_facility_id <- 'F0146469'
  defaults$standardized_material_code <- '739200000'
  defaults$standardized_material_version <- '202004'
  defaults$standardized_material_name <- 'Liquid oxygen/stationary liquid oxygen storage tank (CE)'
  defaults$unit_on_claims <- 'pcs'
  defaults$unit <- ''
  defaults$material_usage <- '1.0'
  defaults$number_of_material <- '1.0'
  defaults$concurrent_id <- ''
  defaults$category_of_medical_care <- '40'
  defaults$material_standard_price <- ''
  defaults$material_standard_additional_rate <- ''
  defaults$actual_point <- ''
  assign('material', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$medical_facility_id <- ''
  defaults$number_of_beds <- '0-19'
  defaults$hpgp <- 'GP'
  defaults$large_classification_of_department <- 'Internal Medicine'
  defaults$medium_classification_of_department <- 'General Internal Medicine'
  defaults$management_body <- 'Clinic'
  defaults$home_care_support_clinic <- ''
  defaults$designated_cancer_care_hospitals <- ''
  defaults$medical_institution_introducing_dpc <- ''
  defaults$special_functioning_hospitals <- ''
  assign('medical_facility', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- 'M009124060'
  defaults$claim_id <- ''
  defaults$statement_id <- '1'
  defaults$type_of_claim <- 'Pharmacy'
  defaults$month_and_year_of_medical_care <- '202303'
  defaults$medical_facility_id <- 'F0146469'
  defaults$jmdc_drug_code <- '100000049967'
  defaults$drug_name <- 'Asverin Powder 10%'
  defaults$drug_price <- '5.60000000000000'
  defaults$date_of_prescription <- ''
  defaults$date_of_dispense <- ''
  defaults$prescribed_amount_per_day <- '1.0'
  defaults$unit_of_administered_amount <- 'T'
  defaults$administered_days <- '1.0'
  defaults$administered_amount <- '1.0'
  defaults$concurrent_id <- '1'
  defaults$as_needed_medication_flag <- ''
  defaults$category_of_medical_care <- ''
  defaults$cost_of_total_administrated_drug <- '61.00000000000000000000000'
  defaults$pharmacy_charge <- ''
  defaults$drug_charge <- ''
  defaults$additional_charge <- '0'
  defaults$actual_point <- '0'
  defaults$total_point <- '228'
  assign('drug', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$standardized_procedure_code <- '160076210'
  defaults$standardized_procedure_version <- '202204'
  defaults$standardized_procedure_name <- 'arthrocentesis (unilateral)'
  defaults$procedure_category_medium_classification_name <- 'surgery'
  defaults$procedure_category_small_classification_name <- 'surgery fee'
  defaults$procedure_category_subclassification_name <- 'musculoskeletal system / extremity / trunk'
  defaults$procedure_category_sub_and_detail_classification_name <- ''
  defaults$procedure_code <- 'D007'
  defaults$icd9cm_level1 <- ''
  defaults$icd9cm_level2 <- ''
  defaults$icd9cm_level3 <- ''
  assign('procedure_master', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$standard_disease_code <- ''
  defaults$standard_disease_name <- ''
  defaults$icd10_level1_code <- 'S00-T98'
  defaults$icd10_level1_name <- 'Injury, poisoning and certain other consequences of external causes'
  defaults$icd10_level2_code <- 'D10-D36'
  defaults$icd10_level2_name <- 'Benign neoplasms'
  defaults$icd10_level3_code <- 'C44'
  defaults$icd10_level3_name <- 'Other malignant neoplasms of skin'
  defaults$icd10_level4_code <- 'D180'
  defaults$icd10_level4_name <- 'Haemangioma and lymphangioma, any site / Haemangioma, any site'
  assign('diagnosis_master', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$member_id <- 'M016152393'
  defaults$claim_id <- ''
  defaults$statement_id <- '1'
  defaults$type_of_claim <- 'Outpatient'
  defaults$month_and_year_of_medical_care <- '202303'
  defaults$date_of_procedure <- ''
  defaults$medical_facility_id <- 'F0146469'
  defaults$standardized_procedure_code <- '112007410'
  defaults$standardized_procedure_version <- '202004'
  defaults$standardized_procedure_name <- 're-consultation fee (excluding hospitals with 200 or more general beds)'
  defaults$number_of_times <- '1'
  defaults$concurrent_id <- '1'
  defaults$category_of_medical_care <- '60'
  defaults$procedure_standard_point <- '11.0'
  defaults$procedure_standard_additional_rate <- ''
  defaults$procedure_standard_price <- ''
  defaults$actual_point <- '0'
  assign('procedure', defaults, envir = frameworkContext$defaultValues)

  frameworkContext$sourceFieldsMapped <- c(
  )

  frameworkContext$targetFieldsMapped <- c(
  )

  frameworkContext$sourceFieldsTested <- c()
  frameworkContext$targetFieldsTested <- c()
}

initFramework()

set_defaults_annual_health_checkup <- function(member_id, health_checkup_id, date_of_health_checkup, bmi, abdominal_circumference, presence_of_medical_history, presence_of_subjective_symptoms, presence_of_objective_symptoms, systolic_bp, diastolic_bp, time_of_blood_collection, triglyceride, hdl_cholesterol, ldl_cholesterol, ast, alt, g_gt, fasting_blood_sugar, casual_blood_sugar, hba1c, urinary_sugar, uric_protein_qualitative, hct, hemoglobin_content, rbc_count, ecg, fundus_examination_keith_wagener_classification, fundus_examination_scheie_classification_h, fundus_examination_scheie_classification_s, fundus_examination_scott_classification, smoking_habit, eating1_fast_eating, eating2_before_bedtime, eating3_late_evening_snack, eating3_snack, eating_habit, drinking_habit, amount_drinking, sleep, drug1_hypertension, drug2_diabetes, drug3_hyperlipidemia, medical_history1_cerebrovascular, medical_history2_cardiovascular, medical_history3_renal, anemia, change_of_weight_from_age_of_twenty, exercise_habit, physical_activity, walking_speed, change_of_weight_in_a_year, mastication, lifestyle_modification, request_for_health_guidance, serum_uric_acid, serum_creatinine, total_cholesterol) {
  defaults <- get('annual_health_checkup', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(health_checkup_id)) {
    defaults$health_checkup_id <- health_checkup_id
  }
  if (!missing(date_of_health_checkup)) {
    defaults$date_of_health_checkup <- date_of_health_checkup
  }
  if (!missing(bmi)) {
    defaults$bmi <- bmi
  }
  if (!missing(abdominal_circumference)) {
    defaults$abdominal_circumference <- abdominal_circumference
  }
  if (!missing(presence_of_medical_history)) {
    defaults$presence_of_medical_history <- presence_of_medical_history
  }
  if (!missing(presence_of_subjective_symptoms)) {
    defaults$presence_of_subjective_symptoms <- presence_of_subjective_symptoms
  }
  if (!missing(presence_of_objective_symptoms)) {
    defaults$presence_of_objective_symptoms <- presence_of_objective_symptoms
  }
  if (!missing(systolic_bp)) {
    defaults$systolic_bp <- systolic_bp
  }
  if (!missing(diastolic_bp)) {
    defaults$diastolic_bp <- diastolic_bp
  }
  if (!missing(time_of_blood_collection)) {
    defaults$time_of_blood_collection <- time_of_blood_collection
  }
  if (!missing(triglyceride)) {
    defaults$triglyceride <- triglyceride
  }
  if (!missing(hdl_cholesterol)) {
    defaults$hdl_cholesterol <- hdl_cholesterol
  }
  if (!missing(ldl_cholesterol)) {
    defaults$ldl_cholesterol <- ldl_cholesterol
  }
  if (!missing(ast)) {
    defaults$ast <- ast
  }
  if (!missing(alt)) {
    defaults$alt <- alt
  }
  if (!missing(g_gt)) {
    defaults$g_gt <- g_gt
  }
  if (!missing(fasting_blood_sugar)) {
    defaults$fasting_blood_sugar <- fasting_blood_sugar
  }
  if (!missing(casual_blood_sugar)) {
    defaults$casual_blood_sugar <- casual_blood_sugar
  }
  if (!missing(hba1c)) {
    defaults$hba1c <- hba1c
  }
  if (!missing(urinary_sugar)) {
    defaults$urinary_sugar <- urinary_sugar
  }
  if (!missing(uric_protein_qualitative)) {
    defaults$uric_protein_qualitative <- uric_protein_qualitative
  }
  if (!missing(hct)) {
    defaults$hct <- hct
  }
  if (!missing(hemoglobin_content)) {
    defaults$hemoglobin_content <- hemoglobin_content
  }
  if (!missing(rbc_count)) {
    defaults$rbc_count <- rbc_count
  }
  if (!missing(ecg)) {
    defaults$ecg <- ecg
  }
  if (!missing(fundus_examination_keith_wagener_classification)) {
    defaults$fundus_examination_keith_wagener_classification <- fundus_examination_keith_wagener_classification
  }
  if (!missing(fundus_examination_scheie_classification_h)) {
    defaults$fundus_examination_scheie_classification_h <- fundus_examination_scheie_classification_h
  }
  if (!missing(fundus_examination_scheie_classification_s)) {
    defaults$fundus_examination_scheie_classification_s <- fundus_examination_scheie_classification_s
  }
  if (!missing(fundus_examination_scott_classification)) {
    defaults$fundus_examination_scott_classification <- fundus_examination_scott_classification
  }
  if (!missing(smoking_habit)) {
    defaults$smoking_habit <- smoking_habit
  }
  if (!missing(eating1_fast_eating)) {
    defaults$eating1_fast_eating <- eating1_fast_eating
  }
  if (!missing(eating2_before_bedtime)) {
    defaults$eating2_before_bedtime <- eating2_before_bedtime
  }
  if (!missing(eating3_late_evening_snack)) {
    defaults$eating3_late_evening_snack <- eating3_late_evening_snack
  }
  if (!missing(eating3_snack)) {
    defaults$eating3_snack <- eating3_snack
  }
  if (!missing(eating_habit)) {
    defaults$eating_habit <- eating_habit
  }
  if (!missing(drinking_habit)) {
    defaults$drinking_habit <- drinking_habit
  }
  if (!missing(amount_drinking)) {
    defaults$amount_drinking <- amount_drinking
  }
  if (!missing(sleep)) {
    defaults$sleep <- sleep
  }
  if (!missing(drug1_hypertension)) {
    defaults$drug1_hypertension <- drug1_hypertension
  }
  if (!missing(drug2_diabetes)) {
    defaults$drug2_diabetes <- drug2_diabetes
  }
  if (!missing(drug3_hyperlipidemia)) {
    defaults$drug3_hyperlipidemia <- drug3_hyperlipidemia
  }
  if (!missing(medical_history1_cerebrovascular)) {
    defaults$medical_history1_cerebrovascular <- medical_history1_cerebrovascular
  }
  if (!missing(medical_history2_cardiovascular)) {
    defaults$medical_history2_cardiovascular <- medical_history2_cardiovascular
  }
  if (!missing(medical_history3_renal)) {
    defaults$medical_history3_renal <- medical_history3_renal
  }
  if (!missing(anemia)) {
    defaults$anemia <- anemia
  }
  if (!missing(change_of_weight_from_age_of_twenty)) {
    defaults$change_of_weight_from_age_of_twenty <- change_of_weight_from_age_of_twenty
  }
  if (!missing(exercise_habit)) {
    defaults$exercise_habit <- exercise_habit
  }
  if (!missing(physical_activity)) {
    defaults$physical_activity <- physical_activity
  }
  if (!missing(walking_speed)) {
    defaults$walking_speed <- walking_speed
  }
  if (!missing(change_of_weight_in_a_year)) {
    defaults$change_of_weight_in_a_year <- change_of_weight_in_a_year
  }
  if (!missing(mastication)) {
    defaults$mastication <- mastication
  }
  if (!missing(lifestyle_modification)) {
    defaults$lifestyle_modification <- lifestyle_modification
  }
  if (!missing(request_for_health_guidance)) {
    defaults$request_for_health_guidance <- request_for_health_guidance
  }
  if (!missing(serum_uric_acid)) {
    defaults$serum_uric_acid <- serum_uric_acid
  }
  if (!missing(serum_creatinine)) {
    defaults$serum_creatinine <- serum_creatinine
  }
  if (!missing(total_cholesterol)) {
    defaults$total_cholesterol <- total_cholesterol
  }
  assign('annual_health_checkup', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_claim <- function(member_id, claim_id, type_of_claim, month_and_year_of_medical_care, paper_claim_flag, medical_facility_id, large_classification_of_department, medium_classification_of_department, department_on_claim_name, days_of_medical_care, admission_date, discharge_date, total_point) {
  defaults <- get('claim', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(claim_id)) {
    defaults$claim_id <- claim_id
  }
  if (!missing(type_of_claim)) {
    defaults$type_of_claim <- type_of_claim
  }
  if (!missing(month_and_year_of_medical_care)) {
    defaults$month_and_year_of_medical_care <- month_and_year_of_medical_care
  }
  if (!missing(paper_claim_flag)) {
    defaults$paper_claim_flag <- paper_claim_flag
  }
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(large_classification_of_department)) {
    defaults$large_classification_of_department <- large_classification_of_department
  }
  if (!missing(medium_classification_of_department)) {
    defaults$medium_classification_of_department <- medium_classification_of_department
  }
  if (!missing(department_on_claim_name)) {
    defaults$department_on_claim_name <- department_on_claim_name
  }
  if (!missing(days_of_medical_care)) {
    defaults$days_of_medical_care <- days_of_medical_care
  }
  if (!missing(admission_date)) {
    defaults$admission_date <- admission_date
  }
  if (!missing(discharge_date)) {
    defaults$discharge_date <- discharge_date
  }
  if (!missing(total_point)) {
    defaults$total_point <- total_point
  }
  assign('claim', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_version <- function(version_id, version_date) {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  if (!missing(version_id)) {
    defaults$version_id <- version_id
  }
  if (!missing(version_date)) {
    defaults$version_date <- version_date
  }
  assign('version', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_material_master <- function(standardized_material_code, standardized_material_version, standardized_material_name, unit, material_category_large_classification_name, material_category_medium_classification_name, material_code) {
  defaults <- get('material_master', envir = frameworkContext$defaultValues)
  if (!missing(standardized_material_code)) {
    defaults$standardized_material_code <- standardized_material_code
  }
  if (!missing(standardized_material_version)) {
    defaults$standardized_material_version <- standardized_material_version
  }
  if (!missing(standardized_material_name)) {
    defaults$standardized_material_name <- standardized_material_name
  }
  if (!missing(unit)) {
    defaults$unit <- unit
  }
  if (!missing(material_category_large_classification_name)) {
    defaults$material_category_large_classification_name <- material_category_large_classification_name
  }
  if (!missing(material_category_medium_classification_name)) {
    defaults$material_category_medium_classification_name <- material_category_medium_classification_name
  }
  if (!missing(material_code)) {
    defaults$material_code <- material_code
  }
  assign('material_master', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_drug_master <- function(jmdc_drug_code, drug_name, standardized_unit, atc_level1_code, atc_level1_name, atc_level2_code, atc_level2_name, atc_level3_code, atc_level3_name, atc_level4_code, atc_level4_name, who_atc_code, who_atc_name, drug_code, yj_code, receipt_computerized_processing_code, general_name, brand_name, generic_drug_flag, formulation_large_classification_name, formulation_medium_classification_name, formulation_small_classification_name, titer, titer_unit) {
  defaults <- get('drug_master', envir = frameworkContext$defaultValues)
  if (!missing(jmdc_drug_code)) {
    defaults$jmdc_drug_code <- jmdc_drug_code
  }
  if (!missing(drug_name)) {
    defaults$drug_name <- drug_name
  }
  if (!missing(standardized_unit)) {
    defaults$standardized_unit <- standardized_unit
  }
  if (!missing(atc_level1_code)) {
    defaults$atc_level1_code <- atc_level1_code
  }
  if (!missing(atc_level1_name)) {
    defaults$atc_level1_name <- atc_level1_name
  }
  if (!missing(atc_level2_code)) {
    defaults$atc_level2_code <- atc_level2_code
  }
  if (!missing(atc_level2_name)) {
    defaults$atc_level2_name <- atc_level2_name
  }
  if (!missing(atc_level3_code)) {
    defaults$atc_level3_code <- atc_level3_code
  }
  if (!missing(atc_level3_name)) {
    defaults$atc_level3_name <- atc_level3_name
  }
  if (!missing(atc_level4_code)) {
    defaults$atc_level4_code <- atc_level4_code
  }
  if (!missing(atc_level4_name)) {
    defaults$atc_level4_name <- atc_level4_name
  }
  if (!missing(who_atc_code)) {
    defaults$who_atc_code <- who_atc_code
  }
  if (!missing(who_atc_name)) {
    defaults$who_atc_name <- who_atc_name
  }
  if (!missing(drug_code)) {
    defaults$drug_code <- drug_code
  }
  if (!missing(yj_code)) {
    defaults$yj_code <- yj_code
  }
  if (!missing(receipt_computerized_processing_code)) {
    defaults$receipt_computerized_processing_code <- receipt_computerized_processing_code
  }
  if (!missing(general_name)) {
    defaults$general_name <- general_name
  }
  if (!missing(brand_name)) {
    defaults$brand_name <- brand_name
  }
  if (!missing(generic_drug_flag)) {
    defaults$generic_drug_flag <- generic_drug_flag
  }
  if (!missing(formulation_large_classification_name)) {
    defaults$formulation_large_classification_name <- formulation_large_classification_name
  }
  if (!missing(formulation_medium_classification_name)) {
    defaults$formulation_medium_classification_name <- formulation_medium_classification_name
  }
  if (!missing(formulation_small_classification_name)) {
    defaults$formulation_small_classification_name <- formulation_small_classification_name
  }
  if (!missing(titer)) {
    defaults$titer <- titer
  }
  if (!missing(titer_unit)) {
    defaults$titer_unit <- titer_unit
  }
  assign('drug_master', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_enrollment <- function(member_id, month_and_year_of_birth_of_member, gender_of_member, family_id, insured_or_dependent, relationship, observation_start, observation_end, withdrawal_death_flag) {
  defaults <- get('enrollment', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(month_and_year_of_birth_of_member)) {
    defaults$month_and_year_of_birth_of_member <- month_and_year_of_birth_of_member
  }
  if (!missing(gender_of_member)) {
    defaults$gender_of_member <- gender_of_member
  }
  if (!missing(family_id)) {
    defaults$family_id <- family_id
  }
  if (!missing(insured_or_dependent)) {
    defaults$insured_or_dependent <- insured_or_dependent
  }
  if (!missing(relationship)) {
    defaults$relationship <- relationship
  }
  if (!missing(observation_start)) {
    defaults$observation_start <- observation_start
  }
  if (!missing(observation_end)) {
    defaults$observation_end <- observation_end
  }
  if (!missing(withdrawal_death_flag)) {
    defaults$withdrawal_death_flag <- withdrawal_death_flag
  }
  assign('enrollment', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_diagnosis <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, medical_facility_id, standard_disease_code, standard_disease_name, main_disease_flag, causative_disease_flag, suspicion_flag, date_of_medical_care_start, outcome, outcome_death_flag, outcome_exacerbation_flag) {
  defaults <- get('diagnosis', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(claim_id)) {
    defaults$claim_id <- claim_id
  }
  if (!missing(statement_id)) {
    defaults$statement_id <- statement_id
  }
  if (!missing(type_of_claim)) {
    defaults$type_of_claim <- type_of_claim
  }
  if (!missing(month_and_year_of_medical_care)) {
    defaults$month_and_year_of_medical_care <- month_and_year_of_medical_care
  }
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(standard_disease_code)) {
    defaults$standard_disease_code <- standard_disease_code
  }
  if (!missing(standard_disease_name)) {
    defaults$standard_disease_name <- standard_disease_name
  }
  if (!missing(main_disease_flag)) {
    defaults$main_disease_flag <- main_disease_flag
  }
  if (!missing(causative_disease_flag)) {
    defaults$causative_disease_flag <- causative_disease_flag
  }
  if (!missing(suspicion_flag)) {
    defaults$suspicion_flag <- suspicion_flag
  }
  if (!missing(date_of_medical_care_start)) {
    defaults$date_of_medical_care_start <- date_of_medical_care_start
  }
  if (!missing(outcome)) {
    defaults$outcome <- outcome
  }
  if (!missing(outcome_death_flag)) {
    defaults$outcome_death_flag <- outcome_death_flag
  }
  if (!missing(outcome_exacerbation_flag)) {
    defaults$outcome_exacerbation_flag <- outcome_exacerbation_flag
  }
  assign('diagnosis', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_material <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, date_of_material, medical_facility_id, standardized_material_code, standardized_material_version, standardized_material_name, unit_on_claims, unit, material_usage, number_of_material, concurrent_id, category_of_medical_care, material_standard_price, material_standard_additional_rate, actual_point) {
  defaults <- get('material', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(claim_id)) {
    defaults$claim_id <- claim_id
  }
  if (!missing(statement_id)) {
    defaults$statement_id <- statement_id
  }
  if (!missing(type_of_claim)) {
    defaults$type_of_claim <- type_of_claim
  }
  if (!missing(month_and_year_of_medical_care)) {
    defaults$month_and_year_of_medical_care <- month_and_year_of_medical_care
  }
  if (!missing(date_of_material)) {
    defaults$date_of_material <- date_of_material
  }
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(standardized_material_code)) {
    defaults$standardized_material_code <- standardized_material_code
  }
  if (!missing(standardized_material_version)) {
    defaults$standardized_material_version <- standardized_material_version
  }
  if (!missing(standardized_material_name)) {
    defaults$standardized_material_name <- standardized_material_name
  }
  if (!missing(unit_on_claims)) {
    defaults$unit_on_claims <- unit_on_claims
  }
  if (!missing(unit)) {
    defaults$unit <- unit
  }
  if (!missing(material_usage)) {
    defaults$material_usage <- material_usage
  }
  if (!missing(number_of_material)) {
    defaults$number_of_material <- number_of_material
  }
  if (!missing(concurrent_id)) {
    defaults$concurrent_id <- concurrent_id
  }
  if (!missing(category_of_medical_care)) {
    defaults$category_of_medical_care <- category_of_medical_care
  }
  if (!missing(material_standard_price)) {
    defaults$material_standard_price <- material_standard_price
  }
  if (!missing(material_standard_additional_rate)) {
    defaults$material_standard_additional_rate <- material_standard_additional_rate
  }
  if (!missing(actual_point)) {
    defaults$actual_point <- actual_point
  }
  assign('material', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_medical_facility <- function(medical_facility_id, number_of_beds, hpgp, large_classification_of_department, medium_classification_of_department, management_body, home_care_support_clinic, designated_cancer_care_hospitals, medical_institution_introducing_dpc, special_functioning_hospitals) {
  defaults <- get('medical_facility', envir = frameworkContext$defaultValues)
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(number_of_beds)) {
    defaults$number_of_beds <- number_of_beds
  }
  if (!missing(hpgp)) {
    defaults$hpgp <- hpgp
  }
  if (!missing(large_classification_of_department)) {
    defaults$large_classification_of_department <- large_classification_of_department
  }
  if (!missing(medium_classification_of_department)) {
    defaults$medium_classification_of_department <- medium_classification_of_department
  }
  if (!missing(management_body)) {
    defaults$management_body <- management_body
  }
  if (!missing(home_care_support_clinic)) {
    defaults$home_care_support_clinic <- home_care_support_clinic
  }
  if (!missing(designated_cancer_care_hospitals)) {
    defaults$designated_cancer_care_hospitals <- designated_cancer_care_hospitals
  }
  if (!missing(medical_institution_introducing_dpc)) {
    defaults$medical_institution_introducing_dpc <- medical_institution_introducing_dpc
  }
  if (!missing(special_functioning_hospitals)) {
    defaults$special_functioning_hospitals <- special_functioning_hospitals
  }
  assign('medical_facility', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_drug <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, medical_facility_id, jmdc_drug_code, drug_name, drug_price, date_of_prescription, date_of_dispense, prescribed_amount_per_day, unit_of_administered_amount, administered_days, administered_amount, concurrent_id, as_needed_medication_flag, category_of_medical_care, cost_of_total_administrated_drug, pharmacy_charge, drug_charge, additional_charge, actual_point, total_point) {
  defaults <- get('drug', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(claim_id)) {
    defaults$claim_id <- claim_id
  }
  if (!missing(statement_id)) {
    defaults$statement_id <- statement_id
  }
  if (!missing(type_of_claim)) {
    defaults$type_of_claim <- type_of_claim
  }
  if (!missing(month_and_year_of_medical_care)) {
    defaults$month_and_year_of_medical_care <- month_and_year_of_medical_care
  }
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(jmdc_drug_code)) {
    defaults$jmdc_drug_code <- jmdc_drug_code
  }
  if (!missing(drug_name)) {
    defaults$drug_name <- drug_name
  }
  if (!missing(drug_price)) {
    defaults$drug_price <- drug_price
  }
  if (!missing(date_of_prescription)) {
    defaults$date_of_prescription <- date_of_prescription
  }
  if (!missing(date_of_dispense)) {
    defaults$date_of_dispense <- date_of_dispense
  }
  if (!missing(prescribed_amount_per_day)) {
    defaults$prescribed_amount_per_day <- prescribed_amount_per_day
  }
  if (!missing(unit_of_administered_amount)) {
    defaults$unit_of_administered_amount <- unit_of_administered_amount
  }
  if (!missing(administered_days)) {
    defaults$administered_days <- administered_days
  }
  if (!missing(administered_amount)) {
    defaults$administered_amount <- administered_amount
  }
  if (!missing(concurrent_id)) {
    defaults$concurrent_id <- concurrent_id
  }
  if (!missing(as_needed_medication_flag)) {
    defaults$as_needed_medication_flag <- as_needed_medication_flag
  }
  if (!missing(category_of_medical_care)) {
    defaults$category_of_medical_care <- category_of_medical_care
  }
  if (!missing(cost_of_total_administrated_drug)) {
    defaults$cost_of_total_administrated_drug <- cost_of_total_administrated_drug
  }
  if (!missing(pharmacy_charge)) {
    defaults$pharmacy_charge <- pharmacy_charge
  }
  if (!missing(drug_charge)) {
    defaults$drug_charge <- drug_charge
  }
  if (!missing(additional_charge)) {
    defaults$additional_charge <- additional_charge
  }
  if (!missing(actual_point)) {
    defaults$actual_point <- actual_point
  }
  if (!missing(total_point)) {
    defaults$total_point <- total_point
  }
  assign('drug', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_procedure_master <- function(standardized_procedure_code, standardized_procedure_version, standardized_procedure_name, procedure_category_medium_classification_name, procedure_category_small_classification_name, procedure_category_subclassification_name, procedure_category_sub_and_detail_classification_name, procedure_code, icd9cm_level1, icd9cm_level2, icd9cm_level3) {
  defaults <- get('procedure_master', envir = frameworkContext$defaultValues)
  if (!missing(standardized_procedure_code)) {
    defaults$standardized_procedure_code <- standardized_procedure_code
  }
  if (!missing(standardized_procedure_version)) {
    defaults$standardized_procedure_version <- standardized_procedure_version
  }
  if (!missing(standardized_procedure_name)) {
    defaults$standardized_procedure_name <- standardized_procedure_name
  }
  if (!missing(procedure_category_medium_classification_name)) {
    defaults$procedure_category_medium_classification_name <- procedure_category_medium_classification_name
  }
  if (!missing(procedure_category_small_classification_name)) {
    defaults$procedure_category_small_classification_name <- procedure_category_small_classification_name
  }
  if (!missing(procedure_category_subclassification_name)) {
    defaults$procedure_category_subclassification_name <- procedure_category_subclassification_name
  }
  if (!missing(procedure_category_sub_and_detail_classification_name)) {
    defaults$procedure_category_sub_and_detail_classification_name <- procedure_category_sub_and_detail_classification_name
  }
  if (!missing(procedure_code)) {
    defaults$procedure_code <- procedure_code
  }
  if (!missing(icd9cm_level1)) {
    defaults$icd9cm_level1 <- icd9cm_level1
  }
  if (!missing(icd9cm_level2)) {
    defaults$icd9cm_level2 <- icd9cm_level2
  }
  if (!missing(icd9cm_level3)) {
    defaults$icd9cm_level3 <- icd9cm_level3
  }
  assign('procedure_master', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_diagnosis_master <- function(standard_disease_code, standard_disease_name, icd10_level1_code, icd10_level1_name, icd10_level2_code, icd10_level2_name, icd10_level3_code, icd10_level3_name, icd10_level4_code, icd10_level4_name) {
  defaults <- get('diagnosis_master', envir = frameworkContext$defaultValues)
  if (!missing(standard_disease_code)) {
    defaults$standard_disease_code <- standard_disease_code
  }
  if (!missing(standard_disease_name)) {
    defaults$standard_disease_name <- standard_disease_name
  }
  if (!missing(icd10_level1_code)) {
    defaults$icd10_level1_code <- icd10_level1_code
  }
  if (!missing(icd10_level1_name)) {
    defaults$icd10_level1_name <- icd10_level1_name
  }
  if (!missing(icd10_level2_code)) {
    defaults$icd10_level2_code <- icd10_level2_code
  }
  if (!missing(icd10_level2_name)) {
    defaults$icd10_level2_name <- icd10_level2_name
  }
  if (!missing(icd10_level3_code)) {
    defaults$icd10_level3_code <- icd10_level3_code
  }
  if (!missing(icd10_level3_name)) {
    defaults$icd10_level3_name <- icd10_level3_name
  }
  if (!missing(icd10_level4_code)) {
    defaults$icd10_level4_code <- icd10_level4_code
  }
  if (!missing(icd10_level4_name)) {
    defaults$icd10_level4_name <- icd10_level4_name
  }
  assign('diagnosis_master', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_procedure <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, date_of_procedure, medical_facility_id, standardized_procedure_code, standardized_procedure_version, standardized_procedure_name, number_of_times, concurrent_id, category_of_medical_care, procedure_standard_point, procedure_standard_additional_rate, procedure_standard_price, actual_point) {
  defaults <- get('procedure', envir = frameworkContext$defaultValues)
  if (!missing(member_id)) {
    defaults$member_id <- member_id
  }
  if (!missing(claim_id)) {
    defaults$claim_id <- claim_id
  }
  if (!missing(statement_id)) {
    defaults$statement_id <- statement_id
  }
  if (!missing(type_of_claim)) {
    defaults$type_of_claim <- type_of_claim
  }
  if (!missing(month_and_year_of_medical_care)) {
    defaults$month_and_year_of_medical_care <- month_and_year_of_medical_care
  }
  if (!missing(date_of_procedure)) {
    defaults$date_of_procedure <- date_of_procedure
  }
  if (!missing(medical_facility_id)) {
    defaults$medical_facility_id <- medical_facility_id
  }
  if (!missing(standardized_procedure_code)) {
    defaults$standardized_procedure_code <- standardized_procedure_code
  }
  if (!missing(standardized_procedure_version)) {
    defaults$standardized_procedure_version <- standardized_procedure_version
  }
  if (!missing(standardized_procedure_name)) {
    defaults$standardized_procedure_name <- standardized_procedure_name
  }
  if (!missing(number_of_times)) {
    defaults$number_of_times <- number_of_times
  }
  if (!missing(concurrent_id)) {
    defaults$concurrent_id <- concurrent_id
  }
  if (!missing(category_of_medical_care)) {
    defaults$category_of_medical_care <- category_of_medical_care
  }
  if (!missing(procedure_standard_point)) {
    defaults$procedure_standard_point <- procedure_standard_point
  }
  if (!missing(procedure_standard_additional_rate)) {
    defaults$procedure_standard_additional_rate <- procedure_standard_additional_rate
  }
  if (!missing(procedure_standard_price)) {
    defaults$procedure_standard_price <- procedure_standard_price
  }
  if (!missing(actual_point)) {
    defaults$actual_point <- actual_point
  }
  assign('procedure', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

get_defaults_annual_health_checkup <- function() {
  defaults <- get('annual_health_checkup', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_claim <- function() {
  defaults <- get('claim', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_material_master <- function() {
  defaults <- get('material_master', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_drug_master <- function() {
  defaults <- get('drug_master', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_enrollment <- function() {
  defaults <- get('enrollment', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_diagnosis <- function() {
  defaults <- get('diagnosis', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_material <- function() {
  defaults <- get('material', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_medical_facility <- function() {
  defaults <- get('medical_facility', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_drug <- function() {
  defaults <- get('drug', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_procedure_master <- function() {
  defaults <- get('procedure_master', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_diagnosis_master <- function() {
  defaults <- get('diagnosis_master', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_procedure <- function() {
  defaults <- get('procedure', envir = frameworkContext$defaultValues)
  return(defaults)
}

declareTest <- function(id, description) {
  frameworkContext$testId <- id
  frameworkContext$testDescription <- description
}

add_annual_health_checkup <- function(member_id, health_checkup_id, date_of_health_checkup, bmi, abdominal_circumference, presence_of_medical_history, presence_of_subjective_symptoms, presence_of_objective_symptoms, systolic_bp, diastolic_bp, time_of_blood_collection, triglyceride, hdl_cholesterol, ldl_cholesterol, ast, alt, g_gt, fasting_blood_sugar, casual_blood_sugar, hba1c, urinary_sugar, uric_protein_qualitative, hct, hemoglobin_content, rbc_count, ecg, fundus_examination_keith_wagener_classification, fundus_examination_scheie_classification_h, fundus_examination_scheie_classification_s, fundus_examination_scott_classification, smoking_habit, eating1_fast_eating, eating2_before_bedtime, eating3_late_evening_snack, eating3_snack, eating_habit, drinking_habit, amount_drinking, sleep, drug1_hypertension, drug2_diabetes, drug3_hyperlipidemia, medical_history1_cerebrovascular, medical_history2_cardiovascular, medical_history3_renal, anemia, change_of_weight_from_age_of_twenty, exercise_habit, physical_activity, walking_speed, change_of_weight_in_a_year, mastication, lifestyle_modification, request_for_health_guidance, serum_uric_acid, serum_creatinine, total_cholesterol) {
  defaults <- get('annual_health_checkup', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(health_checkup_id)) {
    health_checkup_id <- defaults$health_checkup_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.health_checkup_id')
  }
  fields <- c(fields, "health_checkup_id")
  values <- c(values, if (is.null(health_checkup_id)) "NULL" else if (is(health_checkup_id, "subQuery")) paste0("(", as.character(health_checkup_id), ")") else paste0("'", as.character(health_checkup_id), "'"))

  if (missing(date_of_health_checkup)) {
    date_of_health_checkup <- defaults$date_of_health_checkup
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.date_of_health_checkup')
  }
  fields <- c(fields, "date_of_health_checkup")
  values <- c(values, if (is.null(date_of_health_checkup)) "NULL" else if (is(date_of_health_checkup, "subQuery")) paste0("(", as.character(date_of_health_checkup), ")") else paste0("'", as.character(date_of_health_checkup), "'"))

  if (missing(bmi)) {
    bmi <- defaults$bmi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.bmi')
  }
  fields <- c(fields, "bmi")
  values <- c(values, if (is.null(bmi)) "NULL" else if (is(bmi, "subQuery")) paste0("(", as.character(bmi), ")") else paste0("'", as.character(bmi), "'"))

  if (missing(abdominal_circumference)) {
    abdominal_circumference <- defaults$abdominal_circumference
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.abdominal_circumference')
  }
  fields <- c(fields, "abdominal_circumference")
  values <- c(values, if (is.null(abdominal_circumference)) "NULL" else if (is(abdominal_circumference, "subQuery")) paste0("(", as.character(abdominal_circumference), ")") else paste0("'", as.character(abdominal_circumference), "'"))

  if (missing(presence_of_medical_history)) {
    presence_of_medical_history <- defaults$presence_of_medical_history
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.presence_of_medical_history')
  }
  fields <- c(fields, "presence_of_medical_history")
  values <- c(values, if (is.null(presence_of_medical_history)) "NULL" else if (is(presence_of_medical_history, "subQuery")) paste0("(", as.character(presence_of_medical_history), ")") else paste0("'", as.character(presence_of_medical_history), "'"))

  if (missing(presence_of_subjective_symptoms)) {
    presence_of_subjective_symptoms <- defaults$presence_of_subjective_symptoms
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.presence_of_subjective_symptoms')
  }
  fields <- c(fields, "presence_of_subjective_symptoms")
  values <- c(values, if (is.null(presence_of_subjective_symptoms)) "NULL" else if (is(presence_of_subjective_symptoms, "subQuery")) paste0("(", as.character(presence_of_subjective_symptoms), ")") else paste0("'", as.character(presence_of_subjective_symptoms), "'"))

  if (missing(presence_of_objective_symptoms)) {
    presence_of_objective_symptoms <- defaults$presence_of_objective_symptoms
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.presence_of_objective_symptoms')
  }
  fields <- c(fields, "presence_of_objective_symptoms")
  values <- c(values, if (is.null(presence_of_objective_symptoms)) "NULL" else if (is(presence_of_objective_symptoms, "subQuery")) paste0("(", as.character(presence_of_objective_symptoms), ")") else paste0("'", as.character(presence_of_objective_symptoms), "'"))

  if (missing(systolic_bp)) {
    systolic_bp <- defaults$systolic_bp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.systolic_bp')
  }
  fields <- c(fields, "systolic_bp")
  values <- c(values, if (is.null(systolic_bp)) "NULL" else if (is(systolic_bp, "subQuery")) paste0("(", as.character(systolic_bp), ")") else paste0("'", as.character(systolic_bp), "'"))

  if (missing(diastolic_bp)) {
    diastolic_bp <- defaults$diastolic_bp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.diastolic_bp')
  }
  fields <- c(fields, "diastolic_bp")
  values <- c(values, if (is.null(diastolic_bp)) "NULL" else if (is(diastolic_bp, "subQuery")) paste0("(", as.character(diastolic_bp), ")") else paste0("'", as.character(diastolic_bp), "'"))

  if (missing(time_of_blood_collection)) {
    time_of_blood_collection <- defaults$time_of_blood_collection
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.time_of_blood_collection')
  }
  fields <- c(fields, "time_of_blood_collection")
  values <- c(values, if (is.null(time_of_blood_collection)) "NULL" else if (is(time_of_blood_collection, "subQuery")) paste0("(", as.character(time_of_blood_collection), ")") else paste0("'", as.character(time_of_blood_collection), "'"))

  if (missing(triglyceride)) {
    triglyceride <- defaults$triglyceride
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.triglyceride')
  }
  fields <- c(fields, "triglyceride")
  values <- c(values, if (is.null(triglyceride)) "NULL" else if (is(triglyceride, "subQuery")) paste0("(", as.character(triglyceride), ")") else paste0("'", as.character(triglyceride), "'"))

  if (missing(hdl_cholesterol)) {
    hdl_cholesterol <- defaults$hdl_cholesterol
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.hdl_cholesterol')
  }
  fields <- c(fields, "hdl_cholesterol")
  values <- c(values, if (is.null(hdl_cholesterol)) "NULL" else if (is(hdl_cholesterol, "subQuery")) paste0("(", as.character(hdl_cholesterol), ")") else paste0("'", as.character(hdl_cholesterol), "'"))

  if (missing(ldl_cholesterol)) {
    ldl_cholesterol <- defaults$ldl_cholesterol
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.ldl_cholesterol')
  }
  fields <- c(fields, "ldl_cholesterol")
  values <- c(values, if (is.null(ldl_cholesterol)) "NULL" else if (is(ldl_cholesterol, "subQuery")) paste0("(", as.character(ldl_cholesterol), ")") else paste0("'", as.character(ldl_cholesterol), "'"))

  if (missing(ast)) {
    ast <- defaults$ast
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.ast')
  }
  fields <- c(fields, "ast")
  values <- c(values, if (is.null(ast)) "NULL" else if (is(ast, "subQuery")) paste0("(", as.character(ast), ")") else paste0("'", as.character(ast), "'"))

  if (missing(alt)) {
    alt <- defaults$alt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.alt')
  }
  fields <- c(fields, "alt")
  values <- c(values, if (is.null(alt)) "NULL" else if (is(alt, "subQuery")) paste0("(", as.character(alt), ")") else paste0("'", as.character(alt), "'"))

  if (missing(g_gt)) {
    g_gt <- defaults$g_gt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.g_gt')
  }
  fields <- c(fields, "g_gt")
  values <- c(values, if (is.null(g_gt)) "NULL" else if (is(g_gt, "subQuery")) paste0("(", as.character(g_gt), ")") else paste0("'", as.character(g_gt), "'"))

  if (missing(fasting_blood_sugar)) {
    fasting_blood_sugar <- defaults$fasting_blood_sugar
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.fasting_blood_sugar')
  }
  fields <- c(fields, "fasting_blood_sugar")
  values <- c(values, if (is.null(fasting_blood_sugar)) "NULL" else if (is(fasting_blood_sugar, "subQuery")) paste0("(", as.character(fasting_blood_sugar), ")") else paste0("'", as.character(fasting_blood_sugar), "'"))

  if (missing(casual_blood_sugar)) {
    casual_blood_sugar <- defaults$casual_blood_sugar
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.casual_blood_sugar')
  }
  fields <- c(fields, "casual_blood_sugar")
  values <- c(values, if (is.null(casual_blood_sugar)) "NULL" else if (is(casual_blood_sugar, "subQuery")) paste0("(", as.character(casual_blood_sugar), ")") else paste0("'", as.character(casual_blood_sugar), "'"))

  if (missing(hba1c)) {
    hba1c <- defaults$hba1c
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.hba1c')
  }
  fields <- c(fields, "hba1c")
  values <- c(values, if (is.null(hba1c)) "NULL" else if (is(hba1c, "subQuery")) paste0("(", as.character(hba1c), ")") else paste0("'", as.character(hba1c), "'"))

  if (missing(urinary_sugar)) {
    urinary_sugar <- defaults$urinary_sugar
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.urinary_sugar')
  }
  fields <- c(fields, "urinary_sugar")
  values <- c(values, if (is.null(urinary_sugar)) "NULL" else if (is(urinary_sugar, "subQuery")) paste0("(", as.character(urinary_sugar), ")") else paste0("'", as.character(urinary_sugar), "'"))

  if (missing(uric_protein_qualitative)) {
    uric_protein_qualitative <- defaults$uric_protein_qualitative
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.uric_protein_qualitative')
  }
  fields <- c(fields, "uric_protein_qualitative")
  values <- c(values, if (is.null(uric_protein_qualitative)) "NULL" else if (is(uric_protein_qualitative, "subQuery")) paste0("(", as.character(uric_protein_qualitative), ")") else paste0("'", as.character(uric_protein_qualitative), "'"))

  if (missing(hct)) {
    hct <- defaults$hct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.hct')
  }
  fields <- c(fields, "hct")
  values <- c(values, if (is.null(hct)) "NULL" else if (is(hct, "subQuery")) paste0("(", as.character(hct), ")") else paste0("'", as.character(hct), "'"))

  if (missing(hemoglobin_content)) {
    hemoglobin_content <- defaults$hemoglobin_content
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.hemoglobin_content')
  }
  fields <- c(fields, "hemoglobin_content")
  values <- c(values, if (is.null(hemoglobin_content)) "NULL" else if (is(hemoglobin_content, "subQuery")) paste0("(", as.character(hemoglobin_content), ")") else paste0("'", as.character(hemoglobin_content), "'"))

  if (missing(rbc_count)) {
    rbc_count <- defaults$rbc_count
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.rbc_count')
  }
  fields <- c(fields, "rbc_count")
  values <- c(values, if (is.null(rbc_count)) "NULL" else if (is(rbc_count, "subQuery")) paste0("(", as.character(rbc_count), ")") else paste0("'", as.character(rbc_count), "'"))

  if (missing(ecg)) {
    ecg <- defaults$ecg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.ecg')
  }
  fields <- c(fields, "ecg")
  values <- c(values, if (is.null(ecg)) "NULL" else if (is(ecg, "subQuery")) paste0("(", as.character(ecg), ")") else paste0("'", as.character(ecg), "'"))

  if (missing(fundus_examination_keith_wagener_classification)) {
    fundus_examination_keith_wagener_classification <- defaults$fundus_examination_keith_wagener_classification
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.fundus_examination_keith_wagener_classification')
  }
  fields <- c(fields, "fundus_examination_keith_wagener_classification")
  values <- c(values, if (is.null(fundus_examination_keith_wagener_classification)) "NULL" else if (is(fundus_examination_keith_wagener_classification, "subQuery")) paste0("(", as.character(fundus_examination_keith_wagener_classification), ")") else paste0("'", as.character(fundus_examination_keith_wagener_classification), "'"))

  if (missing(fundus_examination_scheie_classification_h)) {
    fundus_examination_scheie_classification_h <- defaults$fundus_examination_scheie_classification_h
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.fundus_examination_scheie_classification_h')
  }
  fields <- c(fields, "fundus_examination_scheie_classification_h")
  values <- c(values, if (is.null(fundus_examination_scheie_classification_h)) "NULL" else if (is(fundus_examination_scheie_classification_h, "subQuery")) paste0("(", as.character(fundus_examination_scheie_classification_h), ")") else paste0("'", as.character(fundus_examination_scheie_classification_h), "'"))

  if (missing(fundus_examination_scheie_classification_s)) {
    fundus_examination_scheie_classification_s <- defaults$fundus_examination_scheie_classification_s
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.fundus_examination_scheie_classification_s')
  }
  fields <- c(fields, "fundus_examination_scheie_classification_s")
  values <- c(values, if (is.null(fundus_examination_scheie_classification_s)) "NULL" else if (is(fundus_examination_scheie_classification_s, "subQuery")) paste0("(", as.character(fundus_examination_scheie_classification_s), ")") else paste0("'", as.character(fundus_examination_scheie_classification_s), "'"))

  if (missing(fundus_examination_scott_classification)) {
    fundus_examination_scott_classification <- defaults$fundus_examination_scott_classification
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.fundus_examination_scott_classification')
  }
  fields <- c(fields, "fundus_examination_scott_classification")
  values <- c(values, if (is.null(fundus_examination_scott_classification)) "NULL" else if (is(fundus_examination_scott_classification, "subQuery")) paste0("(", as.character(fundus_examination_scott_classification), ")") else paste0("'", as.character(fundus_examination_scott_classification), "'"))

  if (missing(smoking_habit)) {
    smoking_habit <- defaults$smoking_habit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.smoking_habit')
  }
  fields <- c(fields, "smoking_habit")
  values <- c(values, if (is.null(smoking_habit)) "NULL" else if (is(smoking_habit, "subQuery")) paste0("(", as.character(smoking_habit), ")") else paste0("'", as.character(smoking_habit), "'"))

  if (missing(eating1_fast_eating)) {
    eating1_fast_eating <- defaults$eating1_fast_eating
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.eating1_fast_eating')
  }
  fields <- c(fields, "eating1_fast_eating")
  values <- c(values, if (is.null(eating1_fast_eating)) "NULL" else if (is(eating1_fast_eating, "subQuery")) paste0("(", as.character(eating1_fast_eating), ")") else paste0("'", as.character(eating1_fast_eating), "'"))

  if (missing(eating2_before_bedtime)) {
    eating2_before_bedtime <- defaults$eating2_before_bedtime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.eating2_before_bedtime')
  }
  fields <- c(fields, "eating2_before_bedtime")
  values <- c(values, if (is.null(eating2_before_bedtime)) "NULL" else if (is(eating2_before_bedtime, "subQuery")) paste0("(", as.character(eating2_before_bedtime), ")") else paste0("'", as.character(eating2_before_bedtime), "'"))

  if (missing(eating3_late_evening_snack)) {
    eating3_late_evening_snack <- defaults$eating3_late_evening_snack
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.eating3_late_evening_snack')
  }
  fields <- c(fields, "eating3_late_evening_snack")
  values <- c(values, if (is.null(eating3_late_evening_snack)) "NULL" else if (is(eating3_late_evening_snack, "subQuery")) paste0("(", as.character(eating3_late_evening_snack), ")") else paste0("'", as.character(eating3_late_evening_snack), "'"))

  if (missing(eating3_snack)) {
    eating3_snack <- defaults$eating3_snack
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.eating3_snack')
  }
  fields <- c(fields, "eating3_snack")
  values <- c(values, if (is.null(eating3_snack)) "NULL" else if (is(eating3_snack, "subQuery")) paste0("(", as.character(eating3_snack), ")") else paste0("'", as.character(eating3_snack), "'"))

  if (missing(eating_habit)) {
    eating_habit <- defaults$eating_habit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.eating_habit')
  }
  fields <- c(fields, "eating_habit")
  values <- c(values, if (is.null(eating_habit)) "NULL" else if (is(eating_habit, "subQuery")) paste0("(", as.character(eating_habit), ")") else paste0("'", as.character(eating_habit), "'"))

  if (missing(drinking_habit)) {
    drinking_habit <- defaults$drinking_habit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.drinking_habit')
  }
  fields <- c(fields, "drinking_habit")
  values <- c(values, if (is.null(drinking_habit)) "NULL" else if (is(drinking_habit, "subQuery")) paste0("(", as.character(drinking_habit), ")") else paste0("'", as.character(drinking_habit), "'"))

  if (missing(amount_drinking)) {
    amount_drinking <- defaults$amount_drinking
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.amount_drinking')
  }
  fields <- c(fields, "amount_drinking")
  values <- c(values, if (is.null(amount_drinking)) "NULL" else if (is(amount_drinking, "subQuery")) paste0("(", as.character(amount_drinking), ")") else paste0("'", as.character(amount_drinking), "'"))

  if (missing(sleep)) {
    sleep <- defaults$sleep
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.sleep')
  }
  fields <- c(fields, "sleep")
  values <- c(values, if (is.null(sleep)) "NULL" else if (is(sleep, "subQuery")) paste0("(", as.character(sleep), ")") else paste0("'", as.character(sleep), "'"))

  if (missing(drug1_hypertension)) {
    drug1_hypertension <- defaults$drug1_hypertension
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.drug1_hypertension')
  }
  fields <- c(fields, "drug1_hypertension")
  values <- c(values, if (is.null(drug1_hypertension)) "NULL" else if (is(drug1_hypertension, "subQuery")) paste0("(", as.character(drug1_hypertension), ")") else paste0("'", as.character(drug1_hypertension), "'"))

  if (missing(drug2_diabetes)) {
    drug2_diabetes <- defaults$drug2_diabetes
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.drug2_diabetes')
  }
  fields <- c(fields, "drug2_diabetes")
  values <- c(values, if (is.null(drug2_diabetes)) "NULL" else if (is(drug2_diabetes, "subQuery")) paste0("(", as.character(drug2_diabetes), ")") else paste0("'", as.character(drug2_diabetes), "'"))

  if (missing(drug3_hyperlipidemia)) {
    drug3_hyperlipidemia <- defaults$drug3_hyperlipidemia
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.drug3_hyperlipidemia')
  }
  fields <- c(fields, "drug3_hyperlipidemia")
  values <- c(values, if (is.null(drug3_hyperlipidemia)) "NULL" else if (is(drug3_hyperlipidemia, "subQuery")) paste0("(", as.character(drug3_hyperlipidemia), ")") else paste0("'", as.character(drug3_hyperlipidemia), "'"))

  if (missing(medical_history1_cerebrovascular)) {
    medical_history1_cerebrovascular <- defaults$medical_history1_cerebrovascular
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.medical_history1_cerebrovascular')
  }
  fields <- c(fields, "medical_history1_cerebrovascular")
  values <- c(values, if (is.null(medical_history1_cerebrovascular)) "NULL" else if (is(medical_history1_cerebrovascular, "subQuery")) paste0("(", as.character(medical_history1_cerebrovascular), ")") else paste0("'", as.character(medical_history1_cerebrovascular), "'"))

  if (missing(medical_history2_cardiovascular)) {
    medical_history2_cardiovascular <- defaults$medical_history2_cardiovascular
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.medical_history2_cardiovascular')
  }
  fields <- c(fields, "medical_history2_cardiovascular")
  values <- c(values, if (is.null(medical_history2_cardiovascular)) "NULL" else if (is(medical_history2_cardiovascular, "subQuery")) paste0("(", as.character(medical_history2_cardiovascular), ")") else paste0("'", as.character(medical_history2_cardiovascular), "'"))

  if (missing(medical_history3_renal)) {
    medical_history3_renal <- defaults$medical_history3_renal
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.medical_history3_renal')
  }
  fields <- c(fields, "medical_history3_renal")
  values <- c(values, if (is.null(medical_history3_renal)) "NULL" else if (is(medical_history3_renal, "subQuery")) paste0("(", as.character(medical_history3_renal), ")") else paste0("'", as.character(medical_history3_renal), "'"))

  if (missing(anemia)) {
    anemia <- defaults$anemia
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.anemia')
  }
  fields <- c(fields, "anemia")
  values <- c(values, if (is.null(anemia)) "NULL" else if (is(anemia, "subQuery")) paste0("(", as.character(anemia), ")") else paste0("'", as.character(anemia), "'"))

  if (missing(change_of_weight_from_age_of_twenty)) {
    change_of_weight_from_age_of_twenty <- defaults$change_of_weight_from_age_of_twenty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.change_of_weight_from_age_of_twenty')
  }
  fields <- c(fields, "change_of_weight_from_age_of_twenty")
  values <- c(values, if (is.null(change_of_weight_from_age_of_twenty)) "NULL" else if (is(change_of_weight_from_age_of_twenty, "subQuery")) paste0("(", as.character(change_of_weight_from_age_of_twenty), ")") else paste0("'", as.character(change_of_weight_from_age_of_twenty), "'"))

  if (missing(exercise_habit)) {
    exercise_habit <- defaults$exercise_habit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.exercise_habit')
  }
  fields <- c(fields, "exercise_habit")
  values <- c(values, if (is.null(exercise_habit)) "NULL" else if (is(exercise_habit, "subQuery")) paste0("(", as.character(exercise_habit), ")") else paste0("'", as.character(exercise_habit), "'"))

  if (missing(physical_activity)) {
    physical_activity <- defaults$physical_activity
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.physical_activity')
  }
  fields <- c(fields, "physical_activity")
  values <- c(values, if (is.null(physical_activity)) "NULL" else if (is(physical_activity, "subQuery")) paste0("(", as.character(physical_activity), ")") else paste0("'", as.character(physical_activity), "'"))

  if (missing(walking_speed)) {
    walking_speed <- defaults$walking_speed
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.walking_speed')
  }
  fields <- c(fields, "walking_speed")
  values <- c(values, if (is.null(walking_speed)) "NULL" else if (is(walking_speed, "subQuery")) paste0("(", as.character(walking_speed), ")") else paste0("'", as.character(walking_speed), "'"))

  if (missing(change_of_weight_in_a_year)) {
    change_of_weight_in_a_year <- defaults$change_of_weight_in_a_year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.change_of_weight_in_a_year')
  }
  fields <- c(fields, "change_of_weight_in_a_year")
  values <- c(values, if (is.null(change_of_weight_in_a_year)) "NULL" else if (is(change_of_weight_in_a_year, "subQuery")) paste0("(", as.character(change_of_weight_in_a_year), ")") else paste0("'", as.character(change_of_weight_in_a_year), "'"))

  if (missing(mastication)) {
    mastication <- defaults$mastication
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.mastication')
  }
  fields <- c(fields, "mastication")
  values <- c(values, if (is.null(mastication)) "NULL" else if (is(mastication, "subQuery")) paste0("(", as.character(mastication), ")") else paste0("'", as.character(mastication), "'"))

  if (missing(lifestyle_modification)) {
    lifestyle_modification <- defaults$lifestyle_modification
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.lifestyle_modification')
  }
  fields <- c(fields, "lifestyle_modification")
  values <- c(values, if (is.null(lifestyle_modification)) "NULL" else if (is(lifestyle_modification, "subQuery")) paste0("(", as.character(lifestyle_modification), ")") else paste0("'", as.character(lifestyle_modification), "'"))

  if (missing(request_for_health_guidance)) {
    request_for_health_guidance <- defaults$request_for_health_guidance
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.request_for_health_guidance')
  }
  fields <- c(fields, "request_for_health_guidance")
  values <- c(values, if (is.null(request_for_health_guidance)) "NULL" else if (is(request_for_health_guidance, "subQuery")) paste0("(", as.character(request_for_health_guidance), ")") else paste0("'", as.character(request_for_health_guidance), "'"))

  if (missing(serum_uric_acid)) {
    serum_uric_acid <- defaults$serum_uric_acid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.serum_uric_acid')
  }
  fields <- c(fields, "serum_uric_acid")
  values <- c(values, if (is.null(serum_uric_acid)) "NULL" else if (is(serum_uric_acid, "subQuery")) paste0("(", as.character(serum_uric_acid), ")") else paste0("'", as.character(serum_uric_acid), "'"))

  if (missing(serum_creatinine)) {
    serum_creatinine <- defaults$serum_creatinine
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.serum_creatinine')
  }
  fields <- c(fields, "serum_creatinine")
  values <- c(values, if (is.null(serum_creatinine)) "NULL" else if (is(serum_creatinine, "subQuery")) paste0("(", as.character(serum_creatinine), ")") else paste0("'", as.character(serum_creatinine), "'"))

  if (missing(total_cholesterol)) {
    total_cholesterol <- defaults$total_cholesterol
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'annual_health_checkup.total_cholesterol')
  }
  fields <- c(fields, "total_cholesterol")
  values <- c(values, if (is.null(total_cholesterol)) "NULL" else if (is(total_cholesterol, "subQuery")) paste0("(", as.character(total_cholesterol), ")") else paste0("'", as.character(total_cholesterol), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "annual_health_checkup", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_claim <- function(member_id, claim_id, type_of_claim, month_and_year_of_medical_care, paper_claim_flag, medical_facility_id, large_classification_of_department, medium_classification_of_department, department_on_claim_name, days_of_medical_care, admission_date, discharge_date, total_point) {
  defaults <- get('claim', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(claim_id)) {
    claim_id <- defaults$claim_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.claim_id')
  }
  fields <- c(fields, "claim_id")
  values <- c(values, if (is.null(claim_id)) "NULL" else if (is(claim_id, "subQuery")) paste0("(", as.character(claim_id), ")") else paste0("'", as.character(claim_id), "'"))

  if (missing(type_of_claim)) {
    type_of_claim <- defaults$type_of_claim
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.type_of_claim')
  }
  fields <- c(fields, "type_of_claim")
  values <- c(values, if (is.null(type_of_claim)) "NULL" else if (is(type_of_claim, "subQuery")) paste0("(", as.character(type_of_claim), ")") else paste0("'", as.character(type_of_claim), "'"))

  if (missing(month_and_year_of_medical_care)) {
    month_and_year_of_medical_care <- defaults$month_and_year_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.month_and_year_of_medical_care')
  }
  fields <- c(fields, "month_and_year_of_medical_care")
  values <- c(values, if (is.null(month_and_year_of_medical_care)) "NULL" else if (is(month_and_year_of_medical_care, "subQuery")) paste0("(", as.character(month_and_year_of_medical_care), ")") else paste0("'", as.character(month_and_year_of_medical_care), "'"))

  if (missing(paper_claim_flag)) {
    paper_claim_flag <- defaults$paper_claim_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.paper_claim_flag')
  }
  fields <- c(fields, "paper_claim_flag")
  values <- c(values, if (is.null(paper_claim_flag)) "NULL" else if (is(paper_claim_flag, "subQuery")) paste0("(", as.character(paper_claim_flag), ")") else paste0("'", as.character(paper_claim_flag), "'"))

  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(large_classification_of_department)) {
    large_classification_of_department <- defaults$large_classification_of_department
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.large_classification_of_department')
  }
  fields <- c(fields, "large_classification_of_department")
  values <- c(values, if (is.null(large_classification_of_department)) "NULL" else if (is(large_classification_of_department, "subQuery")) paste0("(", as.character(large_classification_of_department), ")") else paste0("'", as.character(large_classification_of_department), "'"))

  if (missing(medium_classification_of_department)) {
    medium_classification_of_department <- defaults$medium_classification_of_department
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.medium_classification_of_department')
  }
  fields <- c(fields, "medium_classification_of_department")
  values <- c(values, if (is.null(medium_classification_of_department)) "NULL" else if (is(medium_classification_of_department, "subQuery")) paste0("(", as.character(medium_classification_of_department), ")") else paste0("'", as.character(medium_classification_of_department), "'"))

  if (missing(department_on_claim_name)) {
    department_on_claim_name <- defaults$department_on_claim_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.department_on_claim_name')
  }
  fields <- c(fields, "department_on_claim_name")
  values <- c(values, if (is.null(department_on_claim_name)) "NULL" else if (is(department_on_claim_name, "subQuery")) paste0("(", as.character(department_on_claim_name), ")") else paste0("'", as.character(department_on_claim_name), "'"))

  if (missing(days_of_medical_care)) {
    days_of_medical_care <- defaults$days_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.days_of_medical_care')
  }
  fields <- c(fields, "days_of_medical_care")
  values <- c(values, if (is.null(days_of_medical_care)) "NULL" else if (is(days_of_medical_care, "subQuery")) paste0("(", as.character(days_of_medical_care), ")") else paste0("'", as.character(days_of_medical_care), "'"))

  if (missing(admission_date)) {
    admission_date <- defaults$admission_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.admission_date')
  }
  fields <- c(fields, "admission_date")
  values <- c(values, if (is.null(admission_date)) "NULL" else if (is(admission_date, "subQuery")) paste0("(", as.character(admission_date), ")") else paste0("'", as.character(admission_date), "'"))

  if (missing(discharge_date)) {
    discharge_date <- defaults$discharge_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.discharge_date')
  }
  fields <- c(fields, "discharge_date")
  values <- c(values, if (is.null(discharge_date)) "NULL" else if (is(discharge_date, "subQuery")) paste0("(", as.character(discharge_date), ")") else paste0("'", as.character(discharge_date), "'"))

  if (missing(total_point)) {
    total_point <- defaults$total_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'claim.total_point')
  }
  fields <- c(fields, "total_point")
  values <- c(values, if (is.null(total_point)) "NULL" else if (is(total_point, "subQuery")) paste0("(", as.character(total_point), ")") else paste0("'", as.character(total_point), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "claim", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_version <- function(version_id, version_date) {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(version_id)) {
    version_id <- defaults$version_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'version.version_id')
  }
  fields <- c(fields, "version_id")
  values <- c(values, if (is.null(version_id)) "NULL" else if (is(version_id, "subQuery")) paste0("(", as.character(version_id), ")") else paste0("'", as.character(version_id), "'"))

  if (missing(version_date)) {
    version_date <- defaults$version_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'version.version_date')
  }
  fields <- c(fields, "version_date")
  values <- c(values, if (is.null(version_date)) "NULL" else if (is(version_date, "subQuery")) paste0("(", as.character(version_date), ")") else paste0("'", as.character(version_date), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_version", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_material_master <- function(standardized_material_code, standardized_material_version, standardized_material_name, unit, material_category_large_classification_name, material_category_medium_classification_name, material_code) {
  defaults <- get('material_master', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(standardized_material_code)) {
    standardized_material_code <- defaults$standardized_material_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.standardized_material_code')
  }
  fields <- c(fields, "standardized_material_code")
  values <- c(values, if (is.null(standardized_material_code)) "NULL" else if (is(standardized_material_code, "subQuery")) paste0("(", as.character(standardized_material_code), ")") else paste0("'", as.character(standardized_material_code), "'"))

  if (missing(standardized_material_version)) {
    standardized_material_version <- defaults$standardized_material_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.standardized_material_version')
  }
  fields <- c(fields, "standardized_material_version")
  values <- c(values, if (is.null(standardized_material_version)) "NULL" else if (is(standardized_material_version, "subQuery")) paste0("(", as.character(standardized_material_version), ")") else paste0("'", as.character(standardized_material_version), "'"))

  if (missing(standardized_material_name)) {
    standardized_material_name <- defaults$standardized_material_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.standardized_material_name')
  }
  fields <- c(fields, "standardized_material_name")
  values <- c(values, if (is.null(standardized_material_name)) "NULL" else if (is(standardized_material_name, "subQuery")) paste0("(", as.character(standardized_material_name), ")") else paste0("'", as.character(standardized_material_name), "'"))

  if (missing(unit)) {
    unit <- defaults$unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.unit')
  }
  fields <- c(fields, "unit")
  values <- c(values, if (is.null(unit)) "NULL" else if (is(unit, "subQuery")) paste0("(", as.character(unit), ")") else paste0("'", as.character(unit), "'"))

  if (missing(material_category_large_classification_name)) {
    material_category_large_classification_name <- defaults$material_category_large_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.material_category_large_classification_name')
  }
  fields <- c(fields, "material_category_large_classification_name")
  values <- c(values, if (is.null(material_category_large_classification_name)) "NULL" else if (is(material_category_large_classification_name, "subQuery")) paste0("(", as.character(material_category_large_classification_name), ")") else paste0("'", as.character(material_category_large_classification_name), "'"))

  if (missing(material_category_medium_classification_name)) {
    material_category_medium_classification_name <- defaults$material_category_medium_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.material_category_medium_classification_name')
  }
  fields <- c(fields, "material_category_medium_classification_name")
  values <- c(values, if (is.null(material_category_medium_classification_name)) "NULL" else if (is(material_category_medium_classification_name, "subQuery")) paste0("(", as.character(material_category_medium_classification_name), ")") else paste0("'", as.character(material_category_medium_classification_name), "'"))

  if (missing(material_code)) {
    material_code <- defaults$material_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material_master.material_code')
  }
  fields <- c(fields, "material_code")
  values <- c(values, if (is.null(material_code)) "NULL" else if (is(material_code, "subQuery")) paste0("(", as.character(material_code), ")") else paste0("'", as.character(material_code), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "material_master", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_drug_master <- function(jmdc_drug_code, drug_name, standardized_unit, atc_level1_code, atc_level1_name, atc_level2_code, atc_level2_name, atc_level3_code, atc_level3_name, atc_level4_code, atc_level4_name, who_atc_code, who_atc_name, drug_code, yj_code, receipt_computerized_processing_code, general_name, brand_name, generic_drug_flag, formulation_large_classification_name, formulation_medium_classification_name, formulation_small_classification_name, titer, titer_unit) {
  defaults <- get('drug_master', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(jmdc_drug_code)) {
    jmdc_drug_code <- defaults$jmdc_drug_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.jmdc_drug_code')
  }
  fields <- c(fields, "jmdc_drug_code")
  values <- c(values, if (is.null(jmdc_drug_code)) "NULL" else if (is(jmdc_drug_code, "subQuery")) paste0("(", as.character(jmdc_drug_code), ")") else paste0("'", as.character(jmdc_drug_code), "'"))

  if (missing(drug_name)) {
    drug_name <- defaults$drug_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.drug_name')
  }
  fields <- c(fields, "drug_name")
  values <- c(values, if (is.null(drug_name)) "NULL" else if (is(drug_name, "subQuery")) paste0("(", as.character(drug_name), ")") else paste0("'", as.character(drug_name), "'"))

  if (missing(standardized_unit)) {
    standardized_unit <- defaults$standardized_unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.standardized_unit')
  }
  fields <- c(fields, "standardized_unit")
  values <- c(values, if (is.null(standardized_unit)) "NULL" else if (is(standardized_unit, "subQuery")) paste0("(", as.character(standardized_unit), ")") else paste0("'", as.character(standardized_unit), "'"))

  if (missing(atc_level1_code)) {
    atc_level1_code <- defaults$atc_level1_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level1_code')
  }
  fields <- c(fields, "atc_level1_code")
  values <- c(values, if (is.null(atc_level1_code)) "NULL" else if (is(atc_level1_code, "subQuery")) paste0("(", as.character(atc_level1_code), ")") else paste0("'", as.character(atc_level1_code), "'"))

  if (missing(atc_level1_name)) {
    atc_level1_name <- defaults$atc_level1_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level1_name')
  }
  fields <- c(fields, "atc_level1_name")
  values <- c(values, if (is.null(atc_level1_name)) "NULL" else if (is(atc_level1_name, "subQuery")) paste0("(", as.character(atc_level1_name), ")") else paste0("'", as.character(atc_level1_name), "'"))

  if (missing(atc_level2_code)) {
    atc_level2_code <- defaults$atc_level2_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level2_code')
  }
  fields <- c(fields, "atc_level2_code")
  values <- c(values, if (is.null(atc_level2_code)) "NULL" else if (is(atc_level2_code, "subQuery")) paste0("(", as.character(atc_level2_code), ")") else paste0("'", as.character(atc_level2_code), "'"))

  if (missing(atc_level2_name)) {
    atc_level2_name <- defaults$atc_level2_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level2_name')
  }
  fields <- c(fields, "atc_level2_name")
  values <- c(values, if (is.null(atc_level2_name)) "NULL" else if (is(atc_level2_name, "subQuery")) paste0("(", as.character(atc_level2_name), ")") else paste0("'", as.character(atc_level2_name), "'"))

  if (missing(atc_level3_code)) {
    atc_level3_code <- defaults$atc_level3_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level3_code')
  }
  fields <- c(fields, "atc_level3_code")
  values <- c(values, if (is.null(atc_level3_code)) "NULL" else if (is(atc_level3_code, "subQuery")) paste0("(", as.character(atc_level3_code), ")") else paste0("'", as.character(atc_level3_code), "'"))

  if (missing(atc_level3_name)) {
    atc_level3_name <- defaults$atc_level3_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level3_name')
  }
  fields <- c(fields, "atc_level3_name")
  values <- c(values, if (is.null(atc_level3_name)) "NULL" else if (is(atc_level3_name, "subQuery")) paste0("(", as.character(atc_level3_name), ")") else paste0("'", as.character(atc_level3_name), "'"))

  if (missing(atc_level4_code)) {
    atc_level4_code <- defaults$atc_level4_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level4_code')
  }
  fields <- c(fields, "atc_level4_code")
  values <- c(values, if (is.null(atc_level4_code)) "NULL" else if (is(atc_level4_code, "subQuery")) paste0("(", as.character(atc_level4_code), ")") else paste0("'", as.character(atc_level4_code), "'"))

  if (missing(atc_level4_name)) {
    atc_level4_name <- defaults$atc_level4_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.atc_level4_name')
  }
  fields <- c(fields, "atc_level4_name")
  values <- c(values, if (is.null(atc_level4_name)) "NULL" else if (is(atc_level4_name, "subQuery")) paste0("(", as.character(atc_level4_name), ")") else paste0("'", as.character(atc_level4_name), "'"))

  if (missing(who_atc_code)) {
    who_atc_code <- defaults$who_atc_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.who_atc_code')
  }
  fields <- c(fields, "who_atc_code")
  values <- c(values, if (is.null(who_atc_code)) "NULL" else if (is(who_atc_code, "subQuery")) paste0("(", as.character(who_atc_code), ")") else paste0("'", as.character(who_atc_code), "'"))

  if (missing(who_atc_name)) {
    who_atc_name <- defaults$who_atc_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.who_atc_name')
  }
  fields <- c(fields, "who_atc_name")
  values <- c(values, if (is.null(who_atc_name)) "NULL" else if (is(who_atc_name, "subQuery")) paste0("(", as.character(who_atc_name), ")") else paste0("'", as.character(who_atc_name), "'"))

  if (missing(drug_code)) {
    drug_code <- defaults$drug_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.drug_code')
  }
  fields <- c(fields, "drug_code")
  values <- c(values, if (is.null(drug_code)) "NULL" else if (is(drug_code, "subQuery")) paste0("(", as.character(drug_code), ")") else paste0("'", as.character(drug_code), "'"))

  if (missing(yj_code)) {
    yj_code <- defaults$yj_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.yj_code')
  }
  fields <- c(fields, "yj_code")
  values <- c(values, if (is.null(yj_code)) "NULL" else if (is(yj_code, "subQuery")) paste0("(", as.character(yj_code), ")") else paste0("'", as.character(yj_code), "'"))

  if (missing(receipt_computerized_processing_code)) {
    receipt_computerized_processing_code <- defaults$receipt_computerized_processing_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.receipt_computerized_processing_code')
  }
  fields <- c(fields, "receipt_computerized_processing_code")
  values <- c(values, if (is.null(receipt_computerized_processing_code)) "NULL" else if (is(receipt_computerized_processing_code, "subQuery")) paste0("(", as.character(receipt_computerized_processing_code), ")") else paste0("'", as.character(receipt_computerized_processing_code), "'"))

  if (missing(general_name)) {
    general_name <- defaults$general_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.general_name')
  }
  fields <- c(fields, "general_name")
  values <- c(values, if (is.null(general_name)) "NULL" else if (is(general_name, "subQuery")) paste0("(", as.character(general_name), ")") else paste0("'", as.character(general_name), "'"))

  if (missing(brand_name)) {
    brand_name <- defaults$brand_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.brand_name')
  }
  fields <- c(fields, "brand_name")
  values <- c(values, if (is.null(brand_name)) "NULL" else if (is(brand_name, "subQuery")) paste0("(", as.character(brand_name), ")") else paste0("'", as.character(brand_name), "'"))

  if (missing(generic_drug_flag)) {
    generic_drug_flag <- defaults$generic_drug_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.generic_drug_flag')
  }
  fields <- c(fields, "generic_drug_flag")
  values <- c(values, if (is.null(generic_drug_flag)) "NULL" else if (is(generic_drug_flag, "subQuery")) paste0("(", as.character(generic_drug_flag), ")") else paste0("'", as.character(generic_drug_flag), "'"))

  if (missing(formulation_large_classification_name)) {
    formulation_large_classification_name <- defaults$formulation_large_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.formulation_large_classification_name')
  }
  fields <- c(fields, "formulation_large_classification_name")
  values <- c(values, if (is.null(formulation_large_classification_name)) "NULL" else if (is(formulation_large_classification_name, "subQuery")) paste0("(", as.character(formulation_large_classification_name), ")") else paste0("'", as.character(formulation_large_classification_name), "'"))

  if (missing(formulation_medium_classification_name)) {
    formulation_medium_classification_name <- defaults$formulation_medium_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.formulation_medium_classification_name')
  }
  fields <- c(fields, "formulation_medium_classification_name")
  values <- c(values, if (is.null(formulation_medium_classification_name)) "NULL" else if (is(formulation_medium_classification_name, "subQuery")) paste0("(", as.character(formulation_medium_classification_name), ")") else paste0("'", as.character(formulation_medium_classification_name), "'"))

  if (missing(formulation_small_classification_name)) {
    formulation_small_classification_name <- defaults$formulation_small_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.formulation_small_classification_name')
  }
  fields <- c(fields, "formulation_small_classification_name")
  values <- c(values, if (is.null(formulation_small_classification_name)) "NULL" else if (is(formulation_small_classification_name, "subQuery")) paste0("(", as.character(formulation_small_classification_name), ")") else paste0("'", as.character(formulation_small_classification_name), "'"))

  if (missing(titer)) {
    titer <- defaults$titer
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.titer')
  }
  fields <- c(fields, "titer")
  values <- c(values, if (is.null(titer)) "NULL" else if (is(titer, "subQuery")) paste0("(", as.character(titer), ")") else paste0("'", as.character(titer), "'"))

  if (missing(titer_unit)) {
    titer_unit <- defaults$titer_unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_master.titer_unit')
  }
  fields <- c(fields, "titer_unit")
  values <- c(values, if (is.null(titer_unit)) "NULL" else if (is(titer_unit, "subQuery")) paste0("(", as.character(titer_unit), ")") else paste0("'", as.character(titer_unit), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "drug_master", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_enrollment <- function(member_id, month_and_year_of_birth_of_member, gender_of_member, family_id, insured_or_dependent, relationship, observation_start, observation_end, withdrawal_death_flag) {
  defaults <- get('enrollment', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(month_and_year_of_birth_of_member)) {
    month_and_year_of_birth_of_member <- defaults$month_and_year_of_birth_of_member
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.month_and_year_of_birth_of_member')
  }
  fields <- c(fields, "month_and_year_of_birth_of_member")
  values <- c(values, if (is.null(month_and_year_of_birth_of_member)) "NULL" else if (is(month_and_year_of_birth_of_member, "subQuery")) paste0("(", as.character(month_and_year_of_birth_of_member), ")") else paste0("'", as.character(month_and_year_of_birth_of_member), "'"))

  if (missing(gender_of_member)) {
    gender_of_member <- defaults$gender_of_member
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.gender_of_member')
  }
  fields <- c(fields, "gender_of_member")
  values <- c(values, if (is.null(gender_of_member)) "NULL" else if (is(gender_of_member, "subQuery")) paste0("(", as.character(gender_of_member), ")") else paste0("'", as.character(gender_of_member), "'"))

  if (missing(family_id)) {
    family_id <- defaults$family_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.family_id')
  }
  fields <- c(fields, "family_id")
  values <- c(values, if (is.null(family_id)) "NULL" else if (is(family_id, "subQuery")) paste0("(", as.character(family_id), ")") else paste0("'", as.character(family_id), "'"))

  if (missing(insured_or_dependent)) {
    insured_or_dependent <- defaults$insured_or_dependent
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.insured_or_dependent')
  }
  fields <- c(fields, "insured_or_dependent")
  values <- c(values, if (is.null(insured_or_dependent)) "NULL" else if (is(insured_or_dependent, "subQuery")) paste0("(", as.character(insured_or_dependent), ")") else paste0("'", as.character(insured_or_dependent), "'"))

  if (missing(relationship)) {
    relationship <- defaults$relationship
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.relationship')
  }
  fields <- c(fields, "relationship")
  values <- c(values, if (is.null(relationship)) "NULL" else if (is(relationship, "subQuery")) paste0("(", as.character(relationship), ")") else paste0("'", as.character(relationship), "'"))

  if (missing(observation_start)) {
    observation_start <- defaults$observation_start
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.observation_start')
  }
  fields <- c(fields, "observation_start")
  values <- c(values, if (is.null(observation_start)) "NULL" else if (is(observation_start, "subQuery")) paste0("(", as.character(observation_start), ")") else paste0("'", as.character(observation_start), "'"))

  if (missing(observation_end)) {
    observation_end <- defaults$observation_end
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.observation_end')
  }
  fields <- c(fields, "observation_end")
  values <- c(values, if (is.null(observation_end)) "NULL" else if (is(observation_end, "subQuery")) paste0("(", as.character(observation_end), ")") else paste0("'", as.character(observation_end), "'"))

  if (missing(withdrawal_death_flag)) {
    withdrawal_death_flag <- defaults$withdrawal_death_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment.withdrawal_death_flag')
  }
  fields <- c(fields, "withdrawal_death_flag")
  values <- c(values, if (is.null(withdrawal_death_flag)) "NULL" else if (is(withdrawal_death_flag, "subQuery")) paste0("(", as.character(withdrawal_death_flag), ")") else paste0("'", as.character(withdrawal_death_flag), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "enrollment", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_diagnosis <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, medical_facility_id, standard_disease_code, standard_disease_name, main_disease_flag, causative_disease_flag, suspicion_flag, date_of_medical_care_start, outcome, outcome_death_flag, outcome_exacerbation_flag) {
  defaults <- get('diagnosis', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(claim_id)) {
    claim_id <- defaults$claim_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.claim_id')
  }
  fields <- c(fields, "claim_id")
  values <- c(values, if (is.null(claim_id)) "NULL" else if (is(claim_id, "subQuery")) paste0("(", as.character(claim_id), ")") else paste0("'", as.character(claim_id), "'"))

  if (missing(statement_id)) {
    statement_id <- defaults$statement_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.statement_id')
  }
  fields <- c(fields, "statement_id")
  values <- c(values, if (is.null(statement_id)) "NULL" else if (is(statement_id, "subQuery")) paste0("(", as.character(statement_id), ")") else paste0("'", as.character(statement_id), "'"))

  if (missing(type_of_claim)) {
    type_of_claim <- defaults$type_of_claim
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.type_of_claim')
  }
  fields <- c(fields, "type_of_claim")
  values <- c(values, if (is.null(type_of_claim)) "NULL" else if (is(type_of_claim, "subQuery")) paste0("(", as.character(type_of_claim), ")") else paste0("'", as.character(type_of_claim), "'"))

  if (missing(month_and_year_of_medical_care)) {
    month_and_year_of_medical_care <- defaults$month_and_year_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.month_and_year_of_medical_care')
  }
  fields <- c(fields, "month_and_year_of_medical_care")
  values <- c(values, if (is.null(month_and_year_of_medical_care)) "NULL" else if (is(month_and_year_of_medical_care, "subQuery")) paste0("(", as.character(month_and_year_of_medical_care), ")") else paste0("'", as.character(month_and_year_of_medical_care), "'"))

  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(standard_disease_code)) {
    standard_disease_code <- defaults$standard_disease_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.standard_disease_code')
  }
  fields <- c(fields, "standard_disease_code")
  values <- c(values, if (is.null(standard_disease_code)) "NULL" else if (is(standard_disease_code, "subQuery")) paste0("(", as.character(standard_disease_code), ")") else paste0("'", as.character(standard_disease_code), "'"))

  if (missing(standard_disease_name)) {
    standard_disease_name <- defaults$standard_disease_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.standard_disease_name')
  }
  fields <- c(fields, "standard_disease_name")
  values <- c(values, if (is.null(standard_disease_name)) "NULL" else if (is(standard_disease_name, "subQuery")) paste0("(", as.character(standard_disease_name), ")") else paste0("'", as.character(standard_disease_name), "'"))

  if (missing(main_disease_flag)) {
    main_disease_flag <- defaults$main_disease_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.main_disease_flag')
  }
  fields <- c(fields, "main_disease_flag")
  values <- c(values, if (is.null(main_disease_flag)) "NULL" else if (is(main_disease_flag, "subQuery")) paste0("(", as.character(main_disease_flag), ")") else paste0("'", as.character(main_disease_flag), "'"))

  if (missing(causative_disease_flag)) {
    causative_disease_flag <- defaults$causative_disease_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.causative_disease_flag')
  }
  fields <- c(fields, "causative_disease_flag")
  values <- c(values, if (is.null(causative_disease_flag)) "NULL" else if (is(causative_disease_flag, "subQuery")) paste0("(", as.character(causative_disease_flag), ")") else paste0("'", as.character(causative_disease_flag), "'"))

  if (missing(suspicion_flag)) {
    suspicion_flag <- defaults$suspicion_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.suspicion_flag')
  }
  fields <- c(fields, "suspicion_flag")
  values <- c(values, if (is.null(suspicion_flag)) "NULL" else if (is(suspicion_flag, "subQuery")) paste0("(", as.character(suspicion_flag), ")") else paste0("'", as.character(suspicion_flag), "'"))

  if (missing(date_of_medical_care_start)) {
    date_of_medical_care_start <- defaults$date_of_medical_care_start
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.date_of_medical_care_start')
  }
  fields <- c(fields, "date_of_medical_care_start")
  values <- c(values, if (is.null(date_of_medical_care_start)) "NULL" else if (is(date_of_medical_care_start, "subQuery")) paste0("(", as.character(date_of_medical_care_start), ")") else paste0("'", as.character(date_of_medical_care_start), "'"))

  if (missing(outcome)) {
    outcome <- defaults$outcome
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.outcome')
  }
  fields <- c(fields, "outcome")
  values <- c(values, if (is.null(outcome)) "NULL" else if (is(outcome, "subQuery")) paste0("(", as.character(outcome), ")") else paste0("'", as.character(outcome), "'"))

  if (missing(outcome_death_flag)) {
    outcome_death_flag <- defaults$outcome_death_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.outcome_death_flag')
  }
  fields <- c(fields, "outcome_death_flag")
  values <- c(values, if (is.null(outcome_death_flag)) "NULL" else if (is(outcome_death_flag, "subQuery")) paste0("(", as.character(outcome_death_flag), ")") else paste0("'", as.character(outcome_death_flag), "'"))

  if (missing(outcome_exacerbation_flag)) {
    outcome_exacerbation_flag <- defaults$outcome_exacerbation_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis.outcome_exacerbation_flag')
  }
  fields <- c(fields, "outcome_exacerbation_flag")
  values <- c(values, if (is.null(outcome_exacerbation_flag)) "NULL" else if (is(outcome_exacerbation_flag, "subQuery")) paste0("(", as.character(outcome_exacerbation_flag), ")") else paste0("'", as.character(outcome_exacerbation_flag), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "diagnosis", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_material <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, date_of_material, medical_facility_id, standardized_material_code, standardized_material_version, standardized_material_name, unit_on_claims, unit, material_usage, number_of_material, concurrent_id, category_of_medical_care, material_standard_price, material_standard_additional_rate, actual_point) {
  defaults <- get('material', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(claim_id)) {
    claim_id <- defaults$claim_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.claim_id')
  }
  fields <- c(fields, "claim_id")
  values <- c(values, if (is.null(claim_id)) "NULL" else if (is(claim_id, "subQuery")) paste0("(", as.character(claim_id), ")") else paste0("'", as.character(claim_id), "'"))

  if (missing(statement_id)) {
    statement_id <- defaults$statement_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.statement_id')
  }
  fields <- c(fields, "statement_id")
  values <- c(values, if (is.null(statement_id)) "NULL" else if (is(statement_id, "subQuery")) paste0("(", as.character(statement_id), ")") else paste0("'", as.character(statement_id), "'"))

  if (missing(type_of_claim)) {
    type_of_claim <- defaults$type_of_claim
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.type_of_claim')
  }
  fields <- c(fields, "type_of_claim")
  values <- c(values, if (is.null(type_of_claim)) "NULL" else if (is(type_of_claim, "subQuery")) paste0("(", as.character(type_of_claim), ")") else paste0("'", as.character(type_of_claim), "'"))

  if (missing(month_and_year_of_medical_care)) {
    month_and_year_of_medical_care <- defaults$month_and_year_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.month_and_year_of_medical_care')
  }
  fields <- c(fields, "month_and_year_of_medical_care")
  values <- c(values, if (is.null(month_and_year_of_medical_care)) "NULL" else if (is(month_and_year_of_medical_care, "subQuery")) paste0("(", as.character(month_and_year_of_medical_care), ")") else paste0("'", as.character(month_and_year_of_medical_care), "'"))

  if (missing(date_of_material)) {
    date_of_material <- defaults$date_of_material
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.date_of_material')
  }
  fields <- c(fields, "date_of_material")
  values <- c(values, if (is.null(date_of_material)) "NULL" else if (is(date_of_material, "subQuery")) paste0("(", as.character(date_of_material), ")") else paste0("'", as.character(date_of_material), "'"))

  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(standardized_material_code)) {
    standardized_material_code <- defaults$standardized_material_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.standardized_material_code')
  }
  fields <- c(fields, "standardized_material_code")
  values <- c(values, if (is.null(standardized_material_code)) "NULL" else if (is(standardized_material_code, "subQuery")) paste0("(", as.character(standardized_material_code), ")") else paste0("'", as.character(standardized_material_code), "'"))

  if (missing(standardized_material_version)) {
    standardized_material_version <- defaults$standardized_material_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.standardized_material_version')
  }
  fields <- c(fields, "standardized_material_version")
  values <- c(values, if (is.null(standardized_material_version)) "NULL" else if (is(standardized_material_version, "subQuery")) paste0("(", as.character(standardized_material_version), ")") else paste0("'", as.character(standardized_material_version), "'"))

  if (missing(standardized_material_name)) {
    standardized_material_name <- defaults$standardized_material_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.standardized_material_name')
  }
  fields <- c(fields, "standardized_material_name")
  values <- c(values, if (is.null(standardized_material_name)) "NULL" else if (is(standardized_material_name, "subQuery")) paste0("(", as.character(standardized_material_name), ")") else paste0("'", as.character(standardized_material_name), "'"))

  if (missing(unit_on_claims)) {
    unit_on_claims <- defaults$unit_on_claims
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.unit_on_claims')
  }
  fields <- c(fields, "unit_on_claims")
  values <- c(values, if (is.null(unit_on_claims)) "NULL" else if (is(unit_on_claims, "subQuery")) paste0("(", as.character(unit_on_claims), ")") else paste0("'", as.character(unit_on_claims), "'"))

  if (missing(unit)) {
    unit <- defaults$unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.unit')
  }
  fields <- c(fields, "unit")
  values <- c(values, if (is.null(unit)) "NULL" else if (is(unit, "subQuery")) paste0("(", as.character(unit), ")") else paste0("'", as.character(unit), "'"))

  if (missing(material_usage)) {
    material_usage <- defaults$material_usage
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.material_usage')
  }
  fields <- c(fields, "material_usage")
  values <- c(values, if (is.null(material_usage)) "NULL" else if (is(material_usage, "subQuery")) paste0("(", as.character(material_usage), ")") else paste0("'", as.character(material_usage), "'"))

  if (missing(number_of_material)) {
    number_of_material <- defaults$number_of_material
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.number_of_material')
  }
  fields <- c(fields, "number_of_material")
  values <- c(values, if (is.null(number_of_material)) "NULL" else if (is(number_of_material, "subQuery")) paste0("(", as.character(number_of_material), ")") else paste0("'", as.character(number_of_material), "'"))

  if (missing(concurrent_id)) {
    concurrent_id <- defaults$concurrent_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.concurrent_id')
  }
  fields <- c(fields, "concurrent_id")
  values <- c(values, if (is.null(concurrent_id)) "NULL" else if (is(concurrent_id, "subQuery")) paste0("(", as.character(concurrent_id), ")") else paste0("'", as.character(concurrent_id), "'"))

  if (missing(category_of_medical_care)) {
    category_of_medical_care <- defaults$category_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.category_of_medical_care')
  }
  fields <- c(fields, "category_of_medical_care")
  values <- c(values, if (is.null(category_of_medical_care)) "NULL" else if (is(category_of_medical_care, "subQuery")) paste0("(", as.character(category_of_medical_care), ")") else paste0("'", as.character(category_of_medical_care), "'"))

  if (missing(material_standard_price)) {
    material_standard_price <- defaults$material_standard_price
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.material_standard_price')
  }
  fields <- c(fields, "material_standard_price")
  values <- c(values, if (is.null(material_standard_price)) "NULL" else if (is(material_standard_price, "subQuery")) paste0("(", as.character(material_standard_price), ")") else paste0("'", as.character(material_standard_price), "'"))

  if (missing(material_standard_additional_rate)) {
    material_standard_additional_rate <- defaults$material_standard_additional_rate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.material_standard_additional_rate')
  }
  fields <- c(fields, "material_standard_additional_rate")
  values <- c(values, if (is.null(material_standard_additional_rate)) "NULL" else if (is(material_standard_additional_rate, "subQuery")) paste0("(", as.character(material_standard_additional_rate), ")") else paste0("'", as.character(material_standard_additional_rate), "'"))

  if (missing(actual_point)) {
    actual_point <- defaults$actual_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'material.actual_point')
  }
  fields <- c(fields, "actual_point")
  values <- c(values, if (is.null(actual_point)) "NULL" else if (is(actual_point, "subQuery")) paste0("(", as.character(actual_point), ")") else paste0("'", as.character(actual_point), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "material", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_medical_facility <- function(medical_facility_id, number_of_beds, hpgp, large_classification_of_department, medium_classification_of_department, management_body, home_care_support_clinic, designated_cancer_care_hospitals, medical_institution_introducing_dpc, special_functioning_hospitals) {
  defaults <- get('medical_facility', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(number_of_beds)) {
    number_of_beds <- defaults$number_of_beds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.number_of_beds')
  }
  fields <- c(fields, "number_of_beds")
  values <- c(values, if (is.null(number_of_beds)) "NULL" else if (is(number_of_beds, "subQuery")) paste0("(", as.character(number_of_beds), ")") else paste0("'", as.character(number_of_beds), "'"))

  if (missing(hpgp)) {
    hpgp <- defaults$hpgp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.hpgp')
  }
  fields <- c(fields, "hpgp")
  values <- c(values, if (is.null(hpgp)) "NULL" else if (is(hpgp, "subQuery")) paste0("(", as.character(hpgp), ")") else paste0("'", as.character(hpgp), "'"))

  if (missing(large_classification_of_department)) {
    large_classification_of_department <- defaults$large_classification_of_department
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.large_classification_of_department')
  }
  fields <- c(fields, "large_classification_of_department")
  values <- c(values, if (is.null(large_classification_of_department)) "NULL" else if (is(large_classification_of_department, "subQuery")) paste0("(", as.character(large_classification_of_department), ")") else paste0("'", as.character(large_classification_of_department), "'"))

  if (missing(medium_classification_of_department)) {
    medium_classification_of_department <- defaults$medium_classification_of_department
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.medium_classification_of_department')
  }
  fields <- c(fields, "medium_classification_of_department")
  values <- c(values, if (is.null(medium_classification_of_department)) "NULL" else if (is(medium_classification_of_department, "subQuery")) paste0("(", as.character(medium_classification_of_department), ")") else paste0("'", as.character(medium_classification_of_department), "'"))

  if (missing(management_body)) {
    management_body <- defaults$management_body
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.management_body')
  }
  fields <- c(fields, "management_body")
  values <- c(values, if (is.null(management_body)) "NULL" else if (is(management_body, "subQuery")) paste0("(", as.character(management_body), ")") else paste0("'", as.character(management_body), "'"))

  if (missing(home_care_support_clinic)) {
    home_care_support_clinic <- defaults$home_care_support_clinic
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.home_care_support_clinic')
  }
  fields <- c(fields, "home_care_support_clinic")
  values <- c(values, if (is.null(home_care_support_clinic)) "NULL" else if (is(home_care_support_clinic, "subQuery")) paste0("(", as.character(home_care_support_clinic), ")") else paste0("'", as.character(home_care_support_clinic), "'"))

  if (missing(designated_cancer_care_hospitals)) {
    designated_cancer_care_hospitals <- defaults$designated_cancer_care_hospitals
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.designated_cancer_care_hospitals')
  }
  fields <- c(fields, "designated_cancer_care_hospitals")
  values <- c(values, if (is.null(designated_cancer_care_hospitals)) "NULL" else if (is(designated_cancer_care_hospitals, "subQuery")) paste0("(", as.character(designated_cancer_care_hospitals), ")") else paste0("'", as.character(designated_cancer_care_hospitals), "'"))

  if (missing(medical_institution_introducing_dpc)) {
    medical_institution_introducing_dpc <- defaults$medical_institution_introducing_dpc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.medical_institution_introducing_dpc')
  }
  fields <- c(fields, "medical_institution_introducing_dpc")
  values <- c(values, if (is.null(medical_institution_introducing_dpc)) "NULL" else if (is(medical_institution_introducing_dpc, "subQuery")) paste0("(", as.character(medical_institution_introducing_dpc), ")") else paste0("'", as.character(medical_institution_introducing_dpc), "'"))

  if (missing(special_functioning_hospitals)) {
    special_functioning_hospitals <- defaults$special_functioning_hospitals
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_facility.special_functioning_hospitals')
  }
  fields <- c(fields, "special_functioning_hospitals")
  values <- c(values, if (is.null(special_functioning_hospitals)) "NULL" else if (is(special_functioning_hospitals, "subQuery")) paste0("(", as.character(special_functioning_hospitals), ")") else paste0("'", as.character(special_functioning_hospitals), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "medical_facility", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_drug <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, medical_facility_id, jmdc_drug_code, drug_name, drug_price, date_of_prescription, date_of_dispense, prescribed_amount_per_day, unit_of_administered_amount, administered_days, administered_amount, concurrent_id, as_needed_medication_flag, category_of_medical_care, cost_of_total_administrated_drug, pharmacy_charge, drug_charge, additional_charge, actual_point, total_point) {
  defaults <- get('drug', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(claim_id)) {
    claim_id <- defaults$claim_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.claim_id')
  }
  fields <- c(fields, "claim_id")
  values <- c(values, if (is.null(claim_id)) "NULL" else if (is(claim_id, "subQuery")) paste0("(", as.character(claim_id), ")") else paste0("'", as.character(claim_id), "'"))

  if (missing(statement_id)) {
    statement_id <- defaults$statement_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.statement_id')
  }
  fields <- c(fields, "statement_id")
  values <- c(values, if (is.null(statement_id)) "NULL" else if (is(statement_id, "subQuery")) paste0("(", as.character(statement_id), ")") else paste0("'", as.character(statement_id), "'"))

  if (missing(type_of_claim)) {
    type_of_claim <- defaults$type_of_claim
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.type_of_claim')
  }
  fields <- c(fields, "type_of_claim")
  values <- c(values, if (is.null(type_of_claim)) "NULL" else if (is(type_of_claim, "subQuery")) paste0("(", as.character(type_of_claim), ")") else paste0("'", as.character(type_of_claim), "'"))

  if (missing(month_and_year_of_medical_care)) {
    month_and_year_of_medical_care <- defaults$month_and_year_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.month_and_year_of_medical_care')
  }
  fields <- c(fields, "month_and_year_of_medical_care")
  values <- c(values, if (is.null(month_and_year_of_medical_care)) "NULL" else if (is(month_and_year_of_medical_care, "subQuery")) paste0("(", as.character(month_and_year_of_medical_care), ")") else paste0("'", as.character(month_and_year_of_medical_care), "'"))

  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(jmdc_drug_code)) {
    jmdc_drug_code <- defaults$jmdc_drug_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.jmdc_drug_code')
  }
  fields <- c(fields, "jmdc_drug_code")
  values <- c(values, if (is.null(jmdc_drug_code)) "NULL" else if (is(jmdc_drug_code, "subQuery")) paste0("(", as.character(jmdc_drug_code), ")") else paste0("'", as.character(jmdc_drug_code), "'"))

  if (missing(drug_name)) {
    drug_name <- defaults$drug_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.drug_name')
  }
  fields <- c(fields, "drug_name")
  values <- c(values, if (is.null(drug_name)) "NULL" else if (is(drug_name, "subQuery")) paste0("(", as.character(drug_name), ")") else paste0("'", as.character(drug_name), "'"))

  if (missing(drug_price)) {
    drug_price <- defaults$drug_price
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.drug_price')
  }
  fields <- c(fields, "drug_price")
  values <- c(values, if (is.null(drug_price)) "NULL" else if (is(drug_price, "subQuery")) paste0("(", as.character(drug_price), ")") else paste0("'", as.character(drug_price), "'"))

  if (missing(date_of_prescription)) {
    date_of_prescription <- defaults$date_of_prescription
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.date_of_prescription')
  }
  fields <- c(fields, "date_of_prescription")
  values <- c(values, if (is.null(date_of_prescription)) "NULL" else if (is(date_of_prescription, "subQuery")) paste0("(", as.character(date_of_prescription), ")") else paste0("'", as.character(date_of_prescription), "'"))

  if (missing(date_of_dispense)) {
    date_of_dispense <- defaults$date_of_dispense
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.date_of_dispense')
  }
  fields <- c(fields, "date_of_dispense")
  values <- c(values, if (is.null(date_of_dispense)) "NULL" else if (is(date_of_dispense, "subQuery")) paste0("(", as.character(date_of_dispense), ")") else paste0("'", as.character(date_of_dispense), "'"))

  if (missing(prescribed_amount_per_day)) {
    prescribed_amount_per_day <- defaults$prescribed_amount_per_day
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.prescribed_amount_per_day')
  }
  fields <- c(fields, "prescribed_amount_per_day")
  values <- c(values, if (is.null(prescribed_amount_per_day)) "NULL" else if (is(prescribed_amount_per_day, "subQuery")) paste0("(", as.character(prescribed_amount_per_day), ")") else paste0("'", as.character(prescribed_amount_per_day), "'"))

  if (missing(unit_of_administered_amount)) {
    unit_of_administered_amount <- defaults$unit_of_administered_amount
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.unit_of_administered_amount')
  }
  fields <- c(fields, "unit_of_administered_amount")
  values <- c(values, if (is.null(unit_of_administered_amount)) "NULL" else if (is(unit_of_administered_amount, "subQuery")) paste0("(", as.character(unit_of_administered_amount), ")") else paste0("'", as.character(unit_of_administered_amount), "'"))

  if (missing(administered_days)) {
    administered_days <- defaults$administered_days
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.administered_days')
  }
  fields <- c(fields, "administered_days")
  values <- c(values, if (is.null(administered_days)) "NULL" else if (is(administered_days, "subQuery")) paste0("(", as.character(administered_days), ")") else paste0("'", as.character(administered_days), "'"))

  if (missing(administered_amount)) {
    administered_amount <- defaults$administered_amount
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.administered_amount')
  }
  fields <- c(fields, "administered_amount")
  values <- c(values, if (is.null(administered_amount)) "NULL" else if (is(administered_amount, "subQuery")) paste0("(", as.character(administered_amount), ")") else paste0("'", as.character(administered_amount), "'"))

  if (missing(concurrent_id)) {
    concurrent_id <- defaults$concurrent_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.concurrent_id')
  }
  fields <- c(fields, "concurrent_id")
  values <- c(values, if (is.null(concurrent_id)) "NULL" else if (is(concurrent_id, "subQuery")) paste0("(", as.character(concurrent_id), ")") else paste0("'", as.character(concurrent_id), "'"))

  if (missing(as_needed_medication_flag)) {
    as_needed_medication_flag <- defaults$as_needed_medication_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.as_needed_medication_flag')
  }
  fields <- c(fields, "as_needed_medication_flag")
  values <- c(values, if (is.null(as_needed_medication_flag)) "NULL" else if (is(as_needed_medication_flag, "subQuery")) paste0("(", as.character(as_needed_medication_flag), ")") else paste0("'", as.character(as_needed_medication_flag), "'"))

  if (missing(category_of_medical_care)) {
    category_of_medical_care <- defaults$category_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.category_of_medical_care')
  }
  fields <- c(fields, "category_of_medical_care")
  values <- c(values, if (is.null(category_of_medical_care)) "NULL" else if (is(category_of_medical_care, "subQuery")) paste0("(", as.character(category_of_medical_care), ")") else paste0("'", as.character(category_of_medical_care), "'"))

  if (missing(cost_of_total_administrated_drug)) {
    cost_of_total_administrated_drug <- defaults$cost_of_total_administrated_drug
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.cost_of_total_administrated_drug')
  }
  fields <- c(fields, "cost_of_total_administrated_drug")
  values <- c(values, if (is.null(cost_of_total_administrated_drug)) "NULL" else if (is(cost_of_total_administrated_drug, "subQuery")) paste0("(", as.character(cost_of_total_administrated_drug), ")") else paste0("'", as.character(cost_of_total_administrated_drug), "'"))

  if (missing(pharmacy_charge)) {
    pharmacy_charge <- defaults$pharmacy_charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.pharmacy_charge')
  }
  fields <- c(fields, "pharmacy_charge")
  values <- c(values, if (is.null(pharmacy_charge)) "NULL" else if (is(pharmacy_charge, "subQuery")) paste0("(", as.character(pharmacy_charge), ")") else paste0("'", as.character(pharmacy_charge), "'"))

  if (missing(drug_charge)) {
    drug_charge <- defaults$drug_charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.drug_charge')
  }
  fields <- c(fields, "drug_charge")
  values <- c(values, if (is.null(drug_charge)) "NULL" else if (is(drug_charge, "subQuery")) paste0("(", as.character(drug_charge), ")") else paste0("'", as.character(drug_charge), "'"))

  if (missing(additional_charge)) {
    additional_charge <- defaults$additional_charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.additional_charge')
  }
  fields <- c(fields, "additional_charge")
  values <- c(values, if (is.null(additional_charge)) "NULL" else if (is(additional_charge, "subQuery")) paste0("(", as.character(additional_charge), ")") else paste0("'", as.character(additional_charge), "'"))

  if (missing(actual_point)) {
    actual_point <- defaults$actual_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.actual_point')
  }
  fields <- c(fields, "actual_point")
  values <- c(values, if (is.null(actual_point)) "NULL" else if (is(actual_point, "subQuery")) paste0("(", as.character(actual_point), ")") else paste0("'", as.character(actual_point), "'"))

  if (missing(total_point)) {
    total_point <- defaults$total_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug.total_point')
  }
  fields <- c(fields, "total_point")
  values <- c(values, if (is.null(total_point)) "NULL" else if (is(total_point, "subQuery")) paste0("(", as.character(total_point), ")") else paste0("'", as.character(total_point), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "drug", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_procedure_master <- function(standardized_procedure_code, standardized_procedure_version, standardized_procedure_name, procedure_category_medium_classification_name, procedure_category_small_classification_name, procedure_category_subclassification_name, procedure_category_sub_and_detail_classification_name, procedure_code, icd9cm_level1, icd9cm_level2, icd9cm_level3) {
  defaults <- get('procedure_master', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(standardized_procedure_code)) {
    standardized_procedure_code <- defaults$standardized_procedure_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.standardized_procedure_code')
  }
  fields <- c(fields, "standardized_procedure_code")
  values <- c(values, if (is.null(standardized_procedure_code)) "NULL" else if (is(standardized_procedure_code, "subQuery")) paste0("(", as.character(standardized_procedure_code), ")") else paste0("'", as.character(standardized_procedure_code), "'"))

  if (missing(standardized_procedure_version)) {
    standardized_procedure_version <- defaults$standardized_procedure_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.standardized_procedure_version')
  }
  fields <- c(fields, "standardized_procedure_version")
  values <- c(values, if (is.null(standardized_procedure_version)) "NULL" else if (is(standardized_procedure_version, "subQuery")) paste0("(", as.character(standardized_procedure_version), ")") else paste0("'", as.character(standardized_procedure_version), "'"))

  if (missing(standardized_procedure_name)) {
    standardized_procedure_name <- defaults$standardized_procedure_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.standardized_procedure_name')
  }
  fields <- c(fields, "standardized_procedure_name")
  values <- c(values, if (is.null(standardized_procedure_name)) "NULL" else if (is(standardized_procedure_name, "subQuery")) paste0("(", as.character(standardized_procedure_name), ")") else paste0("'", as.character(standardized_procedure_name), "'"))

  if (missing(procedure_category_medium_classification_name)) {
    procedure_category_medium_classification_name <- defaults$procedure_category_medium_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.procedure_category_medium_classification_name')
  }
  fields <- c(fields, "procedure_category_medium_classification_name")
  values <- c(values, if (is.null(procedure_category_medium_classification_name)) "NULL" else if (is(procedure_category_medium_classification_name, "subQuery")) paste0("(", as.character(procedure_category_medium_classification_name), ")") else paste0("'", as.character(procedure_category_medium_classification_name), "'"))

  if (missing(procedure_category_small_classification_name)) {
    procedure_category_small_classification_name <- defaults$procedure_category_small_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.procedure_category_small_classification_name')
  }
  fields <- c(fields, "procedure_category_small_classification_name")
  values <- c(values, if (is.null(procedure_category_small_classification_name)) "NULL" else if (is(procedure_category_small_classification_name, "subQuery")) paste0("(", as.character(procedure_category_small_classification_name), ")") else paste0("'", as.character(procedure_category_small_classification_name), "'"))

  if (missing(procedure_category_subclassification_name)) {
    procedure_category_subclassification_name <- defaults$procedure_category_subclassification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.procedure_category_subclassification_name')
  }
  fields <- c(fields, "procedure_category_subclassification_name")
  values <- c(values, if (is.null(procedure_category_subclassification_name)) "NULL" else if (is(procedure_category_subclassification_name, "subQuery")) paste0("(", as.character(procedure_category_subclassification_name), ")") else paste0("'", as.character(procedure_category_subclassification_name), "'"))

  if (missing(procedure_category_sub_and_detail_classification_name)) {
    procedure_category_sub_and_detail_classification_name <- defaults$procedure_category_sub_and_detail_classification_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.procedure_category_sub_and_detail_classification_name')
  }
  fields <- c(fields, "procedure_category_sub_and_detail_classification_name")
  values <- c(values, if (is.null(procedure_category_sub_and_detail_classification_name)) "NULL" else if (is(procedure_category_sub_and_detail_classification_name, "subQuery")) paste0("(", as.character(procedure_category_sub_and_detail_classification_name), ")") else paste0("'", as.character(procedure_category_sub_and_detail_classification_name), "'"))

  if (missing(procedure_code)) {
    procedure_code <- defaults$procedure_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.procedure_code')
  }
  fields <- c(fields, "procedure_code")
  values <- c(values, if (is.null(procedure_code)) "NULL" else if (is(procedure_code, "subQuery")) paste0("(", as.character(procedure_code), ")") else paste0("'", as.character(procedure_code), "'"))

  if (missing(icd9cm_level1)) {
    icd9cm_level1 <- defaults$icd9cm_level1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.icd9cm_level1')
  }
  fields <- c(fields, "icd9cm_level1")
  values <- c(values, if (is.null(icd9cm_level1)) "NULL" else if (is(icd9cm_level1, "subQuery")) paste0("(", as.character(icd9cm_level1), ")") else paste0("'", as.character(icd9cm_level1), "'"))

  if (missing(icd9cm_level2)) {
    icd9cm_level2 <- defaults$icd9cm_level2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.icd9cm_level2')
  }
  fields <- c(fields, "icd9cm_level2")
  values <- c(values, if (is.null(icd9cm_level2)) "NULL" else if (is(icd9cm_level2, "subQuery")) paste0("(", as.character(icd9cm_level2), ")") else paste0("'", as.character(icd9cm_level2), "'"))

  if (missing(icd9cm_level3)) {
    icd9cm_level3 <- defaults$icd9cm_level3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure_master.icd9cm_level3')
  }
  fields <- c(fields, "icd9cm_level3")
  values <- c(values, if (is.null(icd9cm_level3)) "NULL" else if (is(icd9cm_level3, "subQuery")) paste0("(", as.character(icd9cm_level3), ")") else paste0("'", as.character(icd9cm_level3), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "procedure_master", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_diagnosis_master <- function(standard_disease_code, standard_disease_name, icd10_level1_code, icd10_level1_name, icd10_level2_code, icd10_level2_name, icd10_level3_code, icd10_level3_name, icd10_level4_code, icd10_level4_name) {
  defaults <- get('diagnosis_master', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(standard_disease_code)) {
    standard_disease_code <- defaults$standard_disease_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.standard_disease_code')
  }
  fields <- c(fields, "standard_disease_code")
  values <- c(values, if (is.null(standard_disease_code)) "NULL" else if (is(standard_disease_code, "subQuery")) paste0("(", as.character(standard_disease_code), ")") else paste0("'", as.character(standard_disease_code), "'"))

  if (missing(standard_disease_name)) {
    standard_disease_name <- defaults$standard_disease_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.standard_disease_name')
  }
  fields <- c(fields, "standard_disease_name")
  values <- c(values, if (is.null(standard_disease_name)) "NULL" else if (is(standard_disease_name, "subQuery")) paste0("(", as.character(standard_disease_name), ")") else paste0("'", as.character(standard_disease_name), "'"))

  if (missing(icd10_level1_code)) {
    icd10_level1_code <- defaults$icd10_level1_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level1_code')
  }
  fields <- c(fields, "icd10_level1_code")
  values <- c(values, if (is.null(icd10_level1_code)) "NULL" else if (is(icd10_level1_code, "subQuery")) paste0("(", as.character(icd10_level1_code), ")") else paste0("'", as.character(icd10_level1_code), "'"))

  if (missing(icd10_level1_name)) {
    icd10_level1_name <- defaults$icd10_level1_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level1_name')
  }
  fields <- c(fields, "icd10_level1_name")
  values <- c(values, if (is.null(icd10_level1_name)) "NULL" else if (is(icd10_level1_name, "subQuery")) paste0("(", as.character(icd10_level1_name), ")") else paste0("'", as.character(icd10_level1_name), "'"))

  if (missing(icd10_level2_code)) {
    icd10_level2_code <- defaults$icd10_level2_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level2_code')
  }
  fields <- c(fields, "icd10_level2_code")
  values <- c(values, if (is.null(icd10_level2_code)) "NULL" else if (is(icd10_level2_code, "subQuery")) paste0("(", as.character(icd10_level2_code), ")") else paste0("'", as.character(icd10_level2_code), "'"))

  if (missing(icd10_level2_name)) {
    icd10_level2_name <- defaults$icd10_level2_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level2_name')
  }
  fields <- c(fields, "icd10_level2_name")
  values <- c(values, if (is.null(icd10_level2_name)) "NULL" else if (is(icd10_level2_name, "subQuery")) paste0("(", as.character(icd10_level2_name), ")") else paste0("'", as.character(icd10_level2_name), "'"))

  if (missing(icd10_level3_code)) {
    icd10_level3_code <- defaults$icd10_level3_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level3_code')
  }
  fields <- c(fields, "icd10_level3_code")
  values <- c(values, if (is.null(icd10_level3_code)) "NULL" else if (is(icd10_level3_code, "subQuery")) paste0("(", as.character(icd10_level3_code), ")") else paste0("'", as.character(icd10_level3_code), "'"))

  if (missing(icd10_level3_name)) {
    icd10_level3_name <- defaults$icd10_level3_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level3_name')
  }
  fields <- c(fields, "icd10_level3_name")
  values <- c(values, if (is.null(icd10_level3_name)) "NULL" else if (is(icd10_level3_name, "subQuery")) paste0("(", as.character(icd10_level3_name), ")") else paste0("'", as.character(icd10_level3_name), "'"))

  if (missing(icd10_level4_code)) {
    icd10_level4_code <- defaults$icd10_level4_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level4_code')
  }
  fields <- c(fields, "icd10_level4_code")
  values <- c(values, if (is.null(icd10_level4_code)) "NULL" else if (is(icd10_level4_code, "subQuery")) paste0("(", as.character(icd10_level4_code), ")") else paste0("'", as.character(icd10_level4_code), "'"))

  if (missing(icd10_level4_name)) {
    icd10_level4_name <- defaults$icd10_level4_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'diagnosis_master.icd10_level4_name')
  }
  fields <- c(fields, "icd10_level4_name")
  values <- c(values, if (is.null(icd10_level4_name)) "NULL" else if (is(icd10_level4_name, "subQuery")) paste0("(", as.character(icd10_level4_name), ")") else paste0("'", as.character(icd10_level4_name), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "diagnosis_master", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_procedure <- function(member_id, claim_id, statement_id, type_of_claim, month_and_year_of_medical_care, date_of_procedure, medical_facility_id, standardized_procedure_code, standardized_procedure_version, standardized_procedure_name, number_of_times, concurrent_id, category_of_medical_care, procedure_standard_point, procedure_standard_additional_rate, procedure_standard_price, actual_point) {
  defaults <- get('procedure', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(member_id)) {
    member_id <- defaults$member_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.member_id')
  }
  fields <- c(fields, "member_id")
  values <- c(values, if (is.null(member_id)) "NULL" else if (is(member_id, "subQuery")) paste0("(", as.character(member_id), ")") else paste0("'", as.character(member_id), "'"))

  if (missing(claim_id)) {
    claim_id <- defaults$claim_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.claim_id')
  }
  fields <- c(fields, "claim_id")
  values <- c(values, if (is.null(claim_id)) "NULL" else if (is(claim_id, "subQuery")) paste0("(", as.character(claim_id), ")") else paste0("'", as.character(claim_id), "'"))

  if (missing(statement_id)) {
    statement_id <- defaults$statement_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.statement_id')
  }
  fields <- c(fields, "statement_id")
  values <- c(values, if (is.null(statement_id)) "NULL" else if (is(statement_id, "subQuery")) paste0("(", as.character(statement_id), ")") else paste0("'", as.character(statement_id), "'"))

  if (missing(type_of_claim)) {
    type_of_claim <- defaults$type_of_claim
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.type_of_claim')
  }
  fields <- c(fields, "type_of_claim")
  values <- c(values, if (is.null(type_of_claim)) "NULL" else if (is(type_of_claim, "subQuery")) paste0("(", as.character(type_of_claim), ")") else paste0("'", as.character(type_of_claim), "'"))

  if (missing(month_and_year_of_medical_care)) {
    month_and_year_of_medical_care <- defaults$month_and_year_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.month_and_year_of_medical_care')
  }
  fields <- c(fields, "month_and_year_of_medical_care")
  values <- c(values, if (is.null(month_and_year_of_medical_care)) "NULL" else if (is(month_and_year_of_medical_care, "subQuery")) paste0("(", as.character(month_and_year_of_medical_care), ")") else paste0("'", as.character(month_and_year_of_medical_care), "'"))

  if (missing(date_of_procedure)) {
    date_of_procedure <- defaults$date_of_procedure
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.date_of_procedure')
  }
  fields <- c(fields, "date_of_procedure")
  values <- c(values, if (is.null(date_of_procedure)) "NULL" else if (is(date_of_procedure, "subQuery")) paste0("(", as.character(date_of_procedure), ")") else paste0("'", as.character(date_of_procedure), "'"))

  if (missing(medical_facility_id)) {
    medical_facility_id <- defaults$medical_facility_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.medical_facility_id')
  }
  fields <- c(fields, "medical_facility_id")
  values <- c(values, if (is.null(medical_facility_id)) "NULL" else if (is(medical_facility_id, "subQuery")) paste0("(", as.character(medical_facility_id), ")") else paste0("'", as.character(medical_facility_id), "'"))

  if (missing(standardized_procedure_code)) {
    standardized_procedure_code <- defaults$standardized_procedure_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.standardized_procedure_code')
  }
  fields <- c(fields, "standardized_procedure_code")
  values <- c(values, if (is.null(standardized_procedure_code)) "NULL" else if (is(standardized_procedure_code, "subQuery")) paste0("(", as.character(standardized_procedure_code), ")") else paste0("'", as.character(standardized_procedure_code), "'"))

  if (missing(standardized_procedure_version)) {
    standardized_procedure_version <- defaults$standardized_procedure_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.standardized_procedure_version')
  }
  fields <- c(fields, "standardized_procedure_version")
  values <- c(values, if (is.null(standardized_procedure_version)) "NULL" else if (is(standardized_procedure_version, "subQuery")) paste0("(", as.character(standardized_procedure_version), ")") else paste0("'", as.character(standardized_procedure_version), "'"))

  if (missing(standardized_procedure_name)) {
    standardized_procedure_name <- defaults$standardized_procedure_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.standardized_procedure_name')
  }
  fields <- c(fields, "standardized_procedure_name")
  values <- c(values, if (is.null(standardized_procedure_name)) "NULL" else if (is(standardized_procedure_name, "subQuery")) paste0("(", as.character(standardized_procedure_name), ")") else paste0("'", as.character(standardized_procedure_name), "'"))

  if (missing(number_of_times)) {
    number_of_times <- defaults$number_of_times
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.number_of_times')
  }
  fields <- c(fields, "number_of_times")
  values <- c(values, if (is.null(number_of_times)) "NULL" else if (is(number_of_times, "subQuery")) paste0("(", as.character(number_of_times), ")") else paste0("'", as.character(number_of_times), "'"))

  if (missing(concurrent_id)) {
    concurrent_id <- defaults$concurrent_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.concurrent_id')
  }
  fields <- c(fields, "concurrent_id")
  values <- c(values, if (is.null(concurrent_id)) "NULL" else if (is(concurrent_id, "subQuery")) paste0("(", as.character(concurrent_id), ")") else paste0("'", as.character(concurrent_id), "'"))

  if (missing(category_of_medical_care)) {
    category_of_medical_care <- defaults$category_of_medical_care
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.category_of_medical_care')
  }
  fields <- c(fields, "category_of_medical_care")
  values <- c(values, if (is.null(category_of_medical_care)) "NULL" else if (is(category_of_medical_care, "subQuery")) paste0("(", as.character(category_of_medical_care), ")") else paste0("'", as.character(category_of_medical_care), "'"))

  if (missing(procedure_standard_point)) {
    procedure_standard_point <- defaults$procedure_standard_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.procedure_standard_point')
  }
  fields <- c(fields, "procedure_standard_point")
  values <- c(values, if (is.null(procedure_standard_point)) "NULL" else if (is(procedure_standard_point, "subQuery")) paste0("(", as.character(procedure_standard_point), ")") else paste0("'", as.character(procedure_standard_point), "'"))

  if (missing(procedure_standard_additional_rate)) {
    procedure_standard_additional_rate <- defaults$procedure_standard_additional_rate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.procedure_standard_additional_rate')
  }
  fields <- c(fields, "procedure_standard_additional_rate")
  values <- c(values, if (is.null(procedure_standard_additional_rate)) "NULL" else if (is(procedure_standard_additional_rate, "subQuery")) paste0("(", as.character(procedure_standard_additional_rate), ")") else paste0("'", as.character(procedure_standard_additional_rate), "'"))

  if (missing(procedure_standard_price)) {
    procedure_standard_price <- defaults$procedure_standard_price
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.procedure_standard_price')
  }
  fields <- c(fields, "procedure_standard_price")
  values <- c(values, if (is.null(procedure_standard_price)) "NULL" else if (is(procedure_standard_price, "subQuery")) paste0("(", as.character(procedure_standard_price), ")") else paste0("'", as.character(procedure_standard_price), "'"))

  if (missing(actual_point)) {
    actual_point <- defaults$actual_point
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'procedure.actual_point')
  }
  fields <- c(fields, "actual_point")
  values <- c(values, if (is.null(actual_point)) "NULL" else if (is(actual_point, "subQuery")) paste0("(", as.character(actual_point), ")") else paste0("'", as.character(actual_point), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "procedure", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

expect_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_concept_id')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.parent_visit_detail_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_date')
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.production_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_concept_id')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_event_id')
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.meas_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_death <- function(person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.person_id')
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_date')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_datetime')
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_type_concept_id')
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_concept_id')
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_value')
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "death", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note <- function(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_concept_id')
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cost <- function(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_domain_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_charge')
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_cost')
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_paid')
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_payer')
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_patient')
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_copay')
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_coinsurance')
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_deductible')
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_primary')
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_ingredient_cost')
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_dispensing_fee')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.amount_allowed')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_date')
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_date')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_date')
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_date')
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_date')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_episode <- function(episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.person_id')
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_concept_id')
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_date')
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_datetime')
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_date')
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_datetime')
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_parent_id')
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_number')
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_object_concept_id')
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_type_concept_id')
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_value')
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "episode", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_episode_event <- function(episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_id')
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.event_id')
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "episode_event", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_metadata <- function(metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_id')
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_number')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version_concept_id')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_definition_id')
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.subject_id')
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_start_date')
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cohort", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_id')
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_name')
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_description')
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.definition_type_concept_id')
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_syntax')
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.subject_concept_id')
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_initiation_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cohort_definition", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_death <- function(person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "death", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note <- function(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cost <- function(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_episode <- function(episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "episode", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_episode_event <- function(episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "episode_event", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_metadata <- function(metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cohort", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cohort_definition", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_person <- function(rowCount, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "person", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation_period <- function(rowCount, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_occurrence <- function(rowCount, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_concept_id')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_detail <- function(rowCount, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.parent_visit_detail_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_detail", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_occurrence <- function(rowCount, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_exposure <- function(rowCount, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_procedure_occurrence <- function(rowCount, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_date')
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "procedure_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_device_exposure <- function(rowCount, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.production_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "device_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_measurement <- function(rowCount, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_concept_id')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_event_id')
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.meas_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "measurement", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation <- function(rowCount, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_death <- function(rowCount, person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.person_id')
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_date')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_datetime')
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_type_concept_id')
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_concept_id')
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_value')
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "death", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note <- function(rowCount, note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note_nlp <- function(rowCount, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note_nlp", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_specimen <- function(rowCount, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "specimen", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_fact_relationship <- function(rowCount, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "fact_relationship", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_location <- function(rowCount, location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_concept_id')
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "location", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_care_site <- function(rowCount, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "care_site", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_provider <- function(rowCount, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "provider", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_payer_plan_period <- function(rowCount, payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "payer_plan_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cost <- function(rowCount, cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_domain_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_charge')
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_cost')
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_paid')
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_payer')
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_patient')
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_copay')
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_coinsurance')
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_deductible')
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_primary')
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_ingredient_cost')
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_dispensing_fee')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.amount_allowed')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cost", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_era <- function(rowCount, drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_date')
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_date')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_dose_era <- function(rowCount, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_date')
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "dose_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_era <- function(rowCount, condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_date')
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_date')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_episode <- function(rowCount, episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.person_id')
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_concept_id')
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_date')
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_datetime')
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_date')
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_datetime')
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_parent_id')
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_number')
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_object_concept_id')
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_type_concept_id')
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_value')
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "episode", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_episode_event <- function(rowCount, episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_id')
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.event_id')
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "episode_event", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_metadata <- function(rowCount, metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_id')
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_number')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "metadata", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cdm_source <- function(rowCount, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version_concept_id')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cdm_source", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cohort <- function(rowCount, cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_definition_id')
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.subject_id')
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_start_date')
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cohort", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cohort_definition <- function(rowCount, cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_id')
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_name')
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_description')
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.definition_type_concept_id')
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_syntax')
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.subject_concept_id')
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_initiation_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cohort_definition", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

lookup_person <- function(fetchField, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.person WHERE')
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id",if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth",if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " month_of_birth",if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " day_of_birth",if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " birth_datetime",if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_concept_id",if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_concept_id",if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_source_value",if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value",if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id",if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_value",if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_concept_id",if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_value",if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_concept_id",if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation_period <- function(fetchField, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation_period WHERE')
  first <- TRUE
  if (!missing(observation_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_id",if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_start_date",if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_end_date",if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " period_type_concept_id",if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_occurrence <- function(fetchField, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_occurrence WHERE')
  first <- TRUE
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_concept_id",if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_date",if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_datetime",if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_date",if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_datetime",if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_type_concept_id",if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_value",if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_concept_id",if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_concept_id",if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_source_value",if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_concept_id",if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_source_value",if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_occurrence_id",if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_detail <- function(fetchField, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_detail WHERE')
  first <- TRUE
  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_concept_id",if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_date",if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_datetime",if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_date",if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_datetime",if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_type_concept_id",if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_value",if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_concept_id",if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_concept_id",if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_source_value",if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_source_value",if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_concept_id",if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_detail_id",if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(parent_visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " parent_visit_detail_id",if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_occurrence <- function(fetchField, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_occurrence WHERE')
  first <- TRUE
  if (!missing(condition_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_id",if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id",if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_date",if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_datetime",if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_date",if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_datetime",if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_type_concept_id",if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_concept_id",if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason",if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_value",if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_concept_id",if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_source_value",if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_exposure <- function(fetchField, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_exposure WHERE')
  first <- TRUE
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_id",if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_date",if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_datetime",if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_date",if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_datetime",if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " verbatim_end_date",if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_type_concept_id",if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason",if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " refills",if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " days_supply",if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sig",if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_concept_id",if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lot_number",if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_value",if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_concept_id",if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_source_value",if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_unit_source_value",if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_procedure_occurrence <- function(fetchField, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.procedure_occurrence WHERE')
  first <- TRUE
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_occurrence_id",if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_concept_id",if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_date",if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_datetime",if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_end_date",if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
  }

  if (!missing(procedure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_end_datetime",if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_type_concept_id",if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_concept_id",if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_value",if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_concept_id",if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_source_value",if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_device_exposure <- function(fetchField, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.device_exposure WHERE')
  first <- TRUE
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_id",if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_concept_id",if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_date",if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_datetime",if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_date",if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_datetime",if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_type_concept_id",if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unique_device_id",if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
  }

  if (!missing(production_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " production_id",if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_value",if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_concept_id",if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_concept_id",if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_measurement <- function(fetchField, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.measurement WHERE')
  first <- TRUE
  if (!missing(measurement_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_id",if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_concept_id",if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_date",if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_datetime",if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_time",if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_type_concept_id",if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " operator_concept_id",if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_low",if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_high",if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_value",if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_concept_id",if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_concept_id",if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_source_value",if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(measurement_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_event_id",if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
  }

  if (!missing(meas_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " meas_event_field_concept_id",if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation <- function(fetchField, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation WHERE')
  first <- TRUE
  if (!missing(observation_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_id",if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_concept_id",if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_date",if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_datetime",if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_type_concept_id",if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string",if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_concept_id",if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_value",if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_concept_id",if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_source_value",if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_source_value",if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_event_id",if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " obs_event_field_concept_id",if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_death <- function(fetchField, person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.death WHERE')
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(death_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_date",if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
  }

  if (!missing(death_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_datetime",if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
  }

  if (!missing(death_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_type_concept_id",if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
  }

  if (!missing(cause_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_concept_id",if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
  }

  if (!missing(cause_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_source_value",if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
  }

  if (!missing(cause_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_source_concept_id",if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note <- function(fetchField, note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note WHERE')
  first <- TRUE
  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id",if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(note_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_date",if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_datetime",if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_type_concept_id",if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_class_concept_id",if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_title",if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_text",if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " encoding_concept_id",if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " language_concept_id",if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_source_value",if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
  }

  if (!missing(note_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_id",if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_field_concept_id",if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note_nlp <- function(fetchField, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note_nlp WHERE')
  first <- TRUE
  if (!missing(note_nlp_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_id",if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id",if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " section_concept_id",if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " snippet",if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
  }

  if (!missing(offset)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " offset",if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
  }

  if (!missing(lexical_variant)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lexical_variant",if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_concept_id",if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_source_concept_id",if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_system",if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_date",if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_datetime",if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_exists",if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_temporal",if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_modifiers",if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_specimen <- function(fetchField, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.specimen WHERE')
  first <- TRUE
  if (!missing(specimen_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_id",if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_concept_id",if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_type_concept_id",if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_date",if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_datetime",if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_concept_id",if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_concept_id",if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_id",if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_value",if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_source_value",if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_source_value",if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_fact_relationship <- function(fetchField, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.fact_relationship WHERE')
  first <- TRUE
  if (!missing(domain_concept_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_1",if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_1",if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_2",if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_2",if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " relationship_concept_id",if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_location <- function(fetchField, location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.location WHERE')
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_1",if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_2",if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " city",if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
  }

  if (!missing(state)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " state",if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
  }

  if (!missing(zip)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " zip",if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
  }

  if (!missing(county)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " county",if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
  }

  if (!missing(location_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_source_value",if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
  }

  if (!missing(country_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " country_concept_id",if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
  }

  if (!missing(country_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " country_source_value",if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
  }

  if (!missing(latitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " latitude",if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " longitude",if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_care_site <- function(fetchField, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.care_site WHERE')
  first <- TRUE
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_name",if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_concept_id",if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_source_value",if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_source_value",if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_provider <- function(fetchField, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.provider WHERE')
  first <- TRUE
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_name",if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " npi",if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dea",if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_concept_id",if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth",if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id",if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_source_value",if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_value",if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_concept_id",if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value",if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id",if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_payer_plan_period <- function(fetchField, payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.payer_plan_period WHERE')
  first <- TRUE
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id",if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_start_date",if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_end_date",if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_concept_id",if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_value",if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_concept_id",if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_concept_id",if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_value",if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_concept_id",if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_concept_id",if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_value",if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_concept_id",if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " family_source_value",if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_concept_id",if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_value",if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_concept_id",if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cost <- function(fetchField, cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cost WHERE')
  first <- TRUE
  if (!missing(cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_id",if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
  }

  if (!missing(cost_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_event_id",if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_domain_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_domain_id",if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_type_concept_id",if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " currency_concept_id",if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
  }

  if (!missing(total_charge)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_charge",if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
  }

  if (!missing(total_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_cost",if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
  }

  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_paid",if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
  }

  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_payer",if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
  }

  if (!missing(paid_by_patient)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_patient",if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
  }

  if (!missing(paid_patient_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_copay",if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
  }

  if (!missing(paid_patient_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_coinsurance",if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
  }

  if (!missing(paid_patient_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_deductible",if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
  }

  if (!missing(paid_by_primary)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_primary",if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
  }

  if (!missing(paid_ingredient_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_ingredient_cost",if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
  }

  if (!missing(paid_dispensing_fee)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_dispensing_fee",if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id",if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(amount_allowed)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " amount_allowed",if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_concept_id",if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_source_value",if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_concept_id",if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
  }

  if (!missing(drg_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_source_value",if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_era <- function(fetchField, drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_era WHERE')
  first <- TRUE
  if (!missing(drug_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_id",if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_start_date",if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_end_date",if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
  }

  if (!missing(drug_exposure_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_count",if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gap_days",if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_dose_era <- function(fetchField, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.dose_era WHERE')
  first <- TRUE
  if (!missing(dose_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_id",if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_value",if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_start_date",if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
  }

  if (!missing(dose_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_end_date",if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_era <- function(fetchField, condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_era WHERE')
  first <- TRUE
  if (!missing(condition_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_id",if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id",if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_start_date",if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
  }

  if (!missing(condition_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_end_date",if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_count",if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_episode <- function(fetchField, episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.episode WHERE')
  first <- TRUE
  if (!missing(episode_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_id",if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(episode_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_concept_id",if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
  }

  if (!missing(episode_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_start_date",if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
  }

  if (!missing(episode_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_start_datetime",if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
  }

  if (!missing(episode_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_end_date",if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
  }

  if (!missing(episode_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_end_datetime",if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
  }

  if (!missing(episode_parent_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_parent_id",if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
  }

  if (!missing(episode_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_number",if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
  }

  if (!missing(episode_object_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_object_concept_id",if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
  }

  if (!missing(episode_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_type_concept_id",if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
  }

  if (!missing(episode_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_source_value",if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
  }

  if (!missing(episode_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_source_concept_id",if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_episode_event <- function(fetchField, episode_id, event_id, episode_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.episode_event WHERE')
  first <- TRUE
  if (!missing(episode_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_id",if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " event_id",if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
  }

  if (!missing(episode_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_event_field_concept_id",if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_metadata <- function(fetchField, metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.metadata WHERE')
  first <- TRUE
  if (!missing(metadata_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_id",if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
  }

  if (!missing(metadata_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_concept_id",if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_type_concept_id",if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " name",if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string",if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(metadata_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_date",if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_datetime",if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cdm_source <- function(fetchField, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cdm_source WHERE')
  first <- TRUE
  if (!missing(cdm_source_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_name",if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_abbreviation",if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_holder",if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_description",if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_documentation_reference",if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_etl_reference",if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_release_date",if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_release_date",if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_version",if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
  }

  if (!missing(cdm_version_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_version_concept_id",if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
  }

  if (!missing(vocabulary_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " vocabulary_version",if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cohort <- function(fetchField, cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cohort WHERE')
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_id",if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " subject_id",if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
  }

  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_start_date",if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
  }

  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_end_date",if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cohort_definition <- function(fetchField, cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cohort_definition WHERE')
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_id",if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(cohort_definition_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_name",if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
  }

  if (!missing(cohort_definition_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_description",if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
  }

  if (!missing(definition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " definition_type_concept_id",if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
  }

  if (!missing(cohort_definition_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_syntax",if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
  }

  if (!missing(subject_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " subject_concept_id",if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
  }

  if (!missing(cohort_initiation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_initiation_date",if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

generateInsertSql <- function(databaseSchema = NULL) {
  insertSql <- c()
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.annual_health_checkup;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.claim;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.material_master;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.drug_master;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.enrollment;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.diagnosis;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.material;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.medical_facility;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.drug;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.procedure_master;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.diagnosis_master;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.procedure;")
  createInsertStatement <- function(insert, env) {
    s <- c()
    if (env$testId != insert$testId) {
      s <- c(s, paste0('-- ', insert$testId, ': ', insert$testDescription))
      env$testId <- insert$testId
    }
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.",
                     insert$table,
                     "(",
                     paste(insert$fields, collapse = ", "),
                     ") VALUES (",
                     paste(insert$values, collapse = ", "), 
                     ");"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  insertSql <- c(insertSql, do.call(c, lapply(frameworkContext$inserts, createInsertStatement, env)))
  if (is.null(databaseSchema)) {
  	insertSql <- gsub('@cdm_database_schema.', '', insertSql)
  } else {
  	insertSql <- gsub('@cdm_database_schema', databaseSchema, insertSql)
  }
  return(insertSql)
}

writeSourceCsv <- function(directory = NULL, separator = ',') {
  clean_value <- function(x) {
    if (x == 'NULL') {
      return('')
    }
    value <- substring(x, 2, nchar(x)-1)
    value <- gsub('"', '""', value)
    if (grepl(separator, value)) {
      return(paste0('"', value, '"'))
    }
    return(value)
  }

  clean_fields <- function(x) {
    if (grepl("^\\[.+?\\]$", x)) {
      return(substring(x, 2, nchar(x)-1))
    }
    return(x)
  }
  dir.create(directory, showWarnings = F)
  
  seen_tables <- c()
  for (insert in frameworkContext$inserts) {
    filename <- file.path(directory, paste0(insert$table, '.csv'))
    if (!(insert$table %in% seen_tables)) {
      write(paste(sapply(insert$fields, clean_fields), collapse = separator), filename, append=F)
      seen_tables <- c(seen_tables, insert$table)
    }
    write(paste(sapply(insert$values, clean_value), collapse = separator), filename, append=T)
  }
  
  for (table_name in names(frameworkContext$defaultValues)) {
    if (!(table_name %in% seen_tables)) {
      filename <- file.path(directory, paste0(table_name, '.csv'))
      write(paste(names(frameworkContext$defaultValues[[table_name]]), collapse = separator), filename, append=F)
    }
  }
}

extractTestTypeString <- function(x) {
  if (x$type == 0) {
    return('Expect')
  } else if (x$type==1) {
    return('Expect No')
  } else if (x$type==2) {
    return(paste('Expect', x$rowCount))
  }
}

generateTestSql <- function(databaseSchema = NULL) {
  testSql <- c()
  testSql <- c(testSql, "IF OBJECT_ID('@cdm_database_schema.test_results', 'U') IS NOT NULL DROP TABLE @cdm_database_schema.test_results;")
  testSql <- c(testSql, "CREATE TABLE @cdm_database_schema.test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));")
  createExpectStatement <- function(expect, env) {
    s <- c()
    if (env$testId != expect$testId) {
      s <- c(s, paste0('-- ', expect$testId, ': ', expect$testDescription))
      env$testId <- expect$testId
    }
    operators <- rep("=", length(expect$fields))
    operators[expect$values == "NULL"] <- rep("IS", sum(expect$values == "NULL"))
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.test_results SELECT ",
                     expect$testId,
                     " AS id, '",
                     expect$testDescription,
                     "' AS description, '",
                     extractTestTypeString(expect), " ", expect$table,
                     "' AS test, CASE WHEN (SELECT COUNT(*) FROM @cdm_database_schema.",
                     expect$table,
                     " WHERE ",
                     paste(paste(expect$fields, expect$values), collapse = " AND "),
                     ") ",
                     if (expect$type == 0) "= 0" else if (expect$type == 1) "!= 0" else paste("!=", expect$rowCount),
                     " THEN 'FAIL' ELSE 'PASS' END AS status;"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  testSql <- c(testSql, do.call(c, lapply(frameworkContext$expects, createExpectStatement, env)))
  if (is.null(databaseSchema)) {
  	testSql <- gsub('@cdm_database_schema.', '', testSql)
  } else {
  	testSql <- gsub('@cdm_database_schema', databaseSchema, testSql)
  }
  return(testSql)
}

getTestsOverview <- function() {
  df <- data.frame(
    testId = sapply(frameworkContext$expects, function(x) x$testId),
    testDescription = sapply(frameworkContext$expects, function(x) x$testDescription),
    testType = sapply(frameworkContext$expects, extractTestTypeString),
    testTable = sapply(frameworkContext$expects, function(x) x$table)
  )
  return(df)
}

exportTestsOverviewToFile <- function(filename) {
  df <- getTestsOverview()
  write.csv(unique(df), filename, row.names=F)
}

summary.frameworkContext <- function(object, ...) {
  nSourceFieldsTested <- length(intersect(object$sourceFieldsMapped, object$sourceFieldsTested))
  nTargetFieldsTested <- length(intersect(object$targetFieldsMapped, object$targetFieldsTested))
  nTotalSourceFields <- length(object$sourceFieldsMapped)
  nTotalTargetFields <- length(object$targetFieldsMapped)
  summary <- c(
    length(object$expects),
    length(unique(sapply(object$expects, function(x) x$testId))),
    nSourceFieldsTested,
    nTotalSourceFields,
    round(100*nSourceFieldsTested/nTotalSourceFields, 2),
    nTargetFieldsTested,
    nTotalTargetFields,
    round(100*nTargetFieldsTested/nTotalTargetFields, 2)
  )
  names(summary) <- c('n_tests', 'n_cases', 'n_source_fields_tested', 'n_source_fields_mapped_from', 'source_coverage (%)', 'n_target_fields_tested', 'n_target_fields_mapped_to', 'target_coverage (%)')
  return(as.data.frame(summary))
}

summaryTestFramework <- function() {
  return(summary(frameworkContext));
}

getUntestedSourceFields <- function() {
  sort(setdiff(frameworkContext$sourceFieldsMapped, frameworkContext$sourceFieldsTested))
}

getUntestedTargetFields <- function() {
  sort(setdiff(frameworkContext$targetFieldsMapped, frameworkContext$targetFieldsTested))
}

outputTestResultsSummary <- function(connection, databaseSchema = NULL) {
  suppressWarnings(require(DatabaseConnector, quietly = TRUE))
  query = 'SELECT * FROM @cdm_database_schema.test_results;'
  if (is.null(databaseSchema)) {
    query <- gsub('@cdm_database_schema.', '', query)
  } else {
    query <- gsub('@cdm_database_schema', databaseSchema, query)
  }
  df_results <- DatabaseConnector::querySql(connection, query)
  n_tests <- nrow(df_results)
  n_failed_tests <- sum(df_results$'STATUS' == 'FAIL')
  if (n_failed_tests > 0) {
    write(sprintf('FAILED unit tests: %d/%d (%.1f%%)', n_failed_tests, n_tests, n_failed_tests/n_tests * 100), file='')
    print(df_results[df_results$'STATUS' == 'FAIL',])
  } else {
    write(sprintf('All %d tests PASSED', n_tests), file='')
  }
}

