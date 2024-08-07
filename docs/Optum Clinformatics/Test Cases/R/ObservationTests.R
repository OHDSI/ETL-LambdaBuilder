createObservationTests <- function()
{
  # if (tolower(Sys.getenv("extendedType")) == "ses") # NOT INCLUDED IN v2.0.0.19 builder
  # {
  #   education <- list(
  #     list(source = "A", value = "Less than 12th Grade"),
  #     list(source = "B", value = "High School Diploma"),
  #     list(source = "C", value = "Less than Bachelor Degree"),
  #     list(source = "D", value = "Bachelor Degree Plus"),
  #     list(source = "U", value = "Unknown")
  #   )
  #   
  #   for (e in education)
  #   {
  #     patient <- createPatient()
  #     claim <- createClaim()
  #     declareTest(paste("Patient has education level code", e$source, sep = " "), 
  #                 id = patient$person_id)
  #     add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2010-05-01', eligend = '2013-10-31',
  #                       gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  #     add_ses(patid = patient$patid, d_education_level_code = e$source)
  #     expect_observation(person_id = patient$person_id, observation_concept_id = 42528763, value_as_string = e$value,
  #                        observation_type_concept_id = 44814721)
  #   }
  #   
  #   household <- list(
  #     list(source = 0, value = "Unknown"),
  #     list(source = 1, value = "<$40K"),
  #     list(source = 2, value = "$40K-$49K"),
  #     list(source = 3, value = "$50K-$59K"),
  #     list(source = 4, value = "$60K-$74K"),
  #     list(source = 5, value = "$75K-$99K"),
  #     list(source = 6, value = "$100K+")
  #   )
  #   
  #   for (h in household)
  #   {
  #     patient <- createPatient()
  #     claim <- createClaim()
  #     declareTest(paste("Patient has household income range code", h$source, sep = " "), 
  #                 id = patient$person_id)
  #     add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2010-05-01', eligend = '2013-10-31',
  #                       gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  #     add_ses(patid = patient$patid, d_household_income_range_code = h$source)
  #     expect_observation(person_id = patient$person_id, observation_concept_id = 4076114, value_as_string = h$value,
  #                        observation_type_concept_id = 44814721)
  #   }
  #   
  #   ownership <- list(
  #     list(source = 0, value = "Unknown"),
  #     list(source = 1, value = "Probable Homeowner")
  #   )
  #   
  #   for (owner in ownership)
  #   {
  #     patient <- createPatient()
  #     claim <- createClaim()
  #     declareTest(paste("Patient has home ownership code", owner$source, sep = " "), 
  #                 id = patient$person_id)
  #     add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2010-05-01', eligend = '2013-10-31',
  #                       gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  #     add_ses(patid = patient$patid, d_home_ownership_code = owner$source)
  #     expect_observation(person_id = patient$person_id, observation_concept_id = 4076206, value_as_number = owner$source,
  #                        value_as_string = owner$value, observation_type_concept_id = 44814721)
  #   }
  #   
  #   occupation <- list(
  #     list(source = "U", value = "Missing/Unknown"),
  #     list(source = 1, value = "Manager/Owner/Professional"),
  #     list(source = 2, value = "White Collar/Health/Civil Service/Military"),
  #     list(source = 3, value = "Blue Collar"),
  #     list(source = 4, value = "Homemaker/Retired")
  #   )
  #   
  #   for (occ in occupation)
  #   {
  #     patient <- createPatient()
  #     claim <- createClaim()
  #     declareTest(paste("Patient has occupation type code", occ$source, sep = " "), 
  #                 id = patient$person_id)
  #     add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2010-05-01', eligend = '2013-10-31',
  #                       gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  #     add_ses(patid = patient$patid, d_occupation_type_code = occ$source)
  #     expect_observation(person_id = patient$person_id, observation_concept_id = 4033543, value_as_string = occ$value,
  #                        observation_type_concept_id = 44814721)
  #   }
  # }
  # 
  patient <- createPatient()
  claim <- createClaim()
  declareTest("OBSERVATION - Patient has series of observations in lab_results that translates to Observation records.", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')
  add_lab_results(pat_planid = patient$patid, patid = patient$patid, loinc_cd = '76345-8', labclmid = claim$clmid, fst_dt = '2013-07-01')
  add_lab_results(pat_planid = patient$patid, patid = patient$patid, loinc_cd = '75415-0', labclmid = claim$clmid, fst_dt = '2013-07-02')
  expect_observation(person_id = patient$person_id, observation_source_value = '76345-8')
  expect_observation(person_id = patient$person_id, observation_source_value = '75415-0')


  patient <- createPatient()
  claim <- createClaim()
  declareTest("OBSERVATION - Patient has diag source codes mapping to domain Observation and visit_place_of_service of IP does not get mapped to Condition", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "E001", clmid = claim$clmid, diag_position = 1, loc_cd = '2', fst_dt = '2013-07-01')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201)
  expect_observation(person_id = patient$person_id, observation_source_value = 'E001')


  patient <- createPatient()
  claim <- createClaim()
  declareTest("OBSERVATION - Patient has diag source codes mapping to domain Observation and visit_place_of_service of OP does not get mapped to Condition", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', loc_cd = '2', pos = '11', 
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678')
  add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "E001", clmid = claim$clmid, diag_position = 1, loc_cd = '2', fst_dt = '2013-07-01')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9202)
  expect_observation(person_id = patient$person_id, observation_source_value = 'E001')

  
  # hraMappings <- read.csv(file = "inst/csv/hra_mappings.csv", header = TRUE) # NOT INCLUDED IN v2.0.0.19 builder
  # 
  # apply(X = hraMappings[hraMappings$DOMAIN_ID == "Observation", ], MARGIN = 1, function(mapping)
  # {
  #   patient <- createPatient()
  #   claim <- createClaim()
  #   fieldName <- as.character(tolower(mapping["HRA_FIELD"][[1]]))
  #   declareTest(sprintf("Patient has HRA record: %s", fieldName),
  #               id = patient$person_id)
  #   add_member_detail(aso = 'N', bus = 'COM', cdhp = 3, eligeff = '2010-05-01', eligend = '2013-10-31',
  #                     gdr_cd = 'F', patid = patient$patid, pat_planid = patient$patid, product = 'HMO', yrdob = 1969)
  #   
  #   valueAsString = mapping["VALUE_AS_STRING_VALUE"]
  #   splits <- strsplit(x = valueAsString, split = " = ")
  #   if (length(splits[[1]]) > 1)
  #   {
  #     valueAsString <- splits[[1]][1]
  #   }
  #   
  #   add_hra(patid = patient$patid, value = valueAsString,
  #           name = fieldName, hra_compltd_dt = '2012-12-31')
  # 
  #   if (length(splits[[1]]) > 1)
  #   {
  #     valueAsString <- splits[[1]][2]
  #   }
  #   
  #   expect_observation(person_id = patient$person_id, 
  #                        observation_concept_id = mapping["CONCEPT_ID"],
  #                        value_as_string = valueAsString)
  # })
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("OBSERVATION - Patient has proc codes in medical_claims mapping to domain Observation", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-01', rvnu_cd = '0100', pos = '21', loc_cd = '2',
                     pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-01', prov = '111111', provcat = '5678', proc_cd = 'A0170')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201)
  expect_observation(person_id = patient$person_id, observation_source_value = 'A0170')
  
  
  patient <- createPatient()
  claim <- createClaim()
  declareTest("OBSERVATION - Patient has proc codes in inpatient_confinement mapping to domain Observation", 
              id = patient$person_id)
  add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2014-10-31',
                                   gdr_cd = 'F', patid = patient$patid, yrdob = 1980)
  add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2014-10-31')								   
  add_inpatient_confinement(patid = patient$patid, pat_planid = patient$patid, admit_date = '2013-08-11', proc2 = 'A0170',
                            diag1 = '250.00', disch_date = '2013-08-22', icd_flag = '9', conf_id = '456', pos = '21')
  expect_visit_occurrence(person_id = patient$person_id, visit_concept_id = 9201)
  expect_observation(person_id = patient$person_id, observation_source_value = 'A0170')

}
