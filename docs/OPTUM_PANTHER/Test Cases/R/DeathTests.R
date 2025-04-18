createDeathTests <- function () {

  # Parameters to use in the function
  patient <- createPatient();
  enc <- createEncounter();
  death_date_threshold <- 31
  death_date <- "201404"
  stay_dead_date <- as.character(as.Date("2014-04-30") + death_date_threshold - 1)
  reborn_date <- as.character(as.Date("2014-04-30") + 60)
  tables_to_check <- c("diagnosis", "encounter", "immunizations", "insurance", "labs", "medication_administrations",
                       "microbiology", "nlp_biomarkers", "nlp_drug_rationale", "nlp_measurement", "nlp_sds", "nlp_sds_family",
                       "observations", "patient_reported_medications", "prescriptions_written", "procedure", "visit")

  # START - Tests
  declareTest("Patient is indicated dead by date_of_death. Their death date is the last day of the month.", id = patient$person_id)
  add_patient(ptid=patient$ptid, date_of_death="201404", deceased_indicator="1")
  add_encounter(enc=enc$encid, ptid = patient$ptid, interaction_date = "2014-04-30")
  expect_death(person_id = patient$person_id, death_date = "2014-04-30")
  patient <- createPatient()

  # Check each table that contains references to the patient (PTID) to see if they have information
  # EXACTLY 30 days (death_date_threshold) from the patient date of death
  desc <- paste("data occurring exactly", (death_date_threshold - 1), "days after death event. Expected result: dead")
  createDeathDataForTables(tables_to_check, desc, death_date, stay_dead_date, "expect_death")

  # Check each table that contains references to the patient (PTID) to see if they have information
  # > 30 days (death_date_threshold) from the patient date of death
  desc <- paste("data occurring 60 days after death event. Expected result: not dead")
  createDeathDataForTables(tables_to_check, desc, death_date, reborn_date, "expect_no_death")
}

createDeathDataForTables <- function(tables_to_check, death_date_desc, death_date, end_date, expect_function) {
  for(tableName in tables_to_check) {
    patient <- createPatient();
    enc = createEncounter();
    visitId <- sequencer$nextSequence();
    declareTest(paste("Patient has", tableName, "data occurring", death_date_desc), id = patient$person_id)
    add_patient(ptid=patient$ptid, date_of_death=death_date,deceased_indicator="1")
    add_encounter(enc=enc$encid, ptid = patient$ptid, interaction_date = end_date, visitid = visitId)

    if (tableName == "care_area")
      add_care_area(ptid=patient$ptid, encid=enc$encid, carearea_date=end_date)
    if (tableName =="diagnosis")
      add_diagnosis(ptid=patient$ptid, encid=enc$encid, diag_date = end_date, diagnosis_cd = '7061', diagnosis_cd_type = 'ICD9')
    if (tableName =="encounter")
      add_encounter(ptid=patient$ptid, encid=enc$encid, interaction_date=end_date)
    if (tableName =="immunizations")
      add_immunizations(ptid=patient$ptid, immunization_date=end_date)
    if (tableName =="insurance")
      add_insurance(ptid=patient$ptid, encid=enc$encid, insurance_date=end_date)
    if (tableName =="labs")
      add_labs(ptid=patient$ptid, encid=enc$encid, result_date=end_date, order_date=end_date)
    if (tableName =="medication_administrations")
      add_medication_administrations(ptid=patient$ptid, encid=enc$encid, order_date=end_date)
    if (tableName =="microbiology")
      add_microbiology(ptid=patient$ptid, encid=enc$encid, collect_date=end_date, order_date=end_date)
    if (tableName =="nlp_biomarkers")
      add_nlp_biomarkers(ptid=patient$ptid, note_date=end_date)
    if (tableName =="nlp_drug_rationale")
      add_nlp_drug_rationale(ptid=patient$ptid, note_date=end_date)
    if (tableName =="nlp_measurement")
      add_nlp_measurement(ptid=patient$ptid, encid=enc$encid, note_date=end_date)
    if (tableName =="nlp_sds")
      add_nlp_sds(ptid=patient$ptid, encid=enc$encid, note_date=end_date)
    if (tableName =="nlp_sds_family")
      add_nlp_sds_family(ptid=patient$ptid, encid=enc$encid, note_date=end_date)
    if (tableName =="observations")
      add_observations(ptid=patient$ptid, encid=enc$encid, obs_date=end_date)
    if (tableName =="patient_reported_medications")
      add_patient_reported_medications(ptid=patient$ptid, reported_date=end_date)
    if (tableName =="prescriptions_written")
      add_prescriptions_written(ptid=patient$ptid, rxdate=end_date)
    if (tableName =="procedure")
      add_procedure(ptid=patient$ptid, proc_date=end_date)
    if (tableName =="visit")
      add_visit(ptid=patient$ptid, visit_start_date=end_date, visitid = visitId)

    do.call(what = expect_function, args=list(person_id = patient$person_id))
  }
}
