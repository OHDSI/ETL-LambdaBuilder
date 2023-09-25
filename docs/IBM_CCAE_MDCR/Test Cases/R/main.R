## Function to source the correct testing framework

#' @export
getSource <- function() {
  if (truvenType == "CCAE") {
    source('extras/IBMCCAE_TestingFramework.R')
  }
  if (truvenType == "MDCR") {
    source('extras/IBMMDCR_TestingFramework.R')
  }
  else if (truvenType == "MDCD") {
    source('extras/IBMMDCD_TestingFramework.R')
  }
}

## Functions to create unique patient, encounter and provider ids
#' @export
getSequence <- function (startValue = 1) {
  counterInstance <- new.env(parent = emptyenv());
  counterInstance$currentValue <- startValue;
  counterInstance$nextSequence <- function()
  {
    nextValue <- counterInstance$currentValue;
    counterInstance$currentValue = counterInstance$currentValue + 1;
    return(nextValue)
  }
  return (counterInstance);
}

#' @export
createPatient <- function() {
  personId = sequencer$nextSequence();
  return (list(enrolid = personId, person_id = personId));
}

#' @export
createEncounter <- function() {
  encounterId = sequencer$nextSequence();
  return (list(caseid = encounterId, visit_occurrence_id = encounterId));
}

#' @export
createProvider <- function() {
  providerId = sequencer$nextSequence();
  return (list(provid = providerId, provider_id = providerId));
}

## Function to source all tests - shouldn't need this if treated as a true package

  # getTests <- function() {
  # source('R/ConditionOccurrenceTests.R')
  # source('R/ConditionEraTests.R')
  # source('R/CostTests.R')
  # source('R/DeathTests.R')
  # source('R/DeviceExposureTests.R')
  # source('R/DrugExposureTests.R')
  # source('R/DrugEraTests.R')
  # source('R/LocationTests.R')
  # source('R/MeasurementTests.R')
  # source('R/ObservationPeriodTests.R')
  # source('R/ObservationTests.R')
  # source('R/PayerPlanPeriodTests.R')
  # source('R/PersonTests.R')
  # source('R/ProcedureOccurrenceTests.R')
  # source('R/ProviderTests.R')
  # #source('R/VisitOccurrenceTest.R')
  # }
  #
  # source('R/UnitTests.R')


## Function to get insertsql statement
#' @export
  getInsertSql <- function(connectionDetails) {
    return(frameworkContext$insertSql);
  }

  ## Function to get testsql statement
#' @export
  getTestSql <- function(connectionDetails) {
    return(frameworkContext$testSql);
  }

#' @export
InsertsToCsv <- function(scanLocation){

    overview <- readxl::read_xlsx(scanLocation, sheet = "Overview")

    tables <- c()

    for (i in 1:length(frameworkContext$inserts)){
      tables <- c(tables, frameworkContext$inserts[[i]]$table)
    }
    ## get list of tables to create a csv for
    tables <- unique(tables)

    for (i in 1:length(tables)){
      ddl <-subset(overview, Table == tables[i], select = c("Field"))
      ddl <- data.table::transpose(ddl)

      csv <- data.frame(matrix(ncol=ncol(ddl),nrow=1))
      colnames(csv) <- as.character(ddl[1,])

      for (j in 1:length(frameworkContext$inserts)){
        list <- frameworkContext$inserts[[j]]
        table <- list$table
        fields <- list$fields

        if(tables[i]==table){

          values <- list(gsub("'", '', list$values))

          df <- do.call(rbind.data.frame, values)
          colnames(df) <- fields

          csv <- dplyr::bind_rows(csv, df)
        }
      }
      assign(paste(tables[i]), csv)
      write.csv(csv,paste0("inst/csv/",tables[i],".csv"))
    }
  }

#' @export
writeSourceCsv <- function(directory = NULL, separator = ',') {
  clean_value <- function(x) {
    if (x == 'NULL') {
      return('')
    }
    value <- substring(x, 2, nchar(x)-1)
    value <- gsub('"', '""', value)
    if (grepl(separator, value)) {
      return(paste0('"', value, '"'))
    }
    return(value)
  }

  clean_fields <- function(x) {
    if (grepl("^\\[.+?\\]$", x)) {
      return(substring(x, 2, nchar(x)-1))
    }
    return(x)
  }
  dir.create(directory, showWarnings = F)

  seen_tables <- c()
  for (insert in frameworkContext$inserts) {
    filename <- file.path(directory, paste0(insert$table, '.csv'))
    if (!(insert$table %in% seen_tables)) {
      write(paste(sapply(insert$fields, clean_fields), collapse = separator), filename, append=F)
      seen_tables <- c(seen_tables, insert$table)
    }
    write(paste(sapply(insert$values, clean_value), collapse = separator), filename, append=T)
  }

  for (table_name in names(frameworkContext$defaultValues)) {
    if (!(table_name %in% seen_tables)) {
      filename <- file.path(directory, paste0(table_name, '.csv'))
      write(paste(names(frameworkContext$defaultValues[[table_name]]), collapse = separator), filename, append=F)
    }
  }
}
