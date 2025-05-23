createDeviceExposureTests <- function () {

  ######################################
  # PROCEDURE
  ######################################

  patient <- createPatient();
  declareTest("Test HCPCS derived device coming from procedure table", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_procedure(ptid=patient$ptid, proc_code = 'A4217', proc_code_type = 'HCPCS', proc_date = '2009-01-01')
  #expect_device_exposure(person_id = patient$person_id, device_concept_id = 2614697, device_source_value = 'A4217', device_source_concept_id = 2614697)
  expect_device_exposure(person_id = patient$person_id, device_concept_id = 2614697, device_source_value = 'A4217')



  ######################################
  # DIAGNOSIS
  ######################################

  patient <- createPatient();
  declareTest("Test device derived from diagnosis table", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = '156009', diagnosis_cd_type = 'SNOMED', diag_date = '2009-01-01',
                diagnosis_status = 'Diagnosis of')
  expect_device_exposure(person_id = patient$person_id, device_concept_id = 4048868,
                         device_source_value = '156009')
}
