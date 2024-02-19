# Cost ------------------------------------------------------------------

createCostTests <- function () {
	declareTest(1201, "Claim cost")
	add_enrollment(member_id = "M000001201")
	add_claim(member_id = "M000001201", claim_id = "C000000001201", total_point = 123)
	expect_cost(cost_event_id = 1201, cost_domain_id = "Visit", cost_type_concept_id = 5031, currency_concept_id = 44818592, total_paid = 1230)

	declareTest(1202, "Procedure cost")
	add_enrollment(member_id = "M000001202")
	add_claim(member_id = "M000001202", claim_id = "C000000001202")
	add_procedure(claim_id = "C000000001202", member_id = "M000001202", standardized_procedure_code = 2, standardized_procedure_version = '201404', number_of_times = 3, procedure_standard_point = 50) # total_charge = number_of_times * 10 * procedure_standard_point
	add_procedure_master(standardized_procedure_code = 2, standardized_procedure_version = '201404')
	expect_cost(cost_event_id = lookup_procedure_occurrence("procedure_occurrence_id", person_id = 1202, visit_occurrence_id = 1202), cost_domain_id = "Procedure", cost_type_concept_id = 5032, currency_concept_id = 44818592, total_charge = 1500)

	declareTest(1203, "Drug cost")
	add_enrollment(member_id = "M000001203")
	add_claim(member_id = "M000001203", claim_id = "C000000001203")
	add_drug(claim_id = "C000000001203", member_id = "M000001203",  jmdc_drug_code = 1, drug_price = 40, administered_amount = 2)
	expect_cost(cost_event_id = lookup_drug_exposure("drug_exposure_id", person_id = 1203, visit_occurrence_id = 1203), cost_domain_id = "Drug", cost_type_concept_id = 5032, currency_concept_id = 44818592, total_charge = 80)
}