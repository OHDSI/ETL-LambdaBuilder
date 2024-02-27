createDeviceExposureTests <- function()
{
  add_medical(medcode = 25169, read_code = '9b20.00')

  # DEVICES

  # 1) valid entry
  patient <- createPatient();
  declareTest(id = patient$person_id, 'valid entry for device exposure, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2012-01-01', medcode = 25169, staffid = 1001, status = 1)
  expect_device_exposure(person_id = lookup_person("person_id", person_source_value = patient$person_id), device_concept_id=4192787,
                         device_source_value='9b20.00',
                         device_exposure_start_date='2012-01-01')


  # 2) 9109 - 1/24/2020 logic no longer needed, gemscript maps to device.
  patient <- createPatient();
  declareTest(id = patient$person_id, 'You have a valid PRODCODE but doesnt get an VOCAB mapping.PRODCODE = 46190. Id is person_Id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 46190, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_device_exposure(person_id = lookup_person("person_id", person_source_value = patient$person_id), device_concept_id = 21380480, device_source_value =  99978020,
                       device_exposure_start_date = '2012-01-01')
  expect_count_device_exposure(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

}
