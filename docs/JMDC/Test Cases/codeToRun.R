
source('extras/TestFrameworkJMDC.R')
devtools::load_all()

initFramework(); # This will set up the framework to create the inserts
setDefaults(); # This sets the default values for certain variables
createTests(); 

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