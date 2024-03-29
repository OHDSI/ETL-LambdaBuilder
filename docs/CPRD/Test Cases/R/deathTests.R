createDeathTests <- function()
{
  # add Practice
  #=============================================
  add_practice(pracid = 888, region = 1, uts = '2009-01-01', lcd= '2014-01-01')
  #
  # 1) + valid deathdate of 2010-01-01
  patient <- createPatient(pracid=888);
  declareTest(id = patient$person_id, 'valid deathdate, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob=169, mob=1, accept=1, deathdate = '2010-01-01',
              crd = '2009-01-01', pracid = patient$pracid)
  expect_death(person_id = lookup_person("person_id", person_source_value = patient$person_id), death_date = '2010-01-01')
  expect_count_death(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

  # 2) - invalid as no deathdate
  patient <- createPatient(pracid=888);
  declareTest(id = patient$person_id, 'invalid: no deathdate, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob=169, mob=1, accept=1, deathdate = NULL,
              crd = '2009-01-01', pracid = patient$pracid)
  expect_no_death(person_id = lookup_person("person_id", person_source_value = patient$person_id))

}
