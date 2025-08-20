################################################################################
#### WRITE TEST CASES AND RELOAD PACKAGE                                   ####
################################################################################

source("R/main.R");
source("R/OptumPantherUnitTests.R");
source("extras/TestFrameworkOptumPantherEhr.R");

sequencer <- getSequence(); 
#getTests();
initFramework();
createTests();


source_schema <- "optum_panther_ehr_tests_native"
cdm_schema <- "optum_panther_ehr_tests_cdm"

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms     = Sys.getenv("dbms"),
  server   = Sys.getenv("server"),
  port     = as.numeric(Sys.getenv("port")),
  user     = Sys.getenv("user"),
  password = Sys.getenv("password"),
  pathToDriver = Sys.getenv("R_path_to_driver_pg")
)
connection <- DatabaseConnector::connect(connectionDetails)
################################################################################
#### BUILD TEST CASES                                                       ####
################################################################################




insertSql <- paste(generateInsertSql(databaseSchema = source_schema),
                   sep = "", collapse = "\n")
SqlRender::writeSql(insertSql, "inst/sql/insert.sql")
DatabaseConnector::executeSql(connection = connection, sql = insertSql)

################################################################################
#### RUN BUILDER                                                            ####
################################################################################



################################################################################
#### TEST CDM                                                               ####
################################################################################

testSql <- paste(generateTestSql(databaseSchema = cdm_schema),
                 sep = "", collapse = "\n")
SqlRender::writeSql(testSql, "inst/sql/test.sql")
DatabaseConnector::executeSql(connection, testSql)

################################################################################
#### VIEW RESULTS                                                           ####
################################################################################

View(DatabaseConnector::querySql(
  connection = connection,
  sql        = paste0("select * from ", cdm_schema, ".test_results order by id")
))

View(DatabaseConnector::querySql(
  connection = connection,
  sql        = paste0("select * from ", cdm_schema, ".test_results
                      where status = 'FAIL' order by id")
))

# SAVE RESULTS
testingResults <- DatabaseConnector::querySql(
  connection = connection,
  sql        = paste0("select * from ", cdm_schema, ".test_results order by id")
)
utils::write.csv(x         = testingResults,
                 file      = "inst/csv/test_results.csv",
                 row.names = FALSE)

