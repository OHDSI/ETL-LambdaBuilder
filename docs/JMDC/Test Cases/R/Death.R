# Death ------------------------------------------------------------------

declareTest(601, "Death person ID from diagnosis")
add_enrollment(member_id = "M000000601")
add_claim(member_id = "M000000601", claim_id = "C000000000600")
add_diagnosis(member_id = "M000000601", claim_id = "C000000000600", outcome = 3)
expect_death(person_id = 601)

declareTest(602, "Death person ID from enrollement")
add_enrollment(member_id = "M000000602", withdrawal_death_flag = "true")
expect_death(person_id = 602)

declareTest(603, "Death date from diagnosis")
add_enrollment(member_id = "M000000603")
add_claim(member_id = "M000000603", claim_id = "C000000000601", month_and_year_of_medical_care = "201001", days_of_medical_care = 3, admission_date = "2010-01-01")
add_diagnosis(member_id = "M000000603", claim_id = "C000000000601", outcome = 3)
expect_death(person_id = 603, death_date = "2010-01-03")

declareTest(604, "Death date from enrollment")
add_enrollment(member_id = "M000000604", withdrawal_death_flag = "true", observation_start = "201001", observation_end = "201112")
expect_death(person_id = 604, death_date = "2011-12-31")

declareTest(605, "Death date from multiple diagnoses")
add_enrollment(member_id = "M000000605")
add_claim(member_id = "M000000605", claim_id = "C000000000602", month_and_year_of_medical_care = "201001", days_of_medical_care = 3, admission_date = "2010-01-01")
add_diagnosis(member_id = "M000000605", claim_id = "C000000000602", outcome = 3)
add_claim(member_id = "M000000605", claim_id = "C000000000603", month_and_year_of_medical_care = "201002", days_of_medical_care = 3, admission_date = "2010-02-01")
add_diagnosis(member_id = "M000000605", claim_id = "C000000000603", outcome = 3)
expect_death(person_id = 605, death_date = "2010-02-03")

declareTest(606, "Death date from diagnosis and enrollment")
add_enrollment(member_id = "M000000606", withdrawal_death_flag = "true", observation_start = "201001", observation_end = "201112")
add_claim(member_id = "M000000606", claim_id = "C000000000604", month_and_year_of_medical_care = "201001", days_of_medical_care = 3, admission_date = "2010-01-01")
add_diagnosis(member_id = "M000000606", claim_id = "C000000000604", outcome = 3)
expect_death(person_id = 606, death_date = "2010-01-03")

declareTest(607, "Death type concept ID")
add_enrollment(member_id = "M000000607", withdrawal_death_flag = "true")
add_enrollment(member_id = "M000000608")
add_claim(member_id = "M000000608", claim_id = "C000000000605")
add_diagnosis(member_id = "M000000608", claim_id = "C000000000605", outcome = 3)
expect_death(person_id = 607, death_type_concept_id = 38003565)
expect_death(person_id = 608, death_type_concept_id = 38003567)