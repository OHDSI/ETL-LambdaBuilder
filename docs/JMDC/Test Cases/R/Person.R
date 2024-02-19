# Person ------------------------------------------------------------------
createPersonTests <- function () {
	declareTest(101, "Person id")
	add_enrollment(member_id = "M000000101")
	expect_person(person_id = 101, person_source_value = "M000000101")

	declareTest(102, "Person gender mappings")
	add_enrollment(member_id = "M000000102", gender_of_member = "male")
	add_enrollment(member_id = "M000000103", gender_of_member = "female")
	expect_person(person_id = 102, gender_concept_id = 8507, gender_source_value = "male")
	expect_person(person_id = 103, gender_concept_id = 8532, gender_source_value = "female")

	declareTest(103, "Person year and month of birth")
	add_enrollment(member_id = "M000000104", month_and_year_of_birth_of_member = "197508")
	expect_person(person_id = 104, year_of_birth = 1975)
	expect_person(person_id = 104, month_of_birth = 8)
}