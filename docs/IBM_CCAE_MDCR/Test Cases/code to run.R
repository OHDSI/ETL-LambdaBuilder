################################################################################
#### ARGUMENTS                                   ####
################################################################################
frameworkType <- "CCAE"
#frameworkType <- "MDCR"
#frameworkType <- "MDCD"


################################################################################
#### WRITE TEST CASES AND RELOAD PACKAGE                                   ####
################################################################################

source("R/_main.R");
source("R/_UnitTests.R");
source("R/_SetDefaults.R");

if (frameworkType == "CCAE" ){
  source('extras/IBMCCAE_TestingFramework.R')
  source_schema <- "ccae_tests_native"
  cdm_schema <- "ccae_tests_cdm"
}
if (frameworkType == "MDCR" ){
  source('extras/IBMMDCR_TestingFramework.R')
  source_schema <- "mdcr_tests_native"
  cdm_schema <- "mdcr_tests_cdm"
}
if (frameworkType == "MDCD" ){
  source('extras/IBMMDCD_TestingFramework.R')
  source_schema <- "mdcd_tests_native"
  cdm_schema <- "mdcd_tests_cdm"
}

sequencer <- getSequence();
initFramework();
setDefaults();
createTests();

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms     = "redshift",
  server   = Sys.getenv("truven_server"),
  port     = as.numeric(Sys.getenv("truven_port")),
  user     = Sys.getenv("truven_user"),
  password = Sys.getenv("truven_password"),
  pathToDriver = Sys.getenv("path_to_redshift_driver")
)
connection <- DatabaseConnector::connect(connectionDetails)


################################################################################
#### BUILD TEST CASES                                                       ####
################################################################################

insertSql <- paste(generateInsertSql(databaseSchema = source_schema),
                   sep = "", collapse = "\n")
SqlRender::writeSql(insertSql, "inst/sql/insert.sql")
DatabaseConnector::executeSql(connection = connection, sql = insertSql)


if(frameworkType != "MDCD" ){
  #YOU NEED A COPY OF GEOLOC IN YOUR RAW
  DatabaseConnector::executeSql(connection, paste0("TRUNCATE TABLE ",source_schema,".GEOLOC; INSERT INTO ",source_schema,
                          ".GEOLOC (EGEOLOC, EGEOLOC_Description, STATE) VALUES (11, 'New Jersey', 'NJ'); INSERT INTO ",
                          source_schema,
                          ".GEOLOC (EGEOLOC, EGEOLOC_Description, STATE) VALUES (38, 'Virginia', 'VA')"))
  
}

#IF TESTING CCAE  YOU NEED A COPY OF HRA_QUESTON_REF, HRA_VARIABLE_REF IN YOUR RAW
if (frameworkType == "CCAE" ){
  DatabaseConnector::executeSql(connection, paste0("TRUNCATE TABLE ",source_schema,".HRA_VARIABLE_REF;
           INSERT INTO ",source_schema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CC_ASTHMA', 'Self-reported asthma', '4');
           INSERT INTO ",source_schema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CGTDUR', 'Number of years of cigarette use', '8');
           INSERT INTO ",source_schema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CGTPKAMT', 'Number of packs of cigarettes smoked per day', '9');"))
  DatabaseConnector::executeSql(connection, paste0("TRUNCATE TABLE ",source_schema,".HRA_QUESTION_REF;
           INSERT INTO ",source_schema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('4', '1', 'Yes');
           INSERT INTO ",source_schema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('8', '3', '11-20');
           INSERT INTO ",source_schema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('9', '2', '1 pack per day or more');"))
}


################################################################################
#### RUN BUILDER                                                            ####
################################################################################
#               .--.
#              (    )
#                 _/
#  ,   ,         |
#  |\_/|_________|
#  |+ +          o
#  |_^_|-||_____||
#    U   ||     ||
#       (_|    (_|


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

################################################################################
#### SAVE RESULTS                                                           ####
################################################################################

testingResults <- DatabaseConnector::querySql(
  connection = connection,
  sql        = paste0("select * from ", cdm_schema, ".test_results order by id")
)
utils::write.csv(x         = testingResults,
                 file      = "inst/csv/test_results.csv",
                 row.names = FALSE)

