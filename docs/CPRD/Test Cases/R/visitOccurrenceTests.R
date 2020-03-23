createVisitOccurrenceTests <- function()
{
  # add Practice
  #=============================================
  add_practice(pracid = 555, region = 11, lcd = '2013-12-31', uts= '2013-01-01')

  #declareTest("hes cohort	check the hes cohort is created")
  #add_hes_linkage_coverage(data_source = 'hes', start = '1990-01-01', end = '2014-12-31')
  #expect_cohort_definition(cohort_definition_id = 224)

  # 1) + valid
  # 501555	Same event date in CONSULTATION has multiple consids	two VISIT_OCCURRENCE records is created;

  patient <- createPatient(pracid=555);
  declareTest(id = patient$person_id, "Multiple consids on the same date but no event record, no visit created.")
  add_patient(patid = patient$patid, gender=1, yob=172, crd='2013-01-01', tod='2013-12-31', accept=1, pracid = patient$pracid)
  add_consultation(patid = patient$patid, eventdate = '2013-02-01', consid=1, staffid = 500)
  add_consultation(patid = patient$patid, eventdate = '2013-02-01', consid=2, staffid = 600)
  expect_visit_occurrence(person_id = patient$person_id, visit_start_date = '2013-02-01', visit_end_date = '2013-02-01'
                          )

  # 2) + valid
  # Record in Immunisation becomes visit

  # 3) + valid
  # Record in Referral becomes visit

  # 4) + valid
  # Record in Test becomes visit

  # 2) /*502*/ - invalid
  patient <- createPatient(pracid=555);
  declareTest(id = patient$person_id, "eventdate in CLINICAL is NULL	No VISIT_OCCURRENCE record created")
  add_patient(patid = patient$patid, gender=1, yob=172, crd='2013-01-01', tod='2013-12-31', accept=1, pracid = patient$pracid)
  add_consultation(patid = patient$patid, eventdate = NULL, consid=1, staffid =NULL)
  expect_no_visit_occurrence(person_id = patient$person_id)

  # 3 /*503*/ - invalid
  patient <- createPatient(pracid=555);
  declareTest(id = patient$person_id, "IMMUNISATION record occurs outside of a valid OBSERVATION_PERIOD, VISIT_OCCURRENCE record still created")
  add_patient(patid = patient$patid, gender=1, yob=172, crd='2013-01-01', tod='2013-12-31', accept=1, pracid = patient$pracid)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', consid=1, staffid =NULL)
  expect_no_visit_occurrence(person_id = patient$person_id)

  # 4) Two records on the same day create one VISIT_OCCURRENCE record
  patient <- createPatient(pracid=555);
  declareTest(id = patient$person_id, "VISIT_OCCURRENCE - Two records on the same day create on VISIT_OCCURRENCE record")
  add_patient(patid = patient$patid, gender=1, yob=172, crd='2013-01-01', tod='2013-12-31', accept=1, pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate =  '2013-04-01', medcode = 898, staffid = '1001', consid = '123')
  add_clinical(patid = patient$patid, eventdate =  '2013-04-01', medcode = 898, staffid = '1001', consid = '456')
  add_consultation(patid = patient$patid, eventdate = '2013-04-01', consid='123', staffid = '123')
  add_consultation(patid = patient$patid, eventdate = '2013-04-01', consid='456', staffid = '456')
  add_staff(staffid = '123')
  add_staff(staffid = '456')
  expect_no_visit_occurrence(person_id = patient$person_id)


}
