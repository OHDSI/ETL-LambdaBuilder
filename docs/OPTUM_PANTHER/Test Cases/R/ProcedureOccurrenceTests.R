createProcedureOccurrenceTests <- function () {

  ######################################
  # PROCEDURE
  ######################################
  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type CPT4", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = '36415', proc_code_type = 'CPT4', proc_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4102442, procedure_source_value = '36415')


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type HCPCS", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = 'C9743', proc_code_type = 'HCPCS', proc_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 37204304, procedure_source_value = 'C9743')


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type ICD9", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = '33.50', proc_code_type = 'ICD9', proc_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4337138, procedure_source_value = '33.50')


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type ICD10", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = '0J8S0', proc_code_type = 'ICD10', proc_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2863829, procedure_source_value = '0J8S0')


  patient <- createPatient();
  declareTest("Tests procedure type concept", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_date = '2009-01-01', proc_code = '36415', proc_code_type = 'CPT4')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_type_concept_id = 32833)


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type of blank results in unmapped procedure occurrence", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code_type = '', proc_date = '2009-01-01', proc_code = '36415')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 0)


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type CUSTOM results in unmapped procedure occurrence", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code_type = 'CUSTOM', proc_date = '2009-01-01', proc_code = '36415')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 0)


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type REV results in unmapped procedure occurrence", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code_type = 'REV', proc_date = '2009-01-01', proc_code = '36415')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 0)


  patient <- createPatient();
  declareTest("Tests procedure record with proc_code_type CLM_UNK results in unmapped procedure occurrence", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code_type = 'CLM_UNK', proc_date = '2009-01-01', proc_code = '36415')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 0)

  ######################################
  # DIAGNOSIS
  ######################################

  patient <- createPatient();
  declareTest("Tests procedure type concept id from diagnosis record", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7606',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_type_concept_id = 32840)


  patient <- createPatient();
  declareTest("Diagnosis record with diagnosis_cd_type ICD9", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '7606',
                diagnosis_cd_type = 'ICD9', diag_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4301351, procedure_source_value = '7606')


  patient <- createPatient();
  declareTest("Diagnosis record with diagnosis_cd_type ICD10", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = 'Z01.110',
                diagnosis_cd_type = 'ICD10', diag_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4134565, procedure_source_value = 'Z01.110')


  patient <- createPatient();
  declareTest("Diagnosis record with diagnosis_cd_type SNOMED", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_status = 'Diagnosis of', diagnosis_cd = '10019001',
                diagnosis_cd_type = 'SNOMED', diag_date = '2009-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4001760, procedure_source_value = '10019001')

}
