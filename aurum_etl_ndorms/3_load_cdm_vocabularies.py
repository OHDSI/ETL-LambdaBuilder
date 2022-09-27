import psycopg2 as sql
import os
import sys
from importlib import import_module


db_conf = import_module('0_postgres_db_conf', os.getcwd() +'\\0_postgres_db_conf.py').db_conf
log = import_module('write_log', os.getcwd() + '\\write_log.py').Log('3_load_cdm_vocabularies')
vocab_folder = db_conf['vocabulary_directory']
vocab_schema = db_conf['vocabulary_schema']


def execute_multiple_queries(query_text):
    try:
        cnx = sql.connect(
            user=db_conf['username'],
            password=db_conf['password'],
            database=db_conf['database']
        )
        cnx.autocommit = True
        cur = cnx.cursor()
        queries = query_text.split(';')
        for query in queries:
            query = query.strip()
            if query!= '':
                query = query.replace('{VOCABULARY_SCHEMA}', vocab_schema)
                query = query.replace('{VOCABULARY_DIRECTORY}', vocab_folder)
                if query[:4] == 'COPY' or query[:5] == 'ALTER' or query[:12] == 'CREATE INDEX':
                    log.log_message('Executing: ' + query)
                cur.execute(query + ';')
    except:
        log.log_message(str(sys.exc_info()[1]))
    finally:
        cnx.close()

vocab_files = ['CONCEPT.csv', 'CONCEPT_ANCESTOR.csv', 'CONCEPT_CLASS.csv', 'CONCEPT_CPT4.csv', 'CONCEPT_RELATIONSHIP.csv', 
               'CONCEPT_SYNONYM.csv', 'DOMAIN.csv', 'DRUG_STRENGTH.csv', 'RELATIONSHIP.csv', 'VOCABULARY.csv']

if not os.path.isdir(vocab_folder):
    os.mkdir(vocab_folder)

if not set(vocab_files).issubset(os.listdir(vocab_folder)):
    pass

execute_multiple_queries(open(os.getcwd() + '\\sql_scripts\\load_cdm_vocabularies.sql').read())

log.log_message('Finished loading vocabularies.')