createPersonTests <- function()
{
  #=======================================================================
  add_practice(pracid = 111, region=5, uts='2010-01-01', lcd= '2013-01-01')
  add_practice(pracid = 113, region=5, uts='2014-01-01', lcd= '2012-12-01')


  # adding patients
  # observation start is max(uts crd), observation end is min (deathdate lcd todate ) - lcd is always non-null
  #=======================================================================
  # 1) - invalid: accept must be 1
  patient <- createPatient();
  declareTest(id = patient$person_id, "accept is 0 so should be deleted")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=1, crd='2010-01-01', deathdate=NULL, tod=NULL, pracid=patient$pracid, accept=0)
  expect_no_person(person_id = patient$person_id)

  # can test accept =1 with other tests:
  # 2) + valid
  patient <- createPatient();
  declareTest(id = patient$person_id, "valid")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=1, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL, pracid=patient$pracid)
  expect_person(person_id = patient$person_id, year_of_birth = 1999, month_of_birth = 1, care_site_id = patient$pracid, gender_concept_id = 8507,
                person_source_value = patient$patid, gender_source_value = 1)

  # 3) - invalid: crd > deathdate
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid: delete because crd 2013-01-01 > deathdate 2012-01-01")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=1, accept=1, crd='2013-01-01', deathdate='2012-01-01', tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)


  # 4) - invalid: crd > todate
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid: delete because crd 2013-01-01 > todate 2011-05-03")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=1, accept=1, crd='2013-01-01', deathdate=NULL, tod='2011-05-03',
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)

  # 5) - invalid: uts < lcd
  patient <- createPatient(pracid=113);
  declareTest(id = patient$person_id, "invalid: delete because uts 2014-01-01 > lcd 2012-12-01")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=1, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)

  # 6) + valid but mob =0 then MONTH_OF_BIRTH=NULL
  patient <- createPatient();
  declareTest(id = patient$person_id, "valid but mob =0 then MONTH_OF_BIRTH=NULL")
  add_patient(patid=patient$patid,gender=1, yob=199, mob=0, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_person(person_id = patient$person_id, year_of_birth = 1999, month_of_birth = NULL, care_site_id = patient$pracid, gender_concept_id = 8507,
                person_source_value = patient$patid, gender_source_value = 1)

  # 7) - invalid: make sure no invalid yob (75 or less, 2014)
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid year of birth 74")
  add_patient(patid=patient$patid,gender=1, yob=74, mob=1, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)

  # 8) + valid - test gender 0-4 (1=MALE, 2=FEMALE, others=UNKNOWN)
  patient <- createPatient();
  declareTest(id = patient$person_id, "valid gender female")
  add_patient(patid=patient$patid,gender=2, yob=195, mob=1, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_person(person_id = patient$person_id, care_site_id = patient$pracid, gender_concept_id = 8532,
                person_source_value = patient$patid, gender_source_value = 2)

  # 9) - not valid unknown gender
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid not entered gender")
  add_patient(patid=patient$patid,gender=0, yob=195, mob=1, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)

  # 10) - not valid gender
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid Indeterminate gender")
  add_patient(patid=patient$patid,gender=3, yob=195, mob=6, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)

  # 11) - not valid gender
  patient <- createPatient();
  declareTest(id = patient$person_id, "invalid unknown gender")
  add_patient(patid=patient$patid,gender=4, yob=195, mob=6, accept=1, crd='2010-01-01', deathdate=NULL, tod=NULL,
              pracid=patient$pracid)
  expect_no_person(person_id = patient$person_id)



}
