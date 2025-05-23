#' @export
createObservationPeriodTests <- function () {

  patient<-createPatient();
  declareTest(id = patient$person_id, "Subsumed enrollment test where two enrollment durations with the second subsumed by the first results in a single observation. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-12-31");
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-06-01", dtend="2012-07-31");
  expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-12-31")
  expect_count_observation_period(person_id=patient$person_id, rowCount=1)

  patient<-createPatient();
  declareTest(id = patient$person_id, "Combine enrollment test where two enrollment durations with the second within 30 days of the first results in a single observation. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-05-01", dtend="2012-05-31")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-06-15", dtend="2012-12-31")
  expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-05-01", observation_period_end_date="2012-12-31")
  expect_count_observation_period(person_id=patient$person_id, rowCount=1)

  patient<-createPatient();
  declareTest(id = patient$person_id, "Gap enrollment test where two enrollment durations are 33 days apart results in two observations. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-06-01")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-08-02", dtend="2012-12-31")
  expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-06-01")
  expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-08-02", observation_period_end_date="2012-12-31")
  
  patient<-createPatient();
  declareTest(id = patient$person_id, "Test two duplicate enrollment records results in a single observation. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-12-25")
  add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-12-25")
  expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-12-25")
  expect_count_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-12-25", rowCount=1)
  
  #patient<-createPatient();
  #declareTest(id = patient$person_id, "When a person has a death recorded then we DO NOT truncate the OBSERVATION_PERIOD_END_DATE to reflect the corresponding DEATH_DATE. Id is PERSON_ID.")
  #add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-12-31")
  #add_facility_header(enrolid=patient$enrolid, svcdate="2012-08-02", dstatus="20")
  #expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-12-31")
  
  #patient<-createPatient();
  #declareTest(id = patient$person_id, "When a person has a death recorded then we DO NOT truncate the OBSERVATION_PERIOD_END_DATE to reflect the corresponding DEATH_DATE. Id is PERSON_ID.")
  #add_enrollment_detail(enrolid=patient$enrolid, dtstart="2012-01-01", dtend="2012-12-31")
  #add_inpatient_services(enrolid=patient$enrolid, svcdate="2012-09-02", dstatus="20")
  #expect_observation_period(person_id=patient$person_id, observation_period_start_date="2012-01-01", observation_period_end_date="2012-12-31")
  
}
