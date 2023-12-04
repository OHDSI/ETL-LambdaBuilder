# Establish Extended Type and Connection strings
#=============================
#detach("package:CPRDTesting", unload=TRUE)

library(CPRDtesting)

source('R/TestFrameworkCprd.R')
devtools::load_all()



#getwd()
#setwd("C:/Users/AnuarAssylkhanov/Documents/projects/ETL-LambdaBuilder/docs/CPRD/Test Cases")

source_schema <- "cprd_native_test"
cdm_schema <- "cprd_cdm_test"

#create a config file with connection information to the testing database and schemas
config <- read.csv("inst/csv/config.csv", stringsAsFactors = FALSE)

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = config$dbms,
                                                                server = config$server,
                                                                user = config$user,
                                                                password = config$pw,
                                                                port = config$port,
                                                                pathToDriver = config$pathToDriver)
#BUILD RAW DATA
#=============================
## Modify connection details as needed
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms, server = server,
                                                                port = port, user = user, password = password, pathToDriver = pathToDriver)
connection <- DatabaseConnector::connect(connectionDetails)

insertSql <- SqlRender::translate(SqlRender::render(paste(generateInsertSql(source_schema),
                                                                        sep = "", collapse = "\n")),
                                  targetDialect = connectionDetails$dbms)
SqlRender::writeSql(insertSql, 'insertSql.sql')
DatabaseConnector::executeSql(connection, insertSql)


#RUN BUILDER
#=============================


#TEST CDM
#=============================

#BUILD RAW DATA
#=============================
connection <- DatabaseConnector::connect(connectionDetails)
testSql <- SqlRender::translate(SqlRender::render(paste(generateTestSql(databaseSchema = cdm_schema), sep = "", collapse = "\n")),
                        targetDialect = connectionDetails$dbms)
SqlRender::writeSql(testSql, 'testSql.sql')
DatabaseConnector::executeSql(connection, testSql)

DatabaseConnector::querySql(connection, SqlRender::renderSql("SELECT status, count(*) FROM @cdm_schema.test_results group by status", cdm_schema = cdm_schema)$sql)

fails <- DatabaseConnector::querySql(connection, SqlRender::renderSql("SELECT * FROM @cdm_schema.test_results", cdm_schema = cdm_schema)$sql)

