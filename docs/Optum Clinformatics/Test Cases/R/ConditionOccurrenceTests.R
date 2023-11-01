createConditionOccurrenceTests <- function()
{
  testDiag <- '7061'
  testConditionConceptId <- 141095
  
    patient <- createPatient()
    claim <- createClaim()
    declareTest("CONDITION_OCCURRENCE - Patient has 1 record in med_diagnosis with diag in position 1", id = patient$person_id)
    add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                      gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
    add_medical_claims(clmid = claim$clmid, clmseq = '001', loc_cd = '2',
                       lst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, 
                       fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
    add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, clmid = claim$clmid, 
                      diag_position = '01', poa = 'Y', fst_dt = '2013-07-01', loc_cd = '2')
    expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = testConditionConceptId, 
                                condition_type_concept_id = 44786627, condition_status_concept_id = 46236988)
    
    patient <- createPatient()
    claim <- createClaim()
    declareTest("CONDITION_OCCURRENCE - Patient has 1 record in med_diagnosis with diag in position 4", id = patient$person_id)
    add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                     gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
    add_medical_claims(clmid = claim$clmid, clmseq = '001', loc_cd = '2',
                       lst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, 
                       fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
    add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, clmid = claim$clmid, 
                      diag_position = '04', fst_dt = '2013-07-01', loc_cd = '2')
    expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = testConditionConceptId, 
                                condition_type_concept_id = 44786629)
  

  patient <- createPatient()
  claim <- createClaim()
  declareTest("CONDITION_OCCURRENCE - Patient has medical records which have some valid and invalid formatted DIAG codes.", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2',
                     pat_planid = patient$person_id, patid = patient$person_id, fst_dt = '2013-07-01', 
                     prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, diag_position = 1, clmid = claim$clmid, loc_cd = '2', fst_dt = '2013-07-01')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "99999", diag_position = 2, clmid = claim$clmid, loc_cd = '2', fst_dt = '2013-07-01')
  
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = testConditionConceptId)
  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = '99999', condition_concept_id = 0)

  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("CONDITION_OCCURRENCE - Patient has a series of 3 inpatient visits with same dates and diagnoses in separate records.", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, 
                    clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
  add_medical_claims(clmid = claim$clmid, clmseq = '002', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, 
                    clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
  add_medical_claims(clmid = claim$clmid, clmseq = '003', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, 
                    clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = testConditionConceptId )
  expect_count_condition_occurrence(person_id = patient$person_id, rowCount = 3)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("CONDITION_OCCURRENCE - Creates two Condition Occurrences from a single Medical row that specifies an ICD9 code that has multiple SNOMED mappings.", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = '24910', 
                    clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = '24910', condition_concept_id = 443727)
  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = '24910', condition_concept_id = 195771)
  expect_count_condition_occurrence(person_id = patient$person_id, rowCount = 2)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("CONDITION_OCCURRENCE - Tests ICD10 CM vs International", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "10", diag = 'Z731', 
                    clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = 'Z731', condition_concept_id = 43020481)
  expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = 'Z731', condition_source_concept_id = 45581067)
  
  poaMappings <- data.frame(
    sourceValue = c('Y','N','U','W'),
    concept = c(46236988, 0, 0, 0), stringsAsFactors = FALSE
  )
  
  patient <- createPatient()
  claim <- createClaim()
  #declareTest("Creates a record that occurs in the future. Expectation is that it will be deleted.", source_pid = patient$patid, cdm_pid = patient$person_id)
  #add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2011-05-01', eligend = '2013-10-31',
  #                  gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1979)
  #add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2099-07-01',
  #                   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2099-07-01', prov = '111111', provcat = '5678')
  #add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = '24910', 
  #                  clmid = claim$clmid, diag_position = 1)
  #expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = '24910', condition_concept_id = 443727)
  
  for (i in 1:nrow(poaMappings)) {
    patient <- createPatient()
    claim <- createClaim()
    declareTest(sprintf("Tests POA = %s", poaMappings[i,]$sourceValue), id = patient$person_id)
    add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                     gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
    add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2',
                       pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
    add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "10", diag = 'Z731', poa = poaMappings[i,]$sourceValue,
                      clmid = claim$clmid, diag_position = '01', loc_cd = '2', fst_dt = '2013-07-01')
    expect_condition_occurrence(person_id = patient$person_id, 
                                condition_status_source_value = poaMappings[i,]$sourceValue, 
                                condition_status_concept_id = poaMappings[i,]$concept)
  }
}
