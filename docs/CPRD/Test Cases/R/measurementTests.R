createMeasurementTests <- function()
{

  add_medical(medcode = 445, read_code = '424Z.00') # complete blood count: 4132152, source: 45508441 / 424Z.00

  # 8) Now testing without hes to give visit_occurrence_id is null - clinical procedure without visit
  patient <- createPatient();
  declareTest(id = patient$person_id, 'testing without hes to give visit_occurrence_id is null - clinical procedure without visit, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2012-01-01', medcode = 445, staffid = 1001)
  expect_measurement(person_id = patient$person_id,
                     measurement_concept_id =  4132152,
                     measurement_source_value =  '424Z.00', measurement_source_concept_id =  45508441,
                     measurement_date =  '2012-01-01',
                     provider_id =   1001
                     )


  # 9) --invalid: Now test gold observation outside patient observation to exclude
  patient <- createPatient();
  declareTest(id = patient$person_id, 'Now test gold observation outside patient observation to exclude')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_clinical(patid = patient$patid, eventdate = '2009-01-01', medcode = 445, staffid = 1001)
  add_consultation(patid = patient$patid, eventdate = '2009-01-01', staffid = 9001)
  expect_measurement(person_id = patient$person_id,
                     measurement_concept_id =  4132152,
                     measurement_source_value =  '424Z.00', measurement_source_concept_id =  45508441,
                     measurement_date =  '2009-01-01',
                     provider_id =   1001
                     )


  # 10) immunisation procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'immunisation procedure, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_immunisation(patid = patient$patid, eventdate = '2011-03-01', medcode = 445, staffid = 1001)
  expect_measurement(person_id = patient$person_id,
                     measurement_concept_id =  4132152,
                     measurement_source_value =  '424Z.00', measurement_source_concept_id =  45508441,
                     measurement_date =  '2011-03-01',
                     provider_id =   1001)


  # 11) referral procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'referral procedure, id is person_Id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid =patient$pracid)
  add_referral(patid = patient$patid, eventdate = '2011-03-01', medcode = 445, staffid = 1001)
  expect_measurement(person_id = patient$person_id, #measurement_concept_id =  40487136,#4064622,
                     measurement_date =  '2011-03-01',
                     measurement_concept_id =  4132152,
                     measurement_source_value =  '424Z.00', measurement_source_concept_id =  45508441,
                     provider_id =   1001)

  # 12) test procedure
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test procedure, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2011-03-01', medcode = 445, staffid = 1001, enttype = 215, data1=9)
  add_entity(code=215, description = 'Clotting Tests', filetype = 'Test', category = 'Haematology',
             data_fields = 4,
             data1 = 'Qualifier', data1lkup = 'TQU',
             data2 = 'Normal range from', data2lkup = NULL,
             data3 = 'Normal range to', data3lkup = NULL,
             data4 = 'Normal range basis', data4lkup = NULL,
             data5 = NULL, data5lkup = NULL,
             data6 =  NULL, data6lkup = NULL,
             data7 = NULL, data7lkup = NULL,
             data8 = NULL, data8lkup = NULL)

  expect_measurement(person_id = patient$person_id,
                     measurement_concept_id =  4199172,
                     measurement_source_value =  '215-Clotting tests',

                     measurement_date =  '2011-03-01',
                     provider_id =   1001)



  #================================================================

  # !!!!!!!  133 missing??


  #================================================================

  # 18)  -- test observation record 4 fields  220 - 3002317
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 4 fields no range values, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 445, staffid = 1001, enttype = 220,
           data1 =25, data2 = NULL, data3 = NULL, data4 = 0.00, data5 = NULL, data6 = NULL, data7 = NULL,
           data8_value = NULL, data8_date = NULL)
  add_entity(code=220, description = 'Full blood count', filetype = 'Test', category = 'Haematology',
             data_fields = 4,
             data1 = 'Qualifier', data1lkup = 'TQU',
             data2 = 'Normal range from', data2lkup = NULL,
             data3 = 'Normal range to', data3lkup = NULL,
             data4 = 'Normal range basis', data4lkup = NULL,
             data5 = NULL, data5lkup = NULL,
             data6 =  NULL, data6lkup = NULL,
             data7 = NULL, data7lkup = NULL,
             data8 = NULL, data8lkup = NULL)
  add_lookup(lookup_id=1172, lookup_type_id=85, code=25, text='Normal')
  add_lookuptype(lookup_type_id=85, name='TQU', description='dfbdfb')
  #add_lookup()
  expect_measurement(person_id = patient$person_id, measurement_concept_id=4132152,
                     measurement_date='2012-01-01',
                     value_source_value='Normal',
                     measurement_source_value='220-Full blood count', value_as_concept_id=45884153)


  # TESTING VALUES RANGE LOW (TEST.data2)
  # 18b)
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 4 fields range low test, id is person_id' )
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 445, staffid = 1001, enttype = 220,
           data1 =25, data2 = 1.2, data3 = NULL, data4 = 0.00, data5 = NULL, data6 = NULL, data7 = NULL,
           data8_value = NULL, data8_date = NULL)
  expect_measurement(person_id = patient$person_id, measurement_concept_id=4132152,
                     measurement_date='2012-01-01', range_low = 1.2,
                     measurement_type_concept_id=44818702, value_source_value='Normal',
                     value_as_concept_id=45884153)


  # TESTING VALUES RANGE HIGH (TEST.data3)
  # 18b)
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 4 fields range high test, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 445, staffid = 1001, enttype = 220,
           data1 =25, data2 = NULL, data3 = 4.3, data4 = 0.00, data5 = NULL, data6 = NULL, data7 = NULL,
           data8_value = NULL, data8_date = NULL)
  expect_measurement(person_id = patient$person_id, measurement_concept_id=4132152,
                     measurement_date='2012-01-01', range_high = 4.3,
                     measurement_type_concept_id=44818702, value_source_value='Normal',
                     value_as_concept_id=45884153)


  # 19) -- test observation record 7 fields -- enntype 173 maps to 3000963 --> SHOULD WORK!
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record 7 fields, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 4, staffid = 1001, enttype = 173,
           data1 = 3, data2 = 14.30, data3 = 56.00, data4 = 0, data5 = 11.50, data6 = 16.50, data7 = 0,
           data8_value = NULL, data8_date = NULL)
  # add all the looks ups and stuff...
  add_medical(medcode=4, read_code = '42VZ.00', description = 'Haemoglobin estimation')
  add_entity(code=173,	description='Haemoglobin',	filetype='Test',	category='Haematology',
             data_fields=7,
             data1='Operator',	data1lkup='OPR',
             data2='Value',	data2lkup=NULL,
             data3='Unit of measure',	data3lkup='SUM',
             data4='Qualifier',	data4lkup='TQU',
             data5='Normal range from',	data5lkup=NULL,
             data6='Normal range to',	data6lkup=NULL,
             data7='Normal range basis',data7lkup='POP',
             data8=NULL,	data8lkup=NULL)

  add_lookup(lookup_id=609, lookup_type_id=56, code=3, text='=')
  add_lookuptype(lookup_type_id=56, name='OPR', description='afdafa')
  add_lookup(lookup_id=911, lookup_type_id=83, code=56, text='g/dL')
  add_lookuptype(lookup_type_id=83, name='SUM', description='gdfhdh')
  add_lookup(lookup_id=1147, lookup_type_id=85, code=0, text='Data Not Entered')
  #add_lookuptype(lookup_type_id=83, name='TQU', description='dfbdfb')

  expect_measurement(person_id = patient$person_id, measurement_concept_id=2212396,
                     measurement_date= '2012-01-01',
                     measurement_type_concept_id=44818702, # Data Not Entered
                     value_as_number=14.30, value_as_concept_id=0, #? value_as_concept_id
                     operator_concept_id=4172703,
                     range_low=11.50, range_high=16.50, unit_source_value='g/dL', unit_concept_id = 8713)


  # 20) -- test observation record enttype=284
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record enttype=284, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 4, staffid = 1001, enttype = 284,
           data1 = 3, data2 = 14.000, data3 = 61.000, data4 = 0, data5 = NULL, data6 = NULL, data7 = 0,
           data8_value = NULL, data8_date = '1998-12-17')
  # check 98196 exists
  add_entity(code=284,	description='Maternity ultra sound scan',	filetype='Test',	category='Maternity',
             data_fields=8,
             data1='Operator',	data1lkup='OPR',
             data2='Estimated size in wks',	data2lkup=NULL,
             data3='Unit of measure',	data3lkup='SUM',
             data4='Qualifier',	data4lkup='TQU',
             data5='Normal range from',	data5lkup=NULL,
             data6='Normal range to',	data6lkup=NULL,
             data7='Normal range basis',	data7lkup='POP',
             data8='Expected delivery date',	data8lkup='dd/mm/yyyy')
  #add_lookup(lookup_id=609, lookup_type_id=55, code=3, text='=')
  ##add_lookuptype(lookup_type_id=55, name='OPR', description='dfdbfdfd')
  add_lookup(lookup_id=916, lookup_type_id=83, code=61, text='IU/L')
  ##add_lookuptype(lookup_type_id=81, name='SUM', description='fdfdf')
  expect_measurement(person_id = patient$person_id, measurement_concept_id=3031455,
                     measurement_date='2012-01-01',
                     measurement_type_concept_id=44818702
                     #17-Dec-1998 00:00:00',
                     )

  #expect_count_measurement(rowCount = 2, person_id = patient$person_id)


  # 21) -- test observation record enttype=311
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record enttype=311, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 4, staffid = 1001, enttype = 311,
           data1 = 3, data2 = 120.00, data3 = 71.00, data4 = 0.00, data5 = NULL, data6 = NULL, data7 = 1,
           data8_value = NULL, data8_date = NULL)
  add_entity(code=311,description = 'PF current',filetype = 'Test',category = 'Asthma', data_fields = 7,
             data1='Operator',	data1lkup='OPR',
             data2='Value',	data2lkup=NULL,
             data3='Unit of measure',	data3lkup='SUM',
             data4='Qualifier',	data4lkup='TQU',
             data5='Normal range from',	data5lkup=NULL,
             data6='Normal range to',	data6lkup=NULL,
             data7='Peak flow device',data7lkup='PFD',
             data8=NULL,	data8lkup=NULL)
  add_lookup(lookup_id=641, lookup_type_id=58, code=1, text='Wright')
  add_lookuptype(lookup_type_id =58, name='PFD', description='Peak flow...')
  add_lookup(lookup_id=926, lookup_type_id=83, code=71, text='L/min')
  ##add_lookuptype(lookup_type_id=81, name='SUM', description='Specimen ...')
  expect_measurement(person_id = patient$person_id, measurement_concept_id=0,
                     measurement_date='2012-01-01',
                     measurement_type_concept_id=44818702)


  #expect_count_measurement(rowCount = 2, person_id = patient$person_id)


  # 22) -- test observation record enttype=154
  patient <- createPatient();
  declareTest(id = patient$person_id, 'test observation record enttype=154, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_test(patid = patient$patid, eventdate = '2012-01-01', medcode = 4, staffid = 1001, enttype = 154,
           data1 = 3, data2 = 1.0, data3 = 0.00, data4 = 0.00, data5 = NULL, data6 = NULL, #data7 = 24,
           data8_value = 24, data8_date = NULL)
  add_entity(code = 154, description = 'Alpha fetoprotein', filetype = 'Test', category = 'Maternity',
             data_fields = 8,
             data1='Operator',	data1lkup='OPR',
             data2='Value',	data2lkup=NULL,
             data3='Unit of measure',	data3lkup='SUM',
             data4='Qualifier',	data4lkup='TQU',
             data5='Normal range from',	data5lkup=NULL,
             data6='Normal range to',	data6lkup=NULL,
             data7='Normal range basis',data7lkup='POP',
             data8='Weeks',	data8lkup=NULL
              )
  add_lookup(lookup_id=855, lookup_type_id = 83, code=0, text='No data Entered')
  ##add_lookuptype(lookup_type_id = 81, name='SUM', description = 'Specimen ...')
  expect_measurement(person_id = patient$person_id, measurement_concept_id=4197249,
                     measurement_date='2012-01-01',
                     measurement_type_concept_id=44818702)

  #expect_count_measurement(rowCount = 2, person_id = patient$person_id)

  #========================================================================
  # TEST SORTED UP TO HERE


  # 23) -- additional observation --> NEED TO ADD ?LOOKUPS
  
  set_defaults_additional(data1_date = NULL, data2_date = NULL, data3_value = NULL, data3_date = NULL, data4_value = NULL, data4_date = NULL, data5_value = NULL, data5_date = NULL, data6_value = NULL, data6_date = NULL, data7_value = NULL, data7_date = NULL, data8_value = NULL, data8_date = NULL, data9_value = NULL, data9_date = NULL, data10_value = NULL, data10_date = NULL, data11_value = NULL, data11_date = NULL, data12_value = NULL, data12_date = NULL)
  
  patient <- createPatient();
  declareTest(id = patient$person_id, '1) additional observation, id is person_id')
  add_patient(patid = patient$patid, gender = 1, yob = 199, mob = 1, accept = 1, crd = '2010-01-01',
              pracid = patient$pracid)
  add_entity(code=1, description = 'Blood pressure', filetype = 'Clinical', category = 'Examination Findings',
             data_fields = 7,
             data1='Diastolic', data1lkup = NULL, data2 = 'Systolic', data2lkup = NULL,
             data3 = 'Korotkoff', data3lkup = NULL, data4 = 'Event Time', data4lkup = NULL,
             data5 = 'Laterality', data5lkup = 'LAT', data6 = 'Posture', data6lkup = 'POS',
             data7 = 'Cuff', data7lkup = 'CUF', data8 = NULL, data8lkup = NULL
             )
  add_additional(patid = patient$patid, enttype = 1, adid = 35,
                 data1_value = 80.000, data2_value = 160.000,
                 data3_value = 5.000, data5_value = 3.000)
  add_clinical(patid = patient$patid, eventdate = '2010-01-01', adid = 35)
  add_consultation(patid = patient$patid, eventdate = '2010-01-01', staffid = 1001)
  expect_measurement(person_id=patient$person_id, measurement_date='2010-01-01', value_as_number=80,
                     measurement_source_value='1-Examination Findings-Blood pressure-Diastolic', measurement_type_concept_id=44818702,
                     measurement_concept_id=4154790)

  declareTest(id = patient$person_id, '2) additional observation')
  expect_measurement(person_id=patient$person_id,measurement_date='2010-01-01', value_as_number=160,
                     measurement_source_value='1-Examination Findings-Blood pressure-Systolic', measurement_type_concept_id=44818702,
                     measurement_concept_id=4152194)

  #observation_table: 3) person_id=1361111;observation_date=2012-01-01; value_as_numbr=5; observation_source_value='1-3'; observation_type _type_concept_id=44818701 4) '1-5' value_source_value='Midline'  )

}
