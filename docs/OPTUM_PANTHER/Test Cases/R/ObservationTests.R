createObservationTests <- function () {

  ######################################
  # OBSERVATIONS
  ######################################

  patient <- createPatient();
  declareTest("Patient has 1 valid OBSERVATIONS record within the enrollment period. Validate that the obs_date maps to the observation_date field properly.", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKE')
  expect_observation(person_id = patient$person_id, observation_date = '2009-01-01')



  # Handle case of observation outside of observation_period
  patient <- createPatient();
  declareTest("Patient has 2 OBSERVATIONS records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKE')
  add_observations(ptid=patient$ptid, obs_date = '2015-01-01', obs_type = 'SMOKE')
  expect_count_observation(person_id = patient$person_id, rowCount = 2)


  # Allow duplicates
  patient <- createPatient();
  declareTest("Patient has multiple OBSERVATIONS records, all within enrollment period", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKE')
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKE')
  expect_count_observation(person_id = patient$person_id, rowCount = 2)


  # Handle field mapping
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has OBSERVATIONS record; validate the encid mapping to visit_occurrence_id", id = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  # add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  # add_observations(ptid=patient$ptid, encid=enc$encid, obs_date = '2009-01-01')
  # expect_visit_occurrence(person_id = patient$person_id, visit_occurrence_id = enc$visit_occurrence_id)


  # Validate obs_type from true STCM
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_type mapping found in the STCM to observation_concept_id", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_type = 'SMOKE', obs_date = '2009-01-01')
  expect_observation(person_id = patient$person_id, observation_concept_id = 40766362)


  # Handle unmapped obs types
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_type mapping NOT found in the STCM maps to observation_concept_id = 0", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKEX')
  expect_observation(person_id = patient$person_id, observation_concept_id = 0)


  # Test Observation Type Concept Id
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the observation_type_concept_id is populated correctly", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_type = 'SMOKE')
  expect_observation(person_id = patient$person_id, observation_type_concept_id = 32831)


  # Test observation time
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_time is mapped to observation_time", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_time = '14:30:00', obs_type = 'SMOKE')
  #expect_observation(person_id = patient$person_id, observation_time = '14:30:00')
  expect_observation(person_id = patient$person_id, observation_datetime = '2009-01-01 14:30:00')

  # Obs Result casting to numeric Observation value
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_result is mapped to value_as_number when obs_result can be cast to a numeric", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_result = '100', obs_type = 'SMOKE')
  expect_observation(person_id = patient$person_id, value_as_number = 100, value_as_string = NULL)


  # Obs Result casting to string Observation value
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_result is mapped to value_as_string when obs_result CANNOT be cast to a numeric", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_result = 'One Hundred', obs_type = 'SMOKE')
  expect_observation(person_id = patient$person_id, value_as_number = NULL, value_as_string = 'One Hundred')


  # Test obs unit when standard UCUM unit found
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_unit is mapped to unit_source_value AND a valid unit_concept_id when it matches a concept in the UCUM vocabulary", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_unit = 'kilogram', obs_type = 'SMOKE', obs_result = 100)
  expect_observation(person_id = patient$person_id, unit_concept_id = 9529, unit_source_value = 'kilogram')


  # Test obs unit when non-standard UCUM unit found
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_unit is mapped to unit_source_value AND unit_concept_id = 0 when it matches a concept in the UCUM vocabulary", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_unit = 'kg', obs_type = 'SMOKE', obs_result = 100)
  expect_observation(person_id = patient$person_id, unit_concept_id = 9529, unit_source_value = 'kg')


  # Test obs unit case sensitivity to UCUM
  patient <- createPatient();
  declareTest("Patient has OBSERVATIONS record; validate the obs_unit is mapped to unit_source_value AND unit_concept_id = 0 when it does not match a standard concept in the UCUM vocabulary", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_observations(ptid=patient$ptid, obs_date = '2009-01-01', obs_unit = 'TEST_UNIT', obs_type = 'SMOKE', obs_result = 100)
  expect_observation(person_id = patient$person_id, unit_concept_id = 0, unit_source_value = 'TEST_UNIT')
  
  patient <- createPatient();
  declareTest("Records from diagnosis with diagnosis_status = History of and primary discharge diagnosis then put in the Observation table with observation_concept_id = 1340204", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = 'H44611',
                diagnosis_cd_type = 'ICD10', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '1', diagnosis_status = 'History of')
  expect_observation(person_id = patient$person_id, observation_concept_id = 1340204, value_as_concept_id = 381850)
  
  patient <- createPatient();
  declareTest("Records from diagnosis with diagnosis_status = History of and primary diagnosis diagnosis then put in the Observation table with observation_concept_id = 1340204", id = patient$person_id)
  enc <- createEncounter();
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001', idn_indicator = 0)
  add_diagnosis(ptid=patient$ptid, diagnosis_cd = 'H44611',
                diagnosis_cd_type = 'ICD10', diag_date = '2009-01-01', primary_diagnosis = '1', admitting_diagnosis = '0', discharge_diagnosis = '1', diagnosis_status = 'History of')
  expect_observation(person_id = patient$person_id, observation_concept_id = 1340204, value_as_concept_id = 381850)


  # ######################################
  # # NLP_SDS_FAMILY
  # ######################################
  # patient <- createPatient();
  # declareTest("Patient has 1 valid NLP_SDS_FAMILY record within the enrollment period. Validate that the note_date maps to the observation_date field properly.", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, observation_date = '2009-01-01')
  #
  # # Handle case of observation outside of observation_period
  # patient <- createPatient();
  # declareTest("Patient has 2 NLP_SDS_FAMILY records, the first within the enrollment period, the second outside of enrollment.", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2015-01-01')
  # expect_count_observation(person_id = patient$person_id, rowCount = 1)
  #
  # # Handle field mapping
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has NLP_SDS_FAMILY record; validate the encid mapping to visit_occurrence_id", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  # add_nlp_sds_family(ptid=patient$ptid, encid=enc$encid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, visit_occurrence_id = enc$visit_occurrence_id)
  #
  #
  # # Test provider for encounter
  # patient <- createPatient();
  # enc <- createEncounter();
  # provider <- createProvider();
  # declareTest("Patient has NLP_SDS_FAMILY record; validate the provider for the encid is mapped to provid", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  # add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  # add_encounter_provider(enc=enc$encid, provid=provider$provid)
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01', encid = enc$encid)
  # expect_observation(person_id = patient$person_id, provider_id = provider$provid)
  #
  #
  # # Test Observation Type Concept Id
  # patient <- createPatient();
  # declareTest("Patient has NLP_SDS_FAMILY record; validate the observation_type_concept_id is populated correctly", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01', sds_term = 'cancer')
  # expect_observation(person_id = patient$person_id, observation_type_concept_id = 38000280)
  #
  #
  # # Tests sds_terms going to observation source value
  # patient <- createPatient();
  # declareTest("Patient has NLP_SDS_FAMILY record; validate the sds_term is mapped to observation_source_value", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01', sds_term = 'cancer')
  # expect_observation(person_id = patient$person_id, observation_source_value = 'cancer')
  #
  #
  # # Tests multiple sds values going to value_as_string
  # patient <- createPatient();
  # declareTest("Patient has NLP_SDS_FAMILY record; validate sds_term, sds_location, sds_family_member, sds_sentiment is mapped to value_as_string with semi-colon delimiter", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds_family(ptid=patient$ptid, note_date = '2009-01-01', sds_term = 'cancer',
  #                    sds_location = 'prostate', sds_family_member = 'who=family', sds_sentiment = 'negative')
  # expect_observation(person_id = patient$person_id, value_as_string = 'cancer;prostate;who=family;negative')
  #
  #
  # ######################################
  # # NLP_SDS
  # ######################################
  # patient <- createPatient();
  # declareTest("Patient has 1 valid NLP_SDS record within the enrollment period. Validate that the note_date maps to the observation_date field properly.", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds(ptid=patient$ptid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, observation_date = '2009-01-01')
  #
  #
  # # Handle case of observation outside of observation_period
  # patient <- createPatient();
  # declareTest("Patient has 2 NLP_SDS records, the first within the enrollment period, the second outside of enrollment.", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds(ptid=patient$ptid, note_date = '2009-01-01')
  # add_nlp_sds(ptid=patient$ptid, note_date = '2015-01-01')
  # expect_count_observation(person_id = patient$person_id, rowCount = 1)
  #
  #
  # # Handle field mapping
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has NLP_SDS record; validate the encid mapping to visit_occurrence_id", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  # add_nlp_sds(ptid=patient$ptid, encid=enc$encid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, visit_occurrence_id = enc$visit_occurrence_id)
  #
  #
  # # Test provider id mapping
  # patient <- createPatient();
  # enc <- createEncounter();
  # provider <- createProvider();
  # declareTest("Patient has NLP_SDS record; validate the provider for the encid is mapped to provid", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_encounter(encid = enc$encid, ptid = patient$ptid, interaction_type = 'Inpatient', interaction_date = '2009-01-01')
  # add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  # add_encounter_provider(enc=enc$encid, provid=provider$provid)
  # add_nlp_sds(ptid=patient$ptid, encid=enc$encid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, provider_id = provider$provid)
  #
  #
  # # Test Observation Type Concept Id
  # patient <- createPatient();
  # declareTest("Patient has NLP_SDS record; validate the observation_type_concept_id is populated correctly", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds(ptid=patient$ptid, note_date = '2009-01-01')
  # expect_observation(person_id = patient$person_id, observation_type_concept_id = 38000280)
  #
  #
  # # Tests sds_term mappping to concept id
  # patient <- createPatient();
  # declareTest("Patient has NLP_SDS record; validate the sds_term is mapped to observation_concept_id using STCM", source_pid = patient$ptid, cdm_pid = patient$person_id)
  # add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
  #             first_month_active = '200701', last_month_active = '201001')
  # add_nlp_sds(ptid=patient$ptid, note_date = '2009-01-01', sds_term = '')
  #
  #
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has NLP_SDS record; validate the sds_term is mapped to observation_source_value using STCM", source_pid = patient$ptid, cdm_pid = patient$person_id)
  #
  # patient <- createPatient();
  # enc <- createEncounter();
  # declareTest("Patient has NLP_SDS record; validate sds_term, sds_location, sds_family_member, sds_sentiment is mapped to value_as_string with semi-colon delimiter", source_pid = patient$ptid, cdm_pid = patient$person_id)

  ######################################
  # DIAGNOSIS
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 1 valid DIAGNOSIS record within the enrollment period. Validate that the diag_date and diag_time maps to the observation_date and observation_time fields properly.", id = patient$person_id)

  # Handle case of diagnosis outside of observation_period
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 2 DIAGNOSIS records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)

  # Handle field mapping
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has DIAGNOSIS record; validate that the diagnosis_cd_type = ICD10, diagnosis_cd = R42 maps to a valid observation_concept_id = 433316, observation_source_value =	R42 and observation_source_concept_id = 45568132", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has DIAGNOSIS record; validate that the diagnosis_cd_type = CIEL, diagnosis_cd = 6011 maps to observation_concept_id = 0, observation_source_value = 6011 and observation_source_concept_id = 45922786", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has DIAGNOSIS record; validate the encid mapping to visit_occurrence_id", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has DIAGNOSIS record; validate the provider for the encid is mapped to provid", id = patient$person_id)

  ######################################
  # PROCEDURE
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 1 valid PROCEDURE record within the enrollment period. Validate that the proc_date and proc_time maps to the observation_date and observation_time fields properly.", id = patient$person_id)

  # Handle case of diagnosis outside of observation_period
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 2 PROCEDURE records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)

  # Handle field mapping
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has PROCEDURE record; validate that the proc_cd_type = ICD10, proc_code = R42 maps to a valid observation_concept_id = 433316, observation_source_value = R42 and observation_source_concept_id = 45568132", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has PROCEDURE record; validate that the proc_cd_type = CIEL, diagnosis_cd = 6011 maps to observation_concept_id = 0, observation_source_value = 6011 and observation_source_concept_id = 45922786", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has PROCEDURE record; validate the encid mapping to visit_occurrence_id", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has PROCEDURE record; validate the provider for the encid is mapped to provid", id = patient$person_id)

  ######################################
  # MICROBIOLOGY
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 1 valid MICROBIOLOGY record within the enrollment period. Validate that the collect_date and collect_time maps to the observation_date and observation_time fields properly.", id = patient$person_id)

  # Handle case of diagnosis outside of observation_period
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 2 MICROBIOLOGY records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)

  # Handle field mapping
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has MICROBIOLOGY record; validate the encid mapping to visit_occurrence_id", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has MICROBIOLOGY record; validate the provider for the encid is mapped to provid", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has MICROBIOLOGY record; validate the organism is mapped to value_as_string and observation_source_value", id = patient$person_id)

  ######################################
  # NLP_BIOMARKERS
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 1 valid NLP_BIOMARKERS record within the enrollment period. Validate that the note_date maps to the observation_date properly.", id = patient$person_id)

  # Handle case of diagnosis outside of observation_period
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 2 NLP_BIOMARKERS records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)

  # Handle field mapping
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has NLP_BIOMARKERS record; ensure the biomarker field is valid and the newly mapped row has observation_concept_id = 0 and observation_source_value = 'BIOMARKER' and observation_source_concept_id = 0", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has NLP_BIOMARKERS record; ensure the biomarker, variation_detail and biomarker_status fields are concatenated by a semi-colon in the value_as_string field", id = patient$person_id)

  ######################################
  # INSURANCE
  ######################################
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 1 valid INSURANCE record within the enrollment period. Validate that the insurance_date maps to the observation_date field and insurance_time maps to the observation_time field.", id = patient$person_id)

  # Handle case of insurance outside of observation_period
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has 2 INSURANCE records, the first within the enrollment period, the second outside of enrollment.", id = patient$person_id)

  # Handle field mapping
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has INSURANCE record; ensure the ins_type field is valid and mapped row has value_as_string = ins_type, observation_concept_id = 45877222 (Insurance status/requirement) and and observation_source_concept_id = 0", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has INSURANCE record; validate the encid mapping to visit_occurrence_id", id = patient$person_id)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Patient has INSURANCE record; validate the provider for the encid is mapped to provid", id = patient$person_id)

}
