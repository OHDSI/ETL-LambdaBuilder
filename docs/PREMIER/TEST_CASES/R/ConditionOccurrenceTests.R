createConditionOccurrenceTests <- function () {

  set_defaults_patbill(serv_date = NULL)
  
  # PATICD_DIAG.ICD_CODE ICD9CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9CM record from PATICD_DIAG to condition_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2005-01-01",
          disc_date    = "2005-01-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "112.89",
                  icd_version = 9);
  expect_condition_occurrence(person_id              = patient$person_id,
                              visit_occurrence_id    = visit$visit_occurrence_id,
                              condition_concept_id   = 433968,
                              condition_start_date   = "2005-01-01",
                              condition_source_value = '112.89');

  # PATICD_DIAG.ICD_CODE ICD10CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10CM record from PATICD_DIAG to condition_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2004-03-01",
          disc_date    = "2004-03-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "M05.421",
                  icd_version = 10);
  expect_condition_occurrence(person_id              = patient$person_id,
                              visit_occurrence_id    = visit$visit_occurrence_id,
                              condition_concept_id   = 4116440,
                              condition_start_date   = "2004-03-01",
                              condition_source_value = "M05.421");
  expect_condition_occurrence(person_id              = patient$person_id,
                              visit_occurrence_id    = visit$visit_occurrence_id,
                              condition_concept_id   = 4107913, #map to multiple concepts?
                              condition_start_date   = "2004-03-01",
                              condition_source_value = "M05.421");

  #PRI_SEC flag to condition_status_concept_id
  pri_sec_vals <- data.frame(
    icd_pri_sec = c('A', 'P', 'S'),
    concept_id = c('32890', '32902', '32908'));

  for (i in 1:nrow(pri_sec_vals))
  {
    pri_sec_val <- pri_sec_vals[i,]
    patient <- createPatient();
    visit <- createVisit();
    declareTest(description=paste0("PATICD_DIAG.ICD_PRI_SEC = ", pri_sec_val$icd_pri_sec, " to CONDITION_STATUS_CONCEPT_ID = ", pri_sec_val$concept_id),
                id = patient$person_id);
    add_pat(medrec_key   = patient$medrec_key,
            pat_key      = visit$pat_key);
    add_paticd_diag(pat_key = visit$pat_key,
                    icd_pri_sec = as.character(pri_sec_val$icd_pri_sec));
    expect_condition_occurrence(person_id                     = patient$person_id,
                                visit_occurrence_id           = visit$visit_occurrence_id,
                                condition_status_concept_id   = pri_sec_val$concept_id,
                                condition_status_source_value = pri_sec_val$icd_pri_sec);
  }

}
