createProviderTests <- function () {

  provider <- createProvider()
  declareTest(id = provider$provid,"Simple Provider Mapping")
  add_provider(provid = provider$provid, specialty = "Internal Medicine", prim_spec_ind = "1")
  expect_provider(specialty_concept_id = "38004456", specialty_source_concept_id = "0", specialty_source_value = "Internal Medicine");


  provider <- createProvider()
  declareTest(id = provider$provid,"Dupe Provider Mapping")
  add_provider(provid = provider$provid, specialty = "Family Medicine", prim_spec_ind = "1");
  add_provider(provid = provider$provid, specialty = "Family Medicine", prim_spec_ind = "1");
  expect_count_provider(rowCount = 1, specialty_concept_id = "38004453", specialty_source_concept_id = "0", specialty_source_value = "Family Medicine");


  provider <- createProvider()
  declareTest(id = provider$provid,"Non-Primary specialty Mapping")
  add_provider(provid = provider$provid, specialty = "Primary Medicine", prim_spec_ind = "1")
  add_provider(provid = provider$provid, specialty = "Emergency Medicine", prim_spec_ind = "0")
  expect_count_provider(rowCount = 1, specialty_source_value = "Primary Medicine");
  expect_count_provider(rowCount = 0, specialty_source_value = "Emergency Medicine");


}
