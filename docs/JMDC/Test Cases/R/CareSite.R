# Care site ------------------------------------------------------------------

declareTest(301, "Care site id")
add_medical_facility(medical_facility_id = "F0000001")
expect_care_site(care_site_id = 10000001, care_site_source_value = "F0000001")