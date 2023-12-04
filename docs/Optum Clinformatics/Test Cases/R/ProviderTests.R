createProviderTests <- function()
{
  provider <- createProvider()
  declareTest("PROVIDER - Creates a provider entry from record in native PROVIDER table.", 
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, provcat = '1001', taxonomy1 = NULL)
  add_provider_bridge(prov_unique = provider$provid, prov = provider$provid, dea = paste0('DEA', provider$provid), npi = paste0('NPI', provider$provid))
  expect_provider(provider_source_value = provider$provid)
  
  provider <- createProvider()
  declareTest("PROVIDER - Creates a provider entry from record in native PROVIDER table, specialty in taxonomy1.", 
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, provcat = NULL, taxonomy1 = '103TC2200X')
  expect_provider(provider_source_value = provider$provid, specialty_concept_id = 38003640, specialty_source_value = '103TC2200X')
  
  provider <- createProvider()
  declareTest("PROVIDER - Creates a provider entry from record in native PROVIDER table, specialty in taxonomy2.", 
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, provcat = NULL, taxonomy1 = NULL, taxonomy2 = '207PE0004X')
  expect_provider(provider_source_value = provider$provid, specialty_concept_id = 38004510, specialty_source_value = '207PE0004X')
  
}
