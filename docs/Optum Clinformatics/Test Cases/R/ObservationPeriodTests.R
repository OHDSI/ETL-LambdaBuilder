createObservationPeriodTests <- function()
{
  patient <- createPatient()
  declareTest("OBSERVATION_PERIOD - Tests if 2 enrollment durations (where second is subsumed by the first) results in a single observation period", #PASS V2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2000-05-01', eligend = '2008-12-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_continuous_enrollment(eligeff = '2000-05-01', eligend = '2008-02-29',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  expect_count_observation_period(rowCount = 1, person_id = patient$person_id)
  expect_observation_period(person_id = patient$person_id, observation_period_start_date = '2000-05-01', observation_period_end_date = '2008-12-31')


  patient <- createPatient()
  declareTest("OBSERVATION_PERIOD - Tests if 2 enrollment durations (where second is within 30 days of first) results in a single observation period", #PASS V2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2000-05-01', eligend = '2005-12-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_continuous_enrollment(eligeff = '2006-01-29', eligend = '2011-12-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  expect_count_observation_period(rowCount = 1, person_id = patient$person_id)
  expect_observation_period(person_id = patient$person_id, observation_period_start_date = '2000-05-01', observation_period_end_date = '2011-12-31')


  patient <- createPatient()
  declareTest("OBSERVATION_PERIOD - Tests if 2 enrollment durations (where second starts > 33 days after first) results in two observation periods", #PASS V2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2001-04-01', eligend = '2006-12-31',
                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_continuous_enrollment(eligeff = '2000-05-01', eligend = '2000-12-31',
                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  expect_count_observation_period(rowCount = 2, person_id = patient$person_id)
  expect_observation_period(person_id = patient$person_id, observation_period_start_date = '2001-04-01', observation_period_end_date = '2006-12-31')
  expect_observation_period(person_id = patient$person_id, observation_period_start_date = '2000-05-01', observation_period_end_date = '2000-12-31')
}
