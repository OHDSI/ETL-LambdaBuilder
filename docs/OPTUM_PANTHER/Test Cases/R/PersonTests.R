createPersonTests <- function () {
  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Unknown gender does not get loaded", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Unknown',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')
  expect_no_person(person_id = patient$person_id)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Male gender", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')
  expect_person(person_id = patient$person_id, year_of_birth = 1950, gender_concept_id = 8507)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Female gender", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Female',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, year_of_birth = 1950, gender_concept_id = 8532)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Unknown birth year", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 'Unknown', gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_no_person(person_id = patient$person_id)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests 1927 and earlier birth year", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = '1927 and earlier', gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1927)

  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests 1930 birth year", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = '1930', gender = 'Male',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1930)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Asian race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Asian', ethnicity = 'Not Hispanic',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8515,
                ethnicity_concept_id = 38003564)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests African American race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'African American', ethnicity = 'Not Hispanic',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8516,
                ethnicity_concept_id = 38003564)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Caucasian race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Caucasian', ethnicity = 'Not Hispanic',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8527,
                ethnicity_concept_id = 38003564)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Unknown race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Other/Unknown', ethnicity = 'Not Hispanic',
              first_month_active = '200701', last_month_active = '201001')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 0,
                ethnicity_concept_id = 38003564)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Hispanic ethnicity, Asian race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Asian',
              first_month_active = '200701', last_month_active = '201001',
              ethnicity = 'Hispanic')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8515,
                ethnicity_concept_id = 38003563)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Hispanic ethnicity, African American race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'African American',
              first_month_active = '200701', last_month_active = '201001',
              ethnicity = 'Hispanic')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8516,
                ethnicity_concept_id = 38003563)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Hispanic ethnicity, Caucasian race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Caucasian',
              first_month_active = '200701', last_month_active = '201001',
              ethnicity = 'Hispanic')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 8527,
                ethnicity_concept_id = 38003563)


  patient <- createPatient();
  enc <- createEncounter();
  declareTest("Tests Hispanic ethnicity, unknown race", id = patient$person_id)
  add_patient(ptid=patient$ptid, birth_yr = 1950, gender = 'Male', race = 'Other/Unknown',
              first_month_active = '200701', last_month_active = '201001',
              ethnicity = 'Hispanic')
  add_encounter(ptid=patient$ptid, encid = enc$encid, interaction_type='Inpatient', interaction_date='2009-01-01')			  
  expect_person(person_id = patient$person_id, gender_concept_id = 8507, year_of_birth = 1950, race_concept_id = 0,
                ethnicity_concept_id = 38003563)
  # TODO: add test of location_id
  # TODO: add test of provider_id
}