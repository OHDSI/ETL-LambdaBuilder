#' @export
createProcedureOccurrenceTests <- function () {

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has a value in PPROC and PROC1 within inpatient_services. Two records should be created. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2000-12-31', dtstart = '2000-01-01')
  add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, pproc = '99238', proc1 = '99221', svcdate = '2000-01-01', tsvcdat = '2000-01-02', year = '2000')
  # expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2514413', procedure_date = '2000-01-02', procedure_type_concept_id = '32854')
  # expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2514404', procedure_date = '2000-01-02', procedure_type_concept_id = '32854') 
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2514413', procedure_date = '2000-01-01')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2514404', procedure_date = '2000-01-01') 
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has two PPROC values, two are created, one with inpatient claim detail and the other with inpatient claim header as the procedure_type_concept. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, pproc = '65779', svcdate = '2012-06-11', tsvcdat = '2012-06-12', year = '2012')
  add_inpatient_admissions(caseid = encounter$caseid, admdate = '2012-06-11', enrolid = patient$enrolid, pproc = '29914', year = '2012')
  # expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757105', procedure_date = '2012-06-12', procedure_type_concept_id = '32854')
  # expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757126', procedure_date = '2012-06-12', procedure_type_concept_id = '32855')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757105', procedure_date = '2012-06-11')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757126', procedure_date = '2012-06-11')

  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "If event date is outside of observation_period, procedure_occurrence record created anyway. Id is PERSON_ID")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, pproc = '65779', svcdate = '2022-06-11', tsvcdat = '2022-06-12', year = '2022')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_date = '2022-06-11')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Procedure occurrence quantity - if not populated in source, leave it NULL. Id is PERSON_ID")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_inpatient_services(caseid = encounter$caseid, enrolid = patient$enrolid, pproc = '65779', svcdate = '2022-05-15', tsvcdat = '2022-05-17', qty = NULL, year = '2022')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_date = '2022-05-15', quantity = NULL)
  
  if (tolower(frameworkType) != "mdcd") {
    patient <- createPatient()
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient has two different providers for the same procedure, two records should be created. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_inpatient_admissions(enrolid = patient$enrolid, admdate = '2012-10-20', caseid = encounter$caseid, year = '2012')
    add_inpatient_services(enrolid = patient$enrolid, caseid = encounter$caseid, svcdate = '2012-10-20', tsvcdat = '2012-10-22', provid = '3456789', proc1 = '50760', stdprov = '220', year = '2012')
    add_inpatient_services(enrolid = patient$enrolid, caseid = encounter$caseid, svcdate = '2012-10-20', tsvcdat = '2012-10-22', provid = '1234567', proc1 = '50760', stdprov = '540', year = '2012')
    # expect_count_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4021253', procedure_date = '2012-10-20', procedure_type_concept_id = '32854', rowCount = 2)
    expect_count_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4021253', procedure_date = '2012-10-20', rowCount = 2)
    
    patient <- createPatient()
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient has HCPCS procedure code with value in PROCMOD. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_outpatient_services(enrolid = patient$enrolid, proc1 = 'C9727', procmod = 'P1',svcdate = '2012-05-12', tsvcdat = '2012-05-12')
    expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4196153', procedure_date = '2012-05-12', modifier_concept_id = '4320556')
    
  } 
  
  if (tolower(frameworkType) == "mdcd") {
    patient <- createPatient()
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient has two different providers for the same procedure, the provider on the first line (ascending) is chosen. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_inpatient_admissions(enrolid = patient$enrolid, caseid = encounter$caseid, year = '2012')
    add_inpatient_services(enrolid = patient$enrolid, caseid = encounter$caseid, svcdate = '2012-10-20', tsvcdat = '2012-10-22', prov_id = '3456789', proc1 = '50760', stdprov = '220', year = '2012')
    add_inpatient_services(enrolid = patient$enrolid, caseid = encounter$caseid, svcdate = '2012-10-20', tsvcdat = '2012-10-22', prov_id = '1234567', proc1 = '50760', stdprov = '540', year = '2012')
    expect_count_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4021253', procedure_date = '2012-10-20', rowCount = 2)
    
    patient <- createPatient()
    encounter <- createEncounter()
    declareTest(id = patient$person_id, "Patient has procedure in proc1 field in long_term_care table. Id is PERSON_ID.")
    add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
    add_long_term_care(enrolid = patient$enrolid, svcdate = '2012-09-15', tsvcdat = '2012-10-30', proc1 = '92568' )
    ## expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2313736', procedure_date = '2012-09-15')
	expect_measurement(person_id = patient$person_id, measurement_concept_id= '4167674', measurement_date = '2012-09-15')
  }
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has two records for the same procedure, two records created. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_outpatient_services(enrolid = patient$enrolid, fachdid = encounter$caseid, proc1 = '54861', svcdate = '2012-02-15', tsvcdat = '2012-02-15', year = '2012')
  add_facility_header(enrolid = patient$enrolid, fachdid = encounter$caseid, proc1 = '54861', svcdate = '2012-02-15', tsvcdat = '2012-02-15', year = '2012')
  expect_count_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4200063', procedure_date = '2012-02-15', procedure_type_concept_id = '32846', rowCount = 2)
  ## expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4200063', procedure_date = '2012-02-15', procedure_type_concept_id = '32846')
  ## expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4200063', procedure_date = '2012-02-15', procedure_type_concept_id = '32846')
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has procedure in proc5 position in facility header, procedure_type_concept_id = 32846 Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_outpatient_services(enrolid = patient$enrolid, fachdid = encounter$caseid, svcdate = '2012-03-03', tsvcdat = '2012-03-03', year = '2012')
  add_facility_header(enrolid = patient$enrolid, fachdid = encounter$caseid, proc5 = '93042', svcdate = '2012-03-03', tsvcdat = '2012-03-03', year = '2012')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_type_concept_id = '32846' )
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2313827', procedure_type_concept_id = '32846' )
  
  patient <- createPatient()
  encounter <- createEncounter()
  declareTest(id = patient$person_id, "Patient has procedures in proc1 - proc6 positions in facility header, procedure_type_concept_id = 32846. Record should be created for each procedure. Id is PERSON_ID.")
  add_enrollment_detail(enrolid=patient$enrolid, dtend = '2012-12-31', dtstart = '2012-01-01')
  add_outpatient_services(enrolid = patient$enrolid, fachdid = encounter$caseid, svcdate = '2012-03-03', tsvcdat = '2012-03-03', year = '2012')
  add_facility_header(enrolid = patient$enrolid, fachdid = encounter$caseid, proc1 = '96900', proc2 = '97811', proc3 = '92570',proc4 = '92568',proc5 = '97780', proc6 = '0093U', svcdate = '2012-03-03', tsvcdat = '2012-03-03', year = '2012')
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '4180942', procedure_type_concept_id = '32846' )
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2314322', procedure_type_concept_id = '32846' )
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '40757149', procedure_type_concept_id = '32846' )
  expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '42739018', procedure_type_concept_id = '32846' )
  ## expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '709845', procedure_type_concept_id = '32846' )
  expect_measurement(person_id = patient$person_id, measurement_concept_id = '4167674', measurement_type_concept_id = '32846' )
  expect_measurement(person_id = patient$person_id, measurement_concept_id= '709845', measurement_type_concept_id = '32846')
  
  
  #Test case to address issue HIX-1255
  ## patient <- createPatient()
  ## encounter <- createEncounter()
  ## declareTest(id = patient$person_id, "Patient has an ICD10PCS value in inpatient_admissions field pdx, pdx is correctly mapped and a procedure_occurrence record created (HIX-1255). Id is PERSON_ID.")
  ## add_enrollment_detail(enrolid=patient$enrolid, dtend = '2016-12-31', dtstart = '2016-01-01')
  ## add_inpatient_admissions(caseid = encounter$caseid, enrolid = patient$enrolid, pdx = 'DB025ZZ', year = '2016', admdate = '2016-05-30', disdate = '2016-06-05')
  ## add_inpatient_services(enrolid = patient$enrolid, caseid = encounter$caseid, svcdate = '2016-06-05', tsvcdat = '2016-06-05', year = '2016', pdx = '')
  ## expect_procedure_occurrence(person_id = patient$person_id, procedure_concept_id = '2789746', procedure_date = '2016-06-05', procedure_type_concept_id = '32855')
  
}
