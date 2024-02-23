# Observation ------------------------------------------------------------------

createObservationTests <- function () {
	declareTest(1101, "Observation person ID from diagnosis")
	add_enrollment(member_id = "M000001101")
	add_claim(member_id = "M000001101", claim_id = "C000000001101")
	add_diagnosis(member_id = "M000001101", claim_id = "C000000001101", standard_disease_code = 4) 
	add_diagnosis_master(standard_disease_code = 4, icd10_level4_code = "Z914") # Personal history of psychological trauma, not elsewhere classified
	expect_observation(person_id = 1101)

	declareTest(1102, "Observation concept ID from diagnosis")
	add_enrollment(member_id = "M000001102")
	add_claim(member_id = "M000001102", claim_id = "C000000001102")
	add_diagnosis(member_id = "M000001102", claim_id = "C000000001102", standard_disease_code = 4) 
	expect_observation(person_id = 1102, observation_concept_id = 1340204, observation_source_concept_id = 45590771) # History of clinical finding in subject

	declareTest(1103, "Observation value as concept ID from diagnosis")
	add_enrollment(member_id = "M000001103")
	add_claim(member_id = "M000001103", claim_id = "C000000001103")
	add_diagnosis(member_id = "M000001103", claim_id = "C000000001103", standard_disease_code = 4) # Personal history of psychological trauma, not elsewhere classified
	expect_observation(person_id = 1103, observation_concept_id = 1340204, value_as_concept_id = 439990) # Victim of psychological trauma

	declareTest(1104, "Observation visit occurrence ID, provider ID, type concept ID from diagnosis")
	add_enrollment(member_id = "M000001104")
	add_claim(member_id = "M000001104", claim_id = "C000000001104")
	add_diagnosis(member_id = "M000001104", claim_id = "C000000001104", standard_disease_code = 4, medical_facility_id = "F0000009", type_of_claim = "Outpatient") # Personal history of psychological trauma, not elsewhere classified
	expect_observation(person_id = 1104, visit_occurrence_id = 1104, provider_id = 10000009, observation_type_concept_id = 32859)

	declareTest(1105, "Observation date from diagnosis with admission date")
	add_enrollment(member_id = "M000001105")
	add_claim(member_id = "M000001105", claim_id = "C000000001105", month_and_year_of_medical_care = "201001", admission_date = "2010-01-01")
	add_diagnosis(member_id = "M000001105", claim_id = "C000000001105", standard_disease_code = 4) # Personal history of psychological trauma, not elsewhere classified
	expect_observation(person_id = 1105, visit_occurrence_id = 1105, observation_date = "2010-01-01")

	declareTest(1106, "Observation date from diagnosis without admission date")
	add_enrollment(member_id = "M000001106")
	add_claim(member_id = "M000001106", claim_id = "C000000001106", month_and_year_of_medical_care = "201001", admission_date = NULL)
	add_diagnosis(member_id = "M000001106", claim_id = "C000000001106", standard_disease_code = 4) # Personal history of psychological trauma, not elsewhere classified
	expect_observation(person_id = 1106, visit_occurrence_id = 1106, observation_date = "2010-01-15")

	declareTest(1107, "Observation from checkup")
	add_enrollment(member_id = "M000001107")
	add_annual_health_checkup(member_id = "M000001107", sleep = 2, date_of_health_checkup =  "2010-01-13")
	expect_observation(person_id = 1107, observation_date = "2010-01-13", observation_concept_id = 40764749, value_as_concept_id = 4188540)
}	