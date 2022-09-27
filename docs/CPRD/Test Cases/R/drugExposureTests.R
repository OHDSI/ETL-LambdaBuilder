createDrugExposureTests <- function()
{
  add_product(prodcode = 2, gemscriptcode = '58976020')
  add_product(prodcode = 9999, gemscriptcode = '93680020')
  add_product(prodcode = 46190, gemscriptcode = '99978020')

  # 1) 9100
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - testing the lookup for numdays does correct end date start+28 days, id is person_id')
  add_daysupply_decodes(prodcode = 2, qty = 1, numpacks = 0, numdays = 29)
  add_commondosages(dosageid = 2, daily_dose = 0.000)
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid= patient$pracid)
  add_therapy(patid =  patient$patid, eventdate = '2012-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 0, staffid = 9001, dosageid = 2)
  add_consultation(patid =  patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_drug_exposure(person_id =  patient$person_id, drug_concept_id = 19073982,
                       drug_source_value = 58976020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-1-29')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 2) 9101
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - testing when there is no lookup available default to start dte, id is person_id' )
  add_patient(patid =  patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid= patient$pracid)
  add_therapy(patid =  patient$patid, eventdate = '2012-01-01', prodcode = 42, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 0, staffid = 9001)
  add_consultation(patid =  patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id,drug_concept_id = 1539463, drug_source_value = 72487020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-1-1')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 3) 9102
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE- The drug records comes in without a valid days supply, no lookup in DAYSSUPPLY_DECODES, no lookups in DAYSSUPPLY_MODES, assume 1 day duration.Id is person_id')
  add_patient(patid =  patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid =  patient$patid, eventdate = '2012-01-01', prodcode = 9999, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 0, staffid = 9001)
  add_consultation(patid =  patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id,drug_source_value = 93680020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-1-1')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 4) 9103
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - testing end date: You have a THERAPY.NUMDAYS = 40. Id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 40, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id,drug_concept_id = 19073982, drug_source_value  = 58976020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-2-9')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 5) 9104
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - testing end date: You have a THERAPY.NUMDAYS = 366 - show correct to 29 days using lookup. Id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id,drug_concept_id = 19073982, drug_source_value  = 58976020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-1-29')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 6) 9105
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - Test visit_occurrence_id: Drug is written to DRUG_EXPOSURE. Id is person_Id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-03-12', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-03-12', staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = '2012-03-12',
                       drug_concept_id = 19073982, drug_source_value  = 58976020, quantity = 1, refills = 1
                       )
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)


  # 7) 9106  - invalid
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Drug date exists in an invalid visit_occurrence (outside practice dates) id is person_id')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  # add_therapy(patid = patient$patid, eventdate = '2016-01-01', prodcode = 2, qty = 1, numpacks = 0,
  #             issueseq = 1, numdays = 366, staffid = 9001)
  # add_consultation(patid = patient$patid, eventdate = '2016-01-01', staffid = 9001)
  # expect_no_drug_exposure(person_id = patient$person_id)


  # 8) 9107
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - Drug date does exist within a valid observation period but does not have a consultation date. Id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = '2012-01-01',
                       drug_concept_id = 19073982, drug_source_value  = 58976020, quantity = 1, refills = 1,
                       drug_exposure_end_date = '2012-1-29')
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)

  # 9) 9108 - invalid
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - PRODCODE = -1 - invalid.')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = -1, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_no_drug_exposure(person_id = patient$person_id)

  # 10) 9109 - 1/24/2020 logic no longer needed, gemscript maps to device.
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'You have a valid PRODCODE but doesnt get an VOCAB mapping.PRODCODE = 46190. Id is person_Id')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  # add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 46190, qty = 1, numpacks = 0,
  #             issueseq = 1, numdays = 366, staffid = 9001)
  # add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  # expect_drug_exposure(person_id = patient$person_id, drug_concept_id = 0, drug_source_value =  99978020,
  #                      drug_exposure_start_date = '2012-01-01')
  # expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)



  #==============================================================================


  add_medical(medcode = 72, read_code = '65F5.00')
  add_medical(medcode = 28, read_code = '6564.00')
  add_medical(medcode = 58, read_code = '65B..00')
  # add 1058 a condition code?

  # 11) -- invalid status -- this is an issue that needs to be resolved, added a wrike task
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - Invalid status, id = person_Id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2012-01-01',medcode = 72, staffid = 1001, status=4)
  expect_no_drug_exposure(person_id = patient$person_id)

  # 12) -- immunization with visit -- now goes to procedure
  add_medical(medcode=1, read_code = '65M2.00')
  # old code 65F5.00 goes to 4179181 procedure domain now
  patient <- createPatient();
  declareTest(patient$person_id, 'DRUG_EXPOSURE - valid immunization with visit, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2012-01-01', medcode = 1, staffid = 1001, status=1)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  expect_procedure_occurrence(person_id = patient$person_id,
                       procedure_concept_id = 35610251,
                       procedure_source_concept_id = 45432113, procedure_source_value = '65M2.00',
                       procedure_type_concept_id = 38000275, procedure_date = '2012-01-01')
  expect_count_procedure_occurrence(person_id = patient$person_id, rowCount = 1)


  # 13) -- immunization without visit  -- now goes to procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - valid immunization without visit - null visit_occur_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2012-01-01', medcode = 1, staffid = 1001, status=1)
  expect_procedure_occurrence(person_id = patient$person_id,
                       procedure_concept_id = 35610251,
                       procedure_source_concept_id = 45432113, procedure_source_value = '65M2.00',
                       procedure_type_concept_id = 38000275, procedure_date = '2012-01-01')
  expect_count_procedure_occurrence(person_id = patient$person_id, rowCount = 1)

  # 14) outside observation period
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - Read  outside observation period, id = person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2009-03-01', medcode = 1, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id,
                       procedure_concept_id = 35610251,
                       procedure_source_concept_id = 45432113, procedure_source_value = '65M2.00',
                       procedure_type_concept_id = 38000275, procedure_date = '2009-03-01')


  # 14) Read code in immunization goes to condition_occurrence
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - immunization read code condition goes into conditions, id = person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2009-03-01', medcode = 1058, staffid = 1001, status = 1)
  expect_condition_occurrence(person_id = patient$person_id)


  # 15) -- from clinical
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - valid read from clinical, id = patient$person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2010-03-01', medcode = 1, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id,
                       procedure_concept_id = 35610251,
                       procedure_source_concept_id = 45432113, procedure_source_value = '65M2.00',
                       procedure_type_concept_id=38000275)
  expect_count_procedure_occurrence(person_id = patient$person_id, rowCount = 1)


  # 16) -- referral
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - valid read from referral, id = person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_referral(patid = patient$patid, eventdate = '2010-03-01', medcode = 1, staffid = 1001)
  expect_procedure_occurrence(person_id = patient$person_id,
                       procedure_concept_id = 35610251,
                       procedure_source_concept_id = 45432113, procedure_source_value = '65M2.00',
                       procedure_type_concept_id=38000275)
  expect_count_procedure_occurrence(person_id = patient$person_id, rowCount = 1)
  
  # 17) -- test #NOT NEEDED AS OF 3/18/2020 - all test entity types were mapped to measurements instead.
  # patient <- createPatient();
  # declareTest( id = patient$person_id, 'valid read from test, id is person_id')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  # add_test(patid = patient$patid, eventdate = '2010-03-01', medcode = 1, staffid = 1001, enttype = 215, data1 = 9)

  # expect_drug_exposure(person_id = patient$person_id,
  #                      drug_concept_id = 19136026,
  #                      drug_source_concept_id = 45432113, drug_source_value = '215--65M2.00',
  #                      drug_type_concept_id=38000177)
  # expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)



  #===========================================================================

  add_medical(medcode = 202, read_code = '65A..00')

  # 19) -- clinical
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - valid entry, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2010-03-01', medcode = 202, staffid = 1001)
  expect_drug_exposure(person_id = patient$person_id,
                       drug_concept_id = 40213170,
                       drug_source_concept_id = 45445397, drug_source_value = '65A..00',
                       drug_type_concept_id=38000177)
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)

  # device or drug??

  # 20) -- referral
  patient <- createPatient();
  declareTest(id = patient$person_id, 'DRUG_EXPOSURE - valid entry, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2010-03-01', medcode = 202, staffid = 1001)
  expect_drug_exposure(person_id = patient$person_id,
                       drug_concept_id = 40213170,
                       drug_source_concept_id = 45445397, drug_source_value = '65A..00',
                       drug_type_concept_id=38000177)
  expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)

  # device or drug??

  # 21) -- test
  # patient <- createPatient(); #NOT NEEDED AS OF 3/18/2020 - all test entity types were mapped to measurements instead.

  # declareTest(id = patient$person_id, 'valid entry, id is person_id')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  # add_test(patid = patient$patid, eventdate = '2010-03-01', medcode = 1, staffid = 1001, enttype = 215, data1= 25)
  # expect_drug_exposure(person_id = patient$person_id,
  #                      drug_concept_id = 19136026,
  #                      drug_source_concept_id = 45432113, drug_source_value = '215--65M2.00',
  #                      drug_type_concept_id=38000177)
  # expect_count_drug_exposure(person_id = patient$person_id, rowCount = 1)

  # 22) ---- immunisation record in future, record removed
  patient <- createPatient();
  declareTest(id = patient$person_id, 'immunization record in future, record removed')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2099-01-01', medcode = 1, staffid = 1001, status=1)
  expect_no_drug_exposure(person_id = patient$person_id)

  patient <- createPatient();
  declareTest(id = patient$person_id, 'Drug date occurs in 2099, record removed')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid=patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2099-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 366, staffid = 9001)
  expect_no_drug_exposure(person_id = patient$person_id)


}
