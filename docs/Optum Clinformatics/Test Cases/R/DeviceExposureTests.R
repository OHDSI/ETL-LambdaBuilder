createDeviceExposureTests <- function()
{
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DEVICE - Patient has NDC source codes mapping to domain Device", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					  								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', ndc = '24840153001', ndc_qty = 1)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201)
  expect_device_exposure(person_id = patient$person_id, device_concept_id = 46358737, device_source_value = '24840153001')
  expect_no_condition_occurrence(person_id = patient$person_id)
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DEVICE - Patient has proc source codes mapping to domain Device, does not get mapped to Procedure", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					  								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '11', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = "K0901", proc_position = 1, clmid = claim$clmid, fst_dt = '2013-07-01')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202)
  expect_device_exposure(person_id = patient$person_id, device_source_value = 'K0901')
  expect_no_procedure_occurrence(person_id = patient$person_id, procedure_source_value = 'K0901')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DEVICE - Patient has proc source codes in medical_claims mapping to domain Device and visit_place_of_service of OP does not get mapped to Procedure", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')					  								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', proc_cd = 'K0901', units = 1)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202)
  expect_device_exposure(person_id = patient$person_id, device_source_value = 'K0901')
  expect_no_procedure_occurrence(person_id = patient$person_id, procedure_source_value = 'K0901')
}
