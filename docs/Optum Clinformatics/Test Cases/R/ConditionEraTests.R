
createConditionEraTests <- function()
{
  testDiag <- '7061'
  testConditionConceptId <- 141095
  
  patient <- createPatient()
  declareTest("CONDITION_ERA - Patient has Medical records (some which are Concept_ID = 0) that both collapse and stay separate in the Condition Era table", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')
  
  claim <- createClaim()
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', loc_cd = '2')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, clmid = claim$clmid, fst_dt = '2013-07-01', loc_cd = '2')
  
  claim <- createClaim()
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-25',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-25', prov = '111111', provcat = '5678', loc_cd = '2')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = testDiag, clmid = claim$clmid, fst_dt = '2013-07-25', loc_cd = '2')
  
  
  claim <- createClaim()
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-25',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-25', prov = '111111', provcat = '5678', loc_cd = '2')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7872", clmid = claim$clmid, fst_dt = '2013-07-25', loc_cd = '2')
  
  
  claim <- createClaim()
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-25',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-25', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "V1582", clmid = claim$clmid)
  

  expect_condition_era(person_id = patient$person_id, condition_concept_id = testConditionConceptId, condition_occurrence_count = 2)
  expect_condition_era(person_id = patient$person_id, condition_concept_id = 31317, condition_occurrence_count = 1)
  expect_no_condition_era(person_id = patient$person_id, condition_concept_id = 0)
}
