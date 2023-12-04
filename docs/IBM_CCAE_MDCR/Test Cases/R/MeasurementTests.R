#' @export
createMeasurementTests <- function () {

  
  if (tolower(frameworkType) != "mdcd")
  {
  
  patient <- createPatient()
  encounter <- createEncounter()
  ## declareTest(id = patient$person_id, "LOINC code does not have a dash in the second to last character, record is dropped. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-03-07', loinccd = '99999')
  ## expect_no_measurement(person_id = patient$person_id)
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Svcdate is outside of observation period, record is kept. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2013-07-09', loinccd = '56773-5')
  expect_measurement(person_id = patient$person_id)
  
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has abnormal=L; value as concept_id = 4267416. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', abnormal = 'L')
  expect_measurement(person_id = patient$person_id, value_as_concept_id = '4267416')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has abnormal=H; value as concept_id = 4267416. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', abnormal = 'H')
  expect_measurement(person_id = patient$person_id, value_as_concept_id = '4328749')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has abnormal=N; value as concept_id = 4267416. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', abnormal = 'N')
  expect_measurement(person_id = patient$person_id, value_as_concept_id = '4069590')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has abnormal=A; value as concept_id = 4267416. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', abnormal = 'A')
  expect_measurement(person_id = patient$person_id, value_as_concept_id = '4135493')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has abnormal=+; value as concept_id = 4267416. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', abnormal = '+')
  expect_measurement(person_id = patient$person_id, value_as_concept_id = '9191')
  
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has result ne 0 and > neg 99999, result listed in value as number field. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-08-24', loinccd = '56789-1', result = '120')
  expect_measurement(person_id = patient$person_id, value_as_number = '120')
  
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient lowercase units, maps to unit_concept_id 8840 (HIX-1183). Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '56789-1', result = '100', resunit = 'mg/dl')
  expect_measurement(person_id = patient$person_id, value_as_number = '100', unit_concept_id = '8840')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "For UNIT_CONCEPT_ID UCUM lookup should not be used, use JNJ_UNITS istead. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '56789-1', result = '100', resunit = 'lbs.')
  expect_measurement(person_id = patient$person_id, unit_concept_id = '8739')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "For UNIT_CONCEPT_ID UCUM lookup should not be used, use JNJ_UNITS istead. 586323 concept_id is expected. 9471 is a wrong UCUM derived unit. Id is a PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '56789-1', result = '100', resunit = 'C')
  expect_measurement(person_id = patient$person_id, unit_concept_id = '586323')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has null in resunit, measurement record have unit_concept_id = NULL and unit_source_concept_id = NULL. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '56789-1', result = NULL, resunit = NULL)
  expect_measurement(person_id = patient$person_id, unit_concept_id = NULL, unit_source_concept_id = NULL)
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "for LOINCs 3142-7, 29463-7, 3141-9 sometimes padded with 0000, strip padding (HIX-1418). Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '29463-7', result = '1500000', resunit = 'lbs.')
  expect_measurement(person_id = patient$person_id, value_as_number = '150', unit_concept_id = '8739')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has REFHIGH and REFLOW mapping correctly. Check to ensure floats convert correctly. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-12-20', loinccd = '56784-2', refhigh = 10.8, reflow = 1)
  expect_measurement(person_id = patient$person_id, range_high = 10.8, range_low = 1)
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has a LOINC of 3142-7, 29463-7, 3141-9 and RESULT > 100000 and RESUNIT = ''LBS''")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2012', svcdate = '2012-04-06', loinccd = '29463-7', result = '1950000', resunit = 'LBS')
  expect_measurement(person_id = patient$person_id, value_as_number = '195', unit_concept_id = '8739')
  

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Event date is outside of observation_period, measurement record created. Id is PERSON_ID")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_lab(enrolid = patient$enrolid, year='2022', svcdate = '2022-04-06', loinccd = '29463-7', result = '1950000', resunit = 'LBS')
  expect_measurement(person_id = patient$person_id, measurement_date = '2022-04-06')
  }
  
  
  if (tolower(frameworkType) == "ccae")
  {

    patient <- createPatient()
    encounter <- createEncounter()  
    declareTest(id = patient$person_id, "Patient has weight 201, value_as_string = null, value_as_number=201. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_health_risk_assessment(enrolid = patient$enrolid, survdate = '2012-07-16', weight = '201')
    expect_measurement(person_id = patient$person_id, measurement_source_value = 'WEIGHT', value_as_number = '201', measurement_date = '2012-07-16')
      
    patient <- createPatient()
    encounter <- createEncounter()  
    declareTest(id = patient$person_id, "BMI is only question answered bmi is only record created in observation . Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_health_risk_assessment(enrolid = patient$enrolid, survdate = '2012-09-22', bmi = '28.6')
    expect_measurement(person_id = patient$person_id, measurement_source_value = 'BMI', value_as_number = '28.6', measurement_date = '2012-09-22')
  
  }
  
}
