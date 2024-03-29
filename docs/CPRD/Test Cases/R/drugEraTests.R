createDrugEraTests <- function()
{
  set_defaults_therapy(consid = NULL, prn = NULL)
  
  # 1) drug era with 2 drug records
  patient <- createPatient(pracid='111');
  declareTest(id = patient$person_id, 'drug era with 2 drug records, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-01', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 20, staffid = 9001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  add_therapy(patid = patient$patid, eventdate = '2012-01-20', prodcode = 2, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 30, staffid = 9001)
  expect_drug_era(person_id = lookup_person("person_id", person_source_value = patient$person_id), drug_concept_id=1316354, drug_era_start_date='2012-01-01',
                  drug_era_end_date='2012-02-18', drug_exposure_count=2)
  expect_count_drug_era(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

  # 2) drug era with multilex drug code
  patient <- createPatient(pracid='111');
  declareTest(id = patient$person_id, 'drug era with multilex drug code id is person_id')
  add_product(prodcode = 2232, gemscriptcode = 90473020, productname = 'Ibuprofen lysine 400mg tablets')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_therapy(patid = patient$patid, eventdate = '2012-01-31', prodcode = 2232, qty = 1, numpacks = 0,
              issueseq = 1, numdays = 30, staffid = 9001)
  expect_drug_era(person_id = lookup_person("person_id", person_source_value = patient$person_id), drug_concept_id=1177480, drug_era_start_date='2012-01-31',
                  drug_era_end_date='2012-02-29', drug_exposure_count=1)
  expect_count_drug_era(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

}
