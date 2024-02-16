# Measurement ------------------------------------------------------------------

set_defaults_annual_health_checkup(abdominal_circumference = NULL, triglyceride = NULL, hdl_cholesterol = NULL, ldl_cholesterol = NULL, g_gt = NULL,fasting_blood_sugar = NULL, casual_blood_sugar = NULL, hba1c = NULL, hct = NULL, hemoglobin_content = NULL, rbc_count = NULL, ecg = NULL, fundus_examination_keith_wagener_classification = NULL,fundus_examination_scheie_classification_h = NULL, fundus_examination_scheie_classification_s = NULL,fundus_examination_scott_classification = NULL,eating3_late_evening_snack = NULL, eating3_snack = NULL, change_of_weight_in_a_year = NULL,serum_uric_acid = NULL, serum_creatinine = NULL, total_cholesterol = NULL)

declareTest(1001, "Measurement person ID")
add_enrollment(member_id = "M000001001")
add_annual_health_checkup(member_id = "M000001001")
expect_measurement(person_id = 1001)

declareTest(1002, "Measurement concept ID and type concept ID")
add_enrollment(member_id = "M000001002")
add_annual_health_checkup(member_id = "M000001002", bmi = "25", ecg = 1)
expect_measurement(person_id = 1002, measurement_concept_id = 3038553, measurement_type_concept_id = 38000277) # BMI
expect_measurement(person_id = 1002, measurement_concept_id = 42869419, measurement_type_concept_id = 38000279) # ECG

declareTest(1003, "Measurement date")
add_enrollment(member_id = "M000001003")
add_annual_health_checkup(member_id = "M000001003", date_of_health_checkup = "2010-01-16")
expect_measurement(person_id = 1003, measurement_date = "2010-01-16")

declareTest(1004, "Measurement value")
add_enrollment(member_id = "M000001004")
add_annual_health_checkup(member_id = "M000001004", bmi = "25.0", ecg = 1, triglyceride = 40, ast = 20, alt = 21)
expect_measurement(person_id = 1004, measurement_concept_id = 3038553, value_as_number = 25, value_source_value = "25.0", unit_concept_id = 9531)
expect_measurement(person_id = 1004, measurement_concept_id = 42869419, value_as_concept_id = 263654008, value_source_value = "1")
expect_measurement(person_id = 1004, measurement_concept_id = 3022038, value_as_number = 40, value_source_value = "40", unit_concept_id = 8840)
expect_measurement(person_id = 1004, measurement_concept_id = 3003792, value_as_number = 20, value_source_value = "20", unit_concept_id = 8645)
expect_measurement(person_id = 1004, measurement_concept_id = 3006923, value_as_number = 21, value_source_value = "21", unit_concept_id = 8645)



declareTest(1005, "Measurement normal ranges")
add_enrollment(member_id = "M000001005")
add_annual_health_checkup(member_id = "M000001005", systolic_bp = 110, diastolic_bp = 70)
expect_measurement(person_id = 1005, measurement_concept_id = 3004249, range_low = 60, range_high = 300)
expect_measurement(person_id = 1005, measurement_concept_id = 3012888, range_low = 30, range_high = 150)

declareTest(1006, "Measurement from diagnosis")
add_enrollment(member_id = "M000001006")
add_claim(member_id = "M000001006", claim_id = "C000000001001")
add_diagnosis(member_id = "M000001006", claim_id = "C000000001001", standard_disease_code = 3, type_of_claim = "Outpatient") 
add_diagnosis_master(standard_disease_code = 3, icd10_level4_code = "R824")# Acetonuria
expect_measurement(person_id = 1006, visit_occurrence_id = 1001, measurement_concept_id = 4042243, value_as_concept_id = 4181412, measurement_type_concept_id = 38000215)