import os
import psycopg2 as sql
from importlib import import_module
import sys


module_location = os.getcwd()
db_conf = import_module('0_postgres_db_conf', module_location + '\\0_postgres_db_conf.py').db_conf
log = import_module('write_log', module_location + '\\write_log.py').Log('prepare_source_vocab_map')
source_schema = db_conf['source_schema']
target_schema = db_conf['target_schema']
vocabulary_schema = db_conf['vocabulary_schema']
stcm_directory = db_conf['stcm_directory']


def execute_multiple_queries(query_text):
    queries = query_text.split(';')
    for query in queries:
        query = query.strip()
        query = query.replace('{TARGET_SCHEMA}', target_schema)
        query = query.replace('{VOCABULARY_SCHEMA}', vocabulary_schema)
        if query!= '':
            if query[:4] == 'COPY' or query[:5] == 'ALTER' or query[:12] == 'CREATE INDEX':
                print('Executing: ' + query)
            cur.execute(query + ';')

if __name__ == '__main__':
    if len(sys.argv) > 1:
        target_schema = sys.argv[1]
try:
    cnx = sql.connect(
        user=db_conf['username'],
        password=db_conf['password'],
        database=db_conf['database']
    )
    cnx.autocommit = True
    cur = cnx.cursor()
    cur.execute(f'truncate table {target_schema}.source_to_concept_map')
    log.log_message('Loading source_to_concept_map data...')
    cur.execute(f'copy {target_schema}.source_to_concept_map from \'{stcm_directory}\\AURUM_UNITS_STCM.csv\' WITH DELIMITER E\',\' CSV HEADER QUOTE E\'"\';')
    cur.execute(f'copy {target_schema}.source_to_concept_map from \'{stcm_directory}\\CONSULTATION_STCM.csv\' WITH DELIMITER E\',\' CSV HEADER QUOTE E\'"\';')
    cur.execute(f'drop table if exists {target_schema}.source_to_source_vocab_map')
    cur.execute(f'drop table if exists {target_schema}.source_to_standard_vocab_map')
    log.log_message('Creating source_to_source_vocab_map table...')
    execute_multiple_queries(open(module_location + '\\sql_scripts\\create_source_to_source_vocab_map.sql').read())
    log.log_message('Creating source_to_standard_vocab_map table...')
    execute_multiple_queries(open(module_location + '\\sql_scripts\\create_source_to_standard_vocab_map.sql').read())
    log.log_message('Creating covid_test_mappings table...')
    cur.execute(f'DROP TABLE IF EXISTS {source_schema}.covid_test_mappings')
    cur.execute(f'CREATE TABLE {source_schema}.covid_test_mappings (measurement_source_value VARCHAR(250) NOT NULL, concept_id INT NULL, value_as_concept_id INT NOT NULL);')
    cur.execute(f'copy {source_schema}.covid_test_mappings from \'{stcm_directory}\\covid_test_mappings.csv\' WITH DELIMITER E\',\' CSV HEADER QUOTE E\'"\';')
finally:
    cnx.close()