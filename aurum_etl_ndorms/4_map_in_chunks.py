import os
import psycopg2 as sql
from importlib import import_module
import timeit
import datetime
import sys
import pdb


db_conf = import_module('0_postgres_db_conf', os.getcwd() + '\\0_postgres_db_conf.py').db_conf
log = import_module('write_log', os.getcwd() + '\\write_log.py').Log('4_map_in_chunks')
source_schema = db_conf['source_schema']
target_schema = db_conf['target_schema']
chunk_size = db_conf['chunk_size']
chunk_limit = db_conf['chunk_limit']
# fresh start will truncate target tables and recreate temp tables etc and run the initial queries.
fresh_start = input('Would you like to run the initial queries that build tables such as patient and visit detail before starting on the chunks? (y/n):') 
while fresh_start.lower() not in ['y', 'n', 'yes', 'no']:
    fresh_start = input('I did not understand that. Would you like to run the initial queries before starting on the chunks? (y/n):') 
debug_queries = False # gives the execution time of each query during the chunked process.


def execute_multiple_queries(filename, chunk_id, cnx, save_progress, debug):
    for query in open(os.getcwd() + f'\\sql_scripts\\{filename}').read().split(';'):
        query = query.strip()
        query = query.replace('{SOURCE_SCHEMA}', source_schema)
        query = query.replace('{TARGET_SCHEMA}', target_schema)
        query = query.replace('{CHUNK_ID}', chunk_id)
        if query != '':
            # The debug flag here is mainly to determine whether all the queries during the chunk process should be logged.
            # By default debug is true for the initial and final queries so they will always be logged.
            if debug:
                dtic=timeit.default_timer()
                log.log_message(query.split('\n')[0])
            cur.execute(query)
            if debug:
                dtoc=timeit.default_timer()
                log.log_message('Query execution time: ' + str(datetime.timedelta(seconds=(dtoc - dtic))))
            if save_progress:
                cnx.commit()

try:
    full_start = timeit.default_timer()
    cnx = sql.connect(
        user=db_conf['username'],
        password=db_conf['password'],
        database=db_conf['database']
    )
    cur = cnx.cursor()
    # create target tables if they don't exist
    execute_multiple_queries('OMOP CDM postgresql v5_3_1 ddl.sql', '', cnx, False, False)
    cnx.commit()
    if fresh_start.lower() in ['y', 'yes']:
        # create source_to_concept_map tables
        os.system(f'python prepare_source_vocab_map.py {target_schema}')
        # execute initial queries including the patient data
        log.log_message('Executing initial queries...')
        execute_multiple_queries('map_in_chunks_initial.sql', '', cnx, True, True)
        cnx.commit()
        # drop and create the chunk table
        cur.execute(f'DROP TABLE IF EXISTS {source_schema}.chunk;')
        cur.execute(f'CREATE TABLE {source_schema}.chunk AS SELECT cast(floor((row_number() over (order by person_id)-1)/{chunk_size}) + 1 as int) chunk_id, ' +
                    f'person_id, cast(0 as smallint) as completed FROM {target_schema}.person;')
        cur.execute(f'ALTER TABLE {source_schema}.chunk ADD CONSTRAINT pk_chunk PRIMARY KEY (chunk_id, person_id);')
        cnx.commit()
    # select all incomplete chunk ids
    cur.execute(f'SELECT chunk_id FROM {source_schema}.chunk where completed = 0 group by chunk_id;')
    chunk_id_array = cur.fetchall()
    chunk_id_array = list(map(lambda x: x[0], chunk_id_array))
    # if the user has put a limit on the number of chunks to be processed, then the chunk_id_array get sliced
    if chunk_limit > 0:
        chunk_id_array = chunk_id_array[:chunk_limit]
    # loop through the chunks executing map_in_chunks_main.sql each time
    for chunk_id in chunk_id_array:
        log.log_message(f'Executing chunk {str(chunk_id)} / {str(chunk_id_array[-1])}')
        tic=timeit.default_timer()
        execute_multiple_queries('map_in_chunks_main.sql', str(chunk_id), cnx, False, debug_queries)
        cnx.commit()
        toc=timeit.default_timer()
        log.log_message(f'Chunk finished in {str(toc - tic)} seconds ({str(datetime.timedelta(seconds=(toc - tic)))})')
    # confirm that all chunks have been completed before running the final scripts & table counts
    cur.execute(f'select count(1) from {source_schema}.chunk where completed = 0;')
    incomplete_count = cur.fetchone()[0]
    if incomplete_count == 0:
        log.log_message('Executing final queries...\n')
        execute_multiple_queries('map_in_chunks_final.sql', '', cnx, True, True)
        cnx.commit()
    full_completion = timeit.default_timer()
    log.log_message(f'Full process completed in {str(datetime.timedelta(seconds=(full_completion - full_start)))}')
    
    if incomplete_count == 0:
        # count the target tables.
        log.log_message('Counting rows in cdm tables...\n')
        cur.execute(f'select count(1) from {target_schema}.observation')
        obs_count = cur.fetchone()[0]
        cur.execute(f'select count(1) from {target_schema}.drug_exposure')
        drug_count = cur.fetchone()[0]
        cur.execute(f'select count(1) from {target_schema}.device_exposure')
        dev_count = cur.fetchone()[0]
        cur.execute(f'select count(1) from {target_schema}.condition_occurrence')
        cond_count = cur.fetchone()[0]
        cur.execute(f'select count(1) from {target_schema}.procedure_occurrence')
        proc_count = cur.fetchone()[0]
        cur.execute(f'select count(1) from {target_schema}.measurement')
        meas_count = cur.fetchone()[0]
        cdm_table_count_string = f'observation count: {str(obs_count)}\n' + \
            f'drug_exposure count: {str(drug_count)}\n' + \
            f'device_exposure count: {str(dev_count)}\n' + \
            f'condition_occurrence count: {str(cond_count)}\n' + \
            f'procedure_occurrence count: {str(proc_count)}\n' + \
            f'measurement count: {str(meas_count)}\n'
        log.log_message(cdm_table_count_string)
except:
    cnx.rollback()
    log.log_message(str(sys.exc_info()[1]))
finally:
    cnx.close()
