#BUILD RAW DATA
#=============================
library(DatabaseConnector)
library(SqlRender)
library(OptumPantherTests)

source_schema <- "optum_panther_native_test"
cdm_schema <- "optum_panther_cdm_test"

insertSql <- SqlRender::translate(SqlRender::render(paste(OptumPantherTests::getInsertSql(source_schema), sep = "", collapse = "\n")),
                                    targetDialect = "sql server")
SqlRender::writeSql(insertSql, "insert.sql")

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = Sys.getenv("PG_DBMS"),
                                                                server = Sys.getenv("PG_DB_SERVER"),
                                                                port = Sys.getenv("PG_DB_PORT"),
                                                                user = Sys.getenv("PG_DB_USER"),
                                                                password = Sys.getenv("PG_DB_PASSWORD")
)

conn <- DatabaseConnector::connect(connectionDetails)

DatabaseConnector::executeSql(conn, insertSql)

DatabaseConnector::disconnect(conn)

#TEST CDM
#=============================
testSql <- SqlRender::translate(SqlRender::render(paste(OptumPantherTests::getTestSql(cdm_schema), sep = "", collapse = "\n")),
                                targetDialect = "sql server")
SqlRender::writeSql(testSql, "test.sql")


querySql(conn, renderSql("SELECT status, count(*) FROM @cdm_schema.test_results group by status", cdm_schema = cdm_schema)$sql)
querySql(conn, renderSql("SELECT * FROM @cdm_schema.test_results where status = 'FAIL'", cdm_schema = cdm_schema)$sql)

