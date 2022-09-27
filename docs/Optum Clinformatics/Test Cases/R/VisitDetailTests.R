createVisitDetailTests <- function() {
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record from medical claims creates a record in visit_detail", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2011-05-01', eligend = '2013-05-13',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2011-08-01', rvnu_cd = '0100', pos = '17',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2011-08-01', prov = '111111', provcat = '5678')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 38003620, visit_detail_start_date = '2011-08-01')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record from inpatient_confinement creates a record in visit_detail", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-08-11', 
                            diag1 = '250.00', disch_date = '2013-08-22', icd_flag = '9', conf_id = '456', pos = '21')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8717, visit_detail_start_date = '2013-08-11', visit_detail_end_date = '2013-08-22')
  
  
  ## RX_CLAIMS tests
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record in rx_claims creates a record in visit_detail, mail_ind", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, fill_dt = '2012-02-02', days_sup = 30, mail_ind = 'Y')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 38004345, visit_detail_start_date = '2012-02-02')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record in rx_claims creates a record in visit_detail, spclt_ind", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, fill_dt = '2012-02-02', days_sup = 30, mail_ind = 'N', spclt_ind = 'Y')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 38004348, visit_detail_start_date = '2012-02-02')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record in rx_claims with days_sup < 0 should set visit_detail_end_date = fill_dt", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, fill_dt = '2012-02-03', days_sup = -25, mail_ind = 'Y')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 38004345, visit_detail_start_date = '2012-02-03', visit_detail_end_date = '2012-02-03')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_DETAIL - Record in rx_claims with days_sup > 365 should set visit_detail_end_date = fill_dt+365-1", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, fill_dt = '2012-02-04', days_sup = 400, mail_ind = 'Y')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 38004345, visit_detail_start_date = '2012-02-04', visit_detail_end_date = '2013-02-02')
  
}
