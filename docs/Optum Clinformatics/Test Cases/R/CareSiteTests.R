createCareSiteTests <- function()
{
  provider <- createProvider()
  declareTest("CARE_SITE - Creates a CARE_SITE entry from a record found in native provider table where prov_type is NULL.", #PASS V2.0.0.19
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, prov_type = NULL)
  expect_care_site(care_site_id = provider$provider_id, care_site_source_value = provider$provider_id, place_of_service_concept_id = 0)
  
  
  provider <- createProvider()
  declareTest("CARE_SITE - Creates a CARE_SITE entry from a record found in native provider table where prov_type = 2.", #PASS V2.0.0.19
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, prov_type = 2)
  expect_care_site(care_site_id = provider$provider_id, care_site_source_value = provider$provider_id, place_of_service_concept_id = 8717)
  
  provider <- createProvider()
  declareTest("CARE_SITE - Creates a CARE_SITE entry from a record found in native provider table where prov_type = 3.", #PASS V2.0.0.19
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, prov_type = 3)
  expect_care_site(care_site_id = provider$provider_id, care_site_source_value = provider$provider_id, place_of_service_concept_id = 38004693)
  
  provider <- createProvider()
  declareTest("CARE_SITE - Creates a CARE_SITE entry from a record found in native provider table where prov_type = 4.", #PASS V2.0.0.19
              id = provider$provider_id)
  add_provider(prov_unique = provider$provid, prov_type = 4)
  expect_care_site(care_site_id = provider$provider_id, care_site_source_value = provider$provider_id, place_of_service_concept_id = 0)
  
  
  patient <- createPatient()
  provider <- createProvider()
  claim <- createClaim()
  declareTest("CARE_SITE - Creates a CARE_SITE entry from an Rx_claims record", id = provider$provider_id) #PASS V2.0.0.19
  add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2009-12-31', gdr_cd = 'F', yrdob = 1988)
  add_rx_claims(patid = patient$patid, pat_planid = patient$patid, fill_dt = '2001-01-01', clmid = claim$clmid, pharm = provider$provid)
  expect_care_site(care_site_id = provider$provider_id, care_site_source_value = provider$provider_id, place_of_service_concept_id = 38004340)
  
}
