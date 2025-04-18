createObservationPeriodTests <- function()
{
  # add Practice
  #=============================================
  add_practice(pracid = 222, region = 5, lcd = '2011-11-11', uts= '2001-02-12')


  # TESTS
  #==============================================
  # 1) + valid: observation start is max(uts crd), observation end is min (lcd todate ) - lcd is always non-null
  patient <- createPatient(pracid=222);
  declareTest(id = patient$person_id, "201222: obs_period start should be uts and obs_period_end should be tod.")
  add_patient(patid = patient$patid, gender=1, yob=169, crd='2000-10-26', tod='2010-01-01', accept=1, pracid = patient$pracid)
  expect_observation_period(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_period_start_date = '2001-02-12',
                            observation_period_end_date = '2010-01-01')
  expect_count_observation_period(rowCount = 1, person_id = lookup_person("person_id", person_source_value = patient$person_id))

  # 2) + valid:
  patient <- createPatient(pracid=222);
  declareTest(id = patient$person_id, "202222: obs_period start should be crd and obs_period_end should be lcd since tod is null.")
  add_patient(patid = patient$patid, gender=1, yob=169, crd='2005-10-26', deathdate ='2010-12-31', accept=1, pracid = patient$pracid)
  expect_observation_period(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_period_start_date = '2005-10-26',
                            observation_period_end_date = '2011-11-11')
  expect_count_observation_period(rowCount = 1, person_id = lookup_person("person_id", person_source_value = patient$person_id))

  #3 - invalid:
  patient <- createPatient(pracid=222);
  declareTest(id = patient$person_id, "203222: patient deleted tod<uts.")
  add_patient(patid = patient$patid, gender=1, yob=169, crd='2000-10-26', tod ='1997-01-01', accept=1, pracid = patient$pracid)
  expect_no_observation_period(person_id = lookup_person("person_id", person_source_value = patient$person_id))



}
