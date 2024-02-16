
source('extras/TestFrameworkJMDC.R')
devtools::load_all()

set_defaults_enrollment(withdrawal_death_flag = NULL)
set_defaults_medical_facility(home_care_support_clinic = NULL, designated_cancer_care_hospitals = NULL, medical_institution_introducing_dpc = NULL, special_functioning_hospitals = NULL)


set_defaults_enrollment(observation_start = "201001", observation_end = "201712")
set_defaults_diagnosis(standard_disease_code = 123)
add_diagnosis_master(standard_disease_code = 123, icd10_level4_code = 'J309') # allergic rhinitis
set_defaults_procedure(standardized_procedure_id = 123, standardized_procedure_version = '201404')
add_procedure_master(standardized_procedure_id = 123, standardized_procedure_version = '201404', icd9cm_level1 = 9394) # Respiratory medication administered by nebulizer

# Generate SQL -------------------------------------------------------------------

insertSql <- generateInsertSql(databaseSchema = "jmdc_native_test")
testSql <- generateTestSql(databaseSchema = "testing.cdm_testing_jmdc")
write(insertSql, "insert.sql")
write(testSql, "test.sql")


# Execute tests ------------------------------------------------------------------
library(DatabaseConnector)
connectionDetails <- createConnectionDetails(user = Sys.getenv("userRds"),
                                             password = Sys.getenv("pwRds"),
                                             dbms = "sql server",
                                             server = Sys.getenv("serverRdsTesting"))
connection <- connect(connectionDetails)

executeSql(connection, paste(insertSql, collapse = "\n"))

# Run CDM_builder

executeSql(connection, paste(testSql, collapse = "\n"))

querySql(connection, "SELECT * FROM testing.cdm_testing_jmdc.test_results;")

querySql(connection, "SELECT * FROM testing.cdm_testing_jmdc.cost WHERE total_paid = 1230")

querySql(connection, "SELECT * FROM testing.cdm_testing_jmdc.visit_occurrence WHERE visit_occurrence_id =  620001201")

DatabaseConnector::disconnect(connection)