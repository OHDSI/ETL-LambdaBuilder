How to run the ETL for CPRD Aurum to the OHDSI CDM

First time setup:
1. If you don't already have it, download the latest version of python 3.x from https://www.python.org/downloads/ and add the path to the directory containing the python executables to your environment variables.
2. Open a new command prompt and navigate to the root of the aurum_etl module.
3. (Recommended) Create a new virtual environment by running `python -m venv <YOUR ENVIRONMENT NAME>`. Activate this new environment by running `Scripts\activate`.
4. Download the python-postgres client with `pip install psycopg2`.


Running the ETL:
1. In postgres, create schemas to for your tables, e.g. public, vocabulary, source, temp, results.
2. Open 0_postgres_db_conf.py in an editor and change the settings to suit this particular ETL.
3. Open a new command prompt and navigate to the root of the aurum_etl module.
4. Run `python 1_load_source_data.py`.
5. Run `python 2_load_lookups.py`.
6. Run `python 3_load_cdm_vocabularies.py`.
7. Run `python 4_map_in_chunks.py`.



Specifics on postgres_db_conf:

username - String. The username for your postgresql account.

password - String. The password for your postgresql account.

database - String. The name of the database that you will be mapping in.

source_schema - String. The name of the schema that you have created to contain your source data, e.g. 'source'.

target_schema - String. The name of the schema that you have created to contain your CDM tables, e.g. 'public'.

vocabulary_schema - String. The name of the schema that you have created to contain your vocabulary tables, e.g. 'vocabulary'. This could be the same as target_schema if you want.

chunk_size - Integer. This specifies the amount of patients to be processed in each chunk. 1000 patients seems to be a good medium.

chunk_limit - Integer. If this number is greater than 0 then it will limit the number of chunks to be processed to this value. If the value is less than 1 then it will be ignored. Once these chunks have completed, the script will end unless all chunks have been processed, in which case the final queries will run.

log_directory - String. The full path to the directory where log files will be written to. If the log directory does not already exist, then it will be created when a script that utilises logging is executed. The path leading up to the log directory, however, must already exist for the logging to work.

source_data_directory - String. The full path to the directory that contains your source data. The script assumes that within this directory there will be sub-directories with the following names: consultation, drugissue, observation, patient, practice, problem, referral and staff; each containing their respective data (they could also be empty if you don't have data for a particular table).

lookup_data_directory - String. The full path to the directory containing lookup tables and medical and drug dictionaries. These text files need to all be stored at the same level for the 2_load_lookups.py to work correctly.

vocabulary_directory - String. The full path to the directory containing the CDM vocabulary files. Each of these text files should be stored at the same level.

stcm_directory - String. The full path to the directory containing any source_to_concept_map files that you want to include in the ETL. These files should use a comma as their field delimiter and double quote as a text-qualifier if they are needed.

medical_dictionary_filename - String. The name of the medical dictionary file (including the file extension).

product_dictionary_filename - String. The name of the product dictionary file (including the file extension).