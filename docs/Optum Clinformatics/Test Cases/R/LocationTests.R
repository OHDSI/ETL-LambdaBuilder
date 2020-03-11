createLocationTests <- function()
{
  
    patient <- createPatient()
    declareTest("Person location test (DOD)", id = patient$person_id)
    add_member_enrollment(aso = 'N', bus = 'COM', eligeff = '2000-05-01', eligend = '2000-12-31', state = 'PA',
                      gdr_cd = 'M', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1987)
    expect_location(location_source_value = 'PA')
  
}