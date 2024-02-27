createConditionOccurrenceTests <- function()
{

  add_medical(medcode = 1058, read_code = 'F563500')
  add_medical(medcode = 898, read_code = 'K17y000')
  add_medical(medcode = 100895, read_code = 'N22y700')
  add_medical(medcode = 45999, read_code = 'J040.14')
  add_medical(medcode = 11531, read_code = 'P00..00')
  add_medical(medcode = 35968, read_code = 'PB2z.00')

  set_defaults_consultation(consid = NULL)
  set_defaults_referral(sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL)
  set_defaults_test(consid = NULL, sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL, data2 = NULL, data5 = NULL, data6 = NULL, data8_value = NULL, data8_date = NULL)
  
  # 1) -- clinical condition with visit
  patient <- createPatient(pracid='311');
  declareTest(id = patient$person_id, 'CONDITION_OCCURRENCE - Read clinical condition with visit, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2012-01-01', medcode = 1058, staffid = 1001, consid = patient$patid)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001, consid = patient$patid)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date = '2012-01-01', condition_concept_id = 75555,
                              condition_source_concept_id = 45436713, condition_source_value = 'F563500',
                              condition_type_concept_id = 32817, provider_id = 1001
                              )
  expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)


  # 2) -- clinical condition without visit
  patient <- createPatient(pracid='311');
  declareTest(id = patient$person_id, 'CONDITION_OCCURRENCE - Read clinical condition, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2012-03-01', medcode = 898, staffid = 1001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date = '2012-03-01', condition_concept_id = 195862,
                              condition_source_concept_id = 45453481, condition_source_value = 'K17y000',
                              condition_type_concept_id = 32817, provider_id = 1001)
  expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)



  # 3) -- Clinical condition outside observation period, condition retained
  patient <- createPatient(pracid='311');
  declareTest(id = patient$person_id, 'CONDITION_OCCURRENCE - Read clinical condition outside observation period, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2009-03-01', medcode = 898, staffid = 1001, consid = patient$person_id)
  add_consultation(patid = patient$patid, eventdate = '2009-03-01', staffid = 9001, consid = patient$person_id)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date = '2009-03-01', condition_concept_id = 195862,
                              condition_source_concept_id = 45453481, condition_source_value = 'K17y000',
                              condition_type_concept_id = 32817, provider_id = 1001)
  expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)



  # 4) ---- clinical condition
  patient <- createPatient(pracid='311');
  declareTest(id = patient$person_id, 'CONDITION_OCCURRENCE - Read immunisation condition, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2011-03-01', medcode = 45999, staffid = 1001)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date = '2011-03-01', condition_source_value = 'J040.14',
                              condition_type_concept_id = 32817, provider_id = 1001,
                              condition_concept_id=4123595, condition_source_concept_id=45463565)
  expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)



  # 5) ---- referral condition
  patient <- createPatient(pracid='311');
  declareTest(id = patient$person_id, 'CONDITION_OCCURRENCE - Read referral condition, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_referral(patid = patient$patid, eventdate =  '2011-03-01', medcode = 11531, staffid = 1001)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date='2011-03-01', condition_source_value='P00..00',
                              condition_type_concept_id=32817, provider_id=1001,
                              condition_source_concept_id=45420722, condition_concept_id=377368)
  expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)


  # 6) ---- test condition #3/18/2020 this is not needed anymore as all entity types in test mapped to MEASUREMENTS
  # patient <- createPatient(pracid='311');
  # declareTest(id = patient$person_id, 'Read test condition with no visit, id is person_id')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_test(patid = patient$patid, eventdate =  '2011-03-01', medcode = 35968, staffid = 1001, enttype = 215, data1=9)
  # expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date='2011-03-01', condition_source_value='215--PB2z.00',
  #                             condition_type_concept_id=32817, provider_id=1001,
  #                             condition_source_concept_id=45430565, condition_concept_id=198550)
  # expect_count_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

  # 7) ---- Clinical record that occurs in the future
  patient <- createPatient(pracid='111');
  declareTest(id = patient$person_id, 'Read clinical condition that occurs in 2099, record removed')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2099-01-01', medcode = 1058, staffid = 1001)
  add_consultation(patid = patient$patid, eventdate = '2099-01-01', staffid = 9001)
  expect_no_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id))

  # 8) ---- test condition
  patient <- createPatient(pracid='111');
  declareTest(id = patient$person_id, 'Read test condition occurs in 2099, record removed')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate =  '2099-03-01', medcode = 35968, staffid = 1001, enttype = 215, data1=9)
  expect_no_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id))

  }
