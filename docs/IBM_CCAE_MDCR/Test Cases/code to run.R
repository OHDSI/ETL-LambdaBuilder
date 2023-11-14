#Code to run

library("DatabaseConnector")
library("SqlRender")

## STEP 1: Source the main file and set variable for which Truven database is being tested ("CCAE" for Commercial Claims and Encounters, "MDCR" for Medicare
## and "MDCD" for Medicaid)

truvenType <- "CCAE"
# truvenType <- "MDCR"
# truvenType <- "MDCD"

# Set the variables for the native and cdm schemas these test cases will be inserted into as well as the connectionDetails object

nativeDatabaseSchema <- "ccae_native_test"
cdmDatabaseSchema <- "ccae_cdm_test"

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "dmbs",
                                                                server = "server",
                                                                port = 5432,
                                                                user = "user",
                                                                password = "password"
)

# STEP 2: Run the getSource function to source the proper framework based on the variable set above. 

getSource()

# STEP 4: AFTER writing all of your tests in the different files, rebuild the package and create the insertsql statements

sequencer <- getSequence() # This will create unique patient ids
initFramework(); # This will set up the framework to create the inserts
setDefaults(); # This sets the default values for certain variables
createTests(); # This creates the tests and puts the values in the framework initialized above

# STEP 5: Create the insert & test sql file 

cat(file="insert.sql", paste(generateInsertSql(databaseSchema = nativeDatabaseSchema), collapse="\n"))

cat(file="test.sql", paste(generateTestSql(databaseSchema = cdmDatabaseSchema), collapse="\n"))


# STEP 6: Run DatabaseConnector to put the test cases in your empty native database and add lines in the lookup tables to support the test cases

conn <- DatabaseConnector::connect(connectionDetails)

insertSql <- readSql("insert.sql")
translatedSql <- translate(insertSql, connectionDetails$dbms)
executeSql(conn, translatedSql)

if(truvenType != "MDCD" ){
  #YOU NEED A COPY OF GEOLOC IN YOUR RAW
  executeSql(conn, paste0("TRUNCATE TABLE ",nativeDatabaseSchema,".GEOLOC; INSERT INTO ",nativeDatabaseSchema,
                          ".GEOLOC (EGEOLOC, EGEOLOC_Description, STATE) VALUES (11, 'New Jersey', 'NJ'); INSERT INTO ",
                          nativeDatabaseSchema,
                          ".GEOLOC (EGEOLOC, EGEOLOC_Description, STATE) VALUES (38, 'Virginia', 'VA')"))
}

#IF TESTING CCAE  YOU NEED A COPY OF HRA_QUESTON_REF, HRA_VARIABLE_REF IN YOUR RAW
if (truvenType == "CCAE" ){
  executeSql(conn, paste0("TRUNCATE TABLE ",nativeDatabaseSchema,".HRA_VARIABLE_REF;
           INSERT INTO ",nativeDatabaseSchema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CC_ASTHMA', 'Self-reported asthma', '4');
           INSERT INTO ",nativeDatabaseSchema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CGTDUR', 'Number of years of cigarette use', '8');
           INSERT INTO ",nativeDatabaseSchema,".HRA_VARIABLE_REF (VARIABLE_NAME, VARIABLE_LONGNAME, QUESTION_TYPE_ID) 
           VALUES ('CGTPKAMT', 'Number of packs of cigarettes smoked per day', '9');"))
  executeSql(conn, paste0("TRUNCATE TABLE ",nativeDatabaseSchema,".HRA_QUESTION_REF;
           INSERT INTO ",nativeDatabaseSchema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('4', '1', 'Yes');
           INSERT INTO ",nativeDatabaseSchema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('8', '3', '11-20');
           INSERT INTO ",nativeDatabaseSchema,".HRA_QUESTION_REF (QUESTION_TYPE_ID, CATEGORY_VALUE, CATEGORY_NAME) 
           VALUES ('9', '2', '1 pack per day or more');"))
}

DatabaseConnector::disconnect(conn)


# STEP 7: Take a break, run builder externally
#               .--.
#              (    )
#                 _/
#  ,   ,         |
#  |\_/|_________|
#  |+ +          o
#  |_^_|-||_____||
#    U   ||     ||
#       (_|    (_|


#### DO THIS IN JENKINS

# STEP 8: Use test.sql to determine which cases pass and which fail
# testResults <- data.frame("id"=numeric(0), "description"=character(0), 
#                             "test"=character(0), "source_pid"=numeric(0), 
#                             "cdm_pid"=numeric(0), "status"=character(0)
#                             , stringsAsFactors=FALSE)
# 
# connectionDetails <- createConnectionDetails(dbms = Sys.getenv("dbms"),
#                                              server = Sys.getenv("server"),
#                                              schema = Sys.getenv("cdm_db"),
#                                              user = Sys.getenv("user"),
#                                              password = Sys.getenv("pw")
# )
# 
# conn <- connect(connectionDetails)
# 
# insertSql <- readSql("test.sql")
# renderedSql <- renderSql(sql = insertSql)$sql;#, cdm_schema = paste0(Sys.getenv("cdm_db"),".",Sys.getenv("cdm_schema")))$sql
# executeSql(conn, renderedSql)
# testResults <- rbind(testResults,querySql(conn, 
#                     paste0("select * from ", paste0(Sys.getenv("cdm_db"),".",Sys.getenv("cdm_schema")),
#                     ".test_results")))
# 
# DatabaseConnector::disconnect(conn)


# STEP 5.5: IF RUNNING ON REDSHIFT, THEN PULL THE DATA OUT OF THE INSERT SQL TO BULKLOAD

# InsertsToCsv(scanLocation = "S:/Git/GitHub/ETL-LambdaBuilder/docs/IBM_CCAE_MDCR/Test Cases/extras/IBM_MDCD_ScanReport_19Nov2020_NO_UNDERSCORE.xlsx")
# 
# connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = Sys.getenv("TEST_DBMS"),
#                                              server = Sys.getenv("TEST_DB_SERVER"),
#                                              port = Sys.getenv("TEST_DB_PORT"),
#                                              user = Sys.getenv("TEST_DB_USER"),
#                                              password = Sys.getenv("TEST_DB_PASSWORD"),
#                                              extraSettings = Sys.getenv("TEST_DB_EXTRASETTINGS")
# )
# 
# conn <- DatabaseConnector::connect(connectionDetails)
# 
# enrollment_detail <- read.csv("inst/csv/enrollment_detail.csv")
# test <- enrollment_detail[ , !(names(enrollment_detail) %in% 'year')]
# 
# DatabaseConnector::insertTable(connection = conn,
#                     tableName = "mdcd_native_test.enrollment_detail",
#                     data = test,
#                     dropTableIfExists = TRUE,
#                     createTable = TRUE,
#                     tempTable = FALSE,
#                     useMppBulkLoad = FALSE, 
#                     progressBar = TRUE)
# 