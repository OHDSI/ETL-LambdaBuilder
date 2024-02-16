# Provider ------------------------------------------------------------------

declareTest(501, "Provider ID from institution")
add_medical_facility(medical_facility_id = "F0000003")
expect_provider(provider_id = 10000003, provider_source_value = "F0000003")

declareTest(504, "Provider specialty")
add_medical_facility(medical_facility_id = "F0000005", medium_classification_of_department = "Cardiology")
expect_provider(care_site_id = 10000005, specialty_concept_id = 38004451, specialty_source_value = "Cardiology")