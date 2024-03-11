createObservationTests <- function()
{
  add_medical(medcode = 98196, read_code = '65PT.11')
  add_medical(medcode = 35209, read_code = 'Q116.00')
  add_medical(medcode = 1137, read_code = 'R100.00')
  add_medical(medcode = 70038, read_code = 'Z5A6200')
  add_medical(medcode = 14612, read_code = '657E.00')
  add_medical(medcode = 1942, read_code = 'M240012', description = 'Hair loss')
  add_medical(medcode = 28844, read_code = '66Ya.00')


  # 1) -- clinical procedure with visit
  
  
  
  patient <- createPatient();
  declareTest(id = patient$person_id, ' clinical procedure with visit')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-01-01', medcode = 98196, staffid = 1001)
  add_consultation(patid = patient$patid, eventdate = '2012-01-01', staffid = 9001)
  # --also add hes visit with same date to test 9202
  #add_hes_hospital(patid = patient$patid, spno = 5, admidate = '2012-01-01')
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2012-01-01',
                     observation_type_concept_id=32817,
                     observation_source_value='65PT.11', observation_concept_id=40479404,
                     observation_source_concept_id=45425506)
  expect_count_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), rowCount = 1)

  # 2) -- clinical procedure without visit
  patient <- createPatient();
  declareTest(id = patient$person_id, ' clinical procedure without visit')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-03-01', medcode = 98196, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2012-03-01', observation_type_concept_id=32817,
                     observation_source_value='65PT.11', observation_concept_id=40479404,
                     observation_source_concept_id=45425506)

  # 3)  -- clinical procedure outside observation period
  patient <- createPatient();
  declareTest(id = patient$person_id, ' clinical procedure outside observation period')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2009-03-01', medcode = 1137, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2009-03-01', observation_source_value='R100.00',
                     observation_concept_id=4044812, observation_source_concept_id=45474099)

  # 4) ---- immunisation procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'immunisation procedure')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2011-03-01', medcode = 1137, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-03-01',
                     observation_type_concept_id=32818,
                     observation_source_value='R100.00', observation_concept_id=4044812,#44801932,
                     observation_source_concept_id=45474099)

  # 5) ---- referral procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'referral procedure')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_referral(patid = patient$patid, eventdate = '2011-03-01', medcode = 1137, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-03-01', observation_type_concept_id=32817,
                     observation_source_value='R100.00', observation_concept_id=4044812,#44801932,
                     observation_source_concept_id=45474099)

  # 6) ---- test procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test procedure')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2011-03-01', medcode = 1137, staffid = 1001, consid = 4244, enttype=311, data1=9)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-03-01', observation_type_concept_id=32856,
                     observation_source_value='R100.00', observation_concept_id=0,
                     observation_source_concept_id=45474099)

  # 7) --- observation not mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'observation not mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2011-03-01', medcode = 70038, staffid = 1001, consid = 4245, enttype= 311, data1=9)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-03-01', observation_source_value='Z5A6200',
                     observation_concept_id=0, observation_source_concept_id=0)

  #============================================================

  # 8) --Read clinical medical history condition
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Read clinical medical history condition')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_clinical(patid = patient$patid, eventdate = '2011-01-01', medcode = 1058, staffid = 1001)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
  #                    observation_type_concept_id=32817,
  #                    observation_source_value='F563500', observation_concept_id=43054928,
  #                    observation_source_concept_id=45436713, value_as_concept_id=75555)
  #
  # # 9) --Read referral medical history procedure (75111)
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Read referral medical history procedure')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_referral(patid = patient$patid, eventdate = '2011-01-01', medcode = 69651, staffid = 1001)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
  #                    observation_type_concept_id=32817,
  #                    observation_source_value='744C.00', observation_concept_id=43054928,
  #                    observation_source_concept_id=45425639, value_as_concept_id=4192131)

  # 10) --Read test medical history observation
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Read test medical history procedure')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_test(patid = patient$patid, eventdate = '2011-01-01', medcode = 1137, staffid = 1001, enttype=215, data1=9)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
  #                    observation_type_concept_id=32817,
  #                    observation_source_value='R100.00', observation_concept_id=43054928,
  #                    observation_source_concept_id=45474099, value_as_concept_id=4044812)#44801932)
  #
  #
  # # 11) --Read immunisation medical history drug
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Read immunisation medical history drug')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_immunisation(patid = patient$patid, eventdate = '2011-01-01', medcode = 14612, staffid = 1001)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01', observation_source_value='657E.00',
  #                    observation_concept_id=43054928, observation_source_concept_id=45472275,
  #                    value_as_concept_id=4197151)
  #
  # # 12) --Read clinical non-medical history condition on observation_period_start_date
  # add_medical(medcode = 10584, read_code = '13JW.00')
  # patient <- createPatient();
  # declareTest(id = patient$person_id, 'Read clinical non-medical history condition on observation_period_start_date')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_clinical(patid = patient$patid, eventdate = '2010-01-01', medcode = 10584, staffid = 1001)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
  #                    observation_source_value='13JW.00',
  #                    observation_concept_id=4053230, observation_source_concept_id=45471745)

  # 13) --Read clinical medical history condition non-mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'Read clinical medical history condition non-mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2011-01-01', medcode = 70038, staffid = 1001)
  expect_condition_occurrence(person_id = lookup_person("person_id", person_source_value = patient$person_id), condition_start_date='2011-01-01', condition_source_value='Z5A6200',
                              condition_concept_id=0, condition_source_concept_id=0)


  # 14) --Read referral medical history condition non-mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'Read referral medical history condition non-mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_referral(patid = patient$patid, eventdate = '2011-01-01', medcode = 70038, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-01-01',
                     observation_source_value='Z5A6200',
                              observation_concept_id=0, observation_source_concept_id=0)


  # 15) --Read test medical history condition non-mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'Read test medical history condition non-mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2011-01-01', medcode = 70038, staffid = 1001, enttype = 215, data1=9)
  expect_measurement(person_id = lookup_person("person_id", person_source_value = patient$person_id), measurement_date='2011-01-01', measurement_source_value='Z5A6200',
                              measurement_concept_id=4199172, measurement_source_concept_id=0)

  # 16) --Read immunisatoin medical history condition non-mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'Read immunisatoin medical history condition non-mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2011-01-01', medcode = 70038, staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2011-01-01', observation_source_value='Z5A6200',
                              observation_concept_id=0, observation_source_concept_id=0)


  #=======================================================================




  #================================================================

  # 24) -- test observation record 4 fields
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 4 fields')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 98196, staffid = 1001, enttype = 215,
           data1 = 9, data2 = 28.800,data3 = 114.000 ,data4 = 0.000, data5 = NULL, data6 = NULL,
           data7 =0 ,data8_value = NULL,data8_date = NULL)
  add_entity(code = 215, description = 'Clotting tests', filetype = 'Test', category = 'Haematology',
             data_fields = 4, data1 = 'Qualifier', data1lkup = 'TQU',
             data2 = 'Normal range from', data2lkup = NULL,
             data3 = 'Normal range to', data3lkup = NULL,
             data4 = 'Normal range basis', data4lkup = NULL)
  add_lookup(lookup_id = 1156,lookup_type_id = 85, code = 9, text = 'Normal')
  expect_measurement(person_id = lookup_person("person_id", person_source_value = patient$person_id), measurement_concept_id=4199172,
                     measurement_date='2012-01-01',
                     measurement_type_concept_id=32856,
                     measurement_source_value='65PT.11')

  # 25) -- test observation record 7 fields
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 7 fields')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 28844,
           staffid = 1001, enttype = 412,
           data1 = 3, data2 = 3.700,data3 = 8 ,data4 = 1, data5 =3.400, data6 = 5.100,
           data7 =0 ,data8_value = NULL,data8_date = NULL)
  add_entity(code = 412, description = 'Airway ...', filetype = 'Test', category = 'Oter Pathology Tests',
             data_fields = 7, data1 = 'Operator', data1lkup = 'OPR',
             data2 = 'Value', data2lkup = NULL,
             data3 = 'Unit of measure', data3lkup = 'SUM',
             data4 = 'Qualifier', data4lkup = 'TQU',
             data5 = 'Normal range from', data5lkup = NULL,
             data6 = 'Normal range to', data6lkup = NULL,
             data7 = 'Normal range basis', data7lkup = 'POP', data8 = NULL, data8lkup = NULL
              )
  add_lookup(lookup_id = 856, lookup_type_id = 56, code = 3, text = '=')
  add_lookup(lookup_id = 1155, lookup_type_id = 83, code = 8, text = '%')
  add_lookup(lookup_id = 1407, lookup_type_id = 85, code = 1, text = 'High')

  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_concept_id=0,
                     observation_date='2012-01-01',
                     observation_type_concept_id=32856,
                     value_as_number=3.7, observation_source_value='66Ya.00', qualifier_concept_id=4172703,
                     unit_source_value='%')
  expect_count_observation(rowCount = 1, person_id = lookup_person("person_id", person_source_value = patient$person_id))

  #========================================================================
  # DONE TESTS UP TO HERE


  # 26) -- additional observation
    
  add_product(prodcode=42, gemscriptcode = 72487020, productname = 'Simvastatin 10mg tablets')
  add_medical(medcode = 1942, read_code = 'M240012', 'Hair loss')
  patient <- createPatient();
  declareTest(id = patient$person_id, '1) additional observation ')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_entity(code = 21, description = 'Allergy', filetype = 'Clinical',category = 'Allergy',
             data_fields = 5,data1 = 'Drug Code', data1lkup = 'Product Dictionary',
             data2 = 'Reaction Type', data2lkup = 'RCT',
             data3 = 'Severity', data3lkup = 'SEV',
             data4 = 'Certainty', data4lkup = 'CER',
             data5 = 'Read Code For Reaction', data5lkup = 'Medical Dictionary')
  add_lookup(lookup_id = 706, lookup_type_id = 69, code = 2, text = 'Intolerance')
  add_lookuptype(lookup_type_id = 69, name = 'RCT', description = 'Reaction Type')
  add_additional(patid = patient$patid, enttype = 21, adid = 35, data1_value  = 42.000, data2_value  = 2.000,
                 data3_value  = 3.000 ,data4_value = 3, data5_value = 1942)
  add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 35)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01', observation_source_value='21-Allergy-Allergy-Drug Code',
                     observation_type_concept_id=32817, value_as_string='72487020', value_as_concept_id = 1539463,
                     observation_concept_id=0, observation_source_concept_id=0)

  declareTest(id = patient$person_id, '2) additional observation ')
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_concept_id=0, observation_date='2010-01-01',
                     observation_source_value='21-Allergy-Allergy-Reaction Type', observation_type_concept_id=32817,
                     value_as_string='Intolerance', observation_source_concept_id=0 )

  declareTest(id = patient$person_id, '3) additional observation ')
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
                     observation_source_value='21-Allergy-Allergy-Severity', observation_type_concept_id=32817,
                     value_as_number=3, observation_source_concept_id=0 )

  declareTest(id = patient$person_id, '4) additional observation ')
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
                     observation_source_value='21-Allergy-Allergy-Certainty', observation_type_concept_id=32817,
                     value_as_number=3, observation_source_concept_id=0 )

  declareTest(id = patient$person_id, '4) additional observation ')
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
                     observation_source_value='21-Allergy-Allergy-Read Code For Reaction', observation_type_concept_id=32817,
                     value_as_string='M240012', observation_source_concept_id=0 )


  # 27) --dates
  # patient <- createPatient();
  # declareTest(id = patient$person_id, '1) dates ')
  # add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  # add_entity(code = 461, description = 'Repeat Medication Review', filetype = 'Clinical', category = 'Miscellaneous',
             # data_fields = 4,
             # data1 = 'Due date', data1lkup = 'dd/mm/yyyy',
             # data2 = 'Seen by', data2lkup = NULL,
             # data3 = 'Review date', data3lkup = 'dd/mm/yyyy',
             # data4 = 'Next review date', data4lkup = 'dd/mm/yyyy'
            # )
  # add_additional(patid = patient$patid, enttype = 461, adid = 42, data1_date  = '2007-07-08',
                 # data3_date  = '2007-01-08',
                 # data4_date  = '2007-07-09')
  # add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 42)
  # add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_date='2010-01-01',
                     # observation_source_value='461-Miscellaneous-Repeat Medication Review-Due date',
                     # observation_type_concept_id=32817, value_as_string='2007-07-08',
                     # observation_concept_id=44807096, observation_source_concept_id=0)

  # declareTest(id = patient$person_id, '2) dates')
  # expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_concept_id=44807096, observation_date='2010-01-01',
                     # observation_source_value='461-Miscellaneous-Repeat Medication Review-Seen By', observation_type_concept_id=32817,
                     # value_as_string='2007-01-08', observation_source_concept_id=0 )



  # 28) --scores with 0 mapping
  add_medical(medcode = 100977, read_code = '1JJ..00')
  add_medical(medcode = 10302, read_code = '3888.00')

  patient <- createPatient();
  declareTest(id = patient$person_id, 'scores with 0 mapping')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  #add_entity(code = 372, data_fields = 4,
  #           data1 = 'Result of test', data1lkup = NULL,
  #           data2 = 'Condition', data2lkup = 'Medical Dictionary',
  #           data3 = 'Scoring Methodology', data3lkup = 'Scoring',
  #           data4 = 'Qualifier', data4lkup = 'P_N')
  add_lookuptype(lookup_type_id = 69, name = 'P_N')
  add_lookup(lookup_id = 905, lookup_type_id = 69, code = 0, text = 'Data Not Entered')
  add_scoringmethod(code = 1, scoring_method = 'PHQ-9')

  add_additional(patid = patient$patid, enttype = 372, adid = 45,
                 data1_value  = 15.000, data2_value  = 100977,
                 data3_value  = 1, data4_value = 0)
  add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 45)
  add_consultation(patid =patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_type_concept_id=32817,
                     observation_concept_id=0, value_as_string = '1JJ..00')

  # 29) -- scores mapped (in correct as measurement)
  patient <- createPatient();
  declareTest(id = patient$person_id, 'scores mapped')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01', pracid = patient$pracid)
  add_additional(patid = patient$patid, enttype = 372, adid = 45,
                 data1_value  = 500.000, data2_value  = 10302,
                 data3_value  = 0.000)
  add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 45)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_no_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_type_concept_id=32817,
                     observation_concept_id=40769009, observation_source_value='372-0-10302',
                     value_as_number=500)

  #### Used to be measurements
  # 24) -- scores mapped
  patient <- createPatient();
  declareTest(id = patient$person_id, 'scores mapped, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_entity(code=372, description = 'Scoring test result', filetype = 'Clinical',
             category = 'Diagnostic Tests', data_fields = 4,
             data1 = 'Result of test', data1lkup = NULL,
             data2 = 'Condition', data2lkup = 'Medical Dictionary',
             data3 = 'Scoring Methodology', data3lkup = 'Scoring',
             data4 = 'Qualifier', data4lkup = 'P_N'
  )
  add_additional(patid = patient$patid, enttype = 372, adid = 45, data1_value = 500.000, data2_value = 7913.000,
                 data3_value = 1373.000)
  add_clinical(patid = patient$patid,  eventdate = '2010-01-01', adid = 45)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_source_value='372-Diagnostic Tests-Scoring test result-Condition',
                     observation_concept_id=0)

  # 25) -- additional observation 114-2
  patient <- createPatient();
  declareTest(id = patient$person_id, 'additional observation 114-2, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_entity(code=114, description = 'Preg out', filetype = 'Clinical', category = 'Maternity',
             data_fields = 2, data1 = 'Discharge Date', data1lkup = 'dd/mm/yyyy',
             data2 = 'Birth Status', data2lkup = 'LIV')
  add_lookup(lookup_id = 556, lookup_type_id = 47, code = 3, text = 'Miscarriage')
  add_lookuptype(lookup_type_id = 47, name = 'LIV', description = 'Birth Type')
  add_additional(patid = patient$patid, enttype = 114, adid = 35, data1_date = '2003-12-07',
                 data2_value = 3.00,
                 data3_value = 1373.000)
  add_clinical(patid = patient$patid,  eventdate = '2010-01-01', adid = 35)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_source_value='114-Maternity-Preg out-Discharge Date',
                     observation_concept_id=0)

  # 26) -- additional observation 60-1 with SUM
  patient <- createPatient();
  declareTest(id = patient$person_id, 'additional observation 60-1 with SUM, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_entity(code=60, description = 'Ante-natal booking', filetype = 'Clinical', category = 'Maternity',
             data_fields = 3, data1 = 'Weeks gestation', data1lkup = NULL,
             data2 = 'Unit of measure', data2lkup = 'SUM',
             data3 = 'Type of booking', data3lkup = 'MBO')
  add_additional(patid = patient$patid, enttype = 60, adid = 35, data1_value = 8.000, data2_value = 147.000,
                 data3_value = 1373.000)
  add_lookup(lookup_id = 1002, lookup_type_id = 81, code = 147, text = 'Week')
  ##add_lookuptype(lookup_type_id = 81, name = 'SUM', description = 'Specimen ...')
  add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 35)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_observation(person_id = lookup_person("person_id", person_source_value = patient$person_id), observation_source_value='60-Maternity-Ante-natal booking-Weeks gestation',
                     observation_concept_id=0, value_as_number=8,
                     unit_source_value='week')

}
