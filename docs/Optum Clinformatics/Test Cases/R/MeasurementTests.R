createMeasurementTests <- function()
{
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has lab_result with 0 rslt_nbr and string rslt_txt",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')
  add_lab_results(labclmid = claim$clmid, pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', 
                  loinc_cd = '22962-5', proc_cd = '87517', rslt_nbr = 0.00, rslt_txt = 'STUFF')
  expect_measurement(person_id = patient$person_id, measurement_source_value = '22962-5', value_as_number = 0)
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has lab_result with non-zero rslt_nbr and string rslt_txt",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', 
                  loinc_cd = '22962-5', proc_cd = '87517', rslt_nbr = "111", rslt_txt = 'STUFF')
  expect_measurement(person_id = patient$person_id, measurement_source_value = '22962-5', 
                     value_as_number = "111.0")
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has lab_result with both loinc_cd and proc_cd values that map to a Measurement record based on loinc_cd", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', loinc_cd = '22962-5', proc_cd = '87517')
  expect_measurement(person_id = patient$person_id, measurement_source_value = '22962-5')
  expect_no_measurement(person_id = patient$person_id, measurement_source_value = '87517')


  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has diag source codes mapping to domain Measurement and visit_place_of_service of IP does not get mapped to Condition", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "V8271", clmid = claim$clmid, diag_position = 1, loc_cd = '2', fst_dt = '2013-07-01')
  expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = 'V8271')
  expect_measurement(person_id = patient$person_id, measurement_concept_id = 4237017)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has diag source codes mapping to domain Measurement and visit_place_of_service of OP does not get mapped to Condition", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2', pos = '11',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "V8271", clmid = claim$clmid, diag_position = 1, loc_cd = '2', fst_dt = '2013-07-01')
  expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = 'V8271')
  expect_measurement(person_id = patient$person_id, measurement_concept_id = 4237017)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has measurement value (sourced from lab_result rslt_nbr)", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, loinc_cd = '22962-5', 
                  rslt_nbr = 1000)
  expect_measurement(person_id = patient$person_id, value_as_number = 1000, measurement_concept_id = 3012939)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has procedure code in MEDICAL_CLAIMS that maps to measurement", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678',
                     proc_cd = '87517')
  expect_measurement(person_id = patient$person_id, measurement_concept_id = 2213127)
  
  
  patient <- createPatient()
  claim <- createClaim()
  result_text <- 'LOW'
  declareTest(paste0("Patient has ", result_text, " result text"), id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, loinc_cd = '22962-5', 
                  rslt_nbr = 1000, rslt_txt = result_text)
  expect_measurement(person_id = patient$person_id)
  
  
  patient <- createPatient()
  claim <- createClaim()
  result_text <- 'HIGH'
  declareTest(paste0("Patient has ", result_text, " result text"), id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, loinc_cd = '22962-5', 
                  rslt_nbr = 1000, rslt_txt = result_text)
  expect_measurement(person_id = patient$person_id)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has unit of measurement", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, loinc_cd = '22962-5', 
                  rslt_nbr = 1000, rslt_unit_nm = 'cal')
  expect_measurement(person_id = patient$person_id, unit_concept_id = 9472)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has normal range values", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, loinc_cd = '22962-5', 
                  rslt_nbr = 1000, low_nrml = 10, hi_nrml = 100)
  expect_measurement(person_id = patient$person_id, range_low = 10, range_high = 100)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has procedure code in MED_PROCEDURE that maps to measurement", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "87517", proc_position = 1, clmid = claim$clmid, fst_dt = '2013-07-01')
  expect_measurement(person_id = patient$person_id, measurement_concept_id = 2213127)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has procedure code in inpatient_confinement that maps to measurement", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-08-11', 
                            diag1 = '250.00', disch_date = '2013-08-22', icd_flag = '9', conf_id = '456', pos = '21', proc3 = '87517')
  expect_measurement(person_id = patient$person_id, measurement_concept_id = 2213127)
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("MEASUREMENT - Patient has measurement source value of 000", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_lab_results(pat_planid = patient$patid, patid = patient$patid, loinc_cd = '000', fst_dt = '2013-07-01')
  expect_measurement(person_id = patient$person_id, measurement_source_value = '000')
  
}

