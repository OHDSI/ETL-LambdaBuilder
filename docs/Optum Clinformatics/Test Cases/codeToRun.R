### OPTUM EXTENDED DOD/SES TEST SCRIPT
## For Optum Clinformatics DataMart v8 / OMOP CDM v5.3.1

# Establish Extended Type and Connection strings
#=============================

detach("package:OptumExtendedSesDodTesting", unload = TRUE)


source('R/TestFramework.R')
devtools::load_all()
## This testing package combines both SES and DOD so there is no need to switch between the two.

library(OptumExtendedSesDodSesUnitTests)


source_schema <- "optum_extended_native_test"
cdm_schema <- "optum_extended_cdm_test"

## Set Environment variables before running
config <- read.csv("inst/csv/config.csv", stringsAsFactors = FALSE)

user <- #$user
password <- #$pw
server <- "localhost/postgres"#config$server
port <- 5432 #config$port
dbms <- "postgresql" #config$dbms
pathToDriver <- "C:/Users/AnuarAssylkhanov/Documents"

## Modify connection details as needed
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms, server = server,
                                                                port = port, user = user, password = password, pathToDriver = pathToDriver)

#BUILD RAW DATA
#=============================

connection <- DatabaseConnector::connect(connectionDetails = connectionDetails)

insertSql <- SqlRender::translate(SqlRender::render(paste(generateInsertSql(source_schema),
                                                          sep = "", collapse = "\n")),
                                  targetDialect = connectionDetails$dbms)
SqlRender::writeSql(insertSql, 'insertSql.sql')


DatabaseConnector::executeSql(connection = connection, sql = insertSql)
DatabaseConnector::disconnect(connection = connection)

#RUN CDM BUILDER (not part of this package)
#=============================


# RUN TESTS
#=============================

connection <- DatabaseConnector::connect(connectionDetails = connectionDetails)

sql <- SqlRender::translate(SqlRender::render(paste(generateTestSql(cdm_schema),
                                                                            sep = "", collapse = "\n")),
                                                    targetDialect = connectionDetails$dbms)
SqlRender::writeSql(sql, 'testSql.sql')

DatabaseConnector::executeSql(connection = connection, sql = sql)
DatabaseConnector::disconnect(connection = connection)

# VIEW TEST RESULTS
#=============================

connection <- DatabaseConnector::connect(connectionDetails = connectionDetails)

DatabaseConnector::querySql(connection, 
                            SqlRender::renderSql("SELECT status, count(*) FROM @cdmDatabaseSchema.test_results group by status", 
                                                 cdmDatabaseSchema = cdmDatabaseSchema)$sql)
DatabaseConnector::querySql(connection, 
                            SqlRender::renderSql("SELECT * FROM @cdmDatabaseSchema.test_results where status = 'FAIL'", 
                                                 cdmDatabaseSchema = cdmDatabaseSchema)$sql)

DatabaseConnector::disconnect(connection = connection)



