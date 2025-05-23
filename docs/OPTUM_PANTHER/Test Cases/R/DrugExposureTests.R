# TODO: test duplicate drug exposures on same day -- we don't want it to be collapsed
createDrugExposureTests <- function () {

  ######################################
  # MEDICATION_ADMINISTRATIONS
  ######################################
  patient <- createPatient();
  declareTest("Patient has 1 valid MEDICATION_ADMINISTRATIONS record within the enrollment period.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201412')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2011-01-07')
  expect_drug_exposure(person_id = patient$person_id, drug_source_value = '55111067101', drug_exposure_start_date = '2011-01-07', drug_type_concept_id = 32818)

  patient <- createPatient();
  declareTest("Patient has 2 MEDICATION_ADMINISTRATIONS records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2011-01-07')
  add_medication_administrations(ptid=patient$ptid, ndc="58487000102", order_date='2013-01-07')
  expect_drug_exposure(person_id = patient$person_id, drug_source_value = '55111067101')
  expect_drug_exposure(person_id = patient$person_id, drug_source_value = '58487000102')

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has multiple MEDICATION_ADMINISTRATIONS records, all within enrollment period, but have the same encounter_id, ndc and order_date.", id = patient$person_id)
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2011-01-07', encid=enc$encid)
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2011-01-07', encid=enc$encid)
  expect_count_drug_exposure(rowCount = 1, person_id = patient$person_id, drug_exposure_start_date = '2011-01-07', drug_source_value = '55111067101') # distinct was added to the MEDICATION_ADMINISTRATIONS table
   
  patient <- createPatient();
  enc <- createEncounter();
  enc2 <- createEncounter();
  declareTest("Patient has multiple MEDICATION_ADMINISTRATIONS records, all within enrollment period, that have the same ndc on the same day, but different encounters.", id = patient$person_id)
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_encounter(encid = enc2$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, encid=enc$encid, ndc="55111067101", order_date='2011-01-07')
  add_medication_administrations(ptid=patient$ptid, encid=enc2$encid, ndc="55111067101", order_date='2011-01-07')
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has series of MEDICATION_ADMINISTRATIONS with the same encounter_id, but different order_date", id = patient$person_id)
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, encid=enc$encid, ndc="55111067101", order_date='2011-01-07')
  add_medication_administrations(ptid=patient$ptid, encid=enc$encid, ndc="55111067101", order_date='2011-01-08')
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  ### Commented out due to native schema not allowing null order dates
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has MEDICATION_ADMINISTRATIONS with order_date that is NULL")
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_medication_administrations(ptid=patient$ptid, encid=enc$encid, ndc="55111067101", order_date='')
  # expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  provider <- createProvider();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS with provid that is NULL but the encounter has a valid provider id specified", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2012-01-08')
  add_encounter_provider(encid=enc$encid, provid=provider$provid)
  add_medication_administrations(ptid=patient$ptid, encid=enc$encid, ndc="55111067101", order_date='2012-01-08', provid=NULL)
  # TODO: provider_id & visit_occurrence_id auto generated, need to find way to get correct id
  # expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = '2012-01-08', provider_id = provider$provid, visit_occurrence_id = enc$visit_occurrence_id)
  expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = '2012-01-08')

  patient <- createPatient();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS with an NDC that is properly mapped to the source_concept_id and standard concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2012-01-08')
  expect_drug_exposure(person_id = patient$person_id, drug_source_concept_id = 45071548, drug_source_value="55111067101", drug_concept_id=1322189)

  patient <- createPatient();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS with a valid quantity_of_dose", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2012-01-08', quantity_of_dose=.5)
  expect_drug_exposure(person_id = patient$person_id, quantity=.5)

  patient <- createPatient();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS and the route value is found in the source-to-concept-map and assigned the proper concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2012-01-08', route="Oral")
  expect_drug_exposure(person_id = patient$person_id, route_concept_id=4132161, route_source_value="Oral")

  patient <- createPatient();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS and the route value is NOT found in the source-to-concept-map and assigned concept_id of 0", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2012-01-08', route="Osmosis")
  expect_drug_exposure(person_id = patient$person_id, route_concept_id=0, route_source_value="Osmosis")

  patient <- createPatient();
  declareTest("Patient has MEDICATION_ADMINISTRATIONS with a strength_unit that maps to dose_unit_source_value", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_medication_administrations(ptid=patient$ptid, ndc="55111067101", order_date='2012-01-08', strength_unit="mg/mL")
  expect_drug_exposure(person_id = patient$person_id, dose_unit_source_value = "mg/mL")

  ######################################
  # PRESCRIPTIONS_WRITTEN
  ######################################

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with valid information", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, rxdate='2012-01-08')
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id = 32838)

  patient <- createPatient();
  declareTest("Patient has multiple PRESCRIPTIONS_WRITTEN with the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, rxdate='2012-01-08')
  add_prescriptions_written(ptid=patient$ptid, rxdate='2014-01-08')
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)


  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN and the NDC is properly mapped to the source_concept_id and standard concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08')
  expect_drug_exposure(person_id = patient$person_id, drug_source_concept_id = 45071548, drug_source_value="55111067101", drug_concept_id=1322189)

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with quantity_per_fill that contains non-numeric values", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', quantity_per_fill = "90 Tab")
  expect_drug_exposure(person_id = patient$person_id, quantity = "90")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with quantity_per_fill that contains only numerics", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', quantity_per_fill = "90")
  expect_drug_exposure(person_id = patient$person_id, quantity = "90")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with quantity_per_fill that contains NULL AND quantity_of_dose is NOT NULL", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', quantity_per_fill = NULL, quantity_of_dose="1")
  expect_drug_exposure(person_id = patient$person_id, quantity = "1")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with quantity_per_fill that contains NULL AND quantity_of_dose is NOT NULL with text", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', quantity_per_fill = NULL, quantity_of_dose="1 tablet")
  expect_drug_exposure(person_id = patient$person_id, quantity = "1")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with num_refils that contains only numerics", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', num_refills="0")
  expect_drug_exposure(person_id = patient$person_id, refills = "0")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with quantity_per_fill that contains an empty value", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', quantity_per_fill=NULL)
  expect_drug_exposure(person_id = patient$person_id, refills = "0")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with days_supply that contains only numerics", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', days_supply="1.0")
  expect_drug_exposure(person_id = patient$person_id, days_supply = "1")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with days_supply that contains an empty value", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', days_supply=NULL)
  expect_drug_exposure(person_id = patient$person_id, days_supply = 1)
   
  # TODO: provider_id auto generated, need to find way to get correct id
  # patient <- createPatient();
  # declareTest("Patient has PRESCRIPTIONS_WRITTEN with provid specified", id = patient$person_id)
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', provid="843801")
  # expect_drug_exposure(person_id = patient$person_id, provider_id="843801")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with a route that is specified in the route source-to-concept map.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, rxdate='2012-01-08', ndc="55111067101", route="Oral")
  expect_drug_exposure(person_id = patient$person_id, route_concept_id=4132161, route_source_value="Oral")

  patient <- createPatient();
  declareTest("Patient has PRESCRIPTIONS_WRITTEN with strength + strength_unit + dose_frequency + dosage_form that should be concatenated", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_prescriptions_written(ptid=patient$ptid, ndc="55111067101", rxdate='2012-01-08', strength="20 - 25", strength_unit = "15 MG", dose_frequency = "1 time a day", dosage_form = "Capsule Delayed Release")
  expect_drug_exposure(person_id = patient$person_id, dose_unit_source_value = "20 - 25;15 MG;Capsule Delayed Release;1 time a day")


  ######################################
  # patient_reported_medications
  ######################################
  patient <- createPatient();
  declareTest("Patient has patient_reported_medications with valid information", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08')
  expect_count_drug_exposure(rowCount = 1, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has multiple patient_reported_medications with the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2014-01-08')
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has patient_reported_medications with valid reported_date and drug_type_concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08', ndc="55111067101")
  expect_drug_exposure(person_id = patient$person_id, drug_exposure_start_date = "01-08-2012", drug_type_concept_id = 32865)

  patient <- createPatient();
  declareTest("Patient has patient_reported_medications and the NDC is properly mapped to the source_concept_id and standard concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08', ndc="55111067101")
  expect_drug_exposure(person_id = patient$person_id, drug_source_concept_id = 45071548, drug_source_value="55111067101", drug_concept_id=1322189)

  # TODO: provider_id auto generated, need to find way to get correct id
  # patient <- createPatient();
  # declareTest("Patient has patient_reported_medications with provid mapped", id = patient$person_id)
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08', provid="179865")
  # expect_drug_exposure(person_id = patient$person_id, provid="179865")

  ### Commented out since native schema doesn't allow null reported date
  # patient <- createPatient();
  # declareTest("Patient has patient_reported_medications record with a NULL reported_date.")
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_patient_reported_medications(ptid=patient$ptid, reported_date=NULL, ndc="55111067101")
  # expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has patient_reported_medications with a route that is specified in the route source-to-concept map.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08', ndc="55111067101", route="Oral")
  expect_drug_exposure(person_id = patient$person_id, route_concept_id=4132161, route_source_value="Oral")

  patient <- createPatient();
  declareTest("Patient has patient_reported_medications with a quantity_of_dose that maps to quantity.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_patient_reported_medications(ptid=patient$ptid, reported_date='2012-01-08', ndc="55111067101", quantity_of_dose="6")
  expect_drug_exposure(person_id = patient$person_id, quantity="6")

  ######################################
  # immunizations
  ######################################
  patient <- createPatient();
  declareTest("Patient has immunizations with valid information", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  expect_count_drug_exposure(rowCount = 1, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has multiple immunizations with the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  add_immunizations(ptid = patient$ptid, immunization_date="2013-10-12", ndc="66521011802", pt_reported="N")
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has multiple immunizations records, all within enrollment period, but have the same immunization_date and ndc", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has immunizations with immunization_date that is NULL", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date=NULL, ndc="66521011802", pt_reported="N")
  expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  # patient <- createPatient();
  # declareTest("Patient has immunizations with pt_reported =''Y''", id = patient$person_id)
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="Y")
  # expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has immunizations and the NDC is properly mapped to the source_concept_id and standard concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  expect_drug_exposure(person_id = patient$person_id, drug_source_concept_id = 46364505, drug_source_value="66521011802", drug_concept_id=46275888)

  patient <- createPatient();
  declareTest("Patient has immunizations with pt_reported =''N'' with a valid drug_type_concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc="66521011802", pt_reported="N")
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id="32818")

  ##### COVID Vaccine Tests

  patient <- createPatient();
  encounter1 <- createEncounter();
  encounter2 <- createEncounter();
  declareTest(description = "Patient has covid vaccine with immunization_desc = ''COVID-19 VACCINE, PFIZER'' ", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(ptid = patient$ptid, encid = encounter1$encid, interaction_date = "2010-05-01")
  add_encounter(ptid = patient$ptid, encid = encounter2$encid,  interaction_date = "2012-12-31")
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc=NULL, immunization_desc = "COVID-19 VACCINE, PFIZER")
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id="32818", drug_concept_id = "37003436")

  patient <- createPatient();
  encounter1 <- createEncounter();
  encounter2 <- createEncounter();
  declareTest(description = "Patient has covid vaccine with immunization_desc = ''COVID-19 VACCINE, MODERNA'' ", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(ptid = patient$ptid, encid = encounter1$encid, interaction_date = "2010-05-01")
  add_encounter(ptid = patient$ptid, encid = encounter2$encid,  interaction_date = "2012-12-31")
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc=NULL, immunization_desc = "COVID-19 VACCINE, MODERNA")
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id="32818", drug_concept_id = "37003518")

  patient <- createPatient();
  encounter1 <- createEncounter();
  encounter2 <- createEncounter();
  declareTest(description = "Patient has covid vaccine with immunization_desc = ''SARS-COV-2 (COVID-19) vaccine, UNSPECIFIED'' ", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(ptid = patient$ptid, encid = encounter1$encid, interaction_date = "2010-05-01")
  add_encounter(ptid = patient$ptid, encid = encounter2$encid,  interaction_date = "2012-12-31")
  add_immunizations(ptid = patient$ptid, immunization_date="2011-10-12", ndc=NULL, immunization_desc = "SARS-COV-2 (COVID-19) vaccine, UNSPECIFIED")
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id="32818", drug_concept_id = "724904")


  ######################################
  # PROCEDURE
  ######################################
  patient <- createPatient();
  declareTest("Procedure has PROC_CODE that is a drug with valid information and valid drug_type_concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_procedure(ptid = patient$ptid, proc_code="J9310", proc_code_type="HCPCS", proc_date="2011-02-11")
  expect_drug_exposure(person_id = patient$person_id, drug_type_concept_id = 32833)

  patient <- createPatient();
  declareTest("Patient has multiple PROCEDURE records with the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_procedure(ptid = patient$ptid, proc_date="2011-10-12", proc_code="J9310", proc_code_type="HCPCS")
  add_procedure(ptid = patient$ptid, proc_date="2013-10-12", proc_code="J9310", proc_code_type="HCPCS")
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has multiple PROCEDURE records, all within enrollment period, but have the same PROC_DATE and proc_code.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_procedure(ptid = patient$ptid, proc_date="2011-10-12", proc_code="J9310", proc_code_type="HCPCS")
  add_procedure(ptid = patient$ptid, proc_date="2011-10-12", proc_code="J9310", proc_code_type="HCPCS")
  expect_count_drug_exposure(rowCount = 2, person_id = patient$person_id)

  ### Commented out due to native schema not allowing null proc date
  # patient <- createPatient();
  # declareTest("Patient has PROCEDURE with PROC_DATE that is NULL")
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_procedure(ptid = patient$ptid, proc_date=NULL, proc_code="J9310", proc_code_type="HCPCS")
  # expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  patient <- createPatient();
  declareTest("Patient has PROCEDURE with HCPCS proc_code that maps to a standard concept", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_procedure(ptid = patient$ptid, proc_date="2011-10-12", proc_code="J9310", proc_code_type="HCPCS")
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id="46275081", drug_source_value="J9310", drug_source_concept_id="2718907")

  # TODO: provider_id auto generated, need to find way to get correct id
  # patient <- createPatient();
  # provider <- createProvider();
  # declareTest("Patient has PROCEDURE with provid_perform that maps to provid", id = patient$person_id)
  # add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  # add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  # add_procedure(ptid = patient$ptid, proc_date="2011-10-12", proc_code="J9310", proc_code_type="HCPCS", provid_perform = provider$provid)
  # expect_drug_exposure(person_id = patient$person_id, drug_concept_id="46275076", drug_source_value="J9310", drug_source_concept_id="2718907", provider_id = provider$provider_id)

  ######################################
  # NLP_DRUG_RATIONALE
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("NLP_DRUG_RATIONALE has valid note_date and other valid information with a valid drug_type_concept_id", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_nlp_drug_rationale(ptid = patient$ptid, encid = enc$encid, note_date='2011-01-07', drug_name='COUMADIN', drug_action = 'TAKE', sentiment = NULL, reason_general = 'stop')
  # TODO: visit_occurrence_id auto generated, need to find way to get correct id
  # expect_drug_exposure(person_id = patient$person_id, drug_concept_id="1310149", drug_source_value="COUMADIN", drug_exposure_start_date="2011-01-07", drug_type_concept_id="32831", visit_occurrence_id=enc$visit_occurrence_id, stop_reason = 'stop')
  expect_drug_exposure(person_id = patient$person_id, drug_concept_id="1310149", drug_source_value="COUMADIN", drug_exposure_start_date="2011-01-07", drug_type_concept_id="32831", stop_reason = 'stop')

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has NLP_DRUG_RATIONALE with drug_action = STOP which should prevent it from being imported.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_nlp_drug_rationale(ptid = patient$ptid, encid = enc$encid, note_date='2011-01-07', drug_name='COUMADIN', drug_action = 'STOP', sentiment = NULL, reason_general = 'stop')
  expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has NLP_DRUG_RATIONALE with sentiment = NEED.NOT which should prevent it from being imported.", id = patient$person_id)
  add_patient(ptid = patient$ptid, first_month_active = '201005', last_month_active = '201212')
  add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2011-01-07')
  add_nlp_drug_rationale(ptid = patient$ptid, encid = enc$encid, note_date='2011-01-07', drug_name='COUMADIN', drug_action = NULL, sentiment = 'NEED.NOT', reason_general = 'stop')
  expect_count_drug_exposure(rowCount = 0, person_id = patient$person_id)
}
