setDefaults <- function (){
	set_defaults_enrollment(withdrawal_death_flag = NULL)
	set_defaults_medical_facility(home_care_support_clinic = NULL, designated_cancer_care_hospitals = NULL, medical_institution_introducing_dpc = NULL, special_functioning_hospitals = NULL)

	set_defaults_enrollment(observation_start = "201001", observation_end = "201712")
	set_defaults_diagnosis(standard_disease_code = 123)
	add_diagnosis_master(standard_disease_code = 123, icd10_level4_code = 'J309') # allergic rhinitis
	set_defaults_procedure(standardized_procedure_code = 123, standardized_procedure_version = '201404')
	add_procedure_master(standardized_procedure_code = 123, standardized_procedure_version = '201404', icd9cm_level1 = 9394) # Respiratory medication administered by nebulizer

	set_defaults_claim(paper_claim_flag = NULL, admission_date = NULL, discharge_date = NULL)
	set_defaults_drug(date_of_dispense = NULL, as_needed_medication_flag = NULL,category_of_medical_care = NULL, dispensing_charge = NULL, drug_charge = NULL, date_of_prescription = NULL)
	set_defaults_procedure(procedure_standard_additional_rate = NULL, procedure_standard_price = NULL, date_of_procedure = NULL)
	set_defaults_diagnosis(main_disease_flag = NULL, causative_disease_flag = NULL, suspicion_flag = NULL, outcome_death_flag = NULL, outcome_exacerbation_flag = NULL)

	set_defaults_annual_health_checkup(abdominal_circumference = NULL, triglyceride = NULL, hdl_cholesterol = NULL, ldl_cholesterol = NULL, g_gt = NULL,fasting_blood_sugar = NULL, casual_blood_sugar = NULL, hba1c = NULL, hct = NULL, hemoglobin_content = NULL, rbc_count = NULL, ecg = NULL, fundus_examination_keith_wagener_classification = NULL,fundus_examination_scheie_classification_h = NULL, fundus_examination_scheie_classification_s = NULL,fundus_examination_scott_classification = NULL,eating3_late_evening_snack = NULL, eating3_snack = NULL, change_of_weight_in_a_year = NULL,serum_uric_acid = NULL, serum_creatinine = NULL, total_cholesterol = NULL)
}