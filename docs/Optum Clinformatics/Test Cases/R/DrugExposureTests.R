createDrugExposureTests <- function()
{
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Patient has 2 RX records, the first within the enrollment period, the second outside of enrollment.", 
                id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, clmid = claim$clmid, ndc = '55111067101', fill_dt = '2013-10-01')
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, clmid = claim$clmid, ndc = '58487000102', fill_dt = '2013-12-01')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 1322189, drug_source_value = '55111067101')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 581458, visit_start_date = '2013-10-01')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 0, drug_source_value = '58487000102') #The drug_concept_id is 0 becuase the record is prior to the drug approval date
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 581458, visit_start_date = '2013-12-01')


  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Patient has multiple RX records, all within enrollment period, but have the same patid, pat_planid, ndc.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, clmid = claim$clmid, ndc = '55111067101', fill_dt = '10/01/2013')
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, clmid = claim$clmid, ndc = '55111067101', fill_dt = '10/01/2013')
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, clmid = claim$clmid, ndc = '55111067101', fill_dt = '10/01/2013')
  expect_count_drug_exposure(rowCount = 3, person_id = patient$person_id)
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 581458, visit_start_date = '2013-10-01')
  expect_count_visit_occurrence(person_id = patient$person_id, rowCount = 1)
  expect_count_visit_detail(person_id = patient$person_id, rowCount = 3)

  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Patient has procedure in MEDICAL_CLAIMS that should map to a DRUG_EXPOSURE record.",
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', proc_cd = 'J0456', units = 1)
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 41212830)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Patient has procedure in MED_PROCEDURE.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', proc_cd = NULL,
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_procedure(patid = patient$patid, pat_planid = patient$patid, proc = 'J0456', proc_position = 1, clmid = claim$clmid, fst_dt = '2013-07-01')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 41212830)
  expect_no_procedure_occurrence(person_id = patient$person_id)


  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - NDC codes from Medical map to drug exposure", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
  add_medical_claims(clmid = claim$clmid, clmseq = '001', ndc = '55111067101', lst_dt = '2013-07-01',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 1322189, drug_source_value = '55111067101')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Proc codes from lab results map to drug exposure", id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_lab_results(labclmid = claim$clmid, pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', proc_cd = '90651')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 40213322, drug_source_value = '90651')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("DRUG_EXPOSURE - Record from inpatient_confinement with a procedure code that maps to a drug", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-08-11', 
                            diag1 = '250.00', disch_date = '2013-08-22', icd_flag = '9', conf_id = '456', pos = '21', proc1 = '90651')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 40213322, drug_source_value = '90651')
  
}
