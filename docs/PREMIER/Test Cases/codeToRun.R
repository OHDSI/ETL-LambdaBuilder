################################################################################
#### WRITE TEST CASES AND RELOAD PACKAGE                                   ####
################################################################################

source("R/_main.R");
source("R/_UnitTests.R");
source("R/_SetDefaults.R");
source("extras/TestFrameworkPremier.R");

source_schema <- "premier_tests_native"
cdm_schema <- "premier_tests_cdm"

sequencer <- getSequence();
initFramework();
setDefaults();
createTests();

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms     = Sys.getenv("R_Premier_dbms"),
  server   = Sys.getenv("R_Premier_server"),
  port     = as.numeric(Sys.getenv("R_Premier_port")),
  user     = Sys.getenv("R_Premier_user"),
  password = Sys.getenv("R_Premier_password"),
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

#  Vendor                    = "Premier v5.2"
#  Number of batches         = 0
#  Batch Size                = 1000
#  Max Degree of Parallelism = 1

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

