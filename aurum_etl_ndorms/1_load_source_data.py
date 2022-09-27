import os
import sys
import psycopg2 as sql
from importlib import import_module


db_conf   = import_module('0_postgres_db_conf',os.getcwd() + '\\0_postgres_db_conf.py').db_conf
log = import_module('write_log', os.getcwd() + '\\write_log.py').Log('1_load_source_data')


source_data_directory = db_conf['source_data_directory']
TABLE_RESET = True


patient_files = os.listdir(source_data_directory + '\\patient')
practice_files = os.listdir(source_data_directory + '\\practice')
staff_files = os.listdir(source_data_directory + '\\staff')
consultation_files = os.listdir(source_data_directory + '\\consultation')
observation_files = os.listdir(source_data_directory + '\\observation')
drugissue_files = os.listdir(source_data_directory + '\\drugissue')
problem_files = os.listdir(source_data_directory + '\\problem')
referral_files = os.listdir(source_data_directory + '\\referral')


def get_table_count(table_name, console_log):
    cur.execute(f'select count(1) from {SOURCE_SCHEMA}.{table_name}')
    cnt = cur.fetchone()
    if console_log:
        log.log_message(f'{table_name} row count: {str(cnt)}')
    return cnt

try:
    cnx = sql.connect(
        user=db_conf['username'],
        password=db_conf['password'],
        database=db_conf['database']
    )
    cnx.autocommit = True
    cur = cnx.cursor()
    SOURCE_SCHEMA = db_conf['source_schema']
    if TABLE_RESET:
        for query in open(os.getcwd() + '\\sql_scripts\\create_aurum_tables.sql').read().split(';'):
            if query != '':
                query = query.replace('{SOURCE_SCHEMA}', SOURCE_SCHEMA)
                cur.execute(query + ';')
    cur.execute('set datestyle to \'ISO,DMY\'')
    for filename in patient_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.patient FROM \'{source_data_directory}\\patient\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('patient', console_log=True)
    for filename in practice_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.practice FROM \'{source_data_directory}\\practice\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('practice', console_log=True)
    for filename in staff_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.staff FROM \'{source_data_directory}\\staff\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('staff', console_log=True)
    for filename in consultation_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.consultation FROM \'{source_data_directory}\\consultation\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('consultation', console_log=True)
    for filename in observation_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.observation FROM \'{source_data_directory}\\observation\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('observation', console_log=True)
    for filename in drugissue_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.drugissue FROM \'{source_data_directory}\\drugissue\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('drugissue', console_log=True)
    for filename in problem_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.problem FROM \'{source_data_directory}\\problem\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('problem', console_log=True)
    for filename in referral_files:
        log.log_message('Processing: ' + filename)
        cur.execute(f'COPY {SOURCE_SCHEMA}.referral FROM \'{source_data_directory}\\referral\\{filename}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\'')
    get_table_count('referral', console_log=True)
    for query in open(os.getcwd() + '\\sql_scripts\\build_aurum_keys_index.sql').read().split(';'):
        query = query.strip()
        query = query.replace('{SOURCE_SCHEMA}', SOURCE_SCHEMA)
        if query != '':
            log.log_message(query)
            cur.execute(query)
except:
    log.log_message(str(sys.exc_info()[1]))
finally:
    cnx.close()



    
