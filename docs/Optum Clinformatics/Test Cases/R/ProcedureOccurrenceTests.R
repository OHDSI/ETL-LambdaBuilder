createProcedureOccurrenceTests <- function()
{
  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has 2 medical records which have the same proc code listed in proc position 1-3, with repeated PROC_CD in both records.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01', loc_cd = '2',

                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 2, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 3, fst_dt = '2013-07-01')
  
  add_medical_claims(clmid = claim$clmid, clmseq = '002', proc_cd = '92928', lst_dt = '2013-07-01', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 2, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 3, fst_dt = '2013-07-01')
  
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998)

 

  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has medical records which have some valid and invalid formatted PROC codes.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "2", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "2", clmid = claim$clmid, proc_position = 2, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "2", clmid = claim$clmid, proc_position = 3, fst_dt = '2013-07-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_source_value = '2', procedure_concept_id = 0)

  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has a series of 3 inpatient visits with same dates and procedure codes in separate records.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "70481", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has series of procedures within a visit that should use the VISIT_END for PROC or FST_DT for PROC_CD to determine the procedure date.",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '70481',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-31', prov = '111111', provcat = '5678')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998, procedure_date = '2013-07-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331, procedure_date = '2013-07-31')


  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has multiple Medical rows with placeholders for procedure codes.",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928',
                     lst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 2, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 3, fst_dt = '2013-07-01')

  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '70481',
                     lst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 1, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 2, fst_dt = '2013-07-01')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "0000000", clmid = claim$clmid, proc_position = 3, fst_dt = '2013-07-01')

  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has Medical records with a diag that maps to 2 SNOMED concepts, and single procedure.",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '70481', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "24910", diag_position = 1, clmid = claim$clmid, fst_dt = '2013-07-01', loc_cd = '2')

  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = '24910', condition_concept_id = 443727)
  expect_condition_occurrence(person_id = patient$person_id, condition_source_value = '24910', condition_concept_id = 195771)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has 2 medical records with 2 different procedures, but only 1 record has diag specified.",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '92928', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", diag_position = 1, clmid = claim$clmid, loc_cd = '2', fst_dt = '2013-07-01')

  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '70481', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')

  expect_condition_occurrence(person_id = patient$person_id, condition_concept_id = 141095)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 43527998)
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has diag source codes mapping to domain Procedure and visit_place_of_service of IP does not get mapped to Condition",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '92928', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "V5789", diag_position = 1, clmid = claim$clmid, loc_cd = '2', fst_dt = '2013-07-01')

  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4180248)
  expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = 'V5789')
  expect_visit_occurrence(person = patient$person_id, visit_concept_id = 9201)



  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - Patient has diag source codes mapping to domain Procedure and visit_place_of_service of OP does not get mapped to Condition",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = '92928', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', pos = '11')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "V5789", diag_position = 1, clmid = claim$clmid, loc_cd = '2', fst_dt = '2013-07-01')

  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 4180248)
  expect_no_condition_occurrence(person_id = patient$person_id, condition_source_value = 'V5789')
  expect_visit_occurrence(person = patient$person_id, visit_concept_id = 9202)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("Patient has procedure from a lab result proc_cd",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                    gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					
  add_lab_results(labclmid = claim$clmid, fst_dt = '2013-07-01', pat_planid = patient$patid, patid = patient$patid,
                  loinc_cd = '', proc_cd = '70481')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = 2211331)
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - do not set end date for not Medical procedures.", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = NULL,
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = 'V5789', proc_position = 1, clmid = claim$clmid, fst_dt = '2013-07-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_end_date = NULL)
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("PROCEDURE_OCCURRENCE - set end date for Medical procedures.", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', proc_cd = '92928', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_end_date = '2013-07-01')
  
}
