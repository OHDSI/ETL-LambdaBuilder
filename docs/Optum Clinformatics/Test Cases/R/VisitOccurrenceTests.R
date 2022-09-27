createVisitOccurrenceTests <- function() {
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_OCCURRENCE - Multiple IP admission claims on the same day with different pat_planids, should get a single IP visit occurrence.", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)  

  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid*1000, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid*1000, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  
  expect_count_visit_detail(rowCount = 2, person_id = patient$person_id, visit_detail_concept_id = 8717, visit_detail_start_date = '2013-07-01')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201, visit_start_date = '2013-07-01', visit_end_date = '2013-07-01')
  
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_OCCURRENCE - Inpatient Visit Occurrence for a patient with a single medical diagnosis.", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2014-03-13', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2014-03-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201, visit_start_date = '2014-03-01', visit_end_date = '2014-03-13')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8717, visit_detail_start_date = '2014-03-01', visit_detail_end_date = '2014-03-13')

  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_OCCURRENCE - Outpatient Visit Occurrence for a patient with a single medical diagnosis.", #FAIL v2.0.0.19 visit_detail_concepts not rolling up
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-08-01', pos = '11',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-08-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202)
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 581477)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_OCCURRENCE - Emergency Room Visit Occurrence for a patient with a single medical diagnosis.", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-09-01', rvnu_cd = '0981', pos = '23',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-09-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9203)
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8870)
  

  patient <- createPatient()
  claim <- createClaim()
  declareTest("Non-hospital institution Visit Occurrence for a patient with a single medical diagnosis.", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2015-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-10-30', rvnu_cd = '0100', pos = '13',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-10-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 42898160)
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8615)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has a series of diagnoses that fall outside of their Observation Period but visit is still created.", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2009-07-01', pos = '22',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2009-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202, visit_start_date = '2009-07-01', visit_end_date = '2009-07-01')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8756, visit_detail_start_date = '2009-07-01', visit_detail_end_date = '2009-07-01')
 

  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has a series of visits that are linked by foreign key", #FAIL v2.0.0.19 PRECEDING_VISIT_DETAIL_ID not being populated, though PRECEDING_VISIT_OCCURRENCE_ID is
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2012-11-01', pos = '11',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2012-11-01', 
                     prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9",
                    diag = "7061", diag_position = 1, clmid = claim$clmid)
    
  firstOccurrenceId <- lookup_visit_occurrence(fetchField = "visit_occurrence_id", 
                                               person_id = patient$person_id, visit_start_date = '2012-11-01')
  
  firstDetailId <- lookup_visit_detail(fetchField = "visit_detail_id", 
                                               person_id = patient$person_id, visit_detail_start_date = '2012-11-01')
  
  claim <- createClaim()
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2012-11-02',
                     pat_planid = patient$patid, patid = patient$patid, 
                     fst_dt = '2012-11-02', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", 
                    diag = "7061", diag_position = 1, clmid = claim$clmid)
  
  expect_visit_occurrence(person_id = patient$person_id,
                          preceding_visit_occurrence_id = firstOccurrenceId)
  expect_visit_detail(person_id = patient$person_id,
                      preceding_visit_detail_id = firstDetailId)
  

  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has a series of inpatient_confinement records, with an outpatient record in the middle", #PASS v2.0.0.19
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2015-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1959)
  
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-08-21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-08-21', 
                     prov = '111111', provcat = '5678', pos = '21', conf_id = '123')
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-08-11', 
                            diag1 = '250.00', disch_date = '2013-08-22', icd_flag = '9', conf_id = '123')
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2015-02-11', 
                            diag1 = '250.00', disch_date = '2015-02-15', icd_flag = '9', conf_id = '234')
  
  expect_visit_detail(person_id = patient$person_id, visit_detail_start_date = '2013-08-21', visit_detail_end_date = '2013-08-21')
  expect_visit_detail(person_id = patient$person_id, visit_detail_start_date = '2013-08-11', visit_detail_end_date = '2013-08-22')
  expect_visit_detail(person_id = patient$person_id, visit_detail_start_date = '2015-02-11', visit_detail_end_date = '2015-02-15')
  
  expect_visit_occurrence(person_id = patient$person_id, visit_start_date = '2013-08-11', visit_end_date = '2013-08-22')
  expect_visit_occurrence(person_id = patient$person_id, visit_start_date = '2015-02-11', visit_end_date = '2015-02-15')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("VISIT_OCCURRENCE - Emergency Room Visit Occurrence occurring on the first day of an inpatient confinement.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-09-01', rvnu_cd = '0981', pos = '23',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-09-01', prov = '111111', provcat = '1001', conf_id = '987')
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-09-01', 
                            diag1 = '250.00', disch_date = '2013-09-22', icd_flag = '9', conf_id = '987')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 262, visit_start_date = '2013-09-01', visit_end_date = '2013-09-22')
  expect_visit_detail(person_id = patient$person_id, visit_detail_concept_id = 8870)
}

