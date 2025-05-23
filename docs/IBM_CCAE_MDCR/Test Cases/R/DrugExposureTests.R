#' @export
createDrugExposureTests <- function () {

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Duplicate drug records become one record in the CDM. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '36987257801', year = '2012', svcdate = '2012-02-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '36987257801', year = '2012', svcdate = '2012-02-01')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '40161912', drug_exposure_start_date = '2012-02-01')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Negative daysupp should be 0 in cdm. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '58864060830', year = '2012', daysupp = '-30', svcdate = '2012-06-12')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '1545998', days_supply = '1', drug_exposure_start_date = '2012-06-12')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Daysupp >365 should be 365 in cdm. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '58864060830', year = '2012', daysupp = '432', svcdate = '2012-08-07')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '1545998', days_supply = '365', drug_exposure_start_date = '2012-08-07')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "CPT4 drug code in inpatient record moves to drug_exposure. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_inpatient_services(enrolid = patient$enrolid, proc1 = '90376', svcdate = '2012-08-09', tsvcdat = '2012-08-12', caseid = encounter$caseid, year = '2012')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '46234006', drug_exposure_start_date = '2012-08-09')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Days supply is NULL but DRUG_EXPOSURE_END_DATE is set to DRUG_EXPOSURE_START_DATE (HIX-1430). Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_inpatient_services(enrolid = patient$enrolid, proc1 = '90376', svcdate = '2012-08-09', tsvcdat = '2012-08-12', caseid = encounter$caseid, year = '2012')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '46234006', drug_exposure_start_date = '2012-08-09', drug_exposure_end_date = '2012-08-09')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has 11 digit NDC that doesn''t map, should use first 9 digits instead. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '13533063670', year = '2012', svcdate = '2012-01-17')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '46275250', drug_exposure_start_date = '2012-01-17')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Drug exposure quantity - if not populated in source, leave it NULL. Id is PERSON_ID. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '13533063670', year = '2012', svcdate = '2012-01-19', metqty = NULL)
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '46275250', drug_exposure_start_date = '2012-01-19', quantity = NULL)

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has 9 digit NDC that doesn''t map, should use first 9 digits instead, should map to DRUG_CONCEPT_ID=0 because of the date filter. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2006-12-31', dtstart = '2006-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '00006000543', year = '2006', svcdate = '2006-07-08')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '0', drug_exposure_start_date = '2006-07-08')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has 9 digit NDC that doesn''t map, should use first 9 digits instead, should map to correct DRUG_CONCEPT_ID because of the date filter. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2014-12-31', dtstart = '2014-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '00006032582', year = '2014', svcdate = '2014-09-18')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id = '45775771', drug_exposure_start_date = '2014-09-18')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Tofacitinib mapps to 11-digit DRUG_SOURCE_CONCEPT_ID instead of 9-digit (HIX-1534)")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2014-12-31', dtstart = '2014-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '00069100101', year = '2014', svcdate = '2014-09-18')
  expect_drug_exposure(person_id = patient$person_id, drug_source_concept_id = '45332969')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Event date is outside of observation_period, drug_exposure record created. Id is PERSON_ID")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2014-12-31', dtstart = '2014-01-01')
  add_drug_claims(enrolid = patient$enrolid, ndcnum = '00069100101', year = '2019', svcdate = '2019-09-18')
  expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = '2019-09-18')
}


