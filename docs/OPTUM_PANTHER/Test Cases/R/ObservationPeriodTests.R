createObservationPeriodTests <- function () {
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests if 2 patient durations (where second is subsumed by the first) results in a single observation period", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201412')
  add_patient(ptid = patient$ptid, first_month_active = '201006', last_month_active = '201411')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')
  expect_count_observation_period(rowCount = 1, person_id = patient$person_id)

}
