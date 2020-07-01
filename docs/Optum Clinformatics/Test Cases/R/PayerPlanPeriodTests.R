createPayerPlanPeriodTests <- function()
{
  patient <- createPatient()
  declareTest("Tests when patient has multiple payers active in the same time window.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-10-01', eligend = '2000-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1988)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-10-01', eligend = '2000-10-31',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1988)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-10-01', eligend = '2000-10-31',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'EPO', yrdob = 1988)
  expect_count_payer_plan_period(rowCount = 2, person_id = patient$person_id)


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-10-01', eligend = '2017-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'MCR', cdhp = 3, eligeff = '2006-01-01', eligend = '2006-05-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'MCR0', payer_concept_id = 281)


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '1998-10-01', eligend = '2017-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2015-12-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0', payer_concept_id = 327)


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-01-01', eligend = '2009-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2002-06-30', health_exch = 0,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-03-01', eligend = '2009-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2001-12-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-03-01', eligend = '2003-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2001-12-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'EPO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-08-01', eligend = '2003-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-09-01', eligend = '2001-12-31', health_exch = 1,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'IND', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM1', payer_concept_id = 275)


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-02-01', eligend = '2000-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-08-31',
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM Health Maint Org')


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-06-01', eligend = '2000-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'Y', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-08-31', health_exch = 2,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'PPO', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM2', payer_concept_id = 276)


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-10-01', eligend = '2009-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2003-11-01', eligend = '2004-01-31', health_exch = 0,
                    gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'OTH', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("Checks the PAYER_PLAN_SOURCE_VALUE mapping for all combos of source values.", id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-03-01', eligend = '2009-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2006-06-30', health_exch = 0,
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'POS', yrdob = 1969)
  expect_payer_plan_period(person_id = patient$person_id, payer_source_value = 'COM0')


  patient <- createPatient()
  declareTest("Patient has multiple payer plan periods that should be collapsed based on PAYER_SOURCE_VALUE and PLAN_SOURCE_VALUE", 
              id = patient$person_id)
  add_member_continuous_enrollment( eligeff = '2000-03-01', eligend = '2008-11-30',
                                    gdr_cd = 'M', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-05-01', eligend = '2000-10-31',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  add_member_enrollment(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2000-12-01', eligend = '2004-08-31',
                    gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  expect_count_payer_plan_period(rowCount = 1, person_id = patient$person_id)
}
