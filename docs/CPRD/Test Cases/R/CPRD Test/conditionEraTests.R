createConditionEraTests <- function()
{
  set_defaults_patient(chsdate = NULL, tod = NULL, deathdate = NULL)
  set_defaults_clinical(consid = NULL, sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL)
  
  patient <- createPatient();
  declareTest(id = patient$person_id, "CONDITION_ERA - Patient has Medical records that collapse in the Condition Era table")

  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-01-01', medcode = 1058, staffid = 1001)
  add_clinical(patid = patient$patid, eventdate = '2012-01-02', medcode = 1058, staffid = 1001)

  expect_condition_era(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_concept_id=75555, condition_era_start_date='2012-01-01',
                       condition_era_end_date='2012-01-02', condition_occurrence_count=2)


}
