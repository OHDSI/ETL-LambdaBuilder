#' @export
createLocationTests <- function () {

if (tolower(frameworkType) != "mdcd")  {

  patient<-createPatient()
  declareTest(id = patient$person_id, "Location record generated for egeoloc 11. Id is PERSON_ID")
  add_geoloc(egeoloc = '11', egeoloc_description = 'New Jersey', state = 'NJ')
  add_enrollment_detail(enrolid=patient$enrolid, egeoloc = "11")
  expect_location(state="NJ",location_source_value="11")

  patient<-createPatient()
  declareTest(id = patient$person_id, "Only one location record generated for 89. Id is PERSON_ID")
  add_geoloc(egeoloc = '62', egeoloc_description = 'California', state = 'CA')
  add_enrollment_detail(enrolid=patient$enrolid, egeoloc = "89")
  expect_count_location(location_source_value = "89", state = "UN", rowCount = 1)

  patient<-createPatient()
  declareTest(id = patient$person_id, "Only one location record generated for 38. Id is PERSON_ID")
  add_geoloc(egeoloc = '38', egeoloc_description = 'Virginia', state = 'VA')
  add_enrollment_detail(enrolid=patient$enrolid, egeoloc = "38", dtend="2012-07-31", dtstart="2012-07-01")
  add_enrollment_detail(enrolid=patient$enrolid, egeoloc = "38", dtend="2012-06-30", dtstart="2012-06-01")
  expect_count_location(state="VA",location_source_value="38", rowCount = 1)

  }
}
