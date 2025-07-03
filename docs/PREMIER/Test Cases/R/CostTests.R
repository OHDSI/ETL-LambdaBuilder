createCostTests <- function () {

  patient <- createPatient()
  visit <- createVisit()
  declareTest(description="Cost record from drug_exposure", id = patient$person_id);
  add_pat(medrec_key = patient$medrec_key,
          pat_key    = visit$pat_key);
  add_patbill(pat_key       = visit$pat_key,
              std_chg_code  = 250250038820000,
              bill_charges  = 500.50,
              bill_cost     = 300.75);
  add_chgmstr(std_chg_code  = 250250038820000,
              sum_dept_desc = "PHARMACY",
              std_dept_desc = "PHARMACY");
  expect_drug_exposure(person_id       = patient$person_id,
                       drug_concept_id = 19042590);
  expect_cost(cost_domain_id            = "Drug",
              total_charge              = 500.50,
              total_cost                = 300.75,
              revenue_code_concept_id   = 38003147,
              revenue_code_source_value = "PHARMACY / PHARMACY");


  patient <- createPatient()
  visit <- createVisit()
  declareTest(description="Cost record from procedure_occurrence", id = patient$person_id);
  add_pat(medrec_key = patient$medrec_key,
          pat_key    = visit$pat_key);
  add_patbill(pat_key       = visit$pat_key,
              std_chg_code  = 33840,
              bill_charges  = 29374.99,
              bill_cost     = 13572.76);
  add_chgmstr(std_chg_code  = 33840,
              sum_dept_desc = "OR",
              std_dept_desc = "SURGERY");
  expect_procedure_occurrence(person_id            = patient$person_id,
                              procedure_concept_id = 4105220);
  expect_cost(cost_domain_id            = "Procedure",
              total_charge              = 29374.99,
              total_cost                = 13572.76,
              revenue_code_concept_id   = 38003208,
              revenue_code_source_value = "OR / SURGERY");


  patient <- createPatient()
  visit <- createVisit()
  declareTest(description="Cost record from device_exposure", id = patient$person_id);
  add_pat(medrec_key = patient$medrec_key,
          pat_key    = visit$pat_key);
  add_patbill(pat_key       = visit$pat_key,
              std_chg_code  = 270275000120000,
              bill_charges  = 499.99,
              bill_cost     = 99.99);
  add_chgmstr(std_chg_code  = 270275000120000,
              sum_dept_desc = "SUPPLY",
              std_dept_desc = "CENTRAL SUPPLY");
  expect_device_exposure(person_id         = patient$person_id,
                         device_concept_id = 4236068);
  expect_cost(cost_domain_id            = "Device",
              total_charge              = 499.99,
              total_cost                = 99.99,
              revenue_code_concept_id   = 38003163,
              revenue_code_source_value = "SUPPLY / CENTRAL SUPPLY");


  patient <- createPatient()
  visit <- createVisit()
  declareTest(description="Cost record from observation", id = patient$person_id);
  add_pat(medrec_key = patient$medrec_key,
          pat_key    = visit$pat_key);
  add_patbill(pat_key       = visit$pat_key,
              std_chg_code  = 110214000620000,
              bill_charges  = 2347.77,
              bill_cost     = 2000.00);
  add_chgmstr(std_chg_code  = 110214000620000,
              sum_dept_desc = "OTHER",
              std_dept_desc = "DIALYSIS");
  expect_observation(person_id              = patient$person_id,
                     observation_concept_id = 4227255);
  expect_cost(cost_domain_id            = "Observation",
              total_charge              = 2347.77,
              total_cost                = 2000.00,
              revenue_code_concept_id   = 38003458,
              revenue_code_source_value = "OTHER / DIALYSIS");


  patient <- createPatient()
  visit <- createVisit()
  declareTest(description="Cost record from measurement", id = patient$person_id);
  add_pat(medrec_key = patient$medrec_key,
          pat_key    = visit$pat_key);
  add_patbill(pat_key       = visit$pat_key,
              std_chg_code  = 85013,
              bill_charges  = 79.99,
              bill_cost     = 19.50);
  add_chgmstr(std_chg_code  = 85013,
              sum_dept_desc = "LAB",
              std_dept_desc = "LABORATORY");
  expect_measurement(person_id            = patient$person_id,
                     measurement_concept_id = 4016241);
  expect_cost(cost_domain_id            = "Measurement",
              total_charge              = 79.99,
              total_cost                = 19.50,
              revenue_code_concept_id   = 38003172,
              revenue_code_source_value = "LAB / LABORATORY");


  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="MS_DRG record (1 digit) to cost table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2005-01-01",
          disc_date    = "2005-01-01",
          ms_drg       = 1);
  add_patbill(pat_key  = visit$pat_key);
  expect_count_cost(drg_concept_id      = 38000887, #drg=001
              drg_source_value    = "001",
			  rowCount = 1);

}
