
source('extras/TestFrameworkCprd.R')
devtools::load_all()

initFramework(); # This will set up the framework to create the inserts
setDefaults(); # This sets the default values for certain variables
createTests(); 

# Generate SQL -------------------------------------------------------------------

insertSql <- generateInsertSql(databaseSchema = "native_test")
testSql <- generateTestSql(databaseSchema = "cdm_test")
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
