# Procedure occurrence ------------------------------------------------------------------

createProcedureOccurrenceTests <- function () {
	declareTest(901, "Procedure occurrence person ID")
	add_enrollment(member_id = "M000000901")
	add_claim(member_id = "M000000901", claim_id = "C000000000901")
	add_procedure(member_id = "M000000901", claim_id = "C000000000901")
	expect_procedure_occurrence(person_id = 901)

	declareTest(902, "Procedure occurrence visit occurrence ID")
	add_enrollment(member_id = "M000000902")
	add_claim(member_id = "M000000902", claim_id = "C000000000902")
	add_procedure(member_id = "M000000902", claim_id = "C000000000902")
	expect_procedure_occurrence(visit_occurrence_id = 902)

	declareTest(903, "Procedure occurrence type concept ID")
	add_enrollment(member_id = "M000000903")
	add_claim(member_id = "M000000903", claim_id = "C000000000903")
	add_procedure(member_id = "M000000903", claim_id = "C000000000903", type_of_claim = "Outpatient")
	add_claim(member_id = "M000000903", claim_id = "C000000000904")
	add_procedure(member_id = "M000000903", claim_id = "C000000000904", type_of_claim = "Inpatient")
	add_claim(member_id = "M000000903", claim_id = "C000000000905")
	add_procedure(member_id = "M000000903", claim_id = "C000000000905", type_of_claim = "DPC")
	expect_procedure_occurrence(person_id = 903, visit_occurrence_id = 903, procedure_type_concept_id = 32859)
	expect_procedure_occurrence(person_id = 903, visit_occurrence_id = 904, procedure_type_concept_id = 32853)
	expect_procedure_occurrence(person_id = 903, visit_occurrence_id = 905, procedure_type_concept_id = 32853)

	declareTest(904, "Procedure provider")
	add_enrollment(member_id = "M000000904")
	add_claim(member_id = "M000000904", claim_id = "C000000000907")
	add_procedure(member_id = "M000000904", claim_id = "C000000000907", medical_facility_id = "F0000008")
	expect_procedure_occurrence(person_id = 904, visit_occurrence_id = 907, provider_id = 10000008)

	declareTest(906, "Procedure date from procedure date")
	add_enrollment(member_id = "M000000906")
	add_claim(member_id = "M000000906", claim_id = "C000000000909")
	add_procedure(member_id = "M000000906", claim_id = "C000000000909", date_of_procedure = "2010-01-05")
	expect_procedure_occurrence(person_id = 906, visit_occurrence_id = 909, procedure_date = "2010-01-05")

	declareTest(907, "Procedure date from visit date")
	add_enrollment(member_id = "M000000907")
	add_claim(member_id = "M000000907", claim_id = "C000000000910", month_and_year_of_medical_care = "201002")
	add_procedure(member_id = "M000000907", claim_id = "C000000000910", date_of_procedure = NULL)
	expect_procedure_occurrence(person_id = 907, visit_occurrence_id = 910, procedure_date = "2010-02-15")

	declareTest(908, "Procedure concept ID")
	add_enrollment(member_id = "M000000908")
	add_claim(member_id = "M000000908", claim_id = "C000000000911")
	add_procedure(member_id = "M000000908", claim_id = "C000000000911", standardized_procedure_code = 1, standardized_procedure_version = 1)
	add_procedure_master(standardized_procedure_code = 1, standardized_procedure_version = 1, icd9cm_level1 = "9394" )
	expect_procedure_occurrence(person_id = 908, visit_occurrence_id = 911, procedure_concept_id = 4206920, procedure_source_value = "9394", procedure_source_concept_id = 2007683)

	declareTest(909, "Procedure from diagnosis")
	add_enrollment(member_id = "M000000909")
	add_claim(member_id = "M000000909", claim_id = "C000000000912")
	add_diagnosis(member_id = "M000000909", claim_id = "C000000000912", standard_disease_code = 2, type_of_claim = "Outpatient") 
	add_diagnosis_master(standard_disease_code = 2, icd10_level4_code = "Z043") # Examination and observation following other accident
	expect_procedure_occurrence(person_id = 909, visit_occurrence_id = 912, procedure_concept_id = 4085923, procedure_type_concept_id = 32859)
}	