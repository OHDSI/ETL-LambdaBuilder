#' @export
createCostTests <- function () {

  #This will test HIX-1319
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has values in ingcost, dispfee and AWP (HIX-1319). Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_drug_claims(enrolid = patient$enrolid, copay = '20', ndcnum = '00378510501', svcdate = '2012-02-09', ingcost = '50', dispfee = '25', awp = '20')
  # expect_cost(cost_domain_id = 'Drug', paid_patient_copay = '20', paid_ingredient_cost = '50', paid_dispensing_fee = '25', total_cost = '20')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has cost values, cost is correctly associated with cost_domain_id = 10. Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, proc1 = '65779', svcdate = '2012-06-11', tsvcdat = '2012-06-30', copay = '40', deduct = '120', year = '2012')
  # add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, year = '2012')
  # expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757105', procedure_date = '2012-06-11')
  # expect_cost(cost_domain_id = 'Procedure', paid_patient_copay = '40', paid_patient_deductible = '120', paid_by_patient = '160')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has procedure with domain = measurement, measurement record created. Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_outpatient_services(enrolid = patient$enrolid, proc1 = '82985', svcdate = '2012-05-07', tsvcdat = '2012-05-07', netpay = '120', copay = '37')
  # expect_measurement(person_id = patient$person_id, measurement_concept_id = '2212375', measurement_date = '2012-05-07')
  # expect_cost(cost_domain_id = 'Measurement', paid_patient_copay = '37', paid_by_payer = '120', total_paid = '157')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has procedure with domain = observation, observation record created. Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_outpatient_services(enrolid = patient$enrolid, proc1 = 'S9368', svcdate = '2012-10-03', tsvcdat = '2012-10-03', cob = '52', netpay = '75', coins = '100')
  # expect_observation(person_id = patient$person_id, observation_concept_id = '2721503', observation_date = '2012-10-03')
  # expect_cost(cost_domain_id = 'Observation', paid_patient_coinsurance = '100', paid_by_primary = '52', paid_by_payer = '75')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has cost values and revenue code, cost is correctly associated with cost_domain_id = 10. Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, proc1 = NULL, revcode = '0420', svcdate = '2012-06-05', tsvcdat = '2012-06-05', copay = '80', deduct = '20', year = '2012')
  # add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, year = '2012')
  # expect_cost(cost_domain_id = 'Procedure', paid_patient_copay = '80', paid_patient_deductible = '20', paid_by_patient = '100')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Testing DRG Populates (HIX-1431). Id is PERSON_ID.")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, proc1 = NULL, revcode = '0420', svcdate = '2012-06-05', tsvcdat = '2012-06-05', copay = '80', deduct = '20', year = '2012')
  # add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, year = '2012')
  # expect_cost(cost_domain_id = 'Procedure', paid_patient_copay = '80', paid_patient_deductible = '20', paid_by_patient = '100')
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has cost values, cost is correctly associated with the right event_id (HIX-1515).")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, proc1 = '65779', svcdate = '2012-06-11', tsvcdat = '2012-06-30', copay = '40', deduct = '120', year = '2012')
  # add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, year = '2012')
  # event_ID <- lookup_procedure_occurrence(fetchField = "procedure_occurrence_id", person_id = patient$person_id)
  # expect_cost(cost_event_id = event_ID)
  #
  # patient <- createPatient()
  # encounter <- createEncounter()
  # declareTest(id = patient$person_id, "Patient has invalid revenue code, REVENUE_CODE_CONCEPT_ID set to 0. Id is PERSON_ID. (HIX-1486)")
  # add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  # add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, proc1 = '65779', revcode = '0000', svcdate = '2012-06-05', tsvcdat = '2012-06-05', copay = '80', deduct = '20', year = '2012')
  # add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, year = '2012')
  # event_ID <- lookup_procedure_occurrence(fetchField = "procedure_occurrence_id", person_id = patient$person_id)
  # expect_cost(cost_event_id = event_ID , revenue_code_concept_id = 0)
  #
  # if (Sys.getenv("frameworkType") == "MDCD")
  # {
  #   patient <- createPatient()
  #   encounter <- createEncounter()
  #   declareTest(id = patient$person_id, "Patient has record with costs in ltc, cost record created. Id is PERSON_ID.")
  #   add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  #   add_long_term_care(enrolid = patient$enrolid, proc1 = '65779', dx1 = 'v901', dxver = '9', svcdate = '2012-11-12', tsvcdat = '2012-11-22', copay = '62', netpay = '90', coins = '88', cob = '20')
  #   expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = '4053838', condition_type_concept_id = '38000215')
  #   expect_cost(cost_domain_id = 'Procedure', paid_patient_copay = '62', paid_patient_coinsurance = '88', paid_by_primary = '20', paid_by_payer = '90', paid_by_patient = '150')
  # }

}