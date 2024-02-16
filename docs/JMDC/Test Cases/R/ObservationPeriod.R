# Observation period ------------------------------------------------------------------

declareTest(201, "Observation period person id")
add_enrollment(member_id = "M000000201")
expect_observation_period(person_id = 201)

declareTest(202, "Observation period start date")
add_enrollment(member_id = "M000000202", observation_start = "201001", observation_end = "201212")
expect_observation_period(person_id = 202, observation_period_start_date = "20100101")

declareTest(203, "Observation period end date")
add_enrollment(member_id = "M000000203", observation_start = "201001", observation_end = "201412")
expect_observation_period(person_id = 203, observation_period_end_date = "20141231")

declareTest(204, "Observation period type")
add_enrollment(member_id = "M000000204", observation_start = "201001", observation_end = "201412")
expect_observation_period(person_id = 204, period_type_concept_id = 44814722)