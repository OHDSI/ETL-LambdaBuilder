getSource <- function() {
  if (tolower(frameworkType) == "ses") {
    source('extras/TestFramework.R')
  } else if (tolower(frameworkType) == "dod") {
    source('extras/TestFrameworkDOD.R')
  }
}

getSequence <- function (startValue = 1) {
  counterInstance <- new.env(parent = emptyenv())
  counterInstance$currentValue <- startValue
  counterInstance$nextSequence <- function()
  {
    nextValue <- counterInstance$currentValue
    counterInstance$currentValue = counterInstance$currentValue + 1
    return(nextValue)
  }
  return (counterInstance)
}
sequencer <- getSequence()
                         
createPatient <- function() {
  personId = sequencer$nextSequence()
  return (list(patid = personId, person_id = personId))
}

createClaim <- function() {
  claimId = sequencer$nextSequence()
  return (list(clmid = paste0("CLM", claimId)))
}

createProvider <- function() {
  providerId = sequencer$nextSequence()
  return (list(provid = providerId, provider_id = providerId))
}


# Use this function to test build errors
# It's challenging to debug errors when a package loads, so disable onLoad
# and export the below when debugging.
#' @export
testInit <- function() {
  initFramework()
  createTests()
}

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
InsertsToCsv <- function(scanLocation, outputDir = NULL) {

    if (is.null(outputDir)) {
      outputDir <- paste0("inst/csv/", frameworkType)
    }

    overview <- readxl::read_xlsx(scanLocation, sheet = "Field Overview")

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

      ## copy column names from scan report
      ## and make all columns to be character
      fieldNames <- as.character(ddl[1, ])
      colnames(csv) <- fieldNames
      csv[fieldNames] <- NA_character_
      csv <- csv[FALSE, ]

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
	  csv[csv == 'NULL'] <- NA # normalize missing values
      write.csv(
        x = csv,
        file = file.path(
          outputDir,
          paste0(tables[i], ".csv")
        ),
        row.names = FALSE
      )
    }
  }
