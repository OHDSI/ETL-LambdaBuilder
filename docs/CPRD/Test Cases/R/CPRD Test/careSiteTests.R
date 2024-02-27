createCareSiteTests <- function()
{
  caresite <- createCareSite(claimId=3);
  declareTest(id = caresite$care_site_id, 'CARE_SITE - Practice_id=301, region=13, id is care_site_id')
  add_practice(pracid = caresite$pracid, region = 13, uts='2000-01-01', lcd='2016-12-31')
  expect_care_site(care_site_id = caresite$care_site_id, location_id = 13)

}
