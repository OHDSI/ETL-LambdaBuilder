createConditionOccurrenceTests <- function () {

  ######################################
  # DIAGNOSIS
  ######################################

  set_defaults_patient(avg_hh_income = NULL, pct_college_educ = NULL) 
  
  set_defaults_encounter(visitid = NULL, interaction_date = "2012-12-31")
  
  set_defaults_labs(collected_date = NULL, result_date = NULL, order_date = NULL)
  
  set_defaults_medication_administrations(admin_date = NULL)
  
  set_defaults_microbiology(collect_date = NULL, receive_date = NULL)
  
  set_defaults_nlp_measurement(measurement_year = NULL, measurement_date = NULL)
  
  set_defaults_nlp_sds(occurrence_year = NULL, occurrence_date = NULL)
  
  set_defaults_observations(result_date = NULL)
  
  set_defaults_prescriptions_written(daily_dose = NULL, days_supply = NULL)

  patient <- createPatient();
  declareTest("Test diag_date to condition_start_date", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_start_date = '2009-01-01')


  patient <- createPatient();
  declareTest("Test diagnosis code type ICD9", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 141095, condition_source_value = '7061')


  patient <- createPatient();
  declareTest("Test diagnosis code type ICD10", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = 'H44611',
                diagnosis_cd_type = 'ICD10', diag_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 381850, condition_source_value = 'H44611')


  patient <- createPatient();
  declareTest("Test primary admission diagnosis to condition_status_concept_id", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '1')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32901)

  patient <- createPatient();
  declareTest("Test primary diagnosis to condition_status_concept_id", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '0')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32902)
  
  patient <- createPatient();
  declareTest("Test primary discharge diagnosis to condition_status_concept_id", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '1')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32903)
  
  
  patient <- createPatient();
  declareTest("Test preliminary or primary discharge diagnosis to condition_status_concept_id, should be preliminary diagnosis", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '1', diagnosis_status = 'Possible diagnosis of')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32899)
  
  patient <- createPatient();
  declareTest("Test preliminary or primary diagnosis to condition_status_concept_id, should be preliminary diagnosis", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '0', diagnosis_status = 'Possible diagnosis of')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32899)
  
  patient <- createPatient();
  declareTest("diagnosis_status = 'History of' and primary diagnosis, record moved to Observation", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '0', diagnosis_status = 'History of')
  expect_no_condition_occurrence(person_id = patient$person_id)
  
  patient <- createPatient();
  declareTest("diagnosis_status = 'History of' and primary discharge diagnosis, record moved to Observation", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '1', diagnosis_status = 'History of')
  expect_no_condition_occurrence(person_id = patient$person_id)
  
  patient <- createPatient();
  declareTest("Test admission diagnosis to condition_status_concept_id", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '0', admitting_diagnosis = '1')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32890)
  
  patient <- createPatient();
  declareTest("Test discharge diagnosis to condition_status_concept_id", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7061',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01', primary_diagnosis = '0', admitting_diagnosis = '0', discharge_diagnosis = '1')
  expect_condition_occurrence(person_id = patient$person_id, condition_status_concept_id = 32896)


  patient <- createPatient();
  declareTest("Test diagnosis code with wrong diagnosis code type", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '44786629',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 0)


  patient <- createPatient();
  declareTest("Test blank diagnosis code", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = NULL,
                diagnosis_cd_type = NULL, diag_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 0)

  ######################################
  # PROCEDURE
  ######################################

  patient <- createPatient();
  declareTest("Test HCPCS derived condition coming from procedure table", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = 'G9312', proc_code_type = 'HCPCS', proc_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 312327)

  #no conditions in latest vocab originate from ICD9Proc, ICD10PCS, or CPT4

  # Test provider for encounter
  patient <- createPatient();
  provider <- createProvider();
  enc <- createEncounter();
  declareTest("Patient has PROCEDURE record; validate the provider for the encid is mapped to provid", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  add_encounter_provider(enc=enc$encid, provid=provider$provid)
  add_procedure(ptid=patient$ptid, proc_code = 'G9312', encid = enc$encid, proc_code_type = 'HCPCS', proc_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, provider_id = provider$provid)


  # Test visit_occurrence_id
  patient <- createPatient();
  enc <- createEncounter();
  provider <- createProvider();
  declareTest("Patient has PROCEDURE record; validate the visit_occurrence_id", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(enc = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01', visitid = enc$encId)
  add_procedure(ptid = patient$ptid, encid = enc$encid, proc_code = 'G9312', proc_code_type = 'HCPCS', proc_date = '2009-01-01')
  expect_condition_occurrence(person_id = patient$person_id, visit_occurrence_id = enc$visit_occurrence_id)
}
