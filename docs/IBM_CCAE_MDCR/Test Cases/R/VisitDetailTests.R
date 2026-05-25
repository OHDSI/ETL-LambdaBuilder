#' @export
createVisitDetailTests <- function () {
  
  
  if (tolower(frameworkType) == "ccae")
  {
    
    patient <- createPatient()
    declareTest(id = patient$person_id, "Test  visitDetail from outpatient_services")
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient with visit detail that starts before the observation period, start date trimmed to beginning of observation period. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_outpatient_services(enrolid=patient$enrolid, caseid = encounter$caseid, svcdate='2011-12-05', tsvcdat='2012-01-06')
    expect_visit_detail(person_id=patient$person_id, 
                        visit_detail_start_date = '2012-01-01', 
                        VISIT_DETAIL_TYPE_CONCEPT_ID = 32860, 
                        ADMITTING_SOURCE_CONCEPT_ID = 0,
                        DISCHARGE_TO_CONCEPT_ID = 0)
    
    patient <- createPatient()
    declareTest(id = patient$person_id, "Test  visitDetail from inpatient_services")
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient with visit detail that starts before the observation period, start date trimmed to beginning of observation period. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_inpatient_services(enrolid=patient$enrolid, caseid = encounter$caseid, svcdate='2011-12-05', tsvcdat='2012-01-06')
    expect_visit_detail(person_id=patient$person_id, 
                        visit_detail_start_date = '2012-01-01', 
                        VISIT_DETAIL_TYPE_CONCEPT_ID = 32854, 
                        ADMITTING_SOURCE_CONCEPT_ID = 0)
    
    patient <- createPatient()
    declareTest(id = patient$person_id, "Test  visitDetail from facility_header")
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient with visit detail that starts before the observation period, start date trimmed to beginning of observation period. Id is PERSON_ID.")
    add_facility_header(enrolid=patient$enrolid)
    add_inpatient_services(enrolid=patient$enrolid, caseid = encounter$caseid, svcdate='2011-12-05', tsvcdat='2012-01-06')
    expect_visit_detail(person_id=patient$person_id, 
                        visit_detail_start_date = '2012-01-01', 
                        VISIT_DETAIL_TYPE_CONCEPT_ID = 9201, 
                        ADMITTING_SOURCE_CONCEPT_ID = 0)
    
    
  }
  
  if (tolower(frameworkType) != "mdcd")
  {

    
  }
  
  if (tolower(frameworkType) == "mdcd")
  {
    
  }
}
