createProcedureOccurrenceTests <- function()
{
  add_medical(medcode = 48653, read_code = '7J46z00')
  add_medical(medcode = 45832, read_code = '7414200')
  add_medical(medcode = 69651, read_code = '744C.00')

  # 1) -- clinical procedure with visit
  #also add hes visit with same date to test 9202

  patient <- createPatient();
  declareTest(id = patient$person_id, "Read clinical procedure with visit")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-01-01', medcode = 48653, staffid = 1001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_date='2012-01-01', procedure_source_value='7J46z00',
                              procedure_type_concept_id=38000275, provider_id=1001,
                              procedure_source_concept_id=45419444, procedure_concept_id=4074106)


  # 2) clinical procedure without visit
  patient <- createPatient();
  declareTest(id = patient$person_id, "clinical procedure without visit")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-03-01', medcode = 45832, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_date='2012-03-01',
                              procedure_source_value='7414200',
                              procedure_type_concept_id=38000275, provider_id=1001,
                              procedure_source_concept_id=45425628, procedure_concept_id=4336549)

  # 3) -- clinical procedure outside observation period
  patient <- createPatient();
  declareTest(id = patient$person_id, "clinical procedure outside observation period")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2009-03-01', medcode = 69651, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_type_concept_id=38000275,
                              procedure_source_concept_id=45425639, procedure_concept_id=4192131)

  # 4) ---- immunisation procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, "immunisation procedure")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2011-03-01', medcode = 69651, staffid = 1001)
  expect_procedure_occurrence(person_id =patient$person_id, procedure_date='2011-03-01', procedure_source_value='744C.00',
                              procedure_type_concept_id=38000275, provider_id=1001,
                              procedure_source_concept_id=45425639, procedure_concept_id=4192131)



  # 5) ---- referral procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, "referral procedure")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_referral(patid = patient$patid, eventdate = '2011-03-01', medcode = 69651, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_date='2011-03-01', procedure_source_value='744C.00',
                              procedure_type_concept_id=38000275, provider_id=1001,
                              procedure_source_concept_id=45425639, procedure_concept_id=4192131)


  # 6) ---- test procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, "test procedure")
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2011-03-01', medcode = 69651, staffid = 1001, consid = 6489, enttype = 215, data1=9)
  expect_measurement(person_id = patient$person_id, measurement_date='2011-03-01', measurement_source_value='744C.00',
                              measurement_type_concept_id=44818702, provider_id=1001,
                              measurement_source_concept_id=45425639, measurement_concept_id=4199172)



}
