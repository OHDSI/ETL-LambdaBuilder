createObservationTests <- function () {

  # PATCPT.CPT_CODE CPT4
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="CPT4 record to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2010-10-01",
          disc_date    = "2010-10-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = '0581F');
  expect_observation(person_id              = patient$person_id,
                     visit_occurrence_id    = visit$visit_occurrence_id,
                     observation_concept_id = 44816517,
                     observation_date       = "2010-10-01");

  # PATCPT.CPT_CODE HCPCS
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="HCPCS record to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2012-11-01",
          disc_date    = "2012-11-01");
  add_patbill(pat_key = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = 'G8997');
  expect_observation(person_id              = patient$person_id,
                     visit_occurrence_id    = visit$visit_occurrence_id,
                     observation_concept_id = 43533318,
                     observation_date       = "2012-11-01")

  # PATBILL.STD_CHG_CODE JNJ_PMR_PROC_CHRG_CD
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="STD_CHG_CODE record to observation table with date logic", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2009-07-01",
          disc_date    = "2009-07-01");
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 300301800060000,
              hosp_chg_id  = -882725);
  add_hospchg(hosp_chg_id   = -882725,
              hosp_chg_desc = "I-STAT (6+ PANEL)");
  add_chgmstr(std_chg_code = 300301800060000,
              std_chg_desc = "*6 CLINICAL CHEMISTRY TESTS");
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 4148655,
                     observation_date         = "2009-07-01",
                     observation_source_value = "*6 CLINICAL CHEMISTRY TESTS / I-STAT (6+ PANEL)");

  # PATBILL.STD_CHG_CODE JNJ_PMR_PROC_CHRG_CD; JNJ_PMR_PROC_CHRG_CD codes aren't in chgmstr?

  # PATICD_PROC.ICD_CODE ICD9CM;
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9CM record from PATICD_PROC to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2008-05-01",
          disc_date    = "2008-05-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = 'E826',
                  icd_version = 9);
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 443423,
                     observation_date         = "2008-05-01",
                     observation_source_value = "E826");

  # PATICD_PROC.ICD_CODE ICD10CM;
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10CM record from PATICD_PROC to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2008-10-01",
          disc_date    = "2008-10-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = 'V80.02',
                  icd_version = 10);
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 4067275,
                     observation_date         = "2008-10-01",
                     observation_source_value = "V80.02");

  # PATICD_DIAG.ICD_CODE ICD9CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9CM record from PATICD_DIAG to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2005-12-01",
          disc_date    = "2005-12-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "E872.9",
                  icd_version = 9);
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 439633,
                     observation_date         = "2005-12-01",
                     observation_source_value = "E872.9");

  # PATICD_DIAG.ICD_CODE ICD10CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10CM record from PATICD_DIAG to observation table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2004-12-01",
          disc_date    = "2004-12-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "T71.131",
                  icd_version = 10);
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 439470,
                     observation_date         = "2004-12-01",
                     observation_source_value = "T71.131");

  patient <- createPatient();
  visit <- createVisit();
  declareTest(description=paste0("std_chg_code patbill record maps to oservation table"), id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2004-12-01",
          disc_date    = "2004-12-01");
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 999999040442008);
  expect_observation(person_id                = patient$person_id,
                     visit_occurrence_id      = visit$visit_occurrence_id,
                     observation_concept_id   = 2108550,
                     observation_date         = "2004-12-01");

}