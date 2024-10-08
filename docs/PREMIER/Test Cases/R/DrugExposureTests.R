createDrugExposureTests <- function ()
{

  # PATCPT.CPT_CODE HCPCS
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="HCPCS record to drug_exposure table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2010-04-01",
          disc_date    = "2010-04-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "J9310");
  expect_drug_exposure(person_id                = patient$person_id,
                       visit_occurrence_id      = visit$visit_occurrence_id,
                       drug_concept_id          = 46275081,
                       drug_exposure_start_date = "2010-04-01",
                       drug_source_value        = "J9310");

  # PATCPT.CPT_CODE CPT4
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="CPT4 record to drug_exposure table", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2010-06-01",
          disc_date    = "2010-06-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "90687");
  expect_drug_exposure(person_id                = patient$person_id,
                       visit_occurrence_id      = visit$visit_occurrence_id,
                       drug_concept_id          = 40213145,
                       drug_exposure_start_date = "2010-06-01",
                       drug_source_value        = "90687");

  # PATBILL.STD_CHG_CODE
  patient <- createPatient();
  visit1 <- createVisit();
  visit2 <- createVisit();
  declareTest(description="STD_CHG_CODE record to drug_exposure table with date logic", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit1$pat_key,
          adm_date     = "2011-08-01",
          disc_date    = "2011-08-01");
  add_patbill(pat_key  = visit1$pat_key);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit2$pat_key,
          adm_date     = "2011-08-01",
          disc_date    = "2011-08-01");
  add_patbill(pat_key      = visit2$pat_key,
              std_chg_code = 250250015090000);
  add_patbill(pat_key      = visit2$pat_key);
  expect_drug_exposure(person_id                = patient$person_id,
                       visit_occurrence_id      = visit2$visit_occurrence_id,
                       drug_concept_id          = 1100333,
                       drug_exposure_start_date = "2011-08-01")

  # drug_exposure_end_date required
  patient <- createPatient();
  visit <- createVisit();
  declareTest(description="drug_exposure_end_date required, set as drug_exposure_start_date", id = patient$person_id);
  add_pat(medrec_key   = patient$medrec_key,
          pat_key      = visit$pat_key,
          adm_date     = "2010-04-01",
          disc_date    = "2010-04-01");
  add_patbill(pat_key  = visit$pat_key);
  add_patcpt(pat_key  = visit$pat_key,
             cpt_code = "J9310");
  expect_drug_exposure(person_id                = patient$person_id,
                       visit_occurrence_id      = visit$visit_occurrence_id,
                       drug_concept_id          = 46275081,
                       drug_exposure_start_date = "2010-04-01",
                       drug_exposure_end_date   = "2010-04-01",
                       drug_source_value        = "J9310");

}
