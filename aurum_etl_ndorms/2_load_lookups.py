import os
import sys
import psycopg2 as sql
from importlib import import_module


db_conf = import_module('0_postgres_db_conf', os.getcwd() + '\\0_postgres_db_conf.py').db_conf
log = import_module('write_log', os.getcwd() + '\\write_log.py').Log('2_load_lookups')

lookup_directory = db_conf['lookup_data_directory']
source_schema = db_conf['source_schema']
medical_dictionary = db_conf['medical_dictionary_filename']
product_dictionary = db_conf['product_dictionary_filename']
TABLE_RECREATE = True

try:
    cnx = sql.connect(
        user=db_conf['username'],
        password=db_conf['password'],
        database=db_conf['database']
    )
    cnx.autocommit = True
    cur = cnx.cursor()
    if TABLE_RECREATE:
        for query in open(os.getcwd() + '\\sql_scripts\\create_lookup_tables.sql').read().split(';'):
            if query != '':
                query = query.replace('{SOURCE_SCHEMA}', source_schema)
                cur.execute(query + ';')
    log.log_message('loading Region data...')
    cur.execute(f'COPY {source_schema}.lkpregion FROM \'{lookup_directory}\\Region.txt\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message('loading JobCat data...')
    cur.execute(f'COPY {source_schema}.lkpjobcategory FROM \'{lookup_directory}\\JobCat.txt\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message('loading NumUnit data...')
    cur.execute(f'COPY {source_schema}.lkpnumericunit FROM \'{lookup_directory}\\NumUnit.txt\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message('loading QuantUnit data...')
    cur.execute(f'COPY {source_schema}.lkpquantityunit FROM \'{lookup_directory}\\QuantUnit.txt\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message('loading RefServiceType data...')
    cur.execute(f'COPY {source_schema}.lkpreferralservicetype FROM \'{lookup_directory}\\RefServiceType.txt\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message(f'loading {medical_dictionary} data...')
    cur.execute(f'COPY {source_schema}.medicaldictionary FROM \'{lookup_directory}\\{medical_dictionary}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message(f'loading {product_dictionary} data...')
    cur.execute(f'COPY {source_schema}.drugcode FROM \'{lookup_directory}\\{product_dictionary}\' WITH DELIMITER E\'\t\' CSV HEADER QUOTE E\'\b\' ')
    log.log_message('building primary key on lkpnumericunit...')
    cur.execute(f'alter table {source_schema}.lkpnumericunit add constraint pk_lkpnumericunit primary key (numunitid);')
    log.log_message('building primary key on lkpquantityunit...')
    cur.execute(f'alter table {source_schema}.lkpquantityunit add constraint pk_lkpquantityunit primary key (quantunitid);')
    log.log_message('building primary key on lkpreferralservicetype...')
    cur.execute(f'alter table {source_schema}.lkpreferralservicetype add constraint pk_lkpreferralservicetype primary key (refservicetypeid);')
    log.log_message('building primary key on medicaldictionary...')
    cur.execute(f'alter table {source_schema}.medicaldictionary add constraint pk_medicaldictionary primary key (medcodeid);')
    log.log_message('building primary key on drugcode...')
    cur.execute(f'alter table {source_schema}.drugcode add constraint pk_drugcode primary key (prodcodeid);')
    log.log_message('Lookup loading finished.')
except:
    log.log_message(str(sys.exc_info()[1]))
finally:
    cnx.close()