createProcedureOccurrenceTests <- function () {

  # PATBILL.STD_CHG_CODE
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="STD_CHG_CODE record to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2011-07-01",
          disc_date    = "2011-07-01");
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 360360206110000);
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 46257707,
                              procedure_date       = "2011-07-01");

  # PATICD_PROC.ICD_CODE ICD9CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9CM record from PATICD_PROC to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2014-10-01",
          disc_date    = "2014-10-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = "V55.1",
                  icd_version = 9);
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 4125153,
                              procedure_date       = "2014-10-01");

  # PATICD_PROC.ICD_CODE ICD9Proc
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9Proc record from PATICD_PROC to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2013-04-01",
          disc_date    = "2013-04-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = "26.31",
                  icd_version = 9);
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 4239779,
                              procedure_date       = "2013-04-01");

  # PATICD_PROC.ICD_CODE ICD10CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10CM record from PATICD_PROC to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2004-03-01",
          disc_date    = "2004-03-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = "Z05.1",
                  icd_version = 19);
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 44789514,
                              procedure_date       = "2004-03-01");

  # PATICD_PROC.ICD_CODE ICD10PCS
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10PCS record from PATICD_PROC to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2002-02-01",
          disc_date    = "2002-02-01");
  add_patbill(pat_key  = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = "0SG33KJ",
                  icd_version = 10);
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 2771840,
                              procedure_date       = "2002-02-01");

  # PATICD_PROC.ICD_CODE ICD10PCS Modifier, not mapped
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10PCS Hierarchy from PATICD_PROC, doesnt map to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_paticd_proc(pat_key     = visit$pat_key,
                  icd_code    = "0CN83Z",
                  icd_version = 10);
  expect_no_procedure_occurrence(person_id            = patient$person_id,
                                 visit_occurrence_id  = visit$visit_occurrence_id);

  # PATCPT.CPT_CODE HCPCS
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="HCPCS record to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2001-01-01",
          disc_date    = "2001-01-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "S2325");
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 40489502,
                              procedure_date       = "2001-01-01");

  # PATCPT.CPT_CODE CPT4
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="CPT4 record to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2013-03-01",
          disc_date    = "2013-03-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "01210");
  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_concept_id = 2101632,
                              procedure_date       = "2013-03-01");

  # PATCPT.CPT_CODE CPT4 Modifier, not mapped
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="CPT4 Modifier from PATICD_PROC, doesnt map to procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "1P");
  expect_no_procedure_occurrence(person_id            = patient$person_id,
                                 visit_occurrence_id  = visit$visit_occurrence_id);

  # Measurement concept not in procedure

  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="CPT4 measurement record not in procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "81003");
  expect_no_procedure_occurrence(person_id           = patient$person_id,
                                 visit_occurrence_id = visit$visit_occurrence_id);

  # PATCPT.CPT_CODE HCPCS
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="HCPCS record not in procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "G0432");
  expect_no_procedure_occurrence(person_id           = patient$person_id,
                                 visit_occurrence_id = visit$visit_occurrence_id);

  # PATBILL.STD_CHG_CODE
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="STD_CHG_CODE measurement record not in procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 300305856520000);
  expect_no_procedure_occurrence(person_id           = patient$person_id,
                                 visit_occurrence_id = visit$visit_occurrence_id);

  # PATICD_DIAG.ICD_CODE ICD9CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD9CM measurement record not in procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "V85.42",
                  icd_version = 9);
  expect_no_procedure_occurrence(person_id           = patient$person_id,
                                 visit_occurrence_id = visit$visit_occurrence_id);

  # PATICD_DIAG.ICD_CODE ICD10CM
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="ICD10CM measurement record not in procedure_occurrence table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key);
  add_paticd_diag(pat_key     = visit$pat_key,
                  icd_code    = "Z68.3",
                  icd_version = 10);
  expect_no_procedure_occurrence(person_id           = patient$person_id,
                                 visit_occurrence_id = visit$visit_occurrence_id);

  # PATICD_PROC.ICD_PRI_SEC
  # All records within the procedure_occurrence table should have a procedure_type_concept_id = 32875 (Provider financial system)
  pri_secs <- data.frame(
    cond = c('P', 'S'),
    type = c(32875, 32875));

  for (i in 1:nrow(pri_secs))
  {
    pri_sec <- pri_secs[i,]
    patient <- createPatient();
    visit <- createVisit();
    declareTest(description=paste0("PATICD_PROC.ICD_PRI_SEC = ", pri_sec$cond, " to procedure_type_concept_id = ", pri_sec$type), id = patient$person_id);
    add_pat(medrec_key   = patient$medrec_key,
            pat_key      = visit$pat_key);
    add_paticd_proc(pat_key     = visit$pat_key,
                    icd_code    = "86.28",
                    icd_pri_sec = as.character(pri_sec$cond));
    expect_procedure_occurrence(person_id            = patient$person_id,
                                visit_occurrence_id  = visit$visit_occurrence_id,
                                procedure_type_concept_id = pri_sec$type);
  }

  # quantity info to procedure_occurrence
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="patbill.std_qty to condition_occurrence.quantity where std_chg_code maps to standard concept", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2002-02-01",
          disc_date    = "2002-02-01");
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 360360206110000,
              std_qty      = 3);

  expect_procedure_occurrence(person_id            = patient$person_id,
                              visit_occurrence_id  = visit$visit_occurrence_id,
                              procedure_date       = "2002-02-01",
                              procedure_concept_id = 46257707,
                              quantity             = 3);

  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="patbill.std_qty to condition_occurrence.quantity where std_chg_code maps to 0", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2002-02-01",
          disc_date    = "2002-02-01");
  add_patbill(pat_key      = visit$pat_key,
              std_chg_code = 270270019860000,
              std_qty      = 3);

  expect_observation(person_id              = patient$person_id,
                     visit_occurrence_id    = visit$visit_occurrence_id,
                     observation_concept_id = 0,
                     observation_date       = "2002-02-01");				 
}
