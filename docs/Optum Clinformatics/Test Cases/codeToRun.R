#Code to run

library("DatabaseConnector")
library("SqlRender")


## This testing package combines both SES and DOD so there is no need to switch between the two.
# Set the variables for the native and cdm schemas these test cases will be inserted into as well as the connectionDetails object

nativeDatabaseSchema  <- "optum_extended_native_test"
cdmDatabaseSchema  <- "optum_extended_cdm_test"

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
createTests(); # This creates the tests and puts the values in the framework initialized above

# STEP 5: Create the insert & test sql file 

cat(file="insert.sql", paste(generateInsertSql(databaseSchema = nativeDatabaseSchema), collapse="\n"))

cat(file="test.sql", paste(generateTestSql(databaseSchema = cdmDatabaseSchema), collapse="\n"))


# STEP 6: Run DatabaseConnector to put the test cases in your empty native database and add lines in the lookup tables to support the test cases

conn <- DatabaseConnector::connect(connectionDetails)

insertSql <- readSql("insert.sql")
translatedSql <- translate(insertSql, connectionDetails$dbms)
executeSql(conn, translatedSql)

DatabaseConnector::disconnect(conn)