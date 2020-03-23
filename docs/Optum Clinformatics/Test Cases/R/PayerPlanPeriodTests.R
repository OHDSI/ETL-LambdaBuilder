createPayerPlanPeriodTests <- function() #Failures related to incorrect mapping of PAYER_CONCEPT_ID. Wrike issue https://www.wrike.com/open.htm?id=479356662
{
  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Tests when patient has multiple payers active in the same time window.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-10-01', eligend = '2000-10-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-10-01', eligend = '2000-10-31', health_exch = '0',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-10-01', eligend = '2000-10-31', health_exch = '0',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'EPO', yrdob = 1969)
  expect_count_payer_plan_period(rowCount = 2, person_id = patient$person_id)
  expect_payer_plan_period(person_id = patient$person_id, payer_plan_period_start_date = '2000-10-01', payer_plan_period_end_date = '2000-10-31')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2006-01-01', eligend = '2006-05-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'MCR', cdhp = 3, eligeff = '2006-01-01', eligend = '2006-05-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 281, payer_source_value = 'MCR0')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2015-12-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2015-12-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 327, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2002-06-30', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2002-06-30', health_exch = 3,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 276, payer_source_value = 'COM3')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2001-12-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2001-12-31', health_exch = 1,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 275, payer_source_value = 'COM1')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2001-12-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'UNK', cdhp = 3, eligeff = '2000-05-01', eligend = '2001-12-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'EPO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 0, payer_source_value = 'UNK0')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-09-01', eligend = '2001-12-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'NONE', cdhp = 3, eligeff = '2000-09-01', eligend = '2001-12-31', health_exch = 2,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'IND', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_concept_id = 276, payer_source_value = 'NONE2')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2000-08-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-08-31',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, plan_source_value = 'HMO3')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2000-08-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-08-31',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'PPO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, plan_source_value = 'PPO3')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-10-01', eligend = '2004-01-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-10-01', eligend = '2004-01-31',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'OTH', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, plan_source_value = 'OTH3')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-10-01', eligend = '2000-10-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2006-06-30',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'POS', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, plan_source_value = 'POS3')


  patient <- createPatient()
  declareTest("PAYER_PLAN_PERIOD - Patient has multiple payer plan periods that should be collapsed based on PAYER_SOURCE_VALUE and PLAN_SOURCE_VALUE", 
              id = patient$person_id)
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2004-10-31', gdr_cd = 'M', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-10-31',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-12-01', eligend = '2004-08-31',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_count_payer_plan_period(rowCount = 1, person_id = patient$person_id)
}
