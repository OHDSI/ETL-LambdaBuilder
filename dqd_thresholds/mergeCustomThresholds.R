# Create DQD threshold files using the custom thresholds for each database and the universal thresholds for
# all JNJ databases

# Load necessary library
library(dplyr)

# Set folder paths to dqd thresholds folder in ETL-LambdaBuilder repo and to original csv files in the DQD repo
etl_dqd_path <- ".../ETL-LambdaBuilder/dqd_thresholds"
dqd_repo_path <- ".../DataQualityDashboard/inst/csv"

etl_dqd_folders <- list.dirs(etl_dqd_path, full.names = FALSE, recursive = FALSE)

#Define the universal files as we will start with these and then add the db custom thresholds to them

field_level_universal_file_path <- list.files(
  path = etl_dqd_path,
  pattern = "\\v5.4_Field_Level_Universal.csv$",  # Regex to match .csv files
  full.names = TRUE,    # Include full paths
  recursive = FALSE     # Only top-level files
)

field_level_universal_file <- read.csv(field_level_universal_file_path, stringsAsFactors = FALSE, na.strings = c(""))

table_level_universal_file_path <- list.files(
  path = etl_dqd_path,
  pattern = "\\v5.4_Table_Level_Universal.csv$",  # Regex to match .csv files
  full.names = TRUE,    # Include full paths
  recursive = FALSE     # Only top-level files
)

table_level_universal_file <- read.csv(table_level_universal_file_path, stringsAsFactors = FALSE, na.strings = c(""))

# Define and grab the default threshold files

field_level_default_file_path <- list.files(
  path = dqd_repo_path,
  pattern = "\\v5.4_Field_Level.csv$",  # Regex to match .csv files
  full.names = TRUE,    # Include full paths
  recursive = FALSE     # Only top-level files
)

field_level_default_file <- read.csv(field_level_default_file_path, stringsAsFactors = FALSE, na.strings = c(""))

table_level_default_file_path <- list.files(
  path = dqd_repo_path,
  pattern = "\\v5.4_Table_Level.csv$",  # Regex to match .csv files
  full.names = TRUE,    # Include full paths
  recursive = FALSE     # Only top-level files
)

table_level_default_file <- read.csv(table_level_default_file_path, stringsAsFactors = FALSE, na.strings = c(""))

# Replace field threshold records based on `cdmTableName` and `cdmFieldName`
universal_field_thresholds_full <- field_level_default_file %>%
  # Remove rows in file1 that match rows in file2 based on `cdmTableName` and `cdmFieldName`
  anti_join(field_level_universal_file, by = c("cdmTableName", "cdmFieldName")) %>%
  # Add all rows from file2 (which replaces the matching ones)
  bind_rows(field_level_universal_file)


# Replace table threshold records based on `cdmTableName` and `cdmFieldName`
universal_table_thresholds_full <- table_level_default_file %>%
  # Remove rows in file1 that match rows in file2 based on `cdmTableName` 
  anti_join(table_level_universal_file, by = c("cdmTableName")) %>%
  # Add all rows from file2 (which replaces the matching ones)
  bind_rows(table_level_universal_file)

for(i in 1:length(etl_dqd_folders)){
  
  custom_field_thresholds <- read.csv(paste(etl_dqd_path,
                                            etl_dqd_folders[i],
                                            "custom",
                                            "OMOP_CDMv5.4_Field_Level.csv",
                                            sep = "/"),
                                      stringsAsFactors = FALSE,
                                      na.strings = c(""),
                                      colClasses = c("plausibleValueLow"="character",
                                                     "plausibleValueHigh"="character")) %>%
    filter(!is.na(cdmTableName) & cdmTableName != "")
  
  # Replace field threshold records based on `cdmTableName` and `cdmFieldName`
  custom_field_thresholds_full <- universal_field_thresholds_full %>%
    # Remove rows in file1 that match rows in file2 based on `cdmTableName` and `cdmFieldName`
    anti_join(custom_field_thresholds, by = c("cdmTableName", "cdmFieldName")) %>%
    # Add all rows from file2 (which replaces the matching ones)
    bind_rows(custom_field_thresholds)
  
  # Write the updated file back to CSV
  write.csv(custom_field_thresholds_full, 
            paste(etl_dqd_path,
                  etl_dqd_folders[i],
                  "OMOP_CDMv5.4_Field_Level.csv",
                  sep = "/"), row.names = FALSE, na = "")
  
  
  if(file.exists(paste(etl_dqd_path,
                       etl_dqd_folders[i],
                       "custom",
                       "OMOP_CDMv5.4_Table_Level.csv",
                       sep = "/"))){
  
    custom_table_thresholds <- read.csv(paste(etl_dqd_path,
                                              etl_dqd_folders[i],
                                              "custom",
                                              "OMOP_CDMv5.4_Table_Level.csv",
                                              sep = "/"),
                                        stringsAsFactors = FALSE,
                                        na.strings = c("")) %>%
      filter(!is.na(cdmTableName) & cdmTableName != "")
    
    # Replace field threshold records based on `cdmTableName` and `cdmFieldName`
    custom_table_thresholds_full <- universal_table_thresholds_full %>%
      # Remove rows in file1 that match rows in file2 based on `cdmTableName` and `cdmFieldName`
      anti_join(custom_table_thresholds, by = c("cdmTableName")) %>%
      # Add all rows from file2 (which replaces the matching ones)
      bind_rows(custom_table_thresholds)
    
    write.csv(custom_table_thresholds_full, 
              paste(etl_dqd_path,
                    etl_dqd_folders[i],
                    "OMOP_CDMv5.4_Table_Level.csv",
                    sep = "/"), row.names = FALSE, na = "")
  
  }
  
}



