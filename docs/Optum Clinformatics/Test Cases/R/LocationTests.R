createLocationTests <- function()
{
  
    patient <- createPatient()
    declareTest("LOCATION - Person location test (DOD)", id = patient$person_id) #PASS V2.0.0.19
    add_member_continuous_enrollment(patid = patient$patid, eligeff = '2000-05-01', eligend = '2000-12-31')
    set_defaults_member_enrollment(family_id  = NULL)
    add_member_enrollment(aso = 'N', bus = 'COM', eligeff = '2000-05-01', eligend = '2000-12-31', region = 'PA',
                      gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1987)
    expect_location(location_source_value = 'PA')
    
    provider <- createProvider()
    declareTest("LOCATION - Provider location test (DOD)", id = provider$provider_id) #PASS V2.0.0.19
    set_defaults_provider(grp_practice  = NULL, hosp_affil = NULL,)
    add_provider(prov_unique = provider$provid, prov_type = '2', prov_region = 'VA')
    expect_location(location_source_value = 'VA')
  
}